---
created_date: 13/09/2025
updated_date: 20/11/2025
---
# New Package Specifications for Bouskoura MVP

## Missing Core Capabilities Analysis

Based on the MVP-to-Workspace alignment, three critical packages need to be developed from scratch:

---

## 📦 Package: `packages/bid_engine`

### Purpose
Redux-based state management for InDrive-style bidding system between clients and service providers.

### Core Features
- **Bid Lifecycle Management**: Create, submit, accept, reject, counter-offer
- **Real-time Updates**: Live bid notifications and status changes
- **Negotiation Logic**: Price suggestions, automatic bid ranking
- **Time-bound Bidding**: Expiration handling, urgency indicators

### Public API Design

```dart
// Actions
class SubmitBidAction {
  final String jobId;
  final String providerId;
  final double amount;
  final String? message;
  final DateTime? estimatedCompletion;
}

class AcceptBidAction {
  final String bidId;
  final String clientId;
}

class RejectBidAction {
  final String bidId;
  final String? reason;
}

// State
class BidState {
  final Map<String, JobBids> jobBids;      // jobId -> bids list
  final Map<String, Bid> activeBids;       // bidId -> bid details
  final BidStatus status;
  final String? error;
}

class Bid {
  final String id;
  final String jobId;
  final String providerId;
  final double amount;
  final BidStatus status;
  final DateTime createdAt;
  final DateTime? expiresAt;
  final String? message;
}

// Selectors
class BidSelectors {
  static List<Bid> getBidsForJob(BidState state, String jobId);
  static Bid? getActiveBidForProvider(BidState state, String providerId, String jobId);
  static List<Bid> getPendingBidsForProvider(BidState state, String providerId);
  static double? getLowestBidForJob(BidState state, String jobId);
}
```

### Dependencies
- `redux` (state management)
- `equatable` (value equality)
- `freezed` (immutable data classes)
- `packages/core` (API calls)
- `packages/shared` (base Redux setup)

### Testing Strategy
- **Unit Tests**: All reducers, selectors, middleware (≥95% coverage)
- **Widget Tests**: Bid list UI, bid submission forms
- **Integration Tests**: End-to-end bidding flow with mock backend

---

## 📦 Package: `packages/geo_services`

### Purpose
Comprehensive geolocation and mapping services with privacy-aware location handling for service radius matching.

### Core Features
- **Location Services**: GPS, network-based positioning, permission management
- **Geocoding**: Address ↔ coordinates conversion with Morocco support
- **Radius Filtering**: Find providers/jobs within specified distance
- **Map Integration**: Interactive maps for service area selection

### Public API Design

```dart
// Core Services
class GeoLocationService {
  Future<Position> getCurrentPosition();
  Stream<Position> getPositionStream();
  Future<bool> requestPermission();
  Future<List<Placemark>> reverseGeocode(Position position);
}

class RadiusService {
  List<T> filterByRadius<T extends GeoLocatable>(
    Position center,
    List<T> items,
    double radiusKm,
  );
  
  double calculateDistance(Position start, Position end);
  bool isWithinRadius(Position center, Position target, double radiusKm);
}

// Redux Integration
class GeoState {
  final Position? currentPosition;
  final List<ServiceArea> availableAreas;
  final LocationPermissionStatus permission;
  final bool isLoading;
  final String? error;
}

class UpdateLocationAction {
  final Position position;
}

class SetServiceRadiusAction {
  final String providerId;
  final double radiusKm;
  final Position center;
}

// Selectors
class GeoSelectors {
  static List<Provider> getProvidersInRadius(
    AppState state, 
    Position clientLocation, 
    double radiusKm
  );
  
  static List<Job> getJobsInRadius(
    AppState state, 
    Position providerLocation, 
    double radiusKm
  );
}
```

### Dependencies
- `geolocator` (location services)
- `flutter_map` (map display)
- `geocoding` (address conversion)
- `permission_handler` (location permissions)
- `packages/core` (API integration)
- `packages/shared` (Redux setup)

### Morocco-Specific Features
- **Moroccan Address Format**: Support for postal codes, regions, provinces
- **Arabic Street Names**: RTL text handling in map displays
- **Local Landmarks**: Integration with popular Morocco locations

