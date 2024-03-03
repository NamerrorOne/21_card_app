import 'dart:math';

import 'package:card_game/screens/bottom_modal.dart' as customBottomSheet;
import 'package:flutter/material.dart';

class BlackJackScreen extends StatefulWidget {
  const BlackJackScreen({super.key});

  @override
  State<BlackJackScreen> createState() => _BlackJackScreenState();
}

class _BlackJackScreenState extends State<BlackJackScreen> {
  bool isAlreadyWin = false;

  final Map<String, int> deck = {
    'Cards/2.1.png': 2,
    'Cards/2.2.png': 2,
    'Cards/2.3.png': 2,
    'Cards/2.4.png': 2,
    'Cards/3.1.png': 3,
    'Cards/3.2.png': 3,
    'Cards/3.3.png': 3,
    'Cards/3.4.png': 3,
    'Cards/4.1.png': 4,
    'Cards/4.2.png': 4,
    'Cards/4.3.png': 4,
    'Cards/4.4.png': 4,
    'Cards/5.1.png': 5,
    'Cards/5.2.png': 5,
    'Cards/5.3.png': 5,
    'Cards/5.4.png': 5,
    'Cards/6.1.png': 6,
    'Cards/6.2.png': 6,
    'Cards/6.3.png': 6,
    'Cards/6.4.png': 6,
    'Cards/7.1.png': 7,
    'Cards/7.2.png': 7,
    'Cards/7.3.png': 7,
    'Cards/7.4.png': 7,
    'Cards/8.1.png': 8,
    'Cards/8.2.png': 8,
    'Cards/8.3.png': 8,
    'Cards/8.4.png': 8,
    'Cards/9.1.png': 9,
    'Cards/9.2.png': 9,
    'Cards/9.3.png': 9,
    'Cards/9.4.png': 9,
    'Cards/10.1.png': 10,
    'Cards/10.2.png': 10,
    'Cards/10.3.png': 10,
    'Cards/10.4.png': 10,
    'Cards/J1.png': 2,
    'Cards/J2.png': 2,
    'Cards/J3.png': 2,
    'Cards/J4.png': 2,
    'Cards/Q1.png': 3,
    'Cards/Q2.png': 3,
    'Cards/Q3.png': 3,
    'Cards/Q4.png': 3,
    'Cards/K1.png': 4,
    'Cards/K2.png': 4,
    'Cards/K3.png': 4,
    'Cards/K4.png': 4,
    'Cards/A1.png': 10,
    'Cards/A2.png': 10,
    'Cards/A3.png': 10,
    'Cards/A4.png': 10,
  };
  Map<String, int> playingCards = {};

  bool isGameStarted = false;

  List<Image> myCards = [];
  List<Image> dealersCards = [];

  String? playersFirstCard;
  String? playersSecondCard;

  String? dealersFirstCard;
  String? dealersSecondCard;

  int playersScore = 0;
  int dealersScore = 0;

  var dealerCardsCount;

