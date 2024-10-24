import 'package:intl/intl.dart';
import 'package:test_22_10_2024/utils/size_utils.dart';

class Post {
  String? sId;
  String? caption;
  List<String>? tags;
  DateTime? createdAt;
  int? numberOfViews;
  int? numberOfLikes;
  int? numberOfComments;
  List<AssetModel>? assets;
  bool? likedByUser;
  bool? savedByUser;
  String? userId;
  String? username;
  String? artistName;
  String? profilePicture;
  dynamic location;
  String? type;

  Post(
      {this.sId,
      this.caption,
      this.tags,
      this.createdAt,
      this.numberOfViews,
      this.numberOfLikes,
      this.numberOfComments,
      this.assets,
      this.likedByUser,
      this.savedByUser,
      this.userId,
      this.username,
      this.artistName,
      this.profilePicture,
      this.location,
      this.type});

  Post.fromJson(Map<String, dynamic> json) {
    sId = json['id'];
    caption = json['caption'] ?? '';
    tags = json.containsKey('tags')
        ? json['tags'] != null
            ? (json['tags'] is String)
                ? (json['tags'] as String).split(', ')
                : (json['tags'] as List<dynamic>).cast<String>()
            : []
        : [];

    createdAt = json.containsKey('createdAt')
        ? DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
            .parse(json['created_at'], true)
            .toLocal()
        : json.containsKey('created_at')
            ? DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                .parse(json['created_at'], true)
                .toLocal()
            : DateTime.now().toUtc().toLocal();

    numberOfViews = json['number_of_views'] ?? 0;
    numberOfLikes = json['number_of_likes'] ?? 0;
    numberOfComments = json['number_of_comments'] ?? 0;
    if (json['assets'] != null) {
      assets = <AssetModel>[];
      json['assets'].forEach((v) {
        assets!.add(AssetModel.fromJson(v));
      });
    }
    likedByUser = json['liked_by_user'] ?? false;
    savedByUser = json['saved_by_user'] ?? false;
    username = json['username'] ?? '';
    artistName = json['artist_name'] ?? '';
    userId = json['author_id'] ?? '';
    location = json['location'] ?? '';

    profilePicture = json['profile_picture'] ?? '';
    type = json['type'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = sId;
    data['caption'] = caption;
    data['tags'] = tags;
    data['created_at'] =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(createdAt!);
    data['number_of_views'] = numberOfViews;
    data['number_of_likes'] = numberOfLikes;
    data['number_of_comments'] = numberOfComments;
    data['location'] = location;
    if (assets != null) {
      data['assets'] = assets!.map((v) => v.toJson()).toList();
    }
    data['liked_by_user'] = likedByUser;
    data['saved_by_user'] = savedByUser;
    data['username'] = username;
    data['artist_name'] = artistName;
    data['profile_picture'] = profilePicture;
    data['author_id'] ?? userId;
    data['type'] ?? type;

    return data;
  }

  Post copyWith({
    String? sId,
    String? caption,
    List<String>? tags,
    DateTime? createdAt,
    int? numberOfViews,
    int? numberOfLikes,
    int? numberOfComments,
    List<AssetModel>? assets,
    bool? likedByUser,
    bool? savedByUser,
    String? userId,
    String? username,
    String? artistName,
    dynamic location,
    String? profilePicture,
    String? type,
  }) {
    return Post(
      sId: sId ?? this.sId,
      caption: caption ?? this.caption,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
      numberOfViews: numberOfViews ?? this.numberOfViews,
      numberOfLikes: numberOfLikes ?? this.numberOfLikes,
      numberOfComments: numberOfComments ?? this.numberOfComments,
      assets: assets ?? this.assets,
      likedByUser: likedByUser ?? this.likedByUser,
      savedByUser: savedByUser ?? this.savedByUser,
      userId: userId ?? this.userId,
      location: location ?? this.location,
      username: username ?? this.username,
      artistName: artistName ?? this.artistName,
      profilePicture: profilePicture ?? this.profilePicture,
      type: type ?? this.type,
    );
  }
}

class AssetModel {
  String? url;
  String? thumbnail;
  String? contentType;
  double? defaultHeight;

  AssetModel({this.url, this.thumbnail, this.contentType});

  AssetModel.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    thumbnail = json['thumbnail'];
    contentType = json.containsKey('content_type') ? json['content_type'] : '';
    defaultHeight = 300.v;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['thumbnail'] = thumbnail;
    data['content_type'] = contentType;
    return data;
  }
}