### Testing Strategy
- **Unit Tests**: Distance calculations, radius filtering logic (≥90% coverage)
- **Widget Tests**: Map picker, location selector components
- **Integration Tests**: Location services with mock GPS data

---

## 📦 Package: `packages/chat_core`

### Purpose
Real-time chat system using Supabase Realtime with message persistence, typing indicators, and offline support.

### Core Features
- **Real-time Messaging**: Instant delivery via Supabase channels
- **Message Persistence**: Chat history stored in PostgreSQL
- **Typing Indicators**: Live typing status updates
- **Offline Support**: Message queuing and retry logic
- **Media Support**: Image sharing for service verification

### Public API Design

```dart
// Core Chat Service
class ChatService {
  Future<void> initializeChat(String userId);
  Future<void> joinChannel(String channelId);
  Future<void> leaveChannel(String channelId);
  
  Stream<Message> getMessageStream(String channelId);
  Future<void> sendMessage(String channelId, MessageContent content);
  Future<List<Message>> getMessageHistory(String channelId, {int limit = 50});
}

// Redux State
class ChatState {
  final Map<String, List<Message>> channelMessages;
  final Map<String, Set<String>> typingUsers;
  final Set<String> activeChannels;
  final ConnectionStatus connectionStatus;
  final Map<String, Message> pendingMessages; // offline queue
}

class Message {
  final String id;
  final String channelId;
  final String senderId;
  final MessageContent content;
  final DateTime timestamp;
  final MessageStatus status;
  final Map<String, dynamic>? metadata;
}

class MessageContent {
  final String? text;
  final String? imageUrl;
  final MessageType type;
  final Map<String, dynamic>? extra;
}

// Actions
class SendMessageAction {
  final String channelId;
  final MessageContent content;
}

class ReceiveMessageAction {
  final Message message;
}

class UpdateTypingStatusAction {
  final String channelId;
  final String userId;
  final bool isTyping;
}

// Selectors
class ChatSelectors {
  static List<Message> getChannelMessages(ChatState state, String channelId);
  static bool isUserTyping(ChatState state, String channelId, String userId);
  static int getUnreadCount(ChatState state, String channelId);
}
```

### Dependencies
- `supabase_flutter` (realtime, database)
- `redux` (state management)
- `flutter_chat_ui` (UI components)
- `image_picker` (media upload)
- `packages/core` (authentication, file upload)
- `packages/shared` (Redux base)

### Supabase Schema
```sql
-- Chat channels (booking-specific conversations)
CREATE TABLE chat_channels (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  job_id UUID REFERENCES jobs(id),
  client_id UUID REFERENCES profiles(id),
  provider_id UUID REFERENCES profiles(id),
  status channel_status DEFAULT 'active',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Messages
CREATE TABLE chat_messages (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  channel_id UUID REFERENCES chat_channels(id),
  sender_id UUID REFERENCES profiles(id),
  content JSONB NOT NULL,
  message_type message_type DEFAULT 'text',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

### Testing Strategy
- **Unit Tests**: Message parsing, offline queue, typing logic (≥90% coverage)
- **Widget Tests**: Chat UI components, message bubbles
- **Integration Tests**: Real-time message flow with Supabase test instance

---

## 🏗️ Package Development Sequence

### Priority Order (by MVP criticality)
1. **`packages/geo_services`** - Required for provider-client matching
2. **`packages/bid_engine`** - Core differentiator (InDrive model)
3. **`packages/chat_core`** - Support communication (can start with basic SMS/WhatsApp)

### Development Timeline
- **Week 3**: Geo Services foundation + basic location handling
- **Week 4**: Bid Engine core logic + Redux integration
- **Week 5**: Chat Core MVP + Supabase Realtime integration

### Integration Points
All packages will integrate with existing workspace through:
- **Redux Store**: Extend `packages/shared` app state
- **UI Components**: Use `packages/ui_kit` for consistent styling
- **API Layer**: Leverage `packages/core` for Supabase connections
- **Localization**: Support `packages/languist` for multilingual labels

This modular approach ensures each package can be developed, tested, and deployed independently while maintaining clean architecture boundaries.
