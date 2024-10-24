import 'package:test_22_10_2024/service/api_client.dart';

enum CustomCellListview { homeFeed, followers, following, voteList }

enum CustomApiCall {
  getFollowersApi,
}

class CustomApiRequestClass {
  Map<String, dynamic> dataParam;
  Map<String, dynamic> queryParam;
  ApiMethod method;
  String? url;

  CustomApiRequestClass(
      {required this.dataParam,
      required this.queryParam,
      required this.method,
      required this.url});
}
