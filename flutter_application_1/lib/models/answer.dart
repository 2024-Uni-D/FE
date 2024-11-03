// lib/models/answer.dart

class Answer {
  final int id;
  final int order;
  final String today;

  Answer({
    required this.id,
    required this.order,
    required this.today,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      id: json['id'],
      order: json['order'],
      today: json['today'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order': order,
      'today': today,
    };
  }
}
