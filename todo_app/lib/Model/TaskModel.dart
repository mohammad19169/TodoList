class TaskModel {
  String? id;
  String? projectId;
  int? order;
  String? content;
  String? description;
  bool? isCompleted;
  List<String>? labels;
  int? priority;
  int? commentCount;
  String? creatorId;
  String? createdAt;
  Due? due;
  String? url;

  TaskModel({
    this.id,
    this.projectId,
    this.order,
    this.content,
    this.description,
    this.isCompleted,
    this.labels,
    this.priority,
    this.commentCount,
    this.creatorId,
    this.createdAt,
    this.due,
    this.url,
  });

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectId = json['project_id'];
    order = json['order'];
    content = json['content'];
    description = json['description'];
    isCompleted = json['is_completed'];
    labels = json['labels']?.cast<String>(); // Directly casting if labels are Strings
    priority = json['priority'];
    commentCount = json['comment_count'];
    creatorId = json['creator_id'];
    createdAt = json['created_at'];
    due = json['due'] != null ? Due.fromJson(json['due']) : null;
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'project_id': projectId,
      'order': order,
      'content': content,
      'description': description,
      'is_completed': isCompleted,
      'labels': labels,
      'priority': priority,
      'comment_count': commentCount,
      'creator_id': creatorId,
      'created_at': createdAt,
      'due': due?.toJson(),
      'url': url,
    };
  }
}

class Due {
  String? date;
  String? string;
  String? lang;
  bool? isRecurring;

  Due({this.date, this.string, this.lang, this.isRecurring});

  // Parsing JSON to Due
  Due.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    string = json['string'];
    lang = json['lang'];
    isRecurring = json['is_recurring'];
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'string': string,
      'lang': lang,
      'is_recurring': isRecurring,
    };
  }
}
