import 'package:todo_app/constans/tasktype.dart';

class Task {
  Task({
      required this.description,
      required this.isCompleted,
      required this.title,
      required this.type
      });
      
  final String title;
  final String description;
  bool isCompleted;
  final TaskType type;
}
