import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const BrainMasterApp());
}

class BrainMasterApp extends StatelessWidget {
  const BrainMasterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brain Master Quiz',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7654E8),
          brightness: Brightness.light,
        ),
      ),
      home: const QuizHomePage(),
    );
  }
}

class Question {
  final String text;
  final List<String> options;
  final int answer;
  final String explanation;

  const Question(this.text, this.options, this.answer, this.explanation);
}

const Map<String, List<Question>> questionBank = {
  'General Knowledge': [
    Question('Which planet is known as the Red Planet?',
        ['Earth', 'Mars', 'Jupiter', 'Venus'], 1,
        'Mars looks reddish because iron-rich dust covers much of its surface.'),
    Question('What is the capital of India?',
        ['Mumbai', 'Jaipur', 'New Delhi', 'Chennai'], 2,
        'New Delhi is the capital of India.'),
    Question('Which is the largest ocean on Earth?',
        ['Atlantic Ocean', 'Indian Ocean', 'Arctic Ocean', 'Pacific Ocean'], 3,
        'The Pacific Ocean is the largest and deepest ocean.'),
    Question('How many days are there in a leap year?',
        ['364', '365', '366', '367'], 2,
        'A leap year has 366 days, including 29 days in February.'),
    Question('Which animal is known as the ship of the desert?',
        ['Horse', 'Camel', 'Elephant', 'Yak'], 1,
        'Camels are adapted to travel across dry desert environments.'),
  ],
  'Science': [
    Question('Which gas do plants absorb during photosynthesis?',
        ['Oxygen', 'Nitrogen', 'Carbon dioxide', 'Hydrogen'], 2,
        'Plants use carbon dioxide, water and light to make food.'),
    Question('Which organ pumps blood around the human body?',
        ['Brain', 'Lungs', 'Heart', 'Kidney'], 2,
        'The heart pumps blood through the circulatory system.'),
    Question('What is the chemical formula of water?',
        ['CO2', 'H2O', 'O2', 'NaCl'], 1,
        'A water molecule contains two hydrogen atoms and one oxygen atom.'),
    Question('Which part of a plant usually absorbs water from soil?',
        ['Flower', 'Leaf', 'Root', 'Fruit'], 2,
        'Roots absorb water and minerals from the soil.'),
    Question('What force pulls objects towards Earth?',
        ['Friction', 'Gravity', 'Magnetism', 'Electricity'], 1,
        'Gravity attracts objects with mass towards one another.'),
  ],
  'Mathematics': [
    Question('What is 12 × 8?', ['86', '96', '108', '88'], 1,
        '12 multiplied by 8 equals 96.'),
    Question('What is the square of 9?', ['18', '72', '81', '99'], 2,
        '9 × 9 = 81.'),
    Question('How many sides does a hexagon have?',
        ['Five', 'Six', 'Seven', 'Eight'], 1,
        'A hexagon is a polygon with six sides.'),
    Question('What is 25% of 200?', ['25', '40', '50', '75'], 2,
        '25% means one quarter; one quarter of 200 is 50.'),
    Question('Which number is a prime number?',
        ['21', '27', '29', '33'], 2,
        '29 has exactly two positive factors: 1 and 29.'),
  ],
  'English Vocabulary': [
    Question('Choose the opposite of "Ancient".',
        ['Historic', 'Modern', 'Old', 'Past'], 1,
        'Modern means relating to the present or recent times.'),
    Question('What is a synonym of "Happy"?',
        ['Joyful', 'Angry', 'Tired', 'Worried'], 0,
        'Joyful has a meaning similar to happy.'),
    Question('Choose the correctly spelled word.',
        ['Beautifull', 'Beutiful', 'Beautiful', 'Beautifal'], 2,
        'Beautiful is the correct spelling.'),
    Question('What is the plural of "Child"?',
        ['Childs', 'Childes', 'Children', 'Childrens'], 2,
        'Children is the irregular plural form of child.'),
    Question('Which word is a verb?',
        ['Quickly', 'Happiness', 'Run', 'Blue'], 2,
        'Run is an action word, so it is a verb.'),
  ],
};

