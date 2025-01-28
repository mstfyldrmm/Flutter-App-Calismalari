class Times {
  String? saat;
  String? vakit;

  Times({required this.saat, required this.vakit});

  Times.fromJson(Map<String, dynamic> json) {
    saat = json["saat"];
    vakit = json["vakit"];
  }

  Map<String, String?> toJson() {
    final Map<String, String?> data = {};
    
    data["saat"] = saat;
    data["vakit"] = vakit;

    return data;
  }
}

