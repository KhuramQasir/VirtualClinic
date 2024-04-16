class Autogenerated {
  int? id;
  String? option;
  String? option1;
  String? option2;
  String? option3;
  String? questionText;

  Autogenerated(
      {this.id,
      this.option,
      this.option1,
      this.option2,
      this.option3,
      this.questionText});

  Autogenerated.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    option = json['option_'];
    option1 = json['option_1'];
    option2 = json['option_2'];
    option3 = json['option_3'];
    questionText = json['question_text'];
  }

  Map<String, dynamic> toJson(questionData) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['option_'] = this.option;
    data['option_1'] = this.option1;
    data['option_2'] = this.option2;
    data['option_3'] = this.option3;
    data['question_text'] = this.questionText;
    return data;
  }
}