//import 'dart:js';
import 'package:flutter/material.dart';
import 'location_screen.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../services/location.dart';

const apiKey = '0eb64c32e0822ab14c9d6eb851b8f8b9';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;

  @override
  void initState() {
    super.initState();
    //retrieve user geolocation upon app load
    getLocationData();
  }

  void getLocationData() async {
    /*WHAT'S HAPPENING HERE?

    * We're using the GEOLOCATION package
    Location location = Location();

    * Awaiting the response so we know which data to display relevant to the user's current location
    await location.getCurrentLocation();

    * Retrieve the latitude and longitude from location.dart and store them in local variables to plug them into the url
    latitude = location.latitude;
    longitude = location.longitude;

    * Use call the NetworkCall data type property and store that in a local variable 'networkCall' and call the local longitude and latitude variables in the URL
    NetworkCall networkCall = NetworkCall('https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');
 */

    /*EXCEPTION HANDLING if unable to retrieve user location
     - logic found in location.dart*/
    Location location = Location();
//    initialize location object - import from location.dart file
    await location.getCurrentLocation();
    //wait for location to be retrieved prior to printing to console
    latitude = location.latitude;
    longitude = location.longitude;
    /*ensure we can retrieve current location of user --> location.getCurrentLocation
    prior to attempting to retrieve the retrieve the weather data from the API call*/
    NetworkCall networkCall = NetworkCall(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');

//    var weatherData = await networkCall.getData();

    Navigator.push(this.context, MaterialPageRoute(builder: (context) {
      return LocationScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitFoldingCube(
          color: Colors.white,
          size: 75.0,
        ),
      ),
    );
  }
}
