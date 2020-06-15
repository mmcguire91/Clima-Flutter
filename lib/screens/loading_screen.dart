import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'location_screen.dart';
import '../services/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    //retrieve user geolocation upon app load
    getLocationData();
  }

  void getLocationData() async {
    var weatherData = await WeatherModel().getLocationWeather();
    /*await = data required for something to be performed.
    In this case, without weatherData the location_screen doesn't have any content
    to display because all display logic is tied to the response from the API call*/

    Navigator.push(this.context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationWeather: weatherData,
        //pass over weatherData to next screen retrieved from API call
      );
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
