import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:we_healthy/utils/config.dart';
import 'package:geolocator/geolocator.dart';

class RestApi {
  Future<List<double>> getLocationUser() async {
    List<double> _koorLocation = [];
    double? _lat;
    double? _long;
    Position? _currentPosition;

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((Position position) => {_currentPosition = position});
      _lat = _currentPosition?.latitude;
      _long = _currentPosition?.longitude;

      _koorLocation.add(_lat!);
      _koorLocation.add(_long!);

      return _koorLocation;
    } catch (e) {
      print(e);
    }

    return _koorLocation;
  }

  Future<String> getCurrentLocationUser() async {
    late String? location;
    late String? city;
    late String? province;

    List<double> koordinat = await getLocationUser();
    double latitude = koordinat[0];
    double longitude = koordinat[1];
    String url =
        "https://api.api-ninjas.com/v1/reversegeocoding?lat=$latitude&lon=$longitude&X-Api-Key=$apiKeyNinjas";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        city = decodedData[0]['name'];
        province = decodedData[0]['state'];
        location = "$city, $province";
        print(location);
        return location;
      }
    } catch (e) {
      print(e);
    }

    return location = '-';
  }

  Future<double> getCurrentWeather() async {
    late double? kelvin;
    List<double> koordinat = await getLocationUser();
    double latitude = koordinat[0];
    double longitude = koordinat[1];
    String url =
        "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apikeyOpenWeather";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        kelvin = decodedData['main']['temp'];
        print(kelvin);
        return kelvin!;
      } else {}
    } catch (e) {}

    return kelvin = 0;
  }

  Future<int> getAirPollution() async {
    late int? indexAqi;
    List<double> koordinat = await getLocationUser();
    double latitude = koordinat[0];
    double longitude = koordinat[1];
    String url =
        "https://api.openweathermap.org/data/2.5/air_pollution?lat=$latitude&lon=$longitude&appid=$apikeyOpenWeather";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        indexAqi = decodedData['list'][0]['main']['aqi'];
        print(indexAqi);
        return indexAqi!;
      } else {}
    } catch (e) {}

    return indexAqi = 0;
  }

/*
  Future<String?> fetchDataFood() async {
    String apiUrl =
        'https://api.api-ninjas.com/v1/nutrition?query=1lb%20potato&X-Api-Key=ZoZ43buKeTx5HZNmV0ZDlA==08xWU6bWhzvFUqtW';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);

        String airIndex = decodedData[0]['name'];
        return airIndex;
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
  */
}
