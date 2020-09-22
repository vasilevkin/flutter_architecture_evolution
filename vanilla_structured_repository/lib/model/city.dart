class City {
  final String name;
  final int woeId;

  City({
    this.name,
    this.woeId,
  });

  factory City.fromJson(Map<String, dynamic> map) {
    return City(
      name: map['title'],
      woeId: map['woeid'],
    );
  }

  Map<String, dynamic> toJson() => {
        "title": name,
        "woeid": woeId,
      };

  @override
  String toString() {
    return 'City{name: $name, woeId: $woeId}';
  }
}
