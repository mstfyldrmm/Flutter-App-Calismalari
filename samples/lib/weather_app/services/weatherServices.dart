// ignore: file_names
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:samples/weather_app/model/weatherModel.dart';

class Weatherservices {
  final String url =
      'https://api.collectapi.com/weather/getWeather?data.lang=tr&data.city=kocaeli';

  Future<List<Weathermodel>> getDatas() async {
    final Map<String, String> headers = {
      'Authorization': 'apikey 1KUEJwRveqrc0uJ454Q6tc:3u05GxH7IMDAEuiMUMYKnQ',
      'Content-Type': 'application/json',
    };
    final response = await http.get(Uri.parse(url), headers: headers);
    
    if (response.statusCode == 200) {
      List<dynamic> responseData = jsonDecode(response.body)["result"];
      List<Weathermodel> datas = responseData.map((e) => Weathermodel.fromJson(e)).toList();

      return datas;
    } else {
      throw Exception(
          "Failed to load todos. Status code: ${response.statusCode}");
    }
  }
}
