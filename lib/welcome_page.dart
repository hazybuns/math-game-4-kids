import 'package:flutter/material.dart';
// import 'package:math_for_kids/game_info.dart';
import 'variety_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xFFFF80),
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
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.asset(
                        'assets/images/math_icon.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    const Text(
                      'WELCOME TO THE MATH FLASHCARDS GAME!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'BubblegumSans',
                        color: Color(0xFF001F3F),
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'ENTER YOUR NAME',
                          labelStyle: TextStyle(
                            color:
                                Color(0xFF001F3F), // Dark Navy Blue text color
                            fontFamily: 'BubblegumSans',
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    SizedBox(
                      height: 50,
                      width: 90,
                      child: ElevatedButton(
                        onPressed: () {
                          String playerName = _nameController.text.isNotEmpty
                              ? _nameController.text
                              : "Kid";
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VarietyPage(
                                playerName: playerName,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(
                              0xFFFFA500), // Dark Green button color
                          foregroundColor: const Color(0xFF001F3F),
                          padding: const EdgeInsets.all(15),
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontFamily: 'BubblegumSans',
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text('START'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
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
      //             // Navigator.push(
      //             //   context,
      //             //   MaterialPageRoute(
      //             //     builder: (context) => WelcomePage(),
      //             //   ),
      //             // );
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
      //             //Navigator.pop(context); // Navigate back to the previous page
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
    );
  }
}
