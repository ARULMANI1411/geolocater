import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
class locat extends StatefulWidget {
  const locat({super.key});

  @override
  State<locat> createState() => _locatState();
}

class _locatState extends State<locat> {

 void getCurrentLocation()async{
   // await Geolocator.checkPermission();
   // await Geolocator.requestPermission();


    LocationPermission permission=await Geolocator.checkPermission();
    if (permission==LocationPermission.denied||permission==LocationPermission.deniedForever){
      print('LOCATION DENIED');
      LocationPermission ask=await Geolocator.requestPermission();
    }
    else{
      Position currentposition=await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      print("Latitude=${currentposition.latitude.toString()}");
      print('Longitude=${currentposition.longitude.toString()}');
     // Geolocator.distanceBetween(startLatitude, startLongitude, endLatitude, endLongitude)

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LOCATION"),
        centerTitle: true,
      ),
      body: Column(
        children: [
       SizedBox(height: 30,),
          Center(child: ElevatedButton(onPressed: (){
            getCurrentLocation();
          }, child: Text('LOCATION')))

        ],
      ),
    );
  }
}
