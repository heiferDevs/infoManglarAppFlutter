
class ChartData {

  final String id;
  final List<OrdinalData> ordinalList;
  final bool animate;
  final bool vertical;

  ChartData(
    this.ordinalList,
    this.id,
    {
      this.animate,
      this.vertical,
    }
  );

}

class OrdinalData {

  final String label;
  final int value;

  OrdinalData(
    this.label,
    this.value,
  );

  factory OrdinalData.fromJson(Map<String, dynamic> json) {
    return OrdinalData(
      json['label'],
      json['value'],
    );
  }

}