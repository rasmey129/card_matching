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
  final String frontImage;
  bool faceUp;
  bool matched;

  CardModel({required this.frontImage, this.faceUp = false,this.matched = false});
}
