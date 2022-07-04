import 'package:flutter/material.dart';

import '../../models/weather/weather_model.dart';
class ForeCastWeather extends StatelessWidget {
  final Forecast forecastItem;
  const ForeCastWeather({Key? key,required this.forecastItem }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String? forecastWeather = forecastItem.weather;
    int? forecastTemp = forecastItem.temp;
    int? forecaseId = forecastItem.id;
    int newHour = DateTime.now().hour;
    var itemTime =
    forecaseId == 0 ? '现在' : '${(newHour + forecaseId! * 3) % 24}时';
    return Container(
      padding: EdgeInsets.only(left: 6.0, right: 6.0),
      margin: EdgeInsets.only(left: 8.0, right: 8.0),
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:<Widget> [
          Padding(
            child: Text("$itemTime",
                style: TextStyle(
                  color: Colors.black38,
                  fontSize: 16.0,
                )),
            padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
          ),
          Image.asset(
            'assets/icons/$forecastWeather-icon.webp',
            width: 32.0,
            fit: BoxFit.contain,
          ),
          Padding(
            padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
            child: Text(
              "$forecastTemp°",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          )
        ],
      ),
    );

  }
}
