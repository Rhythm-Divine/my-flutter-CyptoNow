class Price {
  final dynamic time;
  final dynamic value;

  Price({required this.time, required this.value});

  factory Price.fromJson(List<dynamic> json) {
    return Price(
      time: json[0] as int,
      value: json[1] as double,
    );
  }
}
