class CalculateTime {
  String? hour;
  String? min;
  String? remainingTime;
  String? vakit;

  CalculateTime({required this.hour, required this.min, required this.remainingTime});

  CalculateTime.fromJson(Map<String, dynamic> json) {
    hour = json["hour"];
    min = json["min"];
    remainingTime = json["remainingTime"];
  }

  Map<String, String?> toJson() {
    final Map<String, String?> data = {};
    data["hour"] = hour;
    data["min"] = min;
    data["remainingTime"] = remainingTime;

    return data;
  }
}