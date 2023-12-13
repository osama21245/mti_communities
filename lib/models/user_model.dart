// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

class UserModel {
  final String name;
  final String profilePic;
  final String banner;
  final String uid;
  final bool isAuthanticated;
  final int karma;
  final int permission;
  final bool isonline;
  final bool isbaned;
  final List<dynamic> followers;
  final List<dynamic> ingroup;
  final List<dynamic> awards;
  UserModel({
    required this.name,
    required this.profilePic,
    required this.banner,
    required this.uid,
    required this.isAuthanticated,
    required this.karma,
    required this.permission,
    required this.isonline,
    required this.isbaned,
    required this.followers,
    required this.ingroup,
    required this.awards,
  });

  UserModel copyWith({
    String? name,
    String? profilePic,
    String? banner,
    String? uid,
    bool? isAuthanticated,
    int? karma,
    int? permission,
    bool? isonline,
    bool? isbaned,
    List<dynamic>? followers,
    List<dynamic>? ingroup,
    List<dynamic>? awards,
  }) {
    return UserModel(
      name: name ?? this.name,
      profilePic: profilePic ?? this.profilePic,
      banner: banner ?? this.banner,
      uid: uid ?? this.uid,
      isAuthanticated: isAuthanticated ?? this.isAuthanticated,
      karma: karma ?? this.karma,
      permission: permission ?? this.permission,
      isonline: isonline ?? this.isonline,
      isbaned: isbaned ?? this.isbaned,
      followers: followers ?? this.followers,
      ingroup: ingroup ?? this.ingroup,
      awards: awards ?? this.awards,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'profilePic': profilePic,
      'banner': banner,
      'uid': uid,
      'isAuthanticated': isAuthanticated,
      'karma': karma,
      'permission': permission,
      'isonline': isonline,
      'isbaned': isbaned,
      'followers': followers,
      'ingroup': ingroup,
      'awards': awards,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      profilePic: map['profilePic'] as String,
      banner: map['banner'] as String,
      uid: map['uid'] as String,
      isAuthanticated: map['isAuthanticated'] as bool,
      karma: map['karma'] as int,
      permission: map['permission'] as int,
      isonline: map['isonline'] as bool,
      isbaned: map['isbaned'] as bool,
      followers: List<dynamic>.from((map['followers'] as List<dynamic>)),
      ingroup: List<dynamic>.from((map['ingroup'] as List<dynamic>)),
      awards: List<dynamic>.from((map['awards'] as List<dynamic>)),
    );
  }

  @override
  String toString() {
    return 'UserModel(name: $name, profilePic: $profilePic, banner: $banner, uid: $uid, isAuthanticated: $isAuthanticated, karma: $karma, permission: $permission, isonline: $isonline, isbaned: $isbaned, followers: $followers, ingroup: $ingroup, awards: $awards)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.profilePic == profilePic &&
        other.banner == banner &&
        other.uid == uid &&
        other.isAuthanticated == isAuthanticated &&
        other.karma == karma &&
        other.permission == permission &&
        other.isonline == isonline &&
        other.isbaned == isbaned &&
        listEquals(other.followers, followers) &&
        listEquals(other.ingroup, ingroup) &&
        listEquals(other.awards, awards);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        profilePic.hashCode ^
        banner.hashCode ^
        uid.hashCode ^
        isAuthanticated.hashCode ^
        karma.hashCode ^
        permission.hashCode ^
        isonline.hashCode ^
        isbaned.hashCode ^
        followers.hashCode ^
        ingroup.hashCode ^
        awards.hashCode;
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
