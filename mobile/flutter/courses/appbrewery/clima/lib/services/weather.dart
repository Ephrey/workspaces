import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

class WeatherModel {
  Future<dynamic> getCityWeather({String cityName}) async {
    final Uri url = getUrl(queryParams: {'q': cityName});

    final NetworkHelper networkHelper = NetworkHelper(url: url);
    return await networkHelper.getData();
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentPosition();

    final Uri url = getUrl(
      queryParams: {
        'lat': location.latitude.toString(),
        'lon': location.longitude.toString(),
      },
    );

    final NetworkHelper network = NetworkHelper(url: url);
    return await network.getData();
  }

  Uri getUrl({
    Map<String, dynamic> queryParams: const {},
    String units: 'metric',
  }) {
    final Map<String, dynamic> _params = {
      'appid': 'c786577680fb12776014e51a0fa5ba03',
      'units': units,
    };

    if (queryParams.length > 0) {
      _params.addAll(queryParams);
    }

    return Uri.https('api.openweathermap.org', 'data/2.5/weather', _params);
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
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
