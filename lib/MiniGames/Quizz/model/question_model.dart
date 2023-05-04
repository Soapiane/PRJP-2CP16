class QuestionModel {
  String? question;
  Map<String, bool>? answers;
  String? audioPlayer;
  String? explanation;
  String? audioPalyerExplanation;
  //Creating the constructor
  QuestionModel(this.question, this.answers, this.audioPlayer,
      {this.explanation, this.audioPalyerExplanation});
}
