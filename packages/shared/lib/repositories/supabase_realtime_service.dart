import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:shared/utils/failures/failure.dart';
import 'package:shared/utils/type_defs.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Comprehensive Supabase Realtime Service for live data updates
class SupabaseRealtimeService {
  SupabaseRealtimeService(this._client);
  
  final SupabaseClient _client;
  final Map<String, RealtimeChannel> _channels = {};
  final Map<String, StreamController> _controllers = {};

  /// Subscribe to table changes with filters
  Stream<PostgresChangePayload> subscribeToTable({
    required String table,
    PostgresChangeEvent? event,
    String? schema = 'public',
    Map<String, dynamic>? filter,
  }) {
    final channelName = 'table_$table${event != null ? '_${event.name}' : ''}';
    
    if (_channels.containsKey(channelName)) {
      _channels[channelName]!.unsubscribe();
    }

    final controller = StreamController<PostgresChangePayload>.broadcast();
    _controllers[channelName] = controller;

    final channel = _client.channel(channelName);
    
    // Modern Supabase Realtime API - filters are applied client-side
    // The onPostgresChanges method doesn't support server-side filtering anymore
    channel.onPostgresChanges(
      event: event ?? PostgresChangeEvent.all,
      schema: schema ?? 'public',
      table: table,
      callback: (payload) {
        // Apply client-side filtering if filters are provided
        if (filter != null && filter.isNotEmpty) {
          final record = payload.newRecord ?? payload.oldRecord;
          if (record != null) {
            final matches = filter.entries.every((entry) => 
              record[entry.key]?.toString() == entry.value?.toString());
            if (!matches) return; // Skip this payload if it doesn't match filters
          }
        }
        
        if (!controller.isClosed) {
          controller.add(payload);
        }
      },
    );

    channel.subscribe();
    _channels[channelName] = channel;

    return controller.stream;
  }

  /// Subscribe to specific row changes
  Stream<PostgresChangePayload> subscribeToRow({
    required String table,
    required String rowId,
    String idColumn = 'id',
    PostgresChangeEvent? event,
    String? schema = 'public',
  }) {
    return subscribeToTable(
      table: table,
      event: event,
      schema: schema,
      filter: {idColumn: rowId},
    );
  }

  /// Subscribe to user-specific data
  Stream<PostgresChangePayload> subscribeToUserData({
    required String table,
    required String userId,
    String userColumn = 'user_id',
    PostgresChangeEvent? event,
    String? schema = 'public',
  }) {
    return subscribeToTable(
      table: table,
      event: event,
      schema: schema,
      filter: {userColumn: userId},
    );
  }

  /// Create a custom channel for presence or broadcast
  RealtimeChannel createChannel(String channelName) {
    if (_channels.containsKey(channelName)) {
      _channels[channelName]!.unsubscribe();
    }

    final channel = _client.channel(channelName);
    _channels[channelName] = channel;
    
    return channel;
  }

  /// Subscribe to presence updates (user online/offline status)
  Stream<Map<String, dynamic>> subscribeToPresence({
    required String channelName,
    Map<String, dynamic>? initialPresence,
  }) {
    final channel = createChannel(channelName);
    final controller = StreamController<Map<String, dynamic>>.broadcast();
    
    _controllers['presence_$channelName'] = controller;

    channel
      .onPresenceSync((payload) {
        if (!controller.isClosed) {
          controller.add({'type': 'sync', 'presence': payload});
        }
      })
      .onPresenceJoin((payload) {
        if (!controller.isClosed) {
          controller.add({'type': 'join', 'presence': payload});
        }
      })
      .onPresenceLeave((payload) {
        if (!controller.isClosed) {
          controller.add({'type': 'leave', 'presence': payload});
        }
      });

    if (initialPresence != null) {
      channel.track(initialPresence);
    }

    channel.subscribe();
    
    return controller.stream;
  }

  /// Subscribe to broadcast messages
  Stream<Map<String, dynamic>> subscribeToBroadcast({
    required String channelName,
    required String eventName,
  }) {
    final channel = createChannel(channelName);
    final controller = StreamController<Map<String, dynamic>>.broadcast();
    
    _controllers['broadcast_${channelName}_$eventName'] = controller;

    channel.onBroadcast(
      event: eventName,
      callback: (payload) {
        if (!controller.isClosed) {
          controller.add(payload);
        }
      },
    );

    channel.subscribe();
    
    return controller.stream;
  }

  /// Send broadcast message
  ResultVoid sendBroadcast({
    required String channelName,
    required String eventName,
    required Map<String, dynamic> payload,
  }) async {
    try {
      final channel = _channels[channelName] ?? createChannel(channelName);
      
      await channel.sendBroadcastMessage(
        event: eventName,
        payload: payload,
      );
      
      return right(null);
    } catch (e) {
      CoreLogger.error('Failed to send broadcast: $e');
      return left(Failure.network('Failed to send broadcast: $e'));
    }
  }

  /// Update presence data
  ResultVoid updatePresence({
    required String channelName,
    required Map<String, dynamic> presence,
  }) async {
    try {
      final channel = _channels[channelName];
      if (channel == null) {
        return left(Failure.validation('Channel $channelName not found'));
      }
      
      await channel.track(presence);
      return right(null);
    } catch (e) {
      CoreLogger.error('Failed to update presence: $e');
      return left(Failure.network('Failed to update presence: $e'));
    }
  }

