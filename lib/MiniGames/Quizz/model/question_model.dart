class QuestionModel {
  String? question;
  Map<String, bool>? answers;
  String? audioPlayer;
  String? explanation;
  String? audioPalyerExplanation;
  //The model of the question with the question, the answers, the audio player and the explanation and its audio player
  QuestionModel(this.question, this.answers, this.audioPlayer,
      {this.explanation, this.audioPalyerExplanation});
}
