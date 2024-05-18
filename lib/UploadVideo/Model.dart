import 'dart:io';

class Question {
  File? videoFile;
  String Q;

  Question({
    required this.Q,
    this.videoFile,
  });
}

List<Question> questions = [
  Question(Q: 'How have you been feeling lately'),
  Question(Q: 'Have you experienced any unusual thoughts?'),
  Question(Q: 'How are your daily activities?'),
];
