import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_whatapp/models/weather/weather_datail.dart';
import 'package:flutter_login_whatapp/page/weather/weather_data.dart';

class WeatherListPage extends StatefulWidget {
  const WeatherListPage({Key? key, required this.locationCity}) : super(key: key);

  //城市
  final String locationCity;

  @override
  State<WeatherListPage> createState() => _WeatherListPageState();
}

class _WeatherListPageState extends State<WeatherListPage> {
//刷新
  Completer<Null>? completer;
  //周天气数据
  List<Result>? weekWeather;

  @override
  void initState() {
    super.initState();
    getWeekWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text("未来一周天气"),
        centerTitle: true,
      ),
      body: WeatherListBody(
        locationCity: widget.locationCity,
      ),
    );
  }

  WeatherListBody({required String locationCity}) {
    return  RefreshIndicator(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: weekWeather == null ? 0 : weekWeather!.length,
          itemBuilder: (BuildContext context, int index) {
            return buildWeekWeatherItem(weekWeather![index]);
          }),
      onRefresh: _onRefresh,
    );
  }

  ///周天气视图Item
  Widget buildWeekWeatherItem(weatherItem) {
    int itemId = weatherItem!.id;
    var itemWeather = weatherItem!.weather;
    var minTemp = weatherItem!.minTemp;
    var maxTemp = weatherItem!.maxTemp;
    //计算时间
    var now = new DateTime.now();
    var date = DateTime(now.year, now.month, now.day + itemId);
    var weekday = itemId == 0 ? '今天' : weekDayData[date.weekday];
    var dayTime = '${date.year}-${date.month}-${date.day}';
    //转换图标
    var itemWeatherIcon = 'assets/icons/$itemWeather-icon.webp';
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Colors.grey, width: 0.2, style: BorderStyle.solid))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                "$weekday",
                style: TextStyle(fontSize: 20.0),
              ),
              new Text(
                "$dayTime",
                style: TextStyle(color: Colors.black45),
              ),
            ],
          ),
          new Text("$minTemp° ~ $maxTemp°"),
          new Image.asset(
            itemWeatherIcon,
            width: 32.0,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }

  ///刷新
  Future<Null> _onRefresh() async {
    completer =  Completer<Null>();
    getWeekWeather();
    return completer!.future;
  }

  /// 获取一周的天气
  void getWeekWeather() async {
    /// 由于动态接口停止服务，所以改为固定模拟数据
    String url = "https://raw.githubusercontent.com/yy1300326388/weather_flutter/master/api/weather_future.json";
    Dio dio = Dio(BaseOptions(responseType: ResponseType.plain));
    final res = await dio.get(url);
    if (res.statusCode == 200) {
      WeatherDetail weatherDetail = WeatherDetail.fromJson(json.decode(res.data));
      setState(() {
        weekWeather = weatherDetail.result;
      });
    }
    //刷新完毕
    if (completer != null && !completer!.isCompleted) {
      completer!.complete(null);
    }
  }

}



