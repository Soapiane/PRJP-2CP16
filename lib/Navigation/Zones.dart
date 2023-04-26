
enum Zones {
  ville(name: "Ville", cardImagePath: "assets/zones/cards/mer_card.svg", backgroundImagePath: "assets/zones/backgrounds/ville.png"),
  zoneIndustrielle(name: "Zone Industrielle", cardImagePath: "assets/zones/cards/mer_card.svg", backgroundImagePath: "assets/zones/backgrounds/zone_industrielle.png"),
  foret(name: "Foret", cardImagePath: "assets/zones/cards/mer_card.svg", backgroundImagePath: "assets/zones/backgrounds/main_background.png"),
  mere(name: "Mer", cardImagePath: "assets/zones/cards/mer_card.svg", backgroundImagePath: "assets/zones/backgrounds/mer.png");

  final String name, cardImagePath, backgroundImagePath;

  const Zones({
    required this.name,
    required this.cardImagePath,
    required this.backgroundImagePath,
  });

  int get id => index+1;




}