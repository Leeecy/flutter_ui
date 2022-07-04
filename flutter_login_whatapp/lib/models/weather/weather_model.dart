class WeatherModel {
  int? code;
  String? message;
  Result? result;
  WeatherModel({this.code, this.message, this.result});
  WeatherModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  Now? now;
  Today? today;
  List<Forecast>? forecast;

  Result({this.now, this.today, this.forecast});

  Result.fromJson(Map<String, dynamic> json) {
    now = json['now'] != null ? new Now.fromJson(json['now']) : null;
    today = json['today'] != null ? new Today.fromJson(json['today']) : null;
    if (json['forecast'] != null) {
      forecast = <Forecast>[];
      json['forecast'].forEach((v) {
        forecast!.add(new Forecast.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.now != null) {
      data['now'] = this.now!.toJson();
    }
    if (this.today != null) {
      data['today'] = this.today!.toJson();
    }
    if (this.forecast != null) {
      data['forecast'] = this.forecast!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Now {
  int? temp;
  String? weather;

  Now({this.temp, this.weather});

  Now.fromJson(Map<String, dynamic> json) {
    temp = json['temp'];
    weather = json['weather'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['temp'] = this.temp;
    data['weather'] = this.weather;
    return data;
  }
}

class Today {
  int? minTemp;
  int? maxTemp;

  Today({this.minTemp, this.maxTemp});

  Today.fromJson(Map<String, dynamic> json) {
    minTemp = json['minTemp'];
    maxTemp = json['maxTemp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['minTemp'] = this.minTemp;
    data['maxTemp'] = this.maxTemp;
    return data;
  }
}

class Forecast {
  String? weather;
  int? temp;
  int? id;

  Forecast({this.weather, this.temp, this.id});

  Forecast.fromJson(Map<String, dynamic> json) {
    weather = json['weather'];
    temp = json['temp'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['weather'] = this.weather;
    data['temp'] = this.temp;
    data['id'] = this.id;
    return data;
  }
}
