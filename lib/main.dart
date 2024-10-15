import 'package:flutter/material.dart';

void main() {
  runApp(const GameCard());
}

class GameCard extends StatelessWidget{
  final bool faceUp;
  final String frontImage;

  const GameCard({required this.faceUp, required this.frontImage});

  @override

  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
       image: faceUp
       ? DecorationImage(image: AssetImage(frontImage))
        : DecorationImage(image: AssetImage('assets/card_back.png')),
      ),
    );
  }
}

class CardModel{
  final int frontNumber;
  bool faceUp;
  bool matched;

  CardModel({required this.frontNumber, this.faceUp = false,this.matched = false});
}

class FlippingCard extends StatefulWidget{
  final bool flipped;
  const FlippingCard({required this.flipped});

  @override 
  FlippingCardState createState() => FlippingCardState();
}

class FlippingCardState extends State<FlippingCard> with SingleTickerProviderStateMixin{
  late AnimationController controller;

  @override 
  void initState(){
    super.initState();
    controller = AnimationController(duration: const Duration(milliseconds: 700), vsync: this,);
  }

  @override 
  Widget build(BuildContext context){
    return AnimatedBuilder(animation: controller,builder: (context,child){
      return Transform(
        transform: Matrix4.rotationY(controller.value * 3.14), child: child,
      );
    },
  
    );
  }
}