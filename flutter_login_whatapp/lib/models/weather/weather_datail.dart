class WeatherDetail {
  int? code;
  String? message;
  List<Result>? result;

  WeatherDetail({this.code, this.message, this.result});

  WeatherDetail.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  int? id;
  String? weather;
  int? minTemp;
  int? maxTemp;

  Result({this.id, this.weather, this.minTemp, this.maxTemp});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    weather = json['weather'];
    minTemp = json['minTemp'];
    maxTemp = json['maxTemp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['weather'] = this.weather;
    data['minTemp'] = this.minTemp;
    data['maxTemp'] = this.maxTemp;
    return data;
  }
}
