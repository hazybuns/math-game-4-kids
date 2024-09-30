import 'dart:math';

class Flashcard {
  int operand1;
  int operand2;
  int correctAnswer;
  List<int> possibleAnswers;
  String variety;

  Flashcard(
      {required this.operand1, required this.operand2, required this.variety})
      : correctAnswer = 0,
        possibleAnswers = [] {
    setCorrectAnswer();
    possibleAnswers = generatePossibleAnswers(correctAnswer);
  }

  void setCorrectAnswer() {
    switch (variety) {
      case 'Addition':
        correctAnswer = operand1 + operand2;
        break;
      case 'Subtraction':
        correctAnswer = operand1 - operand2;
        break;
      case 'Multiplication':
        correctAnswer = operand1 * operand2;
        break;
      case 'Division':
        correctAnswer = operand1 ~/ operand2;
        break;
      default:
        // Handle unknown variety (optional)
        correctAnswer = 0;
    }
  }

  List<int> generatePossibleAnswers(int correctAnswer) {
    List<int> possibleAnswers = [correctAnswer];

    while (possibleAnswers.length < 6) {
      int randomAnswer = Random().nextInt(99) + 1; // Change the range as needed

      if (!possibleAnswers.contains(randomAnswer)) {
        possibleAnswers.add(randomAnswer);
      }
    }

    possibleAnswers.shuffle();
    return possibleAnswers;
  }

  void generateAdvancedQuestion(int difficultyFactor) {
    Random random = Random();
    switch (variety) {
      case 'Addition':
        if (difficultyFactor > 3 && random.nextBool()) {
          // Introduce triple addition for higher difficulties
          int operand3 = random.nextInt(20) + 1;
          operand1 = (operand1 + operand3) * difficultyFactor;
          correctAnswer = operand1 + operand2 + operand3;
        }
        break;
      case 'Multiplication':
        if (difficultyFactor > 2 && random.nextBool()) {
          // Introduce simple square numbers
          operand1 = random.nextInt(12) + 1;
          operand2 = operand1;
          correctAnswer = operand1 * operand2;
        }
        break;
      case 'Division':
        if (difficultyFactor > 3 && random.nextBool()) {
          // Introduce remainders for higher difficulties
          int dividend = (random.nextInt(50) + 50) * difficultyFactor;
          int divisor = random.nextInt(10) + 2;
          operand1 = dividend;
          operand2 = divisor;
          correctAnswer = dividend ~/ divisor;
        }
        break;
      default:
        break;
    }
  }
}

List<Flashcard> generateAdditionFlashcards(int numberOfFlashcards) {
  List<Flashcard> flashcards = [];

  for (int i = 0; i < numberOfFlashcards; i++) {
    int operand1 = Random().nextInt(100) + 1;
    int operand2 = Random().nextInt(100) + 1;

    flashcards.add(
        Flashcard(operand1: operand1, operand2: operand2, variety: 'Addition'));
  }

  return flashcards;
}

List<Flashcard> generateSubtractionFlashcards(int numberOfFlashcards) {
  List<Flashcard> flashcards = [];

  for (int i = 0; i < numberOfFlashcards; i++) {
    int operand1 = Random().nextInt(100) + 1;
    int operand2 = Random().nextInt(operand1) + 1;

    flashcards.add(Flashcard(
        operand1: operand1, operand2: operand2, variety: 'Subtraction'));
  }

  return flashcards;
}

List<Flashcard> generateMultiplicationFlashcards(int numberOfFlashcards) {
  List<Flashcard> flashcards = [];

  for (int i = 0; i < numberOfFlashcards; i++) {
    int operand1 = Random().nextInt(10) + 1; // Keep the range smaller if needed
    int operand2 = Random().nextInt(10) + 1;

    flashcards.add(Flashcard(
        operand1: operand1, operand2: operand2, variety: 'Multiplication'));
  }

  return flashcards;
}

List<Flashcard> generateDivisionFlashcards(int numberOfFlashcards) {
  List<Flashcard> flashcards = [];

  for (int i = 0; i < numberOfFlashcards; i++) {
    int divisor = Random().nextInt(10) + 1;
    int result = Random().nextInt(10) + 1;
    int operand1 = divisor * result;

    flashcards.add(
        Flashcard(operand1: operand1, operand2: divisor, variety: 'Division'));
  }

  return flashcards;
}

List<Flashcard> generateCombinedFlashcards(int numberOfFlashcards) {
  List<Flashcard> flashcards = [];

  // Adjust the distribution of flashcards for different varieties
  int additionCount = (numberOfFlashcards * 0.25).round();
  int subtractionCount = (numberOfFlashcards * 0.25).round();
  int multiplicationCount = (numberOfFlashcards * 0.25).round();
  int divisionCount = (numberOfFlashcards * 0.25).round();

  flashcards.addAll(generateAdditionFlashcards(additionCount));
  flashcards.addAll(generateSubtractionFlashcards(subtractionCount));
  flashcards.addAll(generateMultiplicationFlashcards(multiplicationCount));
  flashcards.addAll(generateDivisionFlashcards(divisionCount));

  // Shuffle the combined flashcards to mix them up
  flashcards.shuffle();

  return flashcards;
}
