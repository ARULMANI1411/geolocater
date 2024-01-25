import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class lotrack extends StatefulWidget {
  const lotrack({super.key});

  @override
  State<lotrack> createState() => _lotrackState();
}

class _lotrackState extends State<lotrack> {

  final Completer<GoogleMapController>_controller=Completer();
  static const LatLng current=LatLng(11.000183, 76.973322);
  static const LatLng hotel=LatLng(10.998440,76.976533);

  List<LatLng>polylineCoardinates=[];


  void  getpolypoints()async{

    PolylinePoints polylinePoints=PolylinePoints();
    PolylineResult polylineResult=  await  polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyBjXwGIKwMI_6xJWCtel4hYKSdLAQSNNrk",
      PointLatLng(current.longitude, current.latitude),PointLatLng(hotel.latitude, hotel.longitude),
    );
    print(polylineResult.points);

    if(polylineResult.points.isEmpty){
      polylineResult.points.forEach(
          (PointLatLng points)=>polylineCoardinates.add(
            LatLng(points.longitude, points.latitude)
          )
      );

      setState(() {

      });
    }



  }

  @override
  void initState(){
    super.initState();
    getpolypoints();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: GoogleMap(initialCameraPosition:
      CameraPosition(target: LatLng(current.latitude, current.longitude),
      zoom: 18,
      ),
        polylines: {
        Polyline(polylineId: PolylineId('route'),
        points: polylineCoardinates,
          color: Colors.cyan,
          width: 8
        )
        },


        markers: {
        Marker(markerId: MarkerId('current'),
          position: LatLng(current.latitude, current.longitude),
        ),

          Marker(markerId: MarkerId('hotel'),
            position: LatLng(hotel.latitude, hotel.longitude),
          )
        },
      ),
    );
  }
}
