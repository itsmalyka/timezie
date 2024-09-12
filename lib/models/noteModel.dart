import 'package:intl/intl.dart';
class notemodel {
  int? id;
  String title;
  String content;
  String startTime; // Year, month, day, hour, minute
  String endTime;
  String status; //to do, in progress, done
  double completionPercentage;
  String category;
  //String time;

  notemodel(
      {this.id,
      required this.title,
      required this.content,
      required DateTime startTime,
      required DateTime endTime,
      required this.status,
        required this.category,
        //required this.time,
      required this.completionPercentage}): startTime = startTime.toIso8601String(), // Convert to String
  endTime = endTime.toIso8601String(); // Convert to String //constructor
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'startTime': startTime,
      'endTime': startTime,
      'status': status,
      'completionPercentage': completionPercentage,
      'category': category
    };
  }
  //this is a factory constructor which creates a nodemodel object from a map object
  factory notemodel.fromMap(Map<String, dynamic> map) {
    return notemodel(
        title: map['title'],
        content: map['content'],
        startTime: DateTime.parse(map['startTime']), // Parse String to DateTime
        endTime: DateTime.parse(map['endTime']),
        status: map['status'],
        category: map['category'],
        completionPercentage: map['completionPercentage']);
  }
}
