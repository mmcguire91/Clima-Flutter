import 'dart:convert';
import 'package:flutter/material.dart';
import '../services/location.dart';
import 'package:http/http.dart' as http;
//requires user to specify package.DataType
import 'package:convert/convert.dart';
//imports jsonDecode

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

  //API Call
  void getData() async {
    http.Response response = await http.get(
        'https://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=439d4b804bc8187953eb36d2a8c26a02');

    /*http 200 return request = successful call
     If there was a successful API call
     store the longitude data retrieved in JSON format from API call in var longitude
     print the longitude data to the console*/

    if (response.statusCode == 200) {
      String data = response.body;
      //body property of Response holds response as a string
      var longitude = jsonDecode(data)['coord']['lon'];
      //retrieve longitude data from API call in JSON format and store in var longitude
      print(longitude);

      var decodedData = jsonDecode(data);
      //required for us to specify data types
      double temperature = decodedData['main']['temp'];
      print(temperature);

      int condition = decodedData['weather'][0]['id'];
      print(condition);

      String city = decodedData['name'];
      print(city);
    } else {
      print(response.statusCode);
    }
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold();
  }
}