  /// Unsubscribe from a specific channel
  void unsubscribeFromChannel(String channelName) {
    final channel = _channels[channelName];
    if (channel != null) {
      channel.unsubscribe();
      _channels.remove(channelName);
    }

    // Close related controllers
    final controllersToClose = _controllers.keys
        .where((key) => key.contains(channelName))
        .toList();
    
    for (final key in controllersToClose) {
      final controller = _controllers[key];
      if (controller != null && !controller.isClosed) {
        controller.close();
      }
      _controllers.remove(key);
    }
  }

  /// Unsubscribe from all channels
  void unsubscribeFromAll() {
    for (final channel in _channels.values) {
      channel.unsubscribe();
    }
    _channels.clear();

    for (final controller in _controllers.values) {
      if (!controller.isClosed) {
        controller.close();
      }
    }
    _controllers.clear();
  }

  /// Get channel status
  RealtimeChannelStates? getChannelStatus(String channelName) {
    return _channels[channelName]?.state;
  }

  /// Check if channel is subscribed
  bool isChannelSubscribed(String channelName) {
    final channel = _channels[channelName];
    return channel?.state == RealtimeChannelStates.subscribed;
  }

  /// Dispose all resources
  void dispose() {
    unsubscribeFromAll();
  }
}

/// High-level realtime data service for common patterns
class RealtimeDataService {
  RealtimeDataService(this._realtimeService);
  
  final SupabaseRealtimeService _realtimeService;

  /// Subscribe to dashboard metrics updates
  Stream<Map<String, dynamic>> subscribeToDashboardMetrics() {
    return _realtimeService.subscribeToTable(
      table: 'dashboard_metrics',
      event: PostgresChangeEvent.all,
    ).map((payload) => {
      'eventType': payload.eventType.name,
      'table': payload.table,
      'schema': payload.schema,
      'new': payload.newRecord,
      'old': payload.oldRecord,
    });
  }

  /// Subscribe to user activity updates
  Stream<Map<String, dynamic>> subscribeToUserActivities(String userId) {
    return _realtimeService.subscribeToUserData(
      table: 'activities',
      userId: userId,
      event: PostgresChangeEvent.insert,
    ).map((payload) => {
      'eventType': payload.eventType.name,
      'activity': payload.newRecord,
    });
  }

  /// Subscribe to booking updates
  Stream<Map<String, dynamic>> subscribeToBookingUpdates({String? userId}) {
    if (userId != null) {
      return _realtimeService.subscribeToUserData(
        table: 'bookings',
        userId: userId,
        event: PostgresChangeEvent.all,
      ).map((payload) => {
        'eventType': payload.eventType.name,
        'booking': payload.newRecord ?? payload.oldRecord,
      });
    } else {
      return _realtimeService.subscribeToTable(
        table: 'bookings',
        event: PostgresChangeEvent.all,
      ).map((payload) => {
        'eventType': payload.eventType.name,
        'booking': payload.newRecord ?? payload.oldRecord,
      });
    }
  }

  /// Subscribe to chat messages in a room
  Stream<Map<String, dynamic>> subscribeToChatRoom(String roomId) {
    return _realtimeService.subscribeToTable(
      table: 'messages',
      event: PostgresChangeEvent.insert,
      filter: {'room_id': roomId},
    ).map((payload) => {
      'eventType': payload.eventType.name,
      'message': payload.newRecord,
    });
  }

  /// Subscribe to user presence in a room
  Stream<Map<String, dynamic>> subscribeToRoomPresence(String roomId) {
    return _realtimeService.subscribeToPresence(
      channelName: 'room_$roomId',
    );
  }

  /// Join a room with user presence
  ResultVoid joinRoom({
    required String roomId,
    required String userId,
    required String userName,
    Map<String, dynamic>? additionalData,
  }) {
    return _realtimeService.updatePresence(
      channelName: 'room_$roomId',
      presence: {
        'user_id': userId,
        'user_name': userName,
        'joined_at': DateTime.now().toIso8601String(),
        ...?additionalData,
      },
    );
  }

  /// Send a message to a room
  ResultVoid sendRoomMessage({
    required String roomId,
    required String message,
    required String userId,
    Map<String, dynamic>? metadata,
  }) {
    return _realtimeService.sendBroadcast(
      channelName: 'room_$roomId',
      eventName: 'message',
      payload: {
        'message': message,
        'user_id': userId,
        'timestamp': DateTime.now().toIso8601String(),
        'metadata': metadata ?? {},
      },
    );
  }

  /// Subscribe to notifications for a user
  Stream<Map<String, dynamic>> subscribeToNotifications(String userId) {
    return _realtimeService.subscribeToUserData(
      table: 'notifications',
      userId: userId,
      event: PostgresChangeEvent.insert,
    ).map((payload) => {
      'eventType': payload.eventType.name,
      'notification': payload.newRecord,
    });
  }

  /// Subscribe to system-wide announcements
  Stream<Map<String, dynamic>> subscribeToAnnouncements() {
    return _realtimeService.subscribeToBroadcast(
      channelName: 'system',
      eventName: 'announcement',
    );
  }

  /// Send system announcement (admin only)
  ResultVoid sendSystemAnnouncement({
    required String title,
    required String message,
    String? type,
    Map<String, dynamic>? metadata,
  }) {
    return _realtimeService.sendBroadcast(
      channelName: 'system',
      eventName: 'announcement',
      payload: {
        'title': title,
        'message': message,
        'type': type ?? 'info',
        'timestamp': DateTime.now().toIso8601String(),
        'metadata': metadata ?? {},
      },
    );
  }
}
