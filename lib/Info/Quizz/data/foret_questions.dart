import 'package:audioplayers/audioplayers.dart';
import 'package:projet2cp/MiniGames/Quizz/model/question_model.dart';

//The list of the questions of the quizz of forest zone which is a list of QuestionModel objects

List<QuestionModel> questionsForet = [
  QuestionModel(
      "Qu'est-ce que la déforestation ? ",
      {
        " La coupe des arbres pour l'utilisation du bois ": false,
        " La conversion de la forêt en terres agricoles ou urbaines ": true,
        " Les feux de forêt ": false,
        " Aucune réponse ": false,
      },
      "ForetQuizz/quiz_f_q1.m4a",
      explanation:
          "La déforestation est la conversion de la forêt en terres agricoles ou urbaines",
      audioPalyerExplanation: "ForetQuizz/quiz_f_r1.m4a"),
  QuestionModel(
      "Quels sont les impacts de la déforestation sur l'environnement ? ",
      {
        "  Perte de biodiversité  ": true,
        "  Diminution de gaz à effet de serre ": false,
        "  Lutte contre la pollution  ": false,
        "  Aucune réponse ": false,
      },
      "ForetQuizz/quiz_f_q2.m4a",
      explanation:
          "La déforestation a des impacts sur l'environnement, tels que la perte de biodiversité, les émissions accrues de gaz à effet de serre, la dégradation des sols et des ressources en eau.",
      audioPalyerExplanation: "ForetQuizz/quiz_f_r2.m4a"),
  QuestionModel(
    " Qu'est-ce que la surexploitation des ressources forestières ? ",
    {
      " L'exploitation forestière légale et durable  ": false,
      " L'utilisation excessive et non durable des ressources forestières ":
          true,
      " La protection des forêts pour éviter leur dégradation ": false,
      "Aucune réponse ": false,
    },
    "ForetQuizz/quiz_f_q3.m4a",
    explanation:
        "La surexploitation des ressources forestières est l'utilisation excessive et non durable des ressources forestières",
    audioPalyerExplanation: "ForetQuizz/quiz_f_r3.m4a",
  ),
  QuestionModel(
      "Quels sont les avantages de la gestion durable des ressources forestières ? ",
      {
        "  Utilisation plus efficace des ressources forestières ": true,
        " Perte de la biodiversité  ": false,
        " Provoque les changements climatiques  ": false,
        "Aucune réponse ": false,
      },
      "ForetQuizz/quiz_f_q4.m4a",
      explanation:
          " La gestion durable des ressources forestières permet une utilisation plus efficace des ressources forestières, la protection de la biodiversité, le stockage du carbone et la lutte contre les changements climatiques.",
      audioPalyerExplanation: "ForetQuizz/quiz_f_r4.m4a"),
  QuestionModel(
    " Comment peut-on prévenir les incendies de forêt ? ",
    {
      " En éliminant les sources d'allumage telles que les cigarettes ": true,
      " En jetant du verre et plastique dans les forêts ": false,
      " En coupant tous les arbres dans une forêt ": false,
      "Aucune réponse ": false,
    },
    "ForetQuizz/quiz_f_q5.m4a",
    explanation:
        "En éliminant les sources d'allumage telles que les cigarettes ou les feux de camp",
    audioPalyerExplanation: "ForetQuizz/quiz_f_r5.m4a",
  ),
  QuestionModel(
    "Quelle est la plus grande cause d'incendies de forêt ? ",
    {
      " Les éruptions volcaniques ": false,
      " Les foudres ": false,
      " l'activité humaine ": true,
      " la pollution ": false,
    },
    "ForetQuizz/quiz_f_q6.m4a",
    explanation:
        "L'activité humaine, telle que les feux de camp et les mégots de cigarette mal éteints",
    audioPalyerExplanation: "ForetQuizz/quiz_f_r6.m4a",
  ),
  QuestionModel(
      " Quelles sont les conséquences des incendies de forêt ? ",
      {
        " Lutte contre le réchauffement climatique ": false,
        " Destruction des ressources naturelles et l'habitat animal ": true,
        " Protection des ressources naturelles et l'habitat animal ": false,
        "Aucune réponse ": false,
      },
      "ForetQuizz/quiz_f_q7.m4a",
      explanation:
          "La conséquence des feux de fôret c'est la destruction des ressources naturelles et l'habitat animal ",
      audioPalyerExplanation: "ForetQuizz/quiz_f_r7.m4a"),
  QuestionModel(
      "Qu'est-ce que la protection des forêts ? ",
      {
        " Mettre en danger la biodiversité": false,
        " La gestion des écosystèmes forestiers ": true,
        " Polluer l’eau": false,
        " Aucune réponse ": false,
      },
      "ForetQuizz/quiz_f_q8.m4a",
      explanation:
          "La protection des forêts c'est avant tout la gestion des écosystèmes forestiers",
      audioPalyerExplanation: "ForetQuizz/quiz_f_r8.m4a"),
  QuestionModel(
      " Pourquoi est-il important de protéger les forêts ? ",
      {
        " Pour détruire la biodiversité et l'habitat animal ": false,
        " Pour lutter contre le changement climatique ": true,
        " Pour  polluer l'air  ": false,
        " Aucune réponse ": false,
      },
      "ForetQuizz/quiz_f_q9.m4a"),
  QuestionModel(
      " Quel est le plus grand problème de la déforestation ? ",
      {
        " Les arbres sont tristes.": false,
        " La menace des écosystèmes et de la biodiversité ": true,
        " L’utilisation excessive du bois est bonne pour l’economie": false,
        " On ne pourra plus se promener en forêt": false,
      },
      "ForetQuizz/quiz_f_q10.m4a",
      explanation:
          "Le plus grand problème de la déforestation c'est la menace des écosystèmes et la biodiversité",
      audioPalyerExplanation: "ForetQuizz/quiz_f_r10.m4a"),
  QuestionModel(
      " Planter des arbres, ça aide à lutter contre la pollution ",
      {
        "vrai": true,
        "faux": false,
      },
      "ForetQuizz/quiz_f_q11.m4a",
      explanation:
          "Les feuilles d'arbres sont recouvertes de micro-poils et d'une pellicule un peu luisante, la cuticule. Ces poils et cette cuticule capturent une partie des particules polluantes de l'air, comme du ruban adhésif. ",
      audioPalyerExplanation: "ForetQuizz/quiz_f_r11.m4a"),
  QuestionModel(
      " Planter des arbres, ça aide à lutter contre le réchauffement climatique",
      {
        "vrai": true,
        "faux": false,
      },
      "ForetQuizz/quiz_f_q12.m4a",
      explanation:
          "Les arbres jouent un rôle important dans la lutte contre le réchauffement climatique. Ils absorbent le dioxyde de carbone (CO2) de l'atmosphère pendant la photosynthèse et stockent le carbone dans leur biomasse et dans le sol. ",
      audioPalyerExplanation: "ForetQuizz/quiz_f_r12.m4a"),
];
