class TextNoteModel {
  late int? id;
  final String title;
  final String description;
  final String date;

  TextNoteModel({
    this.id,
    required this.title,
    required this.description,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "date_time": date,
      };

  TextNoteModel.fromJson(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'],
        description = map['description'],
        date = map['date_time'];

// TextNoteModel.fromJson(Map<String,dynamic> map):
//     id = map['id'],
//     title = map['title'],
//     description = map['description'],
//     date_time = map['date_time'];
}
