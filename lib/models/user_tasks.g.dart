// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_tasks.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserTasks _$UserTasksFromJson(Map<String, dynamic> json) => UserTasks(
      json['userId'] as int,
      json['id'] as int,
      json['title'] as String,
      json['completed'] as bool,
    );

Map<String, dynamic> _$UserTasksToJson(UserTasks instance) => <String, dynamic>{
      'userId': instance.userId,
      'id': instance.id,
      'title': instance.title,
      'completed': instance.completed,
    };
