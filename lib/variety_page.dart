import 'package:flutter/material.dart';
import 'game_mode_page.dart';

class VarietyPage extends StatelessWidget {
  final String playerName;

  VarietyPage({super.key, required this.playerName});

  final List<Map<String, dynamic>> flashcardVarieties = [
    {
      'variety': 'Addition',
      'image': 'assets/images/add2.png',
      'color': Colors.green.shade200
    },
    {
      'variety': 'Subtraction',
      'image': 'assets/images/sub2.png',
      'color': Colors.red.shade200
    },
    {
      'variety': 'Multiplication',
      'image': 'assets/images/mult2.png',
      'color': Colors.blue.shade200
    },
    {
      'variety': 'Division',
      'image': 'assets/images/div2.png',
      'color': Colors.orange.shade200
    },
    {
      'variety': 'Combined',
      'image': 'assets/images/ycomb.png',
      'color': Colors.purple.shade200
    },
  ];

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
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Hello, $playerName!\nPLEASE SELECT A CATEGORY OF FLASHCARDS TO PLAY!',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'BubblegumSans',
                        color: Color(0xFF001F3F),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15.0,
                      crossAxisSpacing: 15.0,
                      childAspectRatio: 0.9,
                    ),
                    itemCount: flashcardVarieties.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        color: flashcardVarieties[index]['color'],
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GameModePage(
                                  playerName: playerName,
                                  variety: flashcardVarieties[index]['variety'],
                                ),
                              ),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                flashcardVarieties[index]['image'],
                                width: 100,
                                height: 100,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                flashcardVarieties[index]['variety'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'BubblegumSans',
                                  color: Color(0xFF001F3F),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
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
