import 'package:equatable/equatable.dart';

class TodoText extends Equatable {
  final int? id;
  final String text;
  final String date;

   const TodoText({
    this.id,
    required this.text,
    required this.date,
  });

  @override
  List<Object?> get props => [id, text, date];
}
