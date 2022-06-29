class Todo {
  int? id;
  String? body;
  bool? isComplete;
  String? updated;
  String? created;

  Todo({this.id, this.body, this.updated, this.created});

  Todo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    body = json['body'];
    isComplete = json['complete'];
    updated = json['updated'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['body'] = this.body;
    data['complete'] = this.isComplete;
    data['updated'] = this.updated;
    data['created'] = this.created;
    return data;
  }
}
