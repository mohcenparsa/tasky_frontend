class TaskItem {
  final String id;
  late final String title;
  late final String desc;
  final String image;
  late final String priority;
  late final String status;
  DateTime dueDate;

  TaskItem(
    this.id,
    this.title,
    this.desc,
    this.image,
    this.priority,
    this.status,
    this.dueDate,
  );

  factory TaskItem.fromJson(Map<String, dynamic> json) {
    return TaskItem(
      json['_id'] ?? '',
      json['title'] ?? '',
      json['desc'] ?? '',
      json['image'],
      json['priority'] ?? '', // Ensure the correct spelling from the JSON
      json['status'] ?? '',
      json['dueDate'] != null
          ? DateTime.parse(json['dueDate'])
          : DateTime.now(),
    );
  }
}
