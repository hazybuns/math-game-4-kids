import 'package:flutter/material.dart';

class ResultsPage extends StatelessWidget {
  final String playerName;
  final int score;

  ResultsPage({required this.playerName, required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Results'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Congratulations, $playerName!'),
            Text('Your final score: $score'),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Go back to the welcome page
              },
              child: Text('Play Again'),
            ),
          ],
        ),
      ),
    );
  }
}
