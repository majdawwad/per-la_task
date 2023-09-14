import '../../domain/entities/todo_text.dart';

class TodoTextModel extends TodoText {
   const TodoTextModel({
    final int? id,
    required String text,
    required String date,
  }) : super(
          id: id,
          text: text,
          date: date,
        );

  factory TodoTextModel.fromJson(Map<dynamic, dynamic> json) {
    return TodoTextModel(
      id: json['id']??4,
      text: json['text']??"there is todo text",
      date: json['date']??"2023-07-26",
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['text'] = text;
    data['date'] = date;

    return data;
  }
}
