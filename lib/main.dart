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
            : const DecorationImage(
                image: AssetImage('assets/card_back.png'),
                fit: BoxFit.cover,
              ), 
        color: isFaceUp ? Colors.blue : null, 
      ),
      child: Center(
        child: isFaceUp
            ? Text(
                '$frontNumber',  
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              )
            : null, 
      ),
    );
  }
}

class CardModel {
  final int frontNumber;
  bool faceUp;
  bool matched;

  CardModel({required this.frontNumber, this.faceUp = false, this.matched = false});
}

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<CardModel> cards = [];
  CardModel? firstFlippedCard;
  
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

  void handleCardTap(CardModel tappedCard) {
    if (!tappedCard.faceUp && firstFlippedCard == null) {
     
      setState(() {
        tappedCard.faceUp = true;
        firstFlippedCard = tappedCard;
      });
    } else if (!tappedCard.faceUp && firstFlippedCard != null) {
     
      setState(() {
        tappedCard.faceUp = true;
      });

      if (firstFlippedCard!.frontNumber == tappedCard.frontNumber) {
       
        setState(() {
          firstFlippedCard!.matched = true;
          tappedCard.matched = true;
          firstFlippedCard = null;
          checkWinCondition();  
        });
      } else {
       
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            firstFlippedCard!.faceUp = false;
            tappedCard.faceUp = false;
            firstFlippedCard = null;
          });
        });
      }
    }
  }

  void checkWinCondition() {
    if (cards.every((card) => card.matched)) {
      
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('You Win!'),
          content: const Text('Congratulations, you matched all the cards!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                resetGame();
              },
              child: const Text('Restart'),
            ),
          ],
        ),
      );
    }
  }

  void resetGame() {
    setState(() {
      cards = generateCards();  
    });
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
              if (!card.matched && !card.faceUp) {
                handleCardTap(card);
              }
            },
            child: GameCard(isFaceUp: card.faceUp, frontNumber: card.frontNumber),
          );
        },
      ),
    );
  }
}
