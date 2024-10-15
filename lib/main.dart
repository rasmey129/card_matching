import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Card Matching Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GameScreen(),
    );
  }
}
class GameCard extends StatelessWidget {
  final bool isFaceUp;
  final int frontNumber;
  const GameCard({required this.isFaceUp, required this.frontNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: isFaceUp
            ? null
            : DecorationImage(
                image: AssetImage('assets/card_back.png'),
                fit: BoxFit.cover,
              ), 
        color: isFaceUp ? Colors.blue : null, 
      ),
      child: Center(
        child: isFaceUp
            ? Text(
                '$frontNumber',  
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              )
            : null, 
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

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<CardModel> cards = [];
  
  @override
  void initState() {
    super.initState();
    cards = generateCards();  
  }

  List<CardModel> generateCards() {
    List<int> numbers = List.generate(8, (index) => index + 1);  
    List<int> allNumbers = [...numbers, ...numbers]; 
    allNumbers.shuffle();  

    return allNumbers.map((number) => CardModel(frontNumber: number)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Matching Game'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,  
        ),
        itemCount: cards.length,
        itemBuilder: (context, index) {
          final card = cards[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                card.faceUp = !card.faceUp;  
              });
            },
            child: GameCard(isFaceUp: card.faceUp, frontNumber: card.frontNumber),
          );
        },
      ),
    );
  }
}
