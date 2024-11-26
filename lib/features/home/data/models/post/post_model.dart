
import 'package:academe_x/features/home/data/models/post/post_user_model.dart';
import 'package:academe_x/features/home/data/models/post/reactions_model.dart';
import 'package:academe_x/features/home/data/models/post/tag_model.dart';
import 'package:academe_x/features/home/domain/entities/post/post_entity.dart';
import 'package:academe_x/features/home/domain/entities/post/reactions_entity.dart';

import 'file_info_model.dart';

class PostModel extends PostEntity {
  const PostModel({
    required super.id,
    required super.content,
    required super.createdAt,
    required super.updatedAt,
    super.file,
    required super.images,
    super.tags,
    required super.user,
    required super.reactions,
    required super.commentsCount,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] as int,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      file: json['file'] != null ? FileInfoModel.fromJson(json['file']) : null,
      images: List<String>.from(json['images'] == null ? [] : json['images'] == 0?[]:json['images']),
      tags: json['tags']!=null?(json['tags'] as List).map((tag) => TagModel.fromJson(tag)).toList():[],
      user: PostUserModel.fromJson(json['user']),
      reactions: json['reactions'] != null? ReactionsModel.fromJson(json['reactions']):const ReactionsEntity(count: 0, items: []),
      commentsCount: (json['comments']??0) as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'file': file != null ? (file as FileInfoModel).toJson() : null,
      'images': images,
      'tags': tags?.map((tag) => (tag as TagModel).toJson()).toList(),
      'user': user != null?(user as PostUserModel).toJson():null,
      'reactions': reactions != null?(reactions as ReactionsModel).toJson():null,
      'comments': commentsCount,
    };
  }
  factory PostModel.fromEntity(PostEntity entity) {
    return PostModel(
      id: entity.id,
      content: entity.content,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      file: entity.file != null ? (entity.file!) : null,
      images: entity.images,
      tags: entity.tags != null? (entity.tags!.map((tag) => (tag)).toList()):null,
      user: (entity.user),
      reactions: (entity.reactions),
      commentsCount: entity.commentsCount,
    );
  }

}