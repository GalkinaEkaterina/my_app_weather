// МОДЕЛЬ ГЛАВНОГО ЭКРАНА
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_app_weather/weather_api.dart';
import 'package:my_app_weather/weather_forecast_hourly.dart';

class MainScreenModel extends ChangeNotifier {
  WeatherForecastModel? _forecastObject; //МОДЕЛЬ ПРОГНОЗА ПОГОДЫ
  WeatherForecastModel? get forecastObject => _forecastObject;

  bool _loading = true;
  bool get loading => _loading;
  String cityName = '';//ГОРОД

  MainScreenModel() {
    setup();
  }

  Future<void> setup() async {
    _forecastObject ??=
    await WeatherApi().fetchWeatherForecast(cityName: 'London');
    updateState();
  }

  void onSubmitLocate() async {
    updateState();
    _forecastObject = await WeatherApi().fetchWeatherForecast();
    cityName = _forecastObject!.location!.name!;
    updateState();
  }

  void onSubmitSearch() async {
    if (cityName.isEmpty) return;
    updateState();
    _forecastObject =
    await WeatherApi().fetchWeatherForecast(cityName: cityName);
    cityName = '';
    updateState();
  }

  //ОБНОВЛЕНИЕ СОСТОЯНИЯ
  void updateState() {
    _loading = !_loading;

    notifyListeners();
  }
}