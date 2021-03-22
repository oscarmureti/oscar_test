class Photo {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  Photo({this.userId, this.id, this.title, this.completed});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      completed: json['completed'] as bool,
    );
  }
}
