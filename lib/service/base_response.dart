abstract class ApiResponse {
  ApiResponse();

  factory ApiResponse.parsing(dynamic json, String error, bool status) =>
      DataResponse(
          data: json,
          error: error.isNotEmpty
              ? error.replaceFirst(error[0], error[0].toUpperCase())
              : '',
          status: status);
}

class DataResponse extends ApiResponse {
  // ignore: unnecessary_question_mark
  dynamic? data;
  dynamic error;
  bool? status;

  DataResponse({this.data, this.error, this.status});
}
