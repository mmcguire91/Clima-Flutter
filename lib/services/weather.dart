import 'location.dart';
import 'networking.dart';

const apiKey = '0eb64c32e0822ab14c9d6eb851b8f8b9';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  //retrieve data on city based on input from text field in city_screen
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkCall networkCallCity = NetworkCall(
        '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=imperial');

    var cityWeatherData = await networkCallCity.getData();

    return cityWeatherData;
  }

  //retrieve data on user current location
  Future<dynamic> getLocationWeather() async {
    Location location = Location();

    await location.getCurrentLocation();

    NetworkCall networkCall = NetworkCall(
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=imperial');

    var weatherData = await networkCall.getData();
    //store data from API call in variable weatherData

    return weatherData;
  }

  /*WHAT'S HAPPENING HERE?

    * We're using the GEOLOCATION package. Initializing location object which is imported from location.dart file
    Location location = Location();

    * Awaiting the response so we know which data to display relevant to the user's current location
    await location.getCurrentLocation();

    * Retrieve the latitude and longitude from location.dart and store them in local variables to plug them into the url
    latitude = location.latitude;
    longitude = location.longitude;

    * Use call the NetworkCall data type property and store that in a local variable 'networkCall' and call the local longitude and latitude variables in the URL
    NetworkCall networkCall = NetworkCall('https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');

    * Store data from API call in variable weatherData
    var weatherData = await networkCall.getData();

    * Return the value
    return weatherData();
 */

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
