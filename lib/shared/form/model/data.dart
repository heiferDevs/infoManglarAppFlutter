
class Data {

  String id;
  String state;

  Data({
    this.id,
    this.state,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'].toString(),
      state: json['state'],
    );
  }

}
