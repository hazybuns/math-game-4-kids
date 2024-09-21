import 'package:flutter/material.dart';
import 'game_mode_page.dart';

class VarietyPage extends StatelessWidget {
  final String playerName;

  VarietyPage({required this.playerName});

  final List<Map<String, dynamic>> flashcardVarieties = [
    {'variety': 'Addition', 'image': 'assets/images/add2.png', 'color': Colors.transparent},
    {'variety': 'Subtraction', 'image': 'assets/images/sub2.png', 'color': Colors.transparent},
    {'variety': 'Multiplication', 'image': 'assets/images/mult2.png', 'color': Colors.transparent},
    {'variety': 'Division', 'image': 'assets/images/div2.png', 'color': Colors.transparent},
    {'variety': 'Combined', 'image': 'assets/images/ycomb.png', 'color': Colors.transparent},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            color: Color.fromRGBO(38, 148, 221, 0.493),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Hello, $playerName! PLEASE SELECT A CATEGORY OF FLASHCARDS TO PLAY!',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'BubblegumSans',
                        color: Color(0xFF001F3F),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.0),
                    GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                        childAspectRatio: 1.0,
                      ),
                      itemCount: flashcardVarieties.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ElevatedButton(
                          onPressed: () {
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
                          style: ElevatedButton.styleFrom(
                            backgroundColor: flashcardVarieties[index]['color'],
                            padding: EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Image.asset(
                            flashcardVarieties[index]['image'],
                            width: 130,
                            height: 130,
                          ),
                        );
                      },
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
