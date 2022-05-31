class Place {
  int? id;
  String? name;
  double? lat;
  double? lng;

  Place({
    this.id,
    this.name,
    this.lat,
    this.lng,
  });
  factory Place.fromJson(Map<dynamic, dynamic> parsedJson) {
    return Place(
      id: parsedJson['id'],
      name: parsedJson['name'],
      lat: parsedJson['lat'],
      lng: parsedJson['lon'],
    );
  }
}
