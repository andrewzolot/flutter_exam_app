import 'package:json_annotation/json_annotation.dart';

part 'user_tasks.g.dart';

@JsonSerializable()
class UserTasks{
  int userId;
  int id;
  String title;
  bool completed;

  UserTasks(this.userId, this.id, this.title, this.completed);

  factory UserTasks.fromJson(Map<String, dynamic> json) => _$UserTasksFromJson(json);
}