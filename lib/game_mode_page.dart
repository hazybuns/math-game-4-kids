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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            color: const Color.fromRGBO(38, 148, 221, 0.493),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'CHOOSE A GAME MODE:',
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'BubblegumSans',
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF001F3F),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20.0),
                    _buildGameModeButton(
                      context,
                      playerName,
                      variety,
                      'Timer Mode',
                      'assets/images/timed_mode.jpg', // Replace with your image path
                    ),
                    const SizedBox(height: 10.0),
                    _buildGameModeButton(
                      context,
                      playerName,
                      variety,
                      'Infinite',
                      'assets/images/inf.jpg', // Replace with your image path
                    ),
                    const SizedBox(height: 10.0),
                    _buildGameModeButton(
                      context,
                      playerName,
                      variety,
                      'Speed Mode',
                      'assets/images/speed_mode.jpg', // Replace with your image path
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

  Widget _buildGameModeButton(BuildContext context, String playerName,
      String variety, String gameMode, String backgroundImage,
      {Color backgroundColor = Colors.transparent}) {
    return Card(
      color: Colors.transparent,
      elevation: 0, // No shadow
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        width: double.infinity,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: ElevatedButton(
          onPressed: () async {
            if (gameMode == 'Timer Mode') {
              // Show timer selection dialog
              int selectedTimeLimit = await _showTimerSelectionDialog(context);
              if (selectedTimeLimit != -1) {
                // Proceed to the game with the selected time limit
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GamePage(
                      playerName: playerName,
                      variety: variety,
                      gameMode: 'Single Level',
                      timeLimit: selectedTimeLimit,
                    ),
                  ),
                );
              }
            } else if (gameMode == 'Speed Mode') {
              // Proceed to Speed Mode
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GamePage(
                    playerName: playerName,
                    variety: variety,
                    gameMode: 'Speed Mode',
                    timeLimit: null,
                  ),
                ),
              );
            } else {
              // Proceed to the game with the selected game mode
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GamePage(
                    playerName: playerName,
                    variety: variety,
                    gameMode: gameMode,
                    timeLimit: null,
                  ),
                ),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
          child: Text(
            gameMode.toUpperCase(),
            style: const TextStyle(
              fontSize: 25,
              fontFamily: 'BubblegumSans',
              fontWeight: FontWeight.bold,
            ),
          ),
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
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
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
          ),
        );
      },
    );

    return selectedTimeLimit;
  }

  Widget _buildTimerSelectionCard(
      BuildContext context, String label, VoidCallback onTap) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: const Color.fromRGBO(38, 148, 221, 0.493),
          ),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'BubblegumSans',
                fontSize: 20,
                color: Color(0xFF001F3F),
              ),
            ),
          ),
        ),
      ),
    );
  }
}






      // bottomNavigationBar: BottomAppBar(
      //   color: Color(0xFFADD8E6), // Dark Navy Blue bottom bar color
      //   child: Container(
      //     height: 60.0,
      //     padding: EdgeInsets.symmetric(
      //         horizontal: 20.0), // Adjusted horizontal padding
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         ElevatedButton(
      //           onPressed: () {
      //             Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) => WelcomePage(),
      //               ),
      //             );
      //           },
      //           style: ElevatedButton.styleFrom(
      //             backgroundColor: Color(0xFFADD8E6), // Dark Green button color
      //             shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(8.0),
      //             ),
      //             padding: EdgeInsets.all(15.0), // Adjusted button padding
      //           ),
      //           child: Column(
      //             children: [
      //               Icon(
      //                 Icons.home,
      //                 color: Color(0xFF001F3F),
      //                 size: 24.0, // Adjusted icon size
      //               ),
      //               Text(
      //                 'Home',
      //                 style: TextStyle(
      //                   fontSize: 12.0, // Adjusted text size
      //                   color: Color(0xFF001F3F),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //         ElevatedButton(
      //           onPressed: () {
      //             Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) => GameInfoPage(),
      //               ),
      //             );
      //           },
      //           style: ElevatedButton.styleFrom(
      //             backgroundColor: Color(0xFFADD8E6), // Light Blue button color
      //             shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(8.0),
      //             ),
      //             padding: EdgeInsets.all(15.0), // Adjusted button padding
      //           ),
      //           child: Column(
      //             children: [
      //               Icon(
      //                 Icons.info,
      //                 color: Color(0xFF001F3F),
      //                 size: 24.0, // Adjusted icon size
      //               ),
      //               Text(
      //                 'Game Info',
      //                 style: TextStyle(
      //                   fontSize: 12.0, // Adjusted text size
      //                   color: Color(0xFF001F3F),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //         ElevatedButton(
      //           onPressed: () {
      //             Navigator.pop(context); // Navigate back to the previous page
      //           },
      //           style: ElevatedButton.styleFrom(
      //             backgroundColor: Color(0xFFADD8E6), // Dark Green button color
      //             shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(8.0),
      //             ),
      //             padding: EdgeInsets.all(15.0), // Adjusted button padding
      //           ),
      //           child: Column(
      //             children: [
      //               Icon(
      //                 Icons.arrow_back,
      //                 color: Color(0xFF001F3F),
      //                 size: 24.0, // Adjusted icon size
      //               ),
      //               Text(
      //                 'Back',
      //                 style: TextStyle(
      //                   fontSize: 12.0, // Adjusted text size
      //                   color: Color(0xFF001F3F),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
