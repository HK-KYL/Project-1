import 'package:firebase/firestore.dart' as fs;

const String jsonTagId = "id";
const String jsonTagTitle = "title";
const String jsonTagCreatedBy = "createdBy";
const String jsonTagCreatedAt = "createdAt";
const String jsonTagStartedAt = "startedAt";
const String jsonTagEndedAt = "endedAt";
const String jsonTagDescription = "description";
const String jsonTagStatus = "status";
const String jsonTagReward = "reward";

class Job {
  String id;
  String title;
  String createdBy;
  DateTime createdAt;
  String startedAt;
  String endedAt;
  String description;
  String status;
  String reward;

  Job( this.id, 
          this.title, 
          this.createdAt, 
          this.createdBy,
          this.startedAt,
          this.endedAt,
          this.description,
          this.status,
          this.reward,
        ) {
    this.createdBy = createdBy ?? "No";
  }

  Job.fromMap(Map map):
    this( map['id'], 
          map['title'], 
          map['createdAt'], 
          map['createdBy'],
          map['startedAt'],
          map['endedAt'],
          map['description'],
          map['status'],
          map['reward'],
        );

  static Map<String, dynamic> toMap(Job item) {
    Map<String, dynamic> jsonMap = {
      // jsonTagId: item.id,
      jsonTagTitle: item.title,
      jsonTagCreatedBy: item.createdBy,
      jsonTagCreatedAt: fs.FieldValue.serverTimestamp(),
      jsonTagStartedAt: item.startedAt,
      jsonTagEndedAt: item.endedAt,
      jsonTagDescription: item.description,
      jsonTagStatus: item.status,
      jsonTagReward: item.reward,
    };
    return jsonMap;
  }
  
}
