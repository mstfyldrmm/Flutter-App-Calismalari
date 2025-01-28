import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:samples/namaz_vakitleri/model/calcTimes.dart';
import 'package:samples/namaz_vakitleri/model/times.dart';
import 'package:http/http.dart' as http;

class VakitServices {
  Future<String> getLocation() async {
    //Kullanicinin konumu acik mi kontrol ettik
    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Future.error('Konum servisiniz kapali');
    }

    //kullanici konum izni vermiş mi onu kontrol ettik
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      //Konum izni vermemiş ise tekrardan izin istedik
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        //Yine vermemişse hata donduk
        Future.error('Konum izni vermelisiniz');
      }
    }

    //Kullanicinin pozisyonundan yerleşim nktasını bulduk
    final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    final List<Placemark> placeMark =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    //Sehrin yerleşim noktasını kaydettik
    final String? city = placeMark[0].administrativeArea;

    if (city == null) Future.error('Bir sorun olustu');

    return city!.toLowerCase();
  }

  Future<List<Times>> getDatas() async {
    final String city = await getLocation();
    final String url = 'https://api.collectapi.com/pray/all?data.city=$city';

    final Map<String, String> headers = {
      'Authorization': 'apikey 1KUEJwRveqrc0uJ454Q6tc:3u05GxH7IMDAEuiMUMYKnQ',
      'Content-Type': 'application/json',
    };

    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      List<dynamic> responseData = jsonDecode(response.body)["result"];

      List<Times> realData =
          responseData.map((e) => Times.fromJson(e)).toList();

      return realData;
    } else {
      throw Exception(
          "Failed to load todos. Status code: ${response.statusCode}");
    }
  }

  Future<List<CalculateTime>> getRemainingTime() async {
    final String city = await getLocation();
    final List<Times> zamanlar = await getDatas();

    Times? enYakinVakit() {
        final now = DateTime.now();
        final currentTime = TimeOfDay(hour: now.hour, minute: now.minute);
        Times? nearestPrayer;
        bool kontrol = zamanlar.isEmpty ? false : true;

        if (kontrol) {
          for (var time in zamanlar) {
            final timeParts = time.saat!.split(':');
            final prayerTime = TimeOfDay(
                hour: int.parse(timeParts[0]), minute: int.parse(timeParts[1]));

            if (prayerTime.hour > currentTime.hour ||
                (prayerTime.hour == currentTime.hour &&
                    prayerTime.minute > currentTime.minute)) {
              nearestPrayer = time;
              break;
            }
          }
        }
        return nearestPrayer;
      }
    String vakit = enYakinVakit()?.vakit ?? 'Vakit Bulunamadı';
    String encodedPrayer = Uri.encodeComponent(vakit);

    final String url =
        'https://api.collectapi.com/pray/single?ezan=$encodedPrayer&data.city=$city';

    final Map<String, String> headers = {
      'Authorization': 'apikey 1KUEJwRveqrc0uJ454Q6tc:3u05GxH7IMDAEuiMUMYKnQ',
      'Content-Type': 'application/json',
    };

    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      List<dynamic> responseData = jsonDecode(response.body)["result"];

      List<CalculateTime> realData =
          responseData.map((e) => CalculateTime.fromJson(e)).toList();
      realData[0].vakit = vakit; 

      return realData;
    } else {
      throw Exception(
          "Failed to load todos. Status code: ${response.statusCode}");
    }
  }
}
