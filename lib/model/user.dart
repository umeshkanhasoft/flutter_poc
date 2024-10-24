import 'package:get/get.dart';

class Users {
  String? id;
  String? username;
  String? artistName;
  String? profilePicture;
  bool? followed;
  bool? isFollower;
  String? coverPicture;
  String? color;
  String? style;
  String? country;
  String? appToken;
  String? status;
  bool isSelected;
  RxBool? isLoading = false.obs;

  Users({
    this.id,
    this.username,
    this.artistName,
    this.profilePicture,
    this.coverPicture,
    this.followed,
    this.isFollower,
    this.color,
    this.country,
    this.style,
    this.status,
    this.isSelected = false,
    this.isLoading,
    this.appToken,
  });

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'username': username,
      'artist_name': artistName,
      'profile_picture': profilePicture,
      'followed': followed,
      'isFollower': isFollower,
      'cover_picture': coverPicture,
      'is_selected': isSelected,
      'is_loading': isLoading,
      'color': color,
      'country': country,
      'appToken': appToken,
      'status': status,
      'style': style,
    };
  }

  static Users fromJson(Map<String, Object?> json) {
    return Users(
      id: json['id'] == null ? '' : json['id'] as String,
      username: json.containsKey('username')
          ? json['username'] == null
          ? ''
          : json['username'] as String
          : '',
      artistName: json.containsKey('artist_name')
          ? json['artist_name'] == null
          ? ''
          : json['artist_name'] as String
          : '',
      coverPicture: json.containsKey('cover_picture')
          ? json['cover_picture'] == null
          ? ''
          : json['cover_picture'] as String
          : '',
      profilePicture: json.containsKey('profile_picture')
          ? json['profile_picture'] == null
          ? ''
          : json['profile_picture'] as String
          : '',
      followed: json.containsKey('followed')
          ? json['followed'] == null
          ? false
          : json['followed'] as bool
          : false,
      isFollower: json.containsKey('isFollower')
          ? json['is_follower'] == null
          ? false
          : json['is_follower'] as bool
          : false,
      color: json.containsKey('color')
          ? json['color'] == null
          ? ''
          : json['color'] as String
          : '',
      style: json.containsKey('style')
          ? json['style'] == null
          ? ''
          : json['style'] as String
          : '',
      country: json.containsKey('country')
          ? json['country'] == null
          ? ''
          : json['country'] as String
          : '',
      appToken: json.containsKey('app_token')
          ? json['app_token'] == null
          ? ''
          : json['app_token'] as String
          : '',
      status: json.containsKey('status')
          ? json['status'] == null
          ? ''
          : json['status'] as String
          : '',
    );
  }

  @override
  bool operator ==(Object other) {
    return other is Users &&
        other.runtimeType == runtimeType &&
        other.id == id &&
        other.username == username &&
        other.artistName == artistName &&
        other.coverPicture == coverPicture &&
        other.profilePicture == profilePicture &&
        other.isSelected == isSelected &&
        other.isLoading == isLoading &&
        other.followed == followed &&
        other.isFollower == isFollower &&
        other.color == color &&
        other.style == style &&
        other.appToken == appToken &&
        other.status == status;
  }

  @override
  int get hashCode {
    return Object.hash(
        runtimeType,
        id,
        username,
        artistName,
        coverPicture,
        profilePicture,
        followed,
        isFollower,
        isSelected,
        isLoading,
        color,
        style,
        appToken,
        status);
  }
}
