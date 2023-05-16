import '../model/question_model.dart';

//the list of the questions of the quizz of zone which is a list of QuestionModel objects
List<QuestionModel> questionsZone = [
  QuestionModel(
      "Une énergie renouvelable est une energie :",
      {
        " Qui vient d'être découverte.": false,
        " Qui se renouvelle.": true,
        " Industrielle": false,
        " Qui n'existe plus": false,
      },
      "ZoneQuizz/quiz_z_q1.m4a",
      explanation:
          "Une énergie qui se renouvelle vite et ne s'épuise pas, si elle est bien gérée.",
      audioPalyerExplanation: "ZoneQuizz/quiz_zone_r1.m4a"),
  QuestionModel(
      "Il est important de développer les énergies renouvelables pour des raisons :",
      {
        " écologiques": true,
        " économiques": false,
        " pratiques": false,
        " politiques": false,
      },
      "ZoneQuizz/quiz_z_q2.m4a",
      explanation:
          "Il est important de dévlopper des énergies renouvelables pour des raisons écologiques.\n Elles ne sont pas polluantes et sont inépuisables.",
      audioPalyerExplanation: "ZoneQuizz/quiz_zone_r2.m4a"),
  QuestionModel(
      "Le soleil, le vent, la biomasse, les océans et l'hydroélectricité sont des sources d'énergie renouvelables ainsi dénommées parce qu'elles…",
      {
        " Sont gratuites": false,
        " Sont couteuses": false,
        " Se convertissent en électricité": false,
        " Sont reconstituées par la nature": true,
      },
      "ZoneQuizz/quiz_z_q3.m4a",
      explanation:
          " Elles sont ainsi dénomées par ce qu'elles sont constamment reconstituées par la nature.  ",
      audioPalyerExplanation: "ZoneQuizz/quiz_zone_r3.m4a"),
  QuestionModel(
      "On appelle les panneaux qui transforment le rayonnement du Soleil en électricité, des panneaux ",
      {
        " Energétiques": false,
        " Solaires": true,
        " Ecologiques ": false,
        " Aucune réponse": false,
      },
      "ZoneQuizz/quiz_z_q4.m4a",
      explanation: "Ils sont appelés des panneaux solaires photovoltaïques",
      audioPalyerExplanation: "ZoneQuizz/quiz_zone_r5.m4a"),
  QuestionModel(
      "L'énergie du soleil peut apporter de l'énergie sous forme de ?",
      {
        " Pollution": false,
        " Hydraulique": false,
        " Chaleur et électricité": true,
        " Aucune réponse": false,
      },
      "ZoneQuizz/quiz_z_q5.m4a",
      explanation:
          "L'énergie du soleil permet d'obtenir de l'énergie sous forme de chaleur et d'électricité ",
      audioPalyerExplanation: "ZoneQuizz/quiz_zone_r7.m4a"),
  QuestionModel(
      " Laquelle de ces énergies fonctionne à partir de l'eau ?",
      {
        " L'énergie hydraulique.": true,
        " L'énergie éolienne.": false,
        " L'énergie hydrolienne.": false,
        "Aucune réponse": false,
      },
      "ZoneQuizz/quiz_z_q6.m4a",
      explanation: "L'energie hydraulique fonctionne à partir de l'eau",
      audioPalyerExplanation: "ZoneQuizz/quiz_zone_r8.m4a"),
  QuestionModel(
      " Qu'est-ce que l'énergie solaire ? L'énergie produite à partir",
      {
        " Du vent": false,
        " De la chaleur de la Terre ": false,
        " Du soleil": true,
        " De l'eau ": false,
      },
      "ZoneQuizz/quiz_z_q7.m4a",
      explanation:
          "L'énergie solaire est l'énergie produite à partir du soleil",
      audioPalyerExplanation: "ZoneQuizz/quiz_zone_r9.m4a"),
  QuestionModel(
      " Quel est le principal avantage de l'énergie hydraulique ? Elle est",
      {
        " Constante et prévisible ": true,
        " Fossile ": false,
        " Elle n'a pas besoin d'eau ": false,
        " Toutes les réponses ": false,
      },
      "ZoneQuizz/quiz_z_q9.m4a",
      explanation:
          "Le principal avantage de l'énergie hydraulique est qu'elle est constante et prévisible",
      audioPalyerExplanation: "ZoneQuizz/quiz_zone_r12.m4a"),
  QuestionModel(
      " Quel est le principal inconvénient de l'énergie solaire ?",
      {
        " Dépend des conditions météorologiques": true,
        " Elle est constante et prévisible  ": false,
        " Non renouvelable ": false,
        " Aucune réponse ": false,
      },
      "ZoneQuizz/quiz_z_q10.m4a",
      explanation:
          "Le principal inconvénient de l'énergie solaire est qu'elle dépend des conditions météorologiques et de l'ensoleillement",
      audioPalyerExplanation: "ZoneQuizz/quiz_zone_r13.m4a"),
  QuestionModel(
      " Quel est l'impact environnemental des déchets toxiques produits par les usines ? Les déchets peuvent…",
      {
        " Contaminer les sols et les eaux souterraines": true,
        " Préserver la biodiversité ": false,
        " Causer des éruptions volcaniques ": false,
        " Ils n'ont pas d'impact environnemental": false,
      },
      "ZoneQuizz/quiz_z_q11.m4a",
      explanation:
          "Les déchets toxiques produits par les usines peuvent contaminer les sols et les eaux souterraines, ce qui peut avoir un impact sur la santé des humains et de la faune, ainsi que sur l'environnement dans son ensemble.",
      audioPalyerExplanation: "ZoneQuizz/quiz_zone_r15.m4a"),
  QuestionModel(
      "	Les panneaux solaires ne servent à rien s'il ne fait pas soleil.",
      {
        " Vrai": false,
        " Faux": true,
      },
      "ZoneQuizz/quiz_z_q0.m4a",
      explanation:
          "Pas besoin dun beau ciel bleu pour que les panneaux solaires fonctionnent. Même lorsqu'il fait gris, la lumière perce à travers les nuages. Cela suffit pour créer de l'électricité. À la moindre onde lumineuse provenant du soleil, une réaction en chaîne se produit dans la cellule photovoltaïque et un courant électrique se crée. C'est grâce à ce courant qu'on peut alimenter des appareils électriques. Par contre, il est vrai que les panneaux solaires sont moins efficaces lorsqu'il fait sombre et pas du tout la nuit. Ainsi, pour implanter un champ de panneaux solaires, on choisit des régions où il y a beaucoup d'ensoleillement !",
      audioPalyerExplanation: "ZoneQuizz/quiz_zone_r0.m4a"),
  QuestionModel(
      "L'énergie solaire est une énergie fossile",
      {
        "Vrai": false,
        "Faux": true,
      },
      "ZoneQuizz/quiz_z_r15.m4a",
      explanation:
          "l'énergie solaire est une énergie renouvelable, cela signifie qu'elle provient d'une source qui ne s'épuise pas et qui est constamment renouvelée par la nature. Contrairement aux énergies fossiles qui peuvent s'épuiser un jour, nous pouvons compter sur le soleil pour produire de l'énergie de manière durable et respectueuse de l'environnement.",
      audioPalyerExplanation: "ZoneQuizz/quizz_z_r15.m4a"),
  QuestionModel(
      "L'énergie renouvelable peut-elle aider à protéger l'environnement en :",
      {
        "polluant l'air": false,
        "utilisant des ressources non renouvlables": false,
        "réduisant les émissions de gaz à effet de serre": true,
        "augmentant la uantité de déchets dans les décharges": false,
      },
      "ZoneQuizz/quiz_z_q16.m4a",
      explanation:
          "L'énergie renouvelable peut aider à protéger l'environnement en réduisant les émissions de gaz à effet de serre",
      audioPalyerExplanation: "ZoneQuizz/quiz_z_r16.m4a"),
  QuestionModel(
      "Il est important de réduire notre consommation en énergie pour :",
      {
        "en gaspiller toujours plus": false,
        "préserver les ressources naturelles": true,
        "causer plus de pollution": false,
        "rendre les industries plus puissantes": false,
      },
      "ZoneQuizz/quiz_z_q17.m4a",
      explanation:
          "Il est important de réduire notre consommation en énergie pour préserver les ressources naturelles ",
      audioPalyerExplanation: "ZoneQuizz/quiz_z_r17.m4a"),
  QuestionModel(
      "Les déchets produits par les usines doivent etre:",
      {
        "jetés dans la nature": false,
        "envoyés dans l'espace": false,
        "recyclés ou traités": true,
        "utilisés pour produire de l'énergie": false,
      },
      "ZoneQuizz/quiz_z_q18.m4a",
      explanation:
          "Les déchets produits par les usines doivent être recyclés ou traités pour minimiser leur impact sur l'environnement.",
      audioPalyerExplanation: "ZoneQuizz/quiz_z_r18.m4a"),
  QuestionModel(
      "Qu'est-ce que la pollution de l'air ?",
      {
        "Une énergie renouvelable": false,
        "Les substances toxiques dans l'air": true,
        "Les déchets liquides dans l'air": false,
        "Aucune réponse": false,
      },
      "ZoneQuizz/quiz_z_q19.m4a",
      explanation:
          "Par pollution de l’air , on sous-entends les substances toxiques présentes dans l’air qui peuvent nuire aux êtres vivants",
      audioPalyerExplanation: "ZoneQuizz/quiz_z_r19.m4a"),
  QuestionModel(
      "Comment les humains contribuent-ils à l'augmentation des gaz à effet de serre ?",
      {
        "En respirant": false,
        "En utilisant des combustibles fossiles": true,
        "En utilisant des voitures électriques": false,
        "En achetant des plantes": false,
      },
      "ZoneQuizz/quiz_z_q20.m4a",
      explanation:
          " Les humains contribuent-ils à l'augmentation des gaz à effet de serre  principalement en utilisant des combustibles fossiles",
      audioPalyerExplanation: "ZoneQuizz/quiz_z_r20.m4a"),
  QuestionModel(
    "Le charbon, le pétrole et le gaz naturel sont des énergies fossiles. ",
    {
      "Vrai": false,
      "Faux": true,
    },
    "ZoneQuizz/quiz_z_q24.m4a",
  )
];
