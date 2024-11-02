class Diary {
  final String content;
  final int feeling; // 0, 1, 2 중 하나의 값 (예: 0: Positive, 1: Negative, 2: Soso)
  final String date;

  Diary({
    required this.content,
    required this.feeling,
    required this.date,
  });

  // JSON 데이터를 Diary 객체로 변환하는 팩토리 메서드
  factory Diary.fromJson(Map<String, dynamic> json) {
    return Diary(
      content: json['content'],
      feeling: json['feeling'],
      date: json['date'],
    );
  }

  // Diary 객체를 JSON 데이터로 변환하는 메서드
  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'feeling': feeling,
      'date': date,
    };
  }
}
