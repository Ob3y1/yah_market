class ErrorModel {
  late final String error;
  ErrorModel({required this.error});
  factory ErrorModel.fromJson(Map<String, dynamic> jsonData) {
    return ErrorModel(error: jsonData['error']);
  }
}
