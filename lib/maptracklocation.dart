import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Lotrack123 extends StatefulWidget {
  const Lotrack123({Key? key}) : super(key: key);

  @override
  State<Lotrack123> createState() => _Lotrack123State();
}

class _Lotrack123State extends State<Lotrack123> {
  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng current = LatLng(11.000183, 76.973322);
  static const LatLng hotel = LatLng(10.998440, 76.976533);

  List<LatLng> polylineCoordinates = [];

  Future<void> getPolylinePoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult polylineResult = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyBjXwGIKwMI_6xJWCtel4hYKSdLAQSNNrk",
      PointLatLng(current.latitude, current.longitude),
      PointLatLng(hotel.latitude, hotel.longitude),
      travelMode: TravelMode.driving,
    );

    if (!polylineResult.points.isEmpty) {
      setState(() {
        polylineCoordinates.clear();
        polylineResult.points.forEach((PointLatLng points) {
          polylineCoordinates.add(LatLng(points.latitude, points.longitude));
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getPolylinePoints();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(current.latitude, current.longitude),
          zoom: 18,
        ),
        polylines: {
          Polyline(
            polylineId: PolylineId('route'),
            points: polylineCoordinates,
            color: Colors.blue,
            width: 5,
          )
        },
        markers: {
          Marker(
            markerId: MarkerId('current'),
            position: LatLng(current.latitude, current.longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          ),
          Marker(
            markerId: MarkerId('hotel'),
            position: LatLng(hotel.latitude, hotel.longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          )
        },
      ),
    );
  }
}

// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class lotrack123 extends StatefulWidget {
//   const lotrack123({super.key});
//
//   @override
//   State<lotrack123> createState() => _lotrack123State();
// }
//
// class _lotrack123State extends State<lotrack123> {
//   final Completer<GoogleMapController> _controller = Completer();
//   static const LatLng current = LatLng(11.000183, 76.973322);
//   static const LatLng hotel = LatLng(10.998440, 76.976533);
//
//   List<LatLng> polylineCoordinates = [];
//
//   Future<void> getPolylinePoints() async {
//     PolylinePoints polylinePoints = PolylinePoints();
//     PolylineResult polylineResult = await polylinePoints.getRouteBetweenCoordinates(
//       "AIzaSyBjXwGIKwMI_6xJWCtel4hYKSdLAQSNNrk",
//       PointLatLng(current.latitude, current.longitude),
//       PointLatLng(hotel.latitude, hotel.longitude),
//       travelMode: TravelMode.driving,
//     );
//
//     if (!polylineResult.points.isEmpty) {
//       setState(() {
//         polylineCoordinates.clear(); // Clear existing coordinates before adding new ones
//         polylineResult.points.forEach((PointLatLng points) {
//           polylineCoordinates.add(LatLng(points.latitude, points.longitude));
//         });
//       });
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     getPolylinePoints();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GoogleMap(
//         initialCameraPosition: CameraPosition(
//           target: LatLng(current.latitude, current.longitude),
//           zoom: 18,
//         ),
//         polylines: {
//           Polyline(
//             polylineId: PolylineId('route'),
//             points: polylineCoordinates,
//             color: Colors.cyan,
//             width: 40,
//           )
//         },
//         markers: {
//           Marker(
//             markerId: MarkerId('current'),
//             position: LatLng(current.latitude, current.longitude),
//           ),
//           Marker(
//             markerId: MarkerId('hotel'),
//             position: LatLng(hotel.latitude, hotel.longitude),
//           )
//         },
//       ),
//     );
//   }
// }
//
// // import 'dart:async';
// //
// // import 'package:flutter/material.dart';
// // import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// //
// //
// // class lotrack1 extends StatefulWidget {
// //   const lotrack1({super.key});
// //
// //   @override
// //   State<lotrack1> createState() => _lotrack1State();
// // }
// //
// // class _lotrack1State extends State<lotrack1> {
// //
// //   final Completer<GoogleMapController>_controller=Completer();
// //   static const LatLng current=LatLng(11.000183, 76.973322);
// //   static const LatLng hotel=LatLng(10.998440,76.976533);
// //
// //   List<LatLng>polylineCoardinates=[];
// //
// //
// //   // void  getpolypoints()async{
// //   //
// //   //   PolylinePoints polylinePoints=PolylinePoints();
// //   //   PolylineResult polylineResult=  await  polylinePoints.getRouteBetweenCoordinates(
// //   //     "AIzaSyBjXwGIKwMI_6xJWCtel4hYKSdLAQSNNrk",
// //   //     PointLatLng(current.longitude, current.latitude),PointLatLng(hotel.latitude, hotel.longitude),
// //   //   );
// //   //   print(polylineResult.points);
// //   //
// //   //   // if(polylineResult.points.isEmpty){
// //   //   //   polylineResult.points.forEach(
// //   //   //           (PointLatLng points)=>polylineCoardinates.add(
// //   //   //           LatLng(points.longitude, points.latitude)
// //   //   //       )
// //   //   //   );
// //   //   if (!polylineResult.points.isEmpty) {
// //   //     polylineResult.points.forEach((PointLatLng points) {
// //   //       polylineCoardinates.add(LatLng(points.latitude, points.longitude));
// //   //     });
// //   //
// //   //
// //   //     setState(() {
// //   //
// //   //     });
// //   //   }
// //   // }
// //   void getpolypoints() async {
// //     PolylinePoints polylinePoints = PolylinePoints();
// //     PolylineResult polylineResult = await polylinePoints.getRouteBetweenCoordinates(
// //       "AIzaSyBjXwGIKwMI_6xJWCtel4hYKSdLAQSNNrk",
// //       PointLatLng(current.latitude, current.longitude),
// //       PointLatLng(hotel.latitude, hotel.longitude),
// //     );
// //
// //     if (!polylineResult.points.isEmpty) {
// //       setState(() {
// //         polylineCoardinates.clear(); // Clear existing coordinates before adding new ones
// //         polylineResult.points.forEach((PointLatLng points) {
// //           polylineCoardinates.add(LatLng(points.latitude, points.longitude));
// //         });
// //       });
// //     }
// //   }
// //
// //   @override
// //   void initState(){
// //     super.initState();
// //     getpolypoints();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //
// //       body: GoogleMap(initialCameraPosition:
// //       CameraPosition(target: LatLng(current.latitude, current.longitude),
// //         zoom: 17,
// //       ),
// //         onMapCreated: ,
// //         polylines: {
// //           Polyline(polylineId: PolylineId('route'),
// //               points: polylineCoardinates,
// //               color: Colors.cyan,
// //               width: 8
// //           )
// //         },
// //
// //
// //         markers: {
// //           Marker(markerId: MarkerId('current'),
// //             position: LatLng(current.latitude, current.longitude),
// //           ),
// //
// //           Marker(markerId: MarkerId('hotel'),
// //             position: LatLng(hotel.latitude, hotel.longitude),
// //           )
// //         },
// //       ),
// //     );
// //   }
// // }