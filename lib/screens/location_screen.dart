import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import '../services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;
  /*establishing a property and giving that a value of the variable weatherData
  that allows us to pass the data retrieved from the API call from one screen to the next*/
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int temperature;
  String weatherIcon;
  String conditionMessage;
  String cityName;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
    //retrieve location weather data from API from loading screen in LocationScreenState
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      //exception handling if response location services is not accessible
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        conditionMessage = 'unable to retrieve location';
        cityName = '';
        return;
      }
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();

      var weatherCondition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(weatherCondition);
      //translate weather icon as dynamic variable

      conditionMessage = weather.getMessage(temperature);
      cityName = weatherData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            //background image
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(
                        this.context,
                        MaterialPageRoute(
                          builder: (context) => CityScreen(),
                        ),
                      );
                      //retrieve data based on typed name in text field in city_screen
                      if (typedName != null) {
                        var cityWeatherData =
                            await weather.getCityWeather(typedName);
                        updateUI(cityWeatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$conditionMessage in $cityName',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
