import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart';

class track extends StatefulWidget {
  const track({super.key});

  @override
  State<track> createState() => _trackState();
}

class _trackState extends State<track> {


  Completer<GoogleMapController> _controller = Completer();
  Location _locationController = new Location();
 // Set<Marker> _markers = Set<Marker>();

  final Completer<GoogleMapController> _mapController =
  Completer<GoogleMapController>();

  static const LatLng _currentlocat = LatLng(11.000183, 76.973322);
  static const LatLng _hotellocat = LatLng(10.998440,76.976533);
  LatLng? _currentP = null;
  String GOOGLE_MAPS_API_KEY = "AIzaSyBPtiO6qdt12pB2DxWjABFXG4iBw-igbZA";

  Map<PolylineId, Polyline> polylines = {};
 final Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;

  @override
  void initState() {
    super.initState();

    polylinePoints = PolylinePoints();

    // set up initial locations
    this.getLocationUpdates();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   getLocationUpdates().then(
  //         (_) => {
  //       getPolylinePoints().then((coordinates) => {
  //         generatePolyLineFromPoints(coordinates),
  //       }),
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      // _currentP == null
      //     ? const Center(
      //   child: Text("Loading..."),
      // )
          GoogleMap(

              polylines: _polylines,
              initialCameraPosition: CameraPosition(
                target: _currentlocat,
                zoom: 16,
              ),
              markers: {
                Marker(
                  markerId: MarkerId("_sourceLocation"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _currentlocat,
                ),
                Marker(
                  markerId: MarkerId("_destionationLocation"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _hotellocat,
                )
              },
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              setPolylines();
            },

      ),
    );
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(
      target: pos,
      zoom: 18 ,
    );
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(_newCameraPosition),
    );
  }

  Future<void> getLocationUpdates() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationController.serviceEnabled();
    if (_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
    } else {
      return;
    }

    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          _currentP =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
          _cameraToPosition(_currentP!);
        });
      }
    });
  }

  // Future<List<LatLng>> getPolylinePoints() async {
  //   List<LatLng> polylineCoordinates = [];
  //   PolylinePoints polylinePoints = PolylinePoints();
  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //     GOOGLE_MAPS_API_KEY,
  //     PointLatLng(_pGooglePlex.latitude, _pGooglePlex.longitude),
  //     PointLatLng(_pApplePark.latitude, _pApplePark.longitude),
  //     travelMode: TravelMode.driving,
  //   );
  //   if (result.points.isNotEmpty) {
  //     result.points.forEach((PointLatLng point) {
  //       polylineCoordinates.add(LatLng(point.latitude, point.longitude));
  //     });
  //   } else {
  //     print(result.errorMessage);
  //   }
  //   return polylineCoordinates;
  // }
  //
  // void generatePolyLineFromPoints(List<LatLng> polylineCoordinates) async {
  //   PolylineId id = PolylineId("poly");
  //   Polyline polyline = Polyline(
  //       polylineId: id,
  //       color: Colors.blue,
  //       points: polylineCoordinates,
  //       width: 8);
  //   setState(() {
  //     polylines[id] = polyline;
  //   });
  // }




  void setPolylines() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyBPtiO6qdt12pB2DxWjABFXG4iBw-igbZA",
        PointLatLng(
            _currentlocat.latitude,
            _currentlocat.longitude
        ),
        PointLatLng(
            _hotellocat.latitude,
            _hotellocat.longitude
        )
    );

    if (result.status == 'OK') {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      setState(() {
        _polylines.add(
            Polyline(
                width: 10,
                polylineId: PolylineId('polyLine'),
                color: Colors.greenAccent,
                points: polylineCoordinates
            )
        );
      });
    }
  }
}
