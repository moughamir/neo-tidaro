// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, appBarTheme: AppBarThemeData()),
      title: 'BIW',
      home: Scaffold(
        backgroundColor: Colors.deepOrange,
        floatingActionButton: FloatingActionButton(
          onPressed: () => {print('FAB')},
          hoverElevation: 4.0,
          elevation: 0.0,
          mini: false,
          splashColor: Colors.blueAccent,
          hoverColor: Colors.greenAccent,
          backgroundColor: Colors.deepOrange.shade200,
          isExtended: true,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          child: Icon(Icons.message_rounded, color: Colors.amberAccent),
        ),

        drawerEnableOpenDragGesture: true,
        drawer: Drawer(
          width: 120.0,
          backgroundColor: Colors.red,
          child: Text('DRAW'),
        ),
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.amberAccent,
          centerTitle: true,
          leading: Icon(Icons.developer_board),
          title: Text('BiW'),
          elevation: 2.0,

          actions: [
            IconButton(
              icon: const Icon(Icons.menu_rounded),
              onPressed: () => {print('actions')},
            ),
          ],
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: [
                    Card(
                      margin: EdgeInsets.all(4.0),
                      elevation: 0.0,
                      surfaceTintColor: Colors.deepOrange,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Hello World!'),
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.all(4.0),
                      color: Colors.amber,
                      elevation: 8.0,
                      shadowColor: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Hello World!'),
                      ),
                    ),
                  ],
                ),
              ),
              Container(color: Colors.blueAccent, child: Text('Hello World!')),
            ],
          ),
        ),
      ),
    );
  }
}

enum BookingStatus { pending, confirmed, inprogress, completed, cancelled }

enum PaymentStatus { pending, paid, failed, refunded }

class Booking {
  // SupabaseGeneratedId
  late String id;
  // Passed Args
  final String customerId;
  final String serviceId;
  final String professionalId;
  final BookingStatus status;
  // Calculated Prams
  final double totalPrice;
  final PaymentStatus paymentStatus;
  Booking(
    this.totalPrice,
    this.paymentStatus, {
    required this.customerId,
    required this.serviceId,
    required this.professionalId,
    required this.status,
  });
}

class Profile {
  late String id;
  late String fullName;
  late String avatarUrl;
  late String phoneNumber; // IDEA: PhoneNumber Encoder +212-629-144-679
  late String email;
  late String? addressId;
  late UserRole role = UserRole.clientConsumer;
}

enum UserRole { admin, mod, clientConsumer, clientProvider }

class Address {
  late String id;
  late String profileId;
  late GeoPoints geoPoints;
  late String country = 'Morocco';
  late String state = 'Casablanca-Settat';
  late String? region;
  late String? province;
  late String? city = 'Bouskoura';
  late String street;
  late String zipCode;
  late String postalCode;
  late String apartement = '3';
}

class GeoPoints {
  late double latitude;
  late double longitude;
}
