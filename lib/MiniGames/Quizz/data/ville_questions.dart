import 'package:flutter/material.dart';

import '../model/question_model.dart';

List<QuestionModel> questionsVille = [
  QuestionModel(
      " La pollution de l'air en ville est la pollution causée par ",
      {
        " Les usines ": false,
        " Les voitures, les bus et les camions ": true,
        " Les incendies ": false,
        " Autres ": false,
      },
      "quiz_v_q1.m4a"),
  QuestionModel(
    "	Quels sont les principaux gaz polluants émis par les véhicules en ville ? ",
    {
      " Le dioxyde de carbone et l'oxyde d'azote ": true,
      " Le méthane et le monoxyde de carbone ": false,
      " Le dioxyde de soufre et le plomb ": false,
      "Aucune réponse ": false,
    },
    "quiz_v_q2.m4a",
  ),
  QuestionModel(
    "	Si l'air de la ville est pollué on peut avoir des problèmes de:  ",
    {
      "	Respiration et de cœur ": true,
      "	Digestion et de peau ": false,
      "	Cerveau et de santé mentale ": false,
      " L'air pollué ne cause pas de maladies ": false,
    },
    "quiz_v_q3.m4a",
  ),
  QuestionModel(
    "	La pollution lumineuse dans les villes c'est quand :  ",
    {
      " il y a trop de lumières la nuit.  ": true,
      " les décorations lumineuses brillent trop. ": false,
      " les panneaux publicitaires brillent trop. ": false,
      " Les lumières des gratte-ciel sont trop fortes. ": false,
    },
    "quiz_v_q4.m4a",
  ),
  QuestionModel(
      " La pollution sonore peux nous causer des :  ",
      {
        " Problèmes de sommeil ": true,
        " Problèmes de vue et de concentration ": false,
        " Douleurs musculaires ": false,
        " La pollution sonore n'affecte pas la santé ": false,
      },
      "quiz_v_q5.m4a"),
  QuestionModel(
      " Le recyclage des déchets c'est ",
      {
        " Réutiliser les déchets pour fabriquer des produits. ": true,
        "	Transformer les déchets en énergie. ": false,
        "	Détruire les déchets dans des incinérateurs. ": false,
        " Jeter les déchets par terre": false,
      },
      "quiz_v_q6.m4a"),
  QuestionModel(
      "C'est l'heure de se laver ! Pour économiser l'eau et faire sa toilette correctement, mieux vaut :",
      {
        " Prendre un bain de 150 litres": false,
        " Ne pas se laver pendant deux ans d'affilée": false,
        " Prendre une douche de 10 min.": false,
        " Prendre une douche de 5 min.": true,
      },
      "quiz_v_q7.m4a"),
  QuestionModel(
      " Où mets-tu une boîte de pizza en carton vide et propre ",
      {
        " Ailleurs ": false,
        " Dans le bac de récupération ": true,
        " Dans le bac à compost ": false,
        " Dans la poubelle ": false,
      },
      "quiz_v_q8.m4a",
      explanation:
          "Dans le bac de récuppération. \nLe carton d'une boîte de pizza propre est recyclable, comme le papier et le carton en général.",
      audioPalyerExplanation: "quiz_v_r8.m4a"),
  QuestionModel(
      " Où mets-tu une boîte de pizza en carton vide et sale? ",
      {
        " Dans le bac de récupération ": false,
        " Dans la poubelle ": false,
        " Dans le bac à compost ": true,
        " Aileurs": false,
      },
      "quiz_v_q9.m4a",
      explanation:
          " Dans le bac à compost. Le carton souillé est compostable.\n Mais attention, il ne doit pas être ciré ni plastifié.",
      audioPalyerExplanation: "quiz_v_r9.m4a"),
  QuestionModel(
      " Où mets-tu le couvercle en aluminium d'un pot de yogourt ou de compote de fruits? ",
      {
        " Dans le bac de récupération": true,
        " Dans le bac à compost": false,
        " Dans la poubelle": false,
        " Ailleurs": false,
      },
      "quiz_v_q10.m4a",
      explanation:
          "Dans le bac de récupération. \nNettoie-le du mieux que tu peux. Fais-en une boule avec la partie sale au centre. Ainsi, les résidus de nourriture ne contamineront pas les autres matières du bac de récupération. ",
      audioPalyerExplanation: "quiz_v_r10.m4a"),
  QuestionModel(
      " Où mets-tu une fourchette en plastique?",
      {
        " Dans le bac de récupération": false,
        " Dans le bac à compost": false,
        " Dans la poubelle": true,
        " Ailleurs": false,
      },
      "quiz_v_q11.m4a",
      explanation:
          "Dans la poubelle\nLes ustensiles en plastique (fourchette, couteau et cuillère) vont à la poubelle.",
      audioPalyerExplanation: "quiz_v_r11.m4a"),
  QuestionModel(
    "Où mets-tu tes piles lorsqu'elles ne fonctionnent plus?",
    {
      " Ailleurs": true,
      " Dans le bac à compost": false,
      " Dans le bac de récupération": false,
      " Dans la poubelle": false,
    },
    "quiz_v_q12.m4a",
    explanation:
        "Ailleurs\nDébarrasse-toi de tes vieilles piles à la pharmacie ou dans un écocentre : tu y trouveras des boîtes de collecte. Il est dangereux de mettre des piles dans le bac de récupération ou le bac à compost. Elles peuvent entraîner des incendies dans les centres de tri.",
    audioPalyerExplanation: "quiz_v_r12.m4a",
  ),
  QuestionModel(
      "Où mets-tu tes mouchoirs usés?",
      {
        " Dans la poubelle ": false,
        " Dans le bac à compost": true,
        " Dans le bac de récupération": false,
        " Ailleurs": false,
      },
      "quiz_v_q13.m4a",
      explanation:
          "Dans le bac à compost\nLes mouchoirs en papier souillés sont compostables.",
      audioPalyerExplanation: "quiz_v_r13.m4a"),
  QuestionModel(
      "Où mets-tu un contenant de plastique biodégradable ?",
      {
        " Dans le bac à compost": false,
        " Dans la poubelle ": true,
        " Dans le bac de récupération": false,
        " Autre part": false,
      },
      "quiz_v_q14.m4a",
      explanation:
          "Dans la poubelle\nIl ne faut pas les mettre au compost, malgré leur étiquette biodégradable.",
      audioPalyerExplanation: "quiz_v_r14.m4a"),
  QuestionModel(
      "Où mets-tu une pellicule plastique usée, mais propre ?",
      {
        " Dans la poubelle": false,
        " Dans le bac à compost": false,
        " Dans le bac de récupération": true,
        " Autre part": false,
      },
      "quiz_v_q15.m4a",
      explanation:
          "Dans le bac de récupération.\nLes sacs et pellicules de plastique sont recyclables lorsqu'ils sont propres. S'ils sont sales, il faut les jeter à la poubelle.",
      audioPalyerExplanation: "quiz_v_r15.m4a"),
  QuestionModel(
      "Où mets-tu un moule à muffins en papier ?",
      {
        " Dans le bac à compost": true,
        " Dans le bac de récupération": false,
        " Dans la poubelle": false,
        " Autre part": false,
      },
      "quiz_v_q16.m4a",
      explanation:
          "Dans le bac à compost.\nLes moules à muffins sont compostables lorsqu'ils ne sont ni cirés ni plastifiés.",
      audioPalyerExplanation: "quiz_v_r16.m4a"),
  QuestionModel(
      "Où mets-tu une boîte de jus individuelle ?",
      {
        " Dans le bac de récupération": true,
        " Dans la poubelle": false,
        " Dans le bac à compost": false,
        " Autre part": false,
      },
      "quiz_v_q17.m4a",
      explanation:
          "Dans le bac de récupération.\nJette d'abord la paille et son emballage de plastique à la poubelle. La boîte de carton, elle, est recyclable.",
      audioPalyerExplanation: "quiz_v_r17.m4a"),
  QuestionModel(
      "Quelle est l'une des choses que je peux faire pour recycler ?",
      {
        " Jeter par terre plusieurs bouteilles en plastique": false,
        " Jeter mes déchets dans la bonne poubelle": true,
        " Ne surtout pas ramasser les emballages par terre": false,
        " Regarder les éboueurs passer": false,
      },
      "quiz_v_q18.m4a"),
  QuestionModel(
      "Que fabrique-t-on lorsque l'on recycle des emballages de carton ?",
      {
        " Du carton ondulé": true,
        " Des journaux": false,
        " Des briques alimentaires": false,
        " Rien ": false,
      },
      "quiz_v_q19.m4a"),
  QuestionModel(
      "Que peut-on fabriquer lorsque l'on recycle des canettes en acier ?",
      {
        " Des chariots de supermarché": true,
        " Des barquettes en aluminium": false,
        " Des journaux ": false,
        " Rien": false,
      },
      "quiz_v_q20.m4a"),
  QuestionModel(
      "  A quoi correspond la poubelle de couleur jaune ?",
      {
        " Le papier/carton et le plastique": true,
        " Le verre": false,
        " Les ordures ménagères ": false,
        " Une poubelle jolie": false,
      },
      "quiz_v_q21.m4a"),
  QuestionModel(
      "Où doit-on jeter les sacs plastiques et autres sacs de caisse ?",
      {
        " Dans la nature": false,
        " Au recyclage": true,
        " Dans une poubelle traditionnelle": false,
        " Dans la mer": false,
      },
      "quiz_v_q22.m4a"),
  QuestionModel(
    "Qu'est-ce qui cause le réchauffement climatique ?",
    {
      " L'activité solaire ": false,
      " Les éruptions volcaniques ": false,
      " L'activité humaine ": true,
      " Le mouvement des plaques tectoniques": false,
    },
    "quiz_v_q23.m4a",
    explanation:
        "L'activité humaine est la principale cause du réchauffement climatique. Les activités telles que la combustion de combustibles fossiles et la déforestation ont augmenté les niveaux de gaz à effet de serre dans l'atmosphère, piégeant la chaleur et provoquant un réchauffement global de la planète.",
    audioPalyerExplanation: "quiz_v_r23.m4a",
  ),
  QuestionModel(
      "Qu'est-ce que l'effet de serre ?",
      {
        " Le piégeage de la chaleur dans l'atmosphère terrestre": true,
        " L'effet des gaz à effet de serre sur la photosynthèse ": false,
        " L'effet de l'altitude sur la température ": false,
        " L'effet des éruptions volcaniques sur le climat": false,
      },
      "quiz_v_q24.m4a",
      explanation:
          "L'effet de serre est le processus de piégeage de la chaleur dans l'atmosphère terrestre par les gaz à effet de serre tels que le dioxyde de carbone, le méthane et le gaz fluoré. Cet effet est important pour maintenir la température de la planète à un niveau habitable, mais des niveaux élevés de gaz à effet de serre causés par l'activité humaine ont entraîné un réchauffement global.",
      audioPalyerExplanation: "quiz_v_r24.m4a"),
  QuestionModel(
    "Quand je me brosse les dents. Donne la meilleure réponse pour économiser. ",
    {
      " J'ouvre le robinet au maximum": false,
      " Je me douche en même temps": false,
      " J'utilise un verre pour consommer encore moins.": true,
      "Aucune réponse": false,
    },
    "quiz_v_q25.m4a",
  )
];
