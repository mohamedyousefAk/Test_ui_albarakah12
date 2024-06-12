import 'dart:convert';

import 'package:flutter/foundation.dart';

class Welcome {
  List<Comment> comments;
  int total;
  int skip;
  int limit;

  Welcome({
    required this.comments,
    required this.total,
    required this.skip,
    required this.limit,
  });

  Welcome copyWith({
    List<Comment>? comments,
    int? total,
    int? skip,
    int? limit,
  }) {
    return Welcome(
      comments: comments ?? this.comments,
      total: total ?? this.total,
      skip: skip ?? this.skip,
      limit: limit ?? this.limit,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'comments': comments.map((x) => x.toMap()).toList(),
      'total': total,
      'skip': skip,
      'limit': limit,
    };
  }

  factory Welcome.fromMap(Map<String, dynamic> map) {
    return Welcome(
      comments: List<Comment>.from(
        (map['comments'] as List<int>).map<Comment>(
          (x) => Comment.fromMap(x as Map<String, dynamic>),
        ),
      ),
      total: map['total'] as int,
      skip: map['skip'] as int,
      limit: map['limit'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Welcome.fromJson(String source) =>
      Welcome.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Welcome(comments: $comments, total: $total, skip: $skip, limit: $limit)';
  }

  @override
  bool operator ==(covariant Welcome other) {
    if (identical(this, other)) return true;

    return listEquals(other.comments, comments) &&
        other.total == total &&
        other.skip == skip &&
        other.limit == limit;
  }

  @override
  int get hashCode {
    return comments.hashCode ^ total.hashCode ^ skip.hashCode ^ limit.hashCode;
  }
}

class Comment {
  int id;
  String body;
  int postId;
  int likes;
  User user;

  Comment({
    required this.id,
    required this.body,
    required this.postId,
    required this.likes,
    required this.user,
  });

  toMap() {}

  static fromMap(Map<String, dynamic> x) {}
}

class User {
  int id;
  String username;
  String fullName;

  User({
    required this.id,
    required this.username,
    required this.fullName,
  });
}
