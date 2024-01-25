import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
class location extends StatefulWidget {
  const location({super.key});

  @override
  State<location> createState() => _locationState();
}

class _locationState extends State<location> {

  String locat='';
  String address='';


  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }


    return await Geolocator.getCurrentPosition();

  }
     Future<void>GetAddressFromLatLong(Position position)async{

    List<Placemark> placemark=await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemark);
    // Placemark place =placemark[0];
   // address.value='Address:${place.locality}'
     }

   @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
         SizedBox(height: 30,),
          Center(child: IconButton(onPressed: () async {

            Position position =await _determinePosition();
           print("Latitude=${position.latitude.toString()}");
           print('Laonaitude=${position.longitude.toString()}');
                  locat="Latitude=${position.latitude.toString()} ,Laonaitude=${position.longitude.toString()}";
                  GetAddressFromLatLong(position);
          }, icon: Icon(Icons.location_on_outlined,size: 50,))),
          SizedBox(height: 10,width: 20,),
          Center(child: SelectableText(locat)),

        ],
      ),

    );
  }
}
