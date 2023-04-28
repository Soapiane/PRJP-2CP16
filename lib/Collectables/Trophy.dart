enum Trophies {
  // Add your trophies here
  villeTrophy(
    "Finir la zone ville avec 3 etoiles dans tous les niveaux",
  ),
  zoneIndustrielleTrophy(
    "Finir la zone industielle avec 3 etoiles dans tous les niveaux",
  ),
  foretTrophy(
    "Finir la zone foret avec 3 etoiles dans tous les niveaux",
  ),
  mereTrophy(
    "Finir la zone mer avec 3 etoiles dans tous les niveaux",
  );

  final String title;

  const Trophies(
    this.title,
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