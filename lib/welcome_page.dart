import 'package:flutter/material.dart';
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
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: Colors.white.withOpacity(0.9),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Hero(
                          tag: 'gameIcon',
                          child: Image.asset(
                            'assets/images/math_icon.png',
                            height: 120,
                            width: 120,
                          ),
                        ),
                        const SizedBox(height: 24.0),
                        const Text(
                          'Welcome to Math Flashcards!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'BubblegumSans',
                            color: Color(0xFF001F3F),
                          ),
                        ),
                        const SizedBox(height: 24.0),
                        TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: 'Enter Your Name',
                            labelStyle: const TextStyle(
                              color: Color(0xFF001F3F),
                              fontFamily: 'BubblegumSans',
                              fontSize: 18,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 24.0),
                        ElevatedButton(
                          onPressed: () {
                            String playerName = _nameController.text.isNotEmpty
                                ? _nameController.text
                                : "Player";
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
                            backgroundColor: const Color(0xFFFFA500),
                            foregroundColor: const Color(0xFF001F3F),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 16),
                            textStyle: const TextStyle(
                              fontSize: 20,
                              fontFamily: 'BubblegumSans',
                              fontWeight: FontWeight.bold,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          child: const Text('START GAME'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
