import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:math_for_kids/game_info.dart';
import 'package:math_for_kids/welcome_page.dart';
import 'dart:async'; // Add this import
import 'flashcard_generator.dart';
import 'variety_page.dart';

class GamePage extends StatefulWidget {
  final String playerName;
  final String variety;
  final String gameMode;
  final int? timeLimit;

  const GamePage(
      {super.key,
      required this.playerName,
      required this.variety,
      required this.gameMode,
      required this.timeLimit});

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late List<Flashcard> flashcards;
  int currentFlashcardIndex = 0;
  int score = 0;
  late Timer timer; // for Single-Level Mode
  int timeRemaining = 0; // for Single-Level Mode
  bool isTimeUp = false;
  TextEditingController answerController = TextEditingController();
  int lastDifficultyIncreaseScore = 0;
  late Timer speedModeTimer; // Timer for Speed Mode
  int speedModeTimeRemaining =
      10; // Time limit for each flashcard in Speed Mode

  @override
  void initState() {
    super.initState();
    print('Selected Variety: ${widget.variety}');
    if (widget.variety == 'Addition') {
      flashcards = generateAdditionFlashcards(100);
    } else if (widget.variety == 'Subtraction') {
      flashcards = generateSubtractionFlashcards(100);
    } else if (widget.variety == 'Multiplication') {
      flashcards = generateMultiplicationFlashcards(100);
    } else if (widget.variety == 'Division') {
      flashcards = generateDivisionFlashcards(100);
    } else if (widget.variety == 'Combined') {
      flashcards = generateCombinedFlashcards(100);
    }

    if (widget.gameMode == 'Speed Mode') {
      startSpeedModeTimer();
    } else if (widget.gameMode == 'Single Level') {
      // Set the time for Single-Level Mode
      //timeRemaining = 120;
      timeRemaining = widget.timeLimit ?? 120;
      // Start the timer
      timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
        setState(() {
          if (timeRemaining > 0) {
            timeRemaining--;
            // Increase difficulty every 5 points in Infinite mode
            if (widget.gameMode == 'Infinite' && score % 5 == 0) {
              lastDifficultyIncreaseScore = score;
              increaseDifficulty();
            }
          } else {
            // Time is up, end the game
            timer.cancel();
            showResults();
          }
        });
      });
    }
  }

  void startSpeedModeTimer() {
    speedModeTimer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        if (speedModeTimeRemaining > 0) {
          speedModeTimeRemaining--;
        } else {
          speedModeTimer.cancel();
          showResults();
        }
      });
    });
  }

  void increaseDifficulty() {
    setState(() {
      int difficultyFactor =
          (score ~/ 10) + 1; // Increase difficulty every 10 points
      for (var flashcard in flashcards) {
        switch (flashcard.variety) {
          case 'Addition':
          case 'Subtraction':
            flashcard.operand1 += 3 * difficultyFactor;
            flashcard.operand2 += 2 * difficultyFactor;
            break;
          case 'Multiplication':
            flashcard.operand1 += 1 * difficultyFactor;
            flashcard.operand2 += 1 * difficultyFactor;
            break;
          case 'Division':
            flashcard.operand1 += 3 * difficultyFactor;
            flashcard.operand2 += 1 * difficultyFactor;
            break;
        }
        flashcard.setCorrectAnswer();
        flashcard.possibleAnswers =
            flashcard.generatePossibleAnswers(flashcard.correctAnswer);
      }
    });
  }

  String getOperatorSymbol(String variety) {
    switch (variety) {
      case 'Addition':
        return '+';
      case 'Subtraction':
        return '-';
      case 'Multiplication':
        return '×'; // Unicode character for multiplication
      case 'Division':
        return '÷'; // Unicode character for division
      default:
        return '';
    }
  }

  void checkAnswer(int selectedAnswer) {
    int correctAnswer =
        calculateCorrectAnswer(flashcards[currentFlashcardIndex]);

    if (selectedAnswer == correctAnswer) {
      setState(() {
        score++;
        if (score % 5 == 0) {
          increaseDifficulty();
        }
        updateGameDifficulty();
      });
    } else {
      // If the answer is incorrect and the game mode is "Speed Mode", end the game immediately
      if (widget.gameMode == 'Speed Mode') {
        showResults();
        return;
      }
    }

    // Reset the timer for the flashcard
    if (widget.gameMode == 'Single Level') {
      if (isTimeUp) {
        setState(() {
          timeRemaining = widget.timeLimit ?? 120;
        });
      }
    } else if (widget.gameMode == 'Speed Mode') {
      setState(() {
        speedModeTimeRemaining = 10;
      });
    }
    goToNextFlashcard();
  }

  int calculateCorrectAnswer(Flashcard flashcard) {
    switch (flashcard.variety) {
      case 'Addition':
        return flashcard.operand1 + flashcard.operand2;
      case 'Subtraction':
        return flashcard.operand1 - flashcard.operand2;
      case 'Multiplication':
        return flashcard.operand1 * flashcard.operand2;
      case 'Division':
        return flashcard.operand1 ~/ flashcard.operand2;
      default:
        return 0;
    }
  }

  void goToNextFlashcard() {
    setState(() {
      if (!isTimeUp && currentFlashcardIndex < flashcards.length - 1) {
        currentFlashcardIndex++;
      } else {
        if (currentFlashcardIndex == flashcards.length - 1) {
          showResults();
        }
      }
    });
  }

  bool hasShownResults = false;
  void showResults({bool bySurrender = false}) {
    if (hasShownResults) {
      // Results have already been shown, avoid showing them again
      return;
    }
    setState(() {
      isTimeUp = true;
      hasShownResults = true;
    });

    // Show results only if time is up or by surrender
    if (!isTimeUp && !bySurrender) {
      return;
    }

    String remarks = getRemarks(score);

    // Display results in an AlertDialog
    showDialog(
      barrierDismissible:
          false, // Prevents closing the dialog by tapping outside
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Congratulations, ${widget.playerName}!',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              fontFamily: 'BubblegumSans',
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min, // Set to min to adjust size
            children: [
              const Text(
                'GOOD GAME!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  fontFamily: 'BubblegumSans',
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Your final score: $score',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  fontFamily: 'BubblegumSans',
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Remarks: $remarks',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  fontFamily: 'BubblegumSans',
                ),
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the variety selection page
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            VarietyPage(playerName: widget.playerName),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFFFFA500), // Orange button color
                  ),
                  child: const Text(
                    'PLAY AGAIN',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'BubblegumSans',
                      color: Colors.white,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the home page (replace with your home page route)
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WelcomePage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFFFFA500), // Orange button color
                  ),
                  child: const Text(
                    'HOME',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'BubblegumSans',
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
          contentPadding:
              const EdgeInsets.all(16.0), // Adjust padding as needed
        );
      },
    );
    if (widget.gameMode == 'Single Level') {
      timer.cancel(); // Stop the timer
    }
  }

  String getRemarks(int score) {
    if (score >= 8) {
      return 'Excellent! Keep it up, ${widget.playerName}!';
    } else if (score >= 5) {
      return 'Good job, ${widget.playerName}!';
    } else {
      return 'Nice try, do better next time, ${widget.playerName}!';
    }
  }

  void updateGameDifficulty() {
    if (widget.gameMode == 'Infinite' && score >= 20 && !isTimeUp) {
      // Start a timer for Infinite mode after score reaches 20
      if (!timer.isActive) {
        timeRemaining = 30; // Give 30 seconds
        timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
          setState(() {
            if (timeRemaining > 0) {
              timeRemaining--;
            } else {
              timer.cancel();
              showResults();
            }
          });
        });
      }
    }
  }

  @override
  void dispose() {
    if (widget.gameMode == 'Single Level') {
      timer.cancel(); // Cancel the timer to avoid memory leaks
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Card(
            margin: const EdgeInsets.all(10),
            color: const Color.fromRGBO(
                38, 148, 221, 0.493), // Light Blue background color
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'FLASHCARD NO. ${currentFlashcardIndex + 1}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'BubblegumSans',
                                  color: Color(
                                      0xFF001F3F), // Dark Navy Blue text color
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '${flashcards[currentFlashcardIndex].operand1} ${getOperatorSymbol(flashcards[currentFlashcardIndex].variety)} ${flashcards[currentFlashcardIndex].operand2}',
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'BubblegumSans',
                                  color: Color(
                                      0xFF006400), // Dark Green equation color
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Conditional rendering based on game mode
                  widget.gameMode == 'Infinite'
                      ? TextField(
                          controller: answerController, // Use the controller
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: (value) {
                            // Handle input changes if needed
                          },
                          onSubmitted: (value) {
                            // Check the answer when the player submits
                            checkAnswer(int.parse(value));
                            answerController.clear(); // Clear the TextField
                          },
                          style: const TextStyle(
                            fontSize: 25,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            labelText: 'Enter your answer here and press Enter',
                            labelStyle: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'BubblegumSans',
                              color: Color(0xFF001F3F),
                            ),
                          ),
                        )
                      : GridView.builder(
                          // GridView for multiple choice buttons
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                6, // Set crossAxisCount to 6 for a horizontal line
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                          ),
                          itemCount: flashcards[currentFlashcardIndex]
                              .possibleAnswers
                              .length,
                          itemBuilder: (context, index) => Card(
                            elevation: 3,
                            color:
                                const Color(0xFF006400), // Orange button color
                            child: InkWell(
                              onTap: () => checkAnswer(
                                  flashcards[currentFlashcardIndex]
                                      .possibleAnswers[index]),
                              child: Center(
                                child: Text(
                                  flashcards[currentFlashcardIndex]
                                      .possibleAnswers[index]
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 25,
                                    fontFamily: 'BubblegumSans',
                                    color: Color.fromARGB(255, 247, 247,
                                        247), // Dark Navy Blue text color
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                  const SizedBox(height: 20),
// Improved Score Board Design
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // Center the contents
                      children: [
                        Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.center, // Center the text
                          children: [
                            Column(
                              children: [
                                const Text(
                                  'Score/Over',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'BubblegumSans',
                                    color: Color(0xFF001F3F),
                                  ),
                                ),
                                Text(
                                  '$score/$currentFlashcardIndex',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'BubblegumSans',
                                    color: Color(
                                      0xFF001F3F,
                                    ), // Dark Navy Blue text color
                                  ),
                                ),
                              ],
                            ),
                            // Display time remaining only for Single Level and Speed Mode
                            if (widget.gameMode == 'Single Level' ||
                                widget.gameMode == 'Speed Mode')
                              Row(
                                children: [
                                  Text(
                                    widget.gameMode == 'Single Level'
                                        ? 'Time'
                                        : 'Time Remaining',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'BubblegumSans',
                                      color: Color(0xFF001F3F),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    widget.gameMode == 'Single Level'
                                        ? '$timeRemaining'
                                        : '$speedModeTimeRemaining',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'BubblegumSans',
                                      color: Color(
                                        0xFF001F3F,
                                      ), // Dark Navy Blue text color
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                  //if (widget.gameMode == 'Infinite')
                  ElevatedButton(
                    onPressed: () {
                      showResults(
                          bySurrender:
                              true); // Display results when the player surrenders
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.orange, // Orange surrender button color
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(15),
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'BubblegumSans',
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text('SURRENDER'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
