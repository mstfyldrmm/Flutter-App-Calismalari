// ignore_for_file: public_member_api_docs, sort_constructors_first
class Weathermodel {
  String? date;
  String? day;
  String? description;
  String? status;
  String? degree;
  String? min;
  String? max;
  String? night;
  String? icon;
  Weathermodel({
    required this.date,
    required this.day,
    required this.description,
    required this.status,
    required this.degree,
    required this.min,
    required this.max,
    required this.night,
    required this.icon
  });

  Weathermodel.fromJson(Map<String, dynamic> json) {
    date = json["date"];
    day = json["day"];
    description = json["description"];
    status = json["status"];
    degree = json["degree"];
    min = json["min"];
    max = json["max"];
    night = json["night"];
    icon = json["icon"];
  }

  Map<String, String?> toJson() {
    final Map<String, String?> data = {};
    
    data["date"] = date;
    data["day"] = day;
    data["description"] = description;
    data["status"] = status;
    data["degree"] = degree;
    data["min"] = min;
    data["max"] = max;
    data["night"] = night;
    data["icon"] = icon;

    return data;
  }
}
