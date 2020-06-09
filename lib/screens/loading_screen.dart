import 'package:flutter/material.dart';
import '../services/location.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    //retrieve user geolocation upon app load
    getLocation();
  }

  void getLocation() async {
    /*EXCEPTION HANDLING if unable to retrieve user location
     - logic found in location.dart*/
    Location location = Location();
//    initialize location object - import from location.dart file
    await location.getCurrentLocation();
    //wait for location to be retrieved prior to printing to console
    print(location.latitude);
    print(location.longitude);
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
