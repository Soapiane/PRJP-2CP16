
enum Zones {
  ville(name: "ville", cardImagePath: "assets/zones/cards/mer_card.svg"),
  zoneIndustrielle(name: "ville", cardImagePath: "assets/zones/cards/mer_card.svg"),
  foret(name: "ville", cardImagePath: "assets/zones/cards/mer_card.svg"),
  mere(name: "ville", cardImagePath: "assets/zones/cards/mer_card.svg");

  final String name, cardImagePath;

  const Zones({
    required this.name,
    required this.cardImagePath,
  });

}