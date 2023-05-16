import 'package:projet2cp/MiniGames/Quizz/model/question_model.dart';
//The list of the questions of the quizz of mer zone which is a list of QuestionModel objects

List<QuestionModel> questionsMer = [
  QuestionModel(
      "Quel est le matériau qui met le plus de temps à se dégrader ? ",
      {
        " Le plastique ": false,
        " Le verre ": true,
        " Le papier ": false,
        " L'aliminium ": false,
      },
      "MerQuizz/quiz_m_q1.m4a",
      explanation:
          "Le verre met entre 2000 et 4000 ans à se dégrader.\n La bonne nouvelle est qu'on peut le recycler à l'infini !",
      audioPalyerExplanation: "MerQuizz/quiz_m_r1.m4a"),
  QuestionModel(
      " De quel matériau sont composés la majorité des débris trouvés en mer ? ",
      {
        " Le plastique ": true,
        " Le verre ": false,
        " Le papier ": false,
        " L'aliminium ": false,
      },
      "MerQuizz/quiz_m_q2.m4a",
      explanation:
          "Le plastique ennemi numéro 1 ! 60 à 95% des débris sont composés de plastique, essentiellement sous forme d'emballages comme les sacs plastique ou les bouteilles.",
      audioPalyerExplanation: "MerQuizz/quiz_m_r2.m4a"),
  QuestionModel(
      " Qu'est-ce que la pollution marine ? ",
      {
        " Les rejets de l'activité humaine ": true,
        " Une espèce de poissons.": false,
        " Les excréments des animaux marins ": false,
        " Autre ": false,
      },
      "MerQuizz/quiz_m_q3.m4a",
      explanation:
          "Comme c'est agréable de se baigner l'été dans l'océan, parmi les vagues ! En revanche, c'est tout de suite moins sympa quand on se retrouve nez à nez avec des déchets dans l'eau. Qu'ils soient en plastique, en verre, en tissu ou en métal, ils proviennent tous de l'activité humaine.",
      audioPalyerExplanation: "MerQuizz/quiz_m_r3.m4a"),
  QuestionModel(
      " Qu'est-ce qu'une marée noire ? ",
      {
        " Une marée très forte ": false,
        " Une marée propre": false,
        " Une énorme quantité de pétrole déversée dans la mer ": true,
        " Une invasion d'algues toxiques ": false,
      },
      "MerQuizz/quiz_m_q4.m4a",
      explanation:
          "Une marée noire est une catastrophe écologique.\nCe pétrole peut s'échapper d'un bateau ou d'une plateforme pétrolière endommagée et cause beaucoup de dégâts. ",
      audioPalyerExplanation: "MerQuizz/quiz_m_r4.m4a"),
  QuestionModel(
      " Qu'est-ce qu'une station d'épuration ? ",
      {
        " Une usine qui nettoie les eaux usées ": true,
        " Une station qui nettoie les poissons": false,
        " Une usine qui mesure la température de l'eau ": false,
        " Une machine qui pollue la mer  ": false,
      },
      "MerQuizz/quiz_m_q5.m4a",
      explanation:
          "Les stations d'épuration nettoient les eaux usées (des toilettes ou des cuisines) avant de les relâcher dans les rivières et les océans. Mais elles ne sont pas à 100% efficaces : des produits mauvais pour l'environnement restent et sont déversés dans la nature. ",
      audioPalyerExplanation: "MerQuizz/quiz_m_r5.m4a"),
  QuestionModel(
      " Combien y a-t-il d'océans le monde ? ",
      {
        " 1 ": false,
        " 5 ": true,
        " 100 ": false,
        " 900 ": false,
      },
      "MerQuizz/quiz_m_q6.m4a",
      explanation:
          "Il s'agit de l'océan Arctique, du Pacifique, de l'Atlantique, de l'océan Indien et enfin de l'océan Austral qu'on appelle aussi Antarctique. ",
      audioPalyerExplanation: "MerQuizz/quiz_m_r6.m4a"),
  QuestionModel(
      " En majorité d'où viennent  les déchets des océans ? ",
      {
        " Des poissons ": false,
        " De la forêt": false,
        " De l'intérieur des terres ": true,
        " De nulle part ": false,
      },
      "MerQuizz/quiz_m_q7_modif.m4a",
      explanation:
          "80% des déchets des océans viennent de l'intérieur des terres. 10% sont abandonnés sur les rivages et 10% sont jetés directement dans la mer.",
      audioPalyerExplanation: "MerQuizz/quiz_m_r7.m4a"),
  QuestionModel(
      " Pourquoi le plastique est un problème pour les océans ? ",
      {
        " Il ne se décompose jamais sous l’eau": false,
        " Il se décompose en petits morceaux ": true,
        " Le plastique n’est pas un probléme ": false,
        " Tout ce qui a été cité ": false,
      },
      "MerQuizz/quiz_m_q8_modif.m4a",
      explanation:
          "Ces minuscules morceaux de plastique sont plein de produits toxiques et ils se retrouvent partout sur la Terre.",
      audioPalyerExplanation: "MerQuizz/quiz_m_r8.m4a"),
  QuestionModel(
      " Quel est le temps de décomposition d'une bouteille en plastique ? ",
      {
        " Entre 5 et 10 minutes ": false,
        " Entre 1 et 2 heures ": false,
        " Entre 100 et 1000 ans ": true,
        " Ne se décomposent jamais ": false,
      },
      "MerQuizz/quiz_m_q9_modif.m4a",
      explanation:
          "Quand un morceau de plastique tombe par terre, il met tellement de temps à se décomposer qu'il n'aura pas disparu quand tes enfants et tes petits-enfants seront en vie.",
      audioPalyerExplanation: "MerQuizz/quiz_m_r9.m4a"),
  QuestionModel(
      " Que risquent les animaux marins à cause du plastique ?",
      {
        " D'y prendre goût ": false,
        " De se blesser et de mourir ": true,
        " De s'énerver très fort ": false,
        " Autre ": false,
      },
      "MerQuizz/quiz_m_q10_modif.m4a",
      explanation:
          "14 000 mammifères sont chaque année retrouvés morts sur les plages à cause de ça. Mais c'est bien plus en réalité puisque la très grande majorité meurent en mer.",
      audioPalyerExplanation: "MerQuizz/quiz_m_r10.m4a"),
  QuestionModel(
      "Les hydroliennes fonctionnent grâce a ",
      {
        " Des turbines sous-marines ": true,
        " Des panneaux solaires sous l’eau": false,
        " Des bassins d'eau le long des rivages": false,
        " Autre": false,
      },
      "MerQuizz/quiz_m_q13.m4a",
      explanation:
          "Ce sont des turbines fixées au sol sous-marin et totalement immergées. Elles tournent avec l'énergie cinétique des courants sous-marins ",
      audioPalyerExplanation: "MerQuizz/quiz_m_r13.m4a"),
  QuestionModel(
    " Combien d'espèces marines sont menacées par la pollution marine  ",
    {
      " 1 ": false,
      " 693 ": true,
      " 999 ": false,
      " 0 ": false,
    },
    "MerQuizz/quiz_m_q14_modif.m4a",
  ),
];
