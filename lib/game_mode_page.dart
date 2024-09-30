import 'package:flutter/material.dart';
import 'game_page.dart';

class GameModePage extends StatelessWidget {
  final String playerName;
  final String variety;

  const GameModePage(
      {super.key, required this.playerName, required this.variety});

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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: Colors.white.withOpacity(0.9),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'CHOOSE A GAME MODE:',
                      style: TextStyle(
                        fontSize: 28,
                        fontFamily: 'BubblegumSans',
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF001F3F),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    children: [
                      _buildGameModeButton(
                        context,
                        playerName,
                        variety,
                        'Timer Mode',
                        'assets/images/timed_mode.jpg',
                        Colors.blue.shade200,
                      ),
                      const SizedBox(height: 16),
                      _buildGameModeButton(
                        context,
                        playerName,
                        variety,
                        'Infinite',
                        'assets/images/inf.jpg',
                        Colors.green.shade200,
                      ),
                      const SizedBox(height: 16),
                      _buildGameModeButton(
                        context,
                        playerName,
                        variety,
                        'Speed Mode',
                        'assets/images/speed_mode.jpg',
                        Colors.orange.shade200,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGameModeButton(BuildContext context, String playerName,
      String variety, String gameMode, String backgroundImage, Color color) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              color.withOpacity(0.1),
              BlendMode.overlay,
            ),
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () async {
              if (gameMode == 'Timer Mode') {
                int selectedTimeLimit =
                    await _showTimerSelectionDialog(context);
                if (selectedTimeLimit != -1) {
                  _navigateToGamePage(context, playerName, variety,
                      'Single Level', selectedTimeLimit);
                }
              } else if (gameMode == 'Speed Mode') {
                _navigateToGamePage(
                    context, playerName, variety, 'Speed Mode', null);
              } else {
                _navigateToGamePage(
                    context, playerName, variety, gameMode, null);
              }
            },
            child: Center(
              child: Text(
                gameMode.toUpperCase(),
                style: const TextStyle(
                  fontSize: 28,
                  fontFamily: 'BubblegumSans',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 3.0,
                      color: Colors.black,
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToGamePage(BuildContext context, String playerName,
      String variety, String gameMode, int? timeLimit) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GamePage(
          playerName: playerName,
          variety: variety,
          gameMode: gameMode,
          timeLimit: timeLimit,
        ),
      ),
    );
  }

  Future<int> _showTimerSelectionDialog(BuildContext context) async {
    int selectedTimeLimit = -1;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Select Time Limit:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'BubblegumSans',
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTimerSelectionCard(context, '1 MINUTE', () {
                selectedTimeLimit = 60;
                Navigator.pop(context);
              }),
              const SizedBox(height: 10),
              _buildTimerSelectionCard(context, '2 MINUTES', () {
                selectedTimeLimit = 120;
                Navigator.pop(context);
              }),
              const SizedBox(height: 10),
              _buildTimerSelectionCard(context, '3 MINUTES', () {
                selectedTimeLimit = 180;
                Navigator.pop(context);
              }),
            ],
          ),
        );
      },
    );

    return selectedTimeLimit;
  }

  Widget _buildTimerSelectionCard(
      BuildContext context, String label, VoidCallback onTap) {
    return Card(
      color: const Color.fromRGBO(38, 148, 221, 0.493),
      child: ListTile(
        title: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'BubblegumSans',
            fontSize: 20,
            color: Color(0xFF001F3F),
          ),
          textAlign: TextAlign.center,
        ),
        onTap: onTap,
      ),
    );
  }
}
