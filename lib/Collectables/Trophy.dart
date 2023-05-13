enum Trophy {
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

  const Trophy(
    this.title,
  );


  int get id => index+1;

}