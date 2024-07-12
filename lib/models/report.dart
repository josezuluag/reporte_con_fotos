class Report {
  int? id;
  String title;
  String description;
  final String date;
  List<String> imagePaths;
  String group;

  Report({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.imagePaths,
    required this.group,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'imagePaths': imagePaths.join(','),
      'group': group,
    };
  }

  factory Report.fromMap(Map<String, dynamic> map) {
    return Report(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      date: map['date'],
      imagePaths: map['imagePaths'].split(','),
      group: map['group'],
    );
  }
}
