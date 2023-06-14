import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'taxi.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'message_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnimatedSplashScreen(
        splash: SvgPicture.asset(
          'quickloc8.svg', // Replace with your SVG logo file path
        ),
        nextScreen: const MapScreen(),
        splashTransition: SplashTransition.fadeTransition,
        duration: 3000, // Adjust the duration to 3 seconds (3000 milliseconds)
      ),
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // ignore: unused_field
  GoogleMapController? _mapController;
  // ignore: prefer_collection_literals, prefer_final_fields
  Set<Marker> _markers = Set<Marker>();
  // ignore: prefer_final_fields, unused_field
  List<Taxi> _taxis = [
    Taxi(const LatLng(37.4219999, -122.0840575), 45.0),
    Taxi(const LatLng(37.4219999, -122.0869727), 135.0),
    Taxi(const LatLng(37.4219999, -122.0816963), 225.0),
  ];

  @override
  void initState() {
    super.initState();
    _addTaxiMarkers();
  }

  void _addTaxiMarkers() async {
    List<Map<String, dynamic>> taxiData = [
      {"heading": "31", "latitude": "-33.876115", "longitude": "18.5008116"},
      {"heading": "310", "latitude": "-33.9685533", "longitude": "18.5662383"},
      {"heading": "0", "latitude": "-34.0461583", "longitude": "18.7047383"},
      {"heading": "0", "latitude": "-31.8994016", "longitude": "26.8671716"},
      {"heading": "299", "latitude": "-31.8942983", "longitude": "26.878175"},
      {"heading": "43", "latitude": "-31.9998233", "longitude": "27.5801216"}
    ];

    for (var taxi in taxiData) {
      double heading = double.parse(taxi['heading']);
      double latitude =
          double.parse(taxi['latitude']!); // Updated parsing as string
      double longitude =
          double.parse(taxi['longitude']!); // Updated parsing as string

      LatLng location = LatLng(latitude, longitude);

      BitmapDescriptor bitmapDescriptor = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(48, 48)),
        'ic_new_white_taxi.png',
      );

      _markers.add(
        Marker(
          markerId: MarkerId(location.toString()),
          position: location,
          rotation: heading,
          icon: bitmapDescriptor,
        ),
      );
    }

    setState(() {});
  }

  // void _addTaxiMarkers() async {
  //   for (Taxi taxi in _taxis) {
  //     BitmapDescriptor.fromAssetImage(
  //       const ImageConfiguration(size: Size(48, 48)),
  //       'ic_new_white_taxi.png',
  //     ).then((BitmapDescriptor bitmapDescriptor) {
  //       _markers.add(
  //         Marker(
  //           markerId: MarkerId(taxi.location.toString()),
  //           position: taxi.location,
  //           rotation: taxi.heading,
  //           icon: bitmapDescriptor,
  //         ),
  //       );
  //       setState(() {});
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quicloc8'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: const [
          MessageButton(
            jsonFilePath: 'assets/messages.json',
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(-33.9685533, 18.5662383),
          zoom: 12.0,
        ),
        onMapCreated: (controller) {
          _mapController = controller;
        },
        markers: _markers,
      ),
    );
  }
}

// class _MapScreenState extends State<MapScreen> {
//   // ignore: unused_field
//   GoogleMapController? _mapController;
//   // prefer_final_fields
//   // ignore: prefer_collection_literals, prefer_final_fields
//   Set<Marker> _markers = Set<Marker>();

//   @override
//   void initState() {
//     super.initState();
//     _addTaxiMarkers();
//   }

//   void _addTaxiMarkers() {
//     List<Taxi> taxis = [
//       Taxi(const LatLng(37.4219999, -122.0840575), 45.0),
//       Taxi(const LatLng(37.4219999, -122.0869727), 135.0),
//       Taxi(const LatLng(37.4219999, -122.0816963), 225.0),
//     ];

//     for (Taxi taxi in taxis) {
//       _markers.add(
//         Marker(
//           markerId: MarkerId(taxi.location.toString()),
//           position: taxi.location,
//           rotation: taxi.heading,
//           icon:
//               BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Quicloc8'),
//         centerTitle: true,
//       ),
//       body: GoogleMap(
//         initialCameraPosition: const CameraPosition(
//           target: LatLng(37.4219999, -122.0840575),
//           zoom: 12.0,
//         ),
//         onMapCreated: (controller) {
//           _mapController = controller;
//         },
//         markers: _markers,
//       ),
//     );
//   }
// }
