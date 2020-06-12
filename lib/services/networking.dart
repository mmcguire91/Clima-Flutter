import 'package:http/http.dart' as http;
//requires user to specify package.DataType
import 'dart:convert';
//imports jsonDecode

class NetworkCall {
  NetworkCall(this.url);

  final String url;

//API Call
  Future getData() async {
    http.Response response = await http.get(url);

    /*http 200 return request = successful call
     If there was a successful API call
     store the longitude data retrieved in JSON format from API call in var longitude
     print the longitude data to the console*/

    if (response.statusCode == 200) {
      String data = response.body;
      //body property of Response holds response as a string

      return jsonDecode(data);
      //decode the data held inside the API response [held in JSON file format]
      //return the API call

    } else {
      print(response.statusCode);
    }
  }
}

/*
EXAMPLES OF API CALLS FOR COORDINATES, TEMPERATURE, AND CITY DATA

if (response.statusCode == 200) {
      String data = response.body;
      //body property of Response holds response as a string

      var decodedData = jsonDecode(data);
      //required for us to specify data types
      //decode the data held inside the API response [held in JSON file format]
      //return the API call

      var longitude = jsonDecode(data)['coord']['lon'];
      //retrieve longitude data from API call in JSON format and store in var longitude
      print(longitude);

      var latitude = jsonDecode(data)['coord']['lat'];
      //retrieve latitude data from API call in JSON format and store in var longitude
      print(latitude);

      int condition = decodedData['weather'][0]['id'];
      print(condition);

      String city = decodedData['name'];
      print(city);

    } else {
      print(response.statusCode);
    }

*/