const List<Map<String, dynamic>> categories = [
  {'name': 'General Knowledge', 'icon': Icons.public, 'color': Color(0xFF4C8BF5)},
  {'name': 'Science', 'icon': Icons.science, 'color': Color(0xFF22A68A)},
  {'name': 'Mathematics', 'icon': Icons.calculate, 'color': Color(0xFFF19A38)},
  {'name': 'English Vocabulary', 'icon': Icons.menu_book, 'color': Color(0xFFAD6CE0)},
];

class QuizHomePage extends StatefulWidget {
  const QuizHomePage({super.key});

  @override
  State<QuizHomePage> createState() => _QuizHomePageState();
}

class _QuizHomePageState extends State<QuizHomePage> {
  SharedPreferences? preferences;
  String? selectedCategory;
  List<Question> roundQuestions = [];
  final List<int?> userAnswers = [];
  int questionIndex = 0;
  int score = 0;
  int totalCoins = 0;
  int bestScore = 0;
  int? selectedAnswer;
  bool finished = false;
  bool saving = false;

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      preferences = prefs;
      totalCoins = prefs.getInt('totalCoins') ?? 0;
    });
  }

  Future<void> _startGame(String category) async {
    final prefs = preferences ?? await SharedPreferences.getInstance();
    final questions = List<Question>.from(questionBank[category]!);
    questions.shuffle(Random());

    setState(() {
      preferences = prefs;
      selectedCategory = category;
      roundQuestions = questions;
      userAnswers
        ..clear()
        ..addAll(List<int?>.filled(questions.length, null));
      questionIndex = 0;
      score = 0;
      selectedAnswer = null;
      finished = false;
      bestScore = prefs.getInt('best_$category') ?? 0;
    });
  }

  void _chooseAnswer(int option) {
    if (selectedAnswer != null) return;
    setState(() {
      selectedAnswer = option;
      userAnswers[questionIndex] = option;
      if (option == roundQuestions[questionIndex].answer) {
        score++;
      }
    });
  }

  Future<void> _nextQuestion() async {
    if (selectedAnswer == null || saving) return;

    if (questionIndex < roundQuestions.length - 1) {
      setState(() {
        questionIndex++;
        selectedAnswer = null;
      });
      return;
    }

    setState(() => saving = true);
    final prefs = preferences ?? await SharedPreferences.getInstance();
    final category = selectedCategory!;
    final oldBest = prefs.getInt('best_$category') ?? 0;
    final newBest = max(oldBest, score);
    final newCoins = (prefs.getInt('totalCoins') ?? 0) + (score * 10);

    await prefs.setInt('best_$category', newBest);
    await prefs.setInt('totalCoins', newCoins);

    if (!mounted) return;
    setState(() {
      preferences = prefs;
      bestScore = newBest;
      totalCoins = newCoins;
      finished = true;
      saving = false;
    });
  }

  void _goHome() {
    setState(() {
      selectedCategory = null;
      finished = false;
      selectedAnswer = null;
      roundQuestions = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F4FF),
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: selectedCategory == null
              ? _homeScreen()
              : finished
                  ? _resultScreen()
                  : _questionScreen(),
        ),
      ),
    );
  }

  Widget _homeScreen() {
    return SingleChildScrollView(
      key: const ValueKey('home'),
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(0xFFE9E2FF),
                  borderRadius: BorderRadius.circular(17),
                ),
                child: const Icon(Icons.psychology_alt,
                    color: Color(0xFF6845D5), size: 32),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('BRAIN MASTER',
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w900,
                            letterSpacing: 1.1)),
                    Text('Learn • Play • Grow',
                        style: TextStyle(color: Colors.black54)),
                  ],
                ),
              ),
              _coinPill(),
            ],
          ),
          const SizedBox(height: 28),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(23),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF4E2AA8), Color(0xFF8966EE)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(26),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('READY TO CHALLENGE YOUR BRAIN?',
                    style: TextStyle(
                        color: Colors.white70, fontSize: 12,
                        fontWeight: FontWeight.bold, letterSpacing: 1)),
                SizedBox(height: 12),
                Text('Play a quiz.\nBecome a champion!',
                    style: TextStyle(
                        color: Colors.white, fontSize: 27,
                        height: 1.2, fontWeight: FontWeight.w900)),
                SizedBox(height: 12),
                Text('Choose a subject and answer 5 questions.',
                    style: TextStyle(color: Colors.white70, fontSize: 14)),
              ],
            ),
          ),
          const SizedBox(height: 27),
          const Text('Choose your category',
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w900)),
          const SizedBox(height: 5),
          const Text('Pick a topic to start playing.',
              style: TextStyle(color: Colors.black54)),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 13,
              mainAxisSpacing: 13,
              childAspectRatio: 1.12,
            ),
            itemBuilder: (context, index) {
              final item = categories[index];
              final name = item['name'] as String;
              final color = item['color'] as Color;
              return InkWell(
                borderRadius: BorderRadius.circular(21),
                onTap: () => _startGame(name),
                child: Ink(
                  padding: const EdgeInsets.all(17),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(21),
                    border: Border.all(color: color.withOpacity(.18)),
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(.08),
                        blurRadius: 14,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 23,
                        backgroundColor: color.withOpacity(.13),
                        child: Icon(item['icon'] as IconData, color: color),
                      ),
                      Text(name,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w800)),
                      Text('5 questions  •  Play now',
                          style: TextStyle(
                              fontSize: 11, color: Colors.grey.shade600)),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                const Icon(Icons.emoji_events, color: Color(0xFFE6A323), size: 30),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Your learning journey',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Earn 10 coins for every correct answer.',
                          style: TextStyle(
                              color: Colors.grey.shade600, fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _coinPill() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF1CF),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          const Icon(Icons.monetization_on, color: Color(0xFFD99616), size: 19),
          const SizedBox(width: 5),
          Text('$totalCoins',
              style: const TextStyle(fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }

  Widget _questionScreen() {
    final question = roundQuestions[questionIndex];
    final progress = (questionIndex + 1) / roundQuestions.length;
    final categoryColor = categories.firstWhere(
      (item) => item['name'] == selectedCategory,
    )['color'] as Color;

    return SingleChildScrollView(
      key: const ValueKey('question'),
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: _goHome,
                icon: const Icon(Icons.close),
                style: IconButton.styleFrom(backgroundColor: Colors.white),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: Text(selectedCategory!,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w800)),
              ),
              _coinPill(),
            ],
          ),
          const SizedBox(height: 28),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('QUESTION ${questionIndex + 1} OF ${roundQuestions.length}',
                  style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF7654D8), fontSize: 12)),
              Text('Score: $score',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 9,
              backgroundColor: Colors.white,
              color: categoryColor,
            ),
          ),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.all(23),
            decoration: BoxDecoration(
              color: const Color(0xFF4E2AA8),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              children: [
                const Icon(Icons.lightbulb_outline,
                    color: Color(0xFFFFD36A), size: 34),
                const SizedBox(height: 17),
                Text(question.text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white, fontSize: 22,
                        height: 1.35, fontWeight: FontWeight.w800)),
              ],
            ),
          ),
          const SizedBox(height: 22),
          ...List.generate(question.options.length, (index) {
            final isSelected = selectedAnswer == index;
            final isCorrect = question.answer == index;
            Color background = Colors.white;
            Color border = const Color(0xFFE8E4F2);
            IconData? trailing;

            if (selectedAnswer != null && isCorrect) {
              background = const Color(0xFFE1F6E9);
              border = const Color(0xFF35A66A);
              trailing = Icons.check_circle;
            } else if (selectedAnswer != null && isSelected) {
              background = const Color(0xFFFFE8E8);
              border = const Color(0xFFE05B5B);
              trailing = Icons.cancel;
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: 11),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: selectedAnswer == null
                    ? () => _chooseAnswer(index)
                    : null,
                child: Ink(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15, vertical: 17),
                  decoration: BoxDecoration(
                    color: background,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: border, width: 1.4),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: const Color(0xFFEDE8FC),
                        child: Text(String.fromCharCode(65 + index),
                            style: const TextStyle(
                                color: Color(0xFF6845D5),
                                fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(question.options[index],
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w700)),
                      ),
                      if (trailing != null)
                        Icon(trailing,
                            color: isCorrect ? Colors.green : Colors.red),
                    ],
                  ),
                ),
              ),
            );
          }),
          if (selectedAnswer != null) ...[
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFEDE8FC),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                '${selectedAnswer == question.answer ? 'Correct!' : 'Not quite.'} ${question.explanation}',
                style: const TextStyle(
                    color: Color(0xFF42268E), height: 1.4),
              ),
            ),
            const SizedBox(height: 17),
            FilledButton(
              onPressed: saving ? null : _nextQuestion,
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF6845D5),
                minimumSize: const Size(double.infinity, 54),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
              ),
              child: Text(
                saving
                    ? 'SAVING...'
                    : questionIndex == roundQuestions.length - 1
                        ? 'SEE MY RESULT'
                        : 'NEXT QUESTION',
                style: const TextStyle(
                    fontWeight: FontWeight.w900, letterSpacing: .5),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _resultScreen() {
    final percentage = (score / roundQuestions.length * 100).round();
    return SingleChildScrollView(
      key: const ValueKey('result'),
      padding: const EdgeInsets.fromLTRB(20, 35, 20, 25),
      child: Column(
        children: [
          const Icon(Icons.emoji_events,
              size: 92, color: Color(0xFFE6A323)),
          const SizedBox(height: 13),
          const Text('QUIZ COMPLETED!',
              style: TextStyle(
                  fontSize: 25, fontWeight: FontWeight.w900)),
          const SizedBox(height: 7),
          Text(selectedCategory!,
              style: const TextStyle(color: Colors.black54)),
          const SizedBox(height: 23),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF4E2AA8), Color(0xFF8966EE)],
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              children: [
                Text('$score / ${roundQuestions.length}',
                    style: const TextStyle(
                        color: Colors.white, fontSize: 49,
                        fontWeight: FontWeight.w900)),
                const Text('YOUR SCORE',
                    style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2)),
                const SizedBox(height: 17),
                Text('$percentage%',
                    style: const TextStyle(
                        color: Colors.white, fontSize: 28,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Text('+${score * 10} coins earned',
                    style: const TextStyle(
                        color: Color(0xFFFFE08A),
                        fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(child: _statCard('Best score', '$bestScore/5')),
              const SizedBox(width: 12),
              Expanded(child: _statCard('Total coins', '$totalCoins')),
            ],
          ),
          const SizedBox(height: 24),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Answer review',
                style: const TextStyle(
                    fontSize: 19, fontWeight: FontWeight.w900)),
          ),
          const SizedBox(height: 10),
          ...List.generate(roundQuestions.length, (i) {
            final q = roundQuestions[i];
            final correct = userAnswers[i] == q.answer;
            return Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 9),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(correct ? Icons.check_circle : Icons.cancel,
                          color: correct ? Colors.green : Colors.red,
                          size: 19),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text('Question ${i + 1}: ${q.text}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  Text('Your answer: ${q.options[userAnswers[i] ?? 0]}',
                      style: const TextStyle(fontSize: 13)),
                  if (!correct)
                    Text('Correct answer: ${q.options[q.answer]}',
                        style: const TextStyle(
                            fontSize: 13, color: Colors.green,
                            fontWeight: FontWeight.bold)),
                ],
              ),
            );
          }),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: _goHome,
            icon: const Icon(Icons.home),
            label: const Text('BACK TO HOME'),
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFF6845D5),
              minimumSize: const Size(double.infinity, 54),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
            ),
          ),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            onPressed: () => _startGame(selectedCategory!),
            icon: const Icon(Icons.refresh),
            label: const Text('PLAY AGAIN'),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 52),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
      ),
      child: Column(
        children: [
          Text(value,
              style: const TextStyle(
                  fontSize: 22, fontWeight: FontWeight.w900)),
          const SizedBox(height: 4),
          Text(title,
              style: const TextStyle(color: Colors.black54, fontSize: 12)),
        ],
      ),
    );
  }
}
