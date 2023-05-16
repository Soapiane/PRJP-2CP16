
enum Zones {
  //all the zones of the game
  ville(name: "Ville", cardImagePath: "assets/zones/cards/ville.png", backgroundImagePath: "assets/zones/backgrounds/ville.png"),
  zoneIndustrielle(name: "Zone Industrielle", cardImagePath: "assets/zones/cards/zoneIndustrielle.png", backgroundImagePath: "assets/zones/backgrounds/zone_industrielle.png"),
  foret(name: "Foret", cardImagePath: "assets/zones/cards/foret.png", backgroundImagePath: "assets/zones/backgrounds/foret.png"),
  mer(name: "Mer", cardImagePath: "assets/zones/cards/mer.png", backgroundImagePath: "assets/zones/backgrounds/mer.png"),
  alea(name: "Quiz aléatoire",cardImagePath: "assets/zones/cards/alea.png", backgroundImagePath: "assets/zones/backgrounds/main_background.png" );


  final String name, cardImagePath, backgroundImagePath;

  const Zones({
    required this.name,
    required this.cardImagePath,
    required this.backgroundImagePath,
  });

  int get id => index+1;




}