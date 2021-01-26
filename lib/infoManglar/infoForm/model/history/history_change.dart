class HistoryChange {

  int id;
  int userId;
  int date;
  int formId;
  String formType;

  String typeChange;
  String userName;
  String reason;

  HistoryChange({
    this.id,
    this.userId,
    this.date,
    this.formId,
    this.formType,
    this.typeChange,
    this.userName,
    this.reason,
  });

  factory HistoryChange.fromJson(Map<String, dynamic> json) {
    return HistoryChange(
      id: json['id'],
      userId: json['userId'],
      date: json['date'],
      formId: json['formId'],
      formType: json['formType'],
      typeChange: json['typeChange'],
      userName: json['userName'],
      reason: json['reason'],
    );
  }

}
