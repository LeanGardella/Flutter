

class Scan {
  int id;
  String type;
  String value;

  Scan({this.id, this.type, this.value}){
    if(this.value.contains('http'))
      this.type = 'http';
    else
      this.type = 'geo';
  }

  Scan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['value'] = this.value;
    return data;
  }

  // LatLng getLatLng() {
  //   final lalo = value.substring(4).split(',');
  //   return LatLng(double.parse(lalo[0]), double.parse(lalo[1]));
  // }
}
