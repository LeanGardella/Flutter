import 'dart:convert';

import 'package:http/http.dart' as http;

class WeatherProvider {
  final String _apikey = '65f64f8420b1a726cf178ceddc10f5c6';

  final String _url = 'api.openweathermap.org'; //?q=$_location&appid=$_apikey';

  Future<double> getCurrentTemperature(location) async{

    final url = Uri.http(_url, 'data/2.5/weather', {
      'q' : location,
      'appid': _apikey,
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final mainData = decodedData['main'];

    return mainData['temp'];
  }
}