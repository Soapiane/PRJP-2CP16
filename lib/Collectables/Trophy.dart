enum Trophies {
  // Add your trophies here
  villeTrophy(
    "Trophy de la vill",
    "ce trophée est obtenu lorsque tous les niveaux de la ville sont terminés",
    "assets//trophies/ville_trophy.svg",
  ),
  zoneIndustrielleTrophy(
    "Trophy de la zone industrielle",
    "ce trophée est obtenu lorsque tous les niveaux de la zone industrielle sont terminés",
    "assets//trophies/zone_industrielle_trophy.svg",
  ),
  mereTrophy(
    "Trophy de la mer",
    "ce trophée est obtenu lorsque tous les niveaux de la mer sont terminés",
    "assets//trophies/mer_trophy.svg",
  ),
  foretTrophy(
    "Trophy de la forêt",
    "ce trophée est obtenu lorsque tous les niveaux de la forêt sont terminés",
    "assets//trophies/foret_trophy.svg",
  );

  final String title, description, imagePath;

  const Trophies(
    this.title,
    this.description,
    this.imagePath,
  );


  int get id => index+1;

}

class Trophy {

  final bool isUnlocked;
  late Trophies trophy;

  Trophy({
    required this.isUnlocked,
    required this.trophy,
  });


  int get id => trophy.id;




}