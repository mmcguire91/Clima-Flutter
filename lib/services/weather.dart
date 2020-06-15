import 'location.dart';
import 'networking.dart';

const apiKey = '0eb64c32e0822ab14c9d6eb851b8f8b9';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getLocationWeather() async {
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
    /*wait for location to be retrieved prior to printing to console
    ensure we can retrieve current location of user --> location.getCurrentLocation
    prior to attempting to retrieve the retrieve the weather data from the API call*/
    NetworkCall networkCall = NetworkCall(
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=imperial');

    var weatherData = await networkCall.getData();
    //store data from API call in variable weatherData

    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 80) {
      return 'It\'s 🍦 time';
    } else if (temp > 70) {
      return 'Time for shorts and 👕';
    } else if (temp < 50) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
