
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GoogleMapController mapController;
  String searchAddress;
  final LatLng _center = const LatLng(30.3753, 69.3451);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(target: _center),
              onMapCreated: onMapCreated,
            ),
            Positioned(
              top: 50,
                right: 15,
                left: 15,
                child: Container(
                  color: Colors.white,
                  child: Row(
                    children: [
                      IconButton(
                          icon: Icon(Icons.search),
                          onPressed: searchandNavigate),
                      Expanded(
                          child: TextField(
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding:
                                EdgeInsets.symmetric(horizontal: 15),
                              hintText: "Search"
                            ),
                            onChanged: (val){
                              setState(() {
                                searchAddress = val;
                              });
                            },
                          )
                      )
                    ],
                  ),
            ))
          ],
        )
    );
  }

  Future<Null> searchandNavigate() async{
    await Geolocator().placemarkFromAddress(searchAddress).then((value) async{
      await mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target:
          LatLng(value[0].position.latitude,value[0].position.longitude),
          zoom:10.0)));
    });
  }

  void onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

}
