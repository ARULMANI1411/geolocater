import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapsPage> {
  static const LatLng _pGooglePlex = LatLng(10.9903, 76.985);
  static const LatLng _pApplePark = LatLng(11.9703, 76.965);
  LatLng currentLocation = const LatLng(10.9903, 76.985);
  GoogleMapController? _controller;

  Map<PolylineId, Polyline> polylines = {};
  String GOOGLE_MAPS_API_KEY = "AIzaSyBPtiO6qdt12pB2DxWjABFXG4iBw-igbZA";


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              onMapCreated: (controller) {
                _controller = controller;
              },
              initialCameraPosition: CameraPosition(
                target: currentLocation,
                zoom: 14.0,
              ),
              markers: {
                Marker(
                  markerId: MarkerId("sourcelocation"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: currentLocation,
                ),
                const Marker(
                    markerId: MarkerId("_sourceLocation"),
                    icon: BitmapDescriptor.defaultMarker,
                    position: _pGooglePlex),
                const Marker(
                    markerId: MarkerId("_destinationLocation"),
                    icon: BitmapDescriptor.defaultMarker,
                    position: _pApplePark)
              },
            ),
            // Positioned(
            //   bottom: 10,
            //   left: 20,
            //   child: ElevatedButton(
            //     onPressed: () async {
            //       await _fetchLocation();
            //     },
            //     child: const Text("Fetch"),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  // Future<void> _fetchLocation() async {
  //   Location location = Location();
  //
  //   bool _serviceEnabled;
  //   PermissionStatus _permissionGranted;
  //   LocationData _locationData;
  //
  //   _serviceEnabled = await location.serviceEnabled();
  //   if (!_serviceEnabled) {
  //     _serviceEnabled = await location.requestService();
  //     if (!_serviceEnabled) {
  //       return;
  //     }
  //   }
  //
  //   _permissionGranted = await location.hasPermission();
  //   if (_permissionGranted == PermissionStatus.denied) {
  //     _permissionGranted = await location.requestPermission();
  //     if (_permissionGranted != PermissionStatus.granted) {
  //       return;
  //     }
  //   }
  //
  //   _locationData = await location.getLocation();
  //
  //   setState(() {
  //     currentLocation = LatLng(_locationData.latitude!, _locationData.longitude!);
  //     print(currentLocation);
  //   });
  //
  //   _controller?.animateCamera(CameraUpdate.newLatLng(currentLocation));
  // }

  Future<List<LatLng>> getPolylinePoints() async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      GOOGLE_MAPS_API_KEY,
      PointLatLng(_pGooglePlex.latitude, _pGooglePlex.longitude),
      PointLatLng(_pApplePark.latitude, _pApplePark.longitude),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    return polylineCoordinates;
  }

  void generatePolyLineFromPoints(List<LatLng> polylineCoordinates) async  {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.black,
        points: polylineCoordinates,
        width: 8);
    setState(() {
      polylines[id] = polyline;
    });
  }
}