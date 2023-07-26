class Spam {
  List<Result>? result;

  Spam({this.result});

  Spam.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String? message;
  int? spam;

  Result({this.message, this.spam});

  Result.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    spam = json['spam'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['spam'] = this.spam;
    return data;
  }
}
