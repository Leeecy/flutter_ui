import 'dart:convert';
import 'dart:ffi';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login_whatapp/models/weather/weather_model.dart';
import 'package:flutter_login_whatapp/page/weather/weather_cast_item.dart';
import 'package:flutter_login_whatapp/page/weather/weather_data.dart';
import 'package:flutter_login_whatapp/page/weather/weather_list_screen.dart';
import 'package:location/location.dart';

class WeatherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HomePage',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        body: WeatherHome(),
      ),
      routes: <String, WidgetBuilder>{
        '/list': (BuildContext context) => WeatherListPage(
              locationCity: _WeatherHomeState.locationCity,
            ),
      },
    );
  }
}

class WeatherHome extends StatefulWidget {
  const WeatherHome({Key? key}) : super(key: key);

  @override
  State<WeatherHome> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  //位置信息
  LocationData? _currentLocation;
  Location _location = Location();
  bool? _serviceEnabled;

  //城市
  static String locationCity = '西安市';

  //温度
  var temp = 0;

  //天气描述
  var weather = '数据获取中...';
  var weatherImage = 'assets/backgrounds/sunny-bg.webp';

  //今天天气详细信息
  Today? todayWeather;

  //forecast list
  List<Forecast>? forecast;

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  Future<void> refreshHandler()async{
    return getWeather();
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh:() => refreshHandler(),
      child: CustomScrollView(
        primary: true,
        slivers: <Widget>[
          SliverList(
              delegate: SliverChildListDelegate(<Widget>[
            weatherBody(),
            timeTips(),
            buildForeCast(),
          ])),
        ],
      ),
    );
  }

  ///未来天气视图
  Widget buildForeCast() {
    return  SizedBox(
      height: 132.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: forecast == null ? 0 : forecast?.length,
        itemBuilder: (BuildContext context, int index) {
          var forecastItem = forecast![index];
          return ForeCastWeather(forecastItem: forecastItem,);
        },
      ),
    );
  }

  Container weatherBody() {
    return Container(
      ///底部居中对齐
      alignment: Alignment.bottomCenter,
      height: 400.0,

      ///装饰背景图片
      decoration: BoxDecoration(
        image: DecorationImage(
          alignment: Alignment.topCenter,
          fit: BoxFit.fill,
          image: AssetImage(weatherImage),
        ),
      ),
      child: Column(
        children: [
          buildLocation(),
          Padding(padding: EdgeInsets.symmetric(vertical: 20.0)),

          ///温度
          Text(
            "$temp°",
            style: TextStyle(fontSize: 64.0),
          ),

          ///天气描述
          Text(
            weather,
            style: TextStyle(fontSize: 18.0, color: Colors.black38),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0),
          ),
          todayWeatherDetails(),
        ],
      ),
    );
  }

  ///今天的详细天气信息
  Widget todayWeatherDetails() {
    ///计算今天的时间
    DateTime dateTime = DateTime.now();
    String todayTime = "${dateTime.year}-${dateTime.month}-${dateTime.day} 今天";
    String todayWeatherDetails = "0° ~ 0°";
    if (todayWeather != null) {
      todayWeatherDetails =
          "${todayWeather!.minTemp}° ~ ${todayWeather!.maxTemp}°";
    }

    return GestureDetector(
      onTap:(){
        Navigator.pushNamed(context, '/list');
      },
      child: Container(
        height: 49.0,
        padding: EdgeInsets.symmetric(vertical: 14.0),
        margin: EdgeInsets.symmetric(horizontal: 16.0),
        decoration: const BoxDecoration(
          ///Border
          border: Border(
              top: BorderSide(
            color: Colors.black38,
            style: BorderStyle.solid,
            width: 0.2,
          )),
        ),
        child: Row(
          children: [
            Text(
              todayTime,
              style: TextStyle(color: Colors.black45),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  todayWeatherDetails,
                  style: TextStyle(color: Colors.black45),
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 2.0)),
                Image.asset(
                  'assets/icons/arrow-icon.webp',
                  height: 12.0,
                  fit: BoxFit.contain,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Column buildLocation() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/icons/location-icon.webp',
              height: 15.0,
              fit: BoxFit.contain,
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 2.0)),
            Text(
              '$locationCity',
              style: TextStyle(fontSize: 16.0, color: Colors.black45),
            ),
          ],
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
        new GestureDetector(
          onTap: _getLocation,
          child: Text("点击更新位置"),
        )
      ],
    );
  }

  ///通过网络获取天气
  void getWeather() async {
    Dio dio = Dio(BaseOptions(responseType: ResponseType.plain));
    final res = await dio.get(
        'https://raw.githubusercontent.com/yy1300326388/weather_flutter/master/api/weather_now.json');

    print("res=$res");
    if (res.statusCode == 200) {
      WeatherModel weatherModel = WeatherModel.fromJson(json.decode(res.data));
      String? tempWeather = weatherModel.result!.now!.weather;
      setState(() {
        temp = weatherModel.result!.now!.temp!;
        weatherImage = 'assets/backgrounds/$tempWeather-bg.webp';
        weather = weatherMap[tempWeather]!;
        //今天天气
        todayWeather = weatherModel.result!.today;
        //设置未来几个小时的天气
        forecast = weatherModel.result!.forecast!;
      });
    } else {
      throw Exception('can\'t get data');
    }
  }

  ///获取位置信息
  Future<void> _getLocation() async {
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled!) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled!) {
        final snackBar = SnackBar(content: Text("未开启定位服务"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
      }
    }
    var error = '成功';
    try {
      //获取经纬度
      _currentLocation = await _location.getLocation();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
      } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error =
            'Permission denied - please ask the user to enable it from the app settings';
      }
      _currentLocation = null;
    }
    if (_currentLocation != null) {
      var latitude = _currentLocation!.latitude;
      var longitude = _currentLocation!.longitude;
      Dio dio = Dio(BaseOptions(responseType: ResponseType.plain));
      final res = await dio.get(
          'http://apis.map.qq.com/ws/geocoder/v1/?location=$latitude,$longitude&key=ZUHBZ-IUNEF-OTUJD-JBHX3-3YZ6Z-I7FSL');
      if (res.statusCode == 200) {
        var city = res.data['result']['address_component']['city'];
        if (city != null) {
          if (locationCity != city) {
            getWeather();
          }
          //更新城市
          setState(() {
            locationCity = city;
          });
          final snackBar = SnackBar(content: Text("获取位置信息，更新成功"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
    } else {
      final snackBar = SnackBar(content: Text("位置信息获取失败，请检查一下权限"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Widget timeTips() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 6.0, bottom: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/icons/time-icon.webp',
            width: 16.0,
            fit: BoxFit.contain,
          ),
          Text(
            "未来24小时天气预测",
            style: TextStyle(
              color: Colors.black45,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}