  void changeCards() {
    setState(() {
      isGameStarted = true;
      isAlreadyWin = false;
      dealerCardsCount = 2;
    });

    playingCards = {};
    playingCards.addAll(deck);

    myCards = [];
    dealersCards = [];

    Random random = Random();

    String cardOneKey =
        playingCards.keys.elementAt(random.nextInt(deck.length));

    //удаление карты из колоды карт в игре
    playingCards.removeWhere((key, value) => key == cardOneKey);

    String cardTwoKey =
        playingCards.keys.elementAt(random.nextInt(playingCards.length));
    playingCards.removeWhere((key, value) => key == cardTwoKey);

    String cardThreeKey =
        playingCards.keys.elementAt(random.nextInt(playingCards.length));
    playingCards.removeWhere((key, value) => key == cardThreeKey);

    String cardFourKey =
        playingCards.keys.elementAt(random.nextInt(playingCards.length));
    playingCards.removeWhere((key, value) => key == cardFourKey);

    dealersFirstCard = cardOneKey;
    dealersSecondCard = cardTwoKey;

    playersFirstCard = cardThreeKey;
    playersSecondCard = cardFourKey;

    dealersCards.add(Image.asset(dealersFirstCard!));
    dealersCards.add(Image.asset(dealersSecondCard!));

    dealersScore = deck[dealersFirstCard]! + deck[dealersSecondCard]!;

    myCards.add(Image.asset(playersFirstCard!));

    myCards.add(Image.asset(playersSecondCard!));

    playersScore = deck[playersSecondCard]! + deck[playersFirstCard]!;
  }

//adding cards to both players
  void addCard() {
    if (playingCards.isNotEmpty) {
      Random random = Random();

      String cardKey =
          playingCards.keys.elementAt(random.nextInt(playingCards.length));

      playingCards.removeWhere((key, value) => key == cardKey);

      setState(() {
        myCards.add(Image.asset(cardKey));
        playersScore = playersScore + deck[cardKey]!;
        if (playersScore == 21) {
          customBottomSheet.showBottomSheet(context, 'Вы выиграли');
          isAlreadyWin = true;
        }

        if (playersScore > 21) {
          customBottomSheet.showBottomSheet(context, 'Перебор. Вы проиграли!');
          isAlreadyWin = true;
        }
      });

      String dealersCardKey =
          playingCards.keys.elementAt(random.nextInt(playingCards.length));
//dealer logic
      if (dealersScore <= 17) {
        var dealersThirdCard = dealersCardKey;

        dealersCards.add(Image.asset(dealersThirdCard));
        dealersScore = dealersScore + deck[dealersThirdCard]!;
        dealerCardsCount++;
      }

      if (dealersScore > 21) {
        setState(() {
          customBottomSheet.showBottomSheet(
              context, 'Dealer перебрал карт. Вы выиграли!');
          isAlreadyWin = true;
        });
      }

      if (dealersScore == 21) {
        setState(() {
          customBottomSheet.showBottomSheet(
              context, 'Вы проиграли, Dealer выиграл!');
          isAlreadyWin = true;
        });
      }
    } else {
      print('карт больше нет');
    }

    print(playingCards.length);
  }

  @override
  void initState() {
    playingCards.addAll(deck);
    super.initState();
  }

  void compare() {
    if (playersScore > dealersScore) {
      customBottomSheet.showBottomSheet(context, 'Вы победили!');
      isAlreadyWin = true;
    } else if (dealersScore > playersScore) {
      customBottomSheet.showBottomSheet(
          context, 'Dealer Выиграл! Вы проиграли');
      isAlreadyWin = true;
    } else if (dealersScore == playersScore) {
      customBottomSheet.showBottomSheet(context, 'Ничья!');
      isAlreadyWin = true;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isGameStarted
          ? SafeArea(
              child: Center(
              child: Container(
                width: double.infinity,
                color: Colors.pink[100],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //Dealers cards
                    Column(
                      children: [
                        Text(
                            'Dealer`s score:  ${isAlreadyWin ? dealersScore : ''}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600)),
                        const SizedBox(height: 30),

                        //grid view
                        Container(
                          height: 200,
                          child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3),
                              itemCount: dealersCards.length,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return isAlreadyWin
                                    ? Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: dealersCards[index])
                                    : Image.asset('Cards/card_back.png');
                              }),
                        )
                      ],
                    ),
                    //PLayers cards
                    Column(
                      children: [
                        Text('Player`s score:  $playersScore',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600)),
                        const SizedBox(height: 30),
                        Container(
                          height: 200,
                          child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3),
                              itemCount: myCards.length,
                              physics: const ScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: myCards[index]);
                              }),
                        )
                      ],
                    ),
                    IntrinsicWidth(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          isAlreadyWin
                              ? SizedBox()
                              : MaterialButton(
                                  color: Colors.brown[200],
                                  onPressed: () {
                                    try {
                                      addCard();
                                    } catch (e) {
                                      print('Карт больше нет' + e.toString());
                                    }
                                  },
                                  child: const Text('Another card?')),
                          isAlreadyWin
                              ? SizedBox()
                              : MaterialButton(
                                  color: Colors.brown[200],
                                  onPressed: () => compare(),
                                  child: const Text('End',
                                      style: TextStyle(color: Colors.white))),
                          MaterialButton(
                              color: Colors.brown[200],
                              onPressed: () => changeCards(),
                              child: const Text('Next round?',
                                  style: TextStyle(color: Colors.white))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ))
          : Center(
              child: MaterialButton(
                onPressed: () {
                  changeCards();
                },
                child: Text('Start game'),
              ),
            ),
    );
  }
}
