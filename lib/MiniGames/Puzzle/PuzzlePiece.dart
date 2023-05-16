
import 'package:flame/experimental.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'PuzzleManager.dart';
class PuzzlePiece extends SpriteComponent with DragCallbacks {
  late int Level;
  late double TrueX;
  late double TrueY;
  late double TrueWidth;
  late double TrueHeight;
  @override
  late bool fixed=false;
  late int Xtab ;
  late int Ytab;
  late int ind;
  Vector2 sizeScr;
  PuzzleManager puzzleManager;
  double Xdebut;
  double Ydebut;
  double taille;
  late Vector2 positionOriginale;
  /*
   Pour comprendre le code il fait regarder les grilles des puzzle
   nous avons utilise des blocs de 400x400px avec 240 px pour le carre principal de la piece
   et 60 px pour le bord sortant
   Ce qui nous donne des ratio speciaux que nous avons suivit adapte au design fournit
   */
  //CONSTRUCTEUR
  PuzzlePiece({required this.Level,required this.ind,required this.puzzleManager,required this.sizeScr,required this.Xdebut,required this.Ydebut,required this.taille}){
     Xtab=(ind%Level) ;
     Ytab=ind~/(Level);
  }
  bool ENDDraggable=false;
  bool _isDragged=false;
  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);

  }
  double CalculateX(double Xvoulu){
    if(Xtab>=2){
      return Xvoulu-this.width*0.65/4;
    }else{
      return Xvoulu;
    }
  }
  double CalculateY(double Yvoulu){

    if(Ytab>0){
      return Yvoulu-this.height*0.65/4;//ratio oublie pas de le transformer
    }else{
      return Yvoulu;
    }
  }
  double CalculateTrueW(){
    if(Xtab==0 || Xtab==Level-1){
      return this.width*3.05/4;
    }else{
      return this.width*2.39/4;
    }
  }
  double CalculateTrueH(){
    if(Ytab>0){
      return this.height*3.05/4;
    }else{
      return this.width*2.39/4;
    }
  }
  double CalculerFakeW_TQ(double W) {
    if (Xtab==1) {
      return W* 4 / 2.39;
    } else {
     return W * 4 / 2.39;
    }
  }
  double CalculerFakeH_TQ(double H){
    if(Ytab>0){
      return H*4/2.39;
      //CECI EST LE MEME RATIO QUE L'EQUIPE DE DESIGN A CREE

    }else{
      return  H*4/2.39;
    }
  }
  @override
  void onDragStart(DragStartEvent event) {
    /// CETTE FONCTION EST UTILISE LORSQUE L'ENFANT TOUCHE LA PIECE DE PUZZLE
    super.onDragStart(event);
    positionOriginale=this.position.clone();
    _isDragged = true;
    priority = 10;
  }
  @override
  void onDragUpdate(DragUpdateEvent event) {
    /// CETTE FONCTION EST UTILISE TANTQUE L'ENFANT A LA PIECE DE PUZZLE EN MAIN
    super.onDragUpdate(event);
    if(fixed==false){
      position+=event.delta;

    }
  }
  @override
  void onDragEnd(DragEndEvent event) {

    /// CETTE FONCTION EST UTILISE LORSQUE L'ENFANT LACHE LA PIECE DE PUZZLE
    super.onDragEnd(event);
    _isDragged = false;
    priority = 0;
    if (this.x <
        this.CalculateX(Xdebut + (taille / Level) * (ind % Level)) + 20 &&
        this.x >
            this.CalculateX(Xdebut + (taille / Level) * (ind % Level)) - 20) {
      if (this.y < this.CalculateY(Ydebut + (ind ~/ Level) * taille / Level) + 20 &&
          this.y > this.CalculateY(Ydebut + (ind ~/ Level) * taille / Level) - 20 && fixed==false) {
        this.puzzleManager.SpawnNew();
        fixed=true;
        //dans ce cas la piece de puzzle est bien place dont on la fixe
        this.position=Vector2(this.CalculateX(Xdebut + (taille / Level) * (ind % Level)),this.CalculateY(Ydebut + (ind ~/ Level) * taille / Level));
      } else {
        this.position = this.positionOriginale.clone();
        //Mal place
      }
    }else{
      this.position=this.positionOriginale.clone();
      //Mal place
    }
  }
}