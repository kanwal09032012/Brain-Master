import 'package:flutter/material.dart';

void main() => runApp(const BrainMasterQuiz());

class BrainMasterQuiz extends StatelessWidget {
  const BrainMasterQuiz({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brain Master Quiz',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class QuizQuestion {
  final String question;
  final List<String> options;
  final int answer;
  final String explanation;

  const QuizQuestion(this.question, this.options, this.answer, this.explanation);
}

const Map<String, List<QuizQuestion>> quizData = {
  'General Knowledge': [
    QuizQuestion('Which is the largest planet?', ['Earth', 'Jupiter', 'Mars', 'Venus'], 1, 'Jupiter is the largest planet in our solar system.'),
    QuizQuestion('What is the capital of India?', ['Mumbai', 'New Delhi', 'Chennai', 'Kolkata'], 1, 'New Delhi is the capital of India.'),
    QuizQuestion('How many days are in a leap year?', ['365', '366', '364', '360'], 1, 'A leap year has 366 days.'),
    QuizQuestion('Which animal is called the Ship of the Desert?', ['Horse', 'Camel', 'Elephant', 'Lion'], 1, 'The camel is called the Ship of the Desert.'),
    QuizQuestion('What is the national bird of India?', ['Parrot', 'Peacock', 'Eagle', 'Swan'], 1, 'The peacock is the national bird of India.'),
  ],
  'Science': [
    QuizQuestion('Which gas do plants absorb?', ['Oxygen', 'Nitrogen', 'Carbon dioxide', 'Hydrogen'], 2, 'Plants absorb carbon dioxide during photosynthesis.'),
    QuizQuestion('What is the chemical formula of water?', ['CO2', 'H2O', 'O2', 'NaCl'], 1, 'Water is H2O.'),
    QuizQuestion('Which part of a plant absorbs water?', ['Flower', 'Leaf', 'Root', 'Fruit'], 2, 'Roots absorb water from the soil.'),
    QuizQuestion('Which planet is called the Red Planet?', ['Mars', 'Saturn', 'Mercury', 'Neptune'], 0, 'Mars is known as the Red Planet.'),
    QuizQuestion('Which force pulls objects towards Earth?', ['Friction', 'Gravity', 'Magnetism', 'Sound'], 1, 'Gravity pulls objects towards Earth.'),
  ],
  'Mathematics': [
    QuizQuestion('What is 12 × 8?', ['84', '96', '108', '88'], 1, '12 × 8 = 96.'),
    QuizQuestion('What is the square root of 81?', ['7', '8', '9', '10'], 2, '9 × 9 = 81.'),
    QuizQuestion('How many sides does a hexagon have?', ['5', '6', '7', '8'], 1, 'A hexagon has six sides.'),
    QuizQuestion('What is 25% of 200?', ['25', '40', '50', '75'], 2, '25% of 200 is 50.'),
    QuizQuestion('What is 15 + 27?', ['32', '40', '42', '45'], 2, '15 + 27 = 42.'),
  ],
  'English Vocabulary': [
    QuizQuestion('Choose the synonym of Happy.', ['Sad', 'Joyful', 'Angry', 'Tired'], 1, 'Joyful means happy.'),
    QuizQuestion('What is the opposite of Ancient?', ['Old', 'Historic', 'Modern', 'Past'], 2, 'Modern is the opposite of ancient.'),
    QuizQuestion('Choose the correct spelling.', ['Beautifull', 'Beutiful', 'Beautiful', 'Beautifal'], 2, 'Beautiful is the correct spelling.'),
    QuizQuestion('What is the plural of Child?', ['Childs', 'Children', 'Childes', 'Childrens'], 1, 'The plural of child is children.'),
    QuizQuestion('Choose the synonym of Quick.', ['Slow', 'Rapid', 'Late', 'Quiet'], 1, 'Rapid means quick or fast.'),
  ],
};

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = quizData.keys.toList();
    final icons = [Icons.public, Icons.science, Icons.calculate, Icons.menu_book];

    return Scaffold(
      appBar: AppBar(title: const Text('Brain Master Quiz'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Colors.deepPurple, Colors.purpleAccent]),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.lightbulb, color: Colors.white, size: 38),
                SizedBox(height: 10),
                Text('Learn something new every day!', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 6),
                Text('Choose a subject and test your knowledge.', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text('Choose a category', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ...List.generate(categories.length, (i) {
            final name = categories[i];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: CircleAvatar(child: Icon(icons[i])),
                title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('5 multiple-choice questions'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 17),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (_) => QuizPage(category: name, questions: quizData[name]!),
                  ));
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  final String category;
  final List<QuizQuestion> questions;

  const QuizPage({super.key, required this.category, required this.questions});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int questionIndex = 0;
  int score = 0;
  int? selected;
  bool answered = false;

  void selectAnswer(int index) {
    if (answered) return;
    setState(() {
      selected = index;
      answered = true;
      if (index == widget.questions[questionIndex].answer) score++;
    });
  }

  void nextQuestion() {
    if (questionIndex < widget.questions.length - 1) {
      setState(() {
        questionIndex++;
        selected = null;
        answered = false;
      });
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (_) => ResultPage(category: widget.category, score: score, total: widget.questions.length),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final q = widget.questions[questionIndex];

    return Scaffold(
      appBar: AppBar(title: Text(widget.category)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Question ${questionIndex + 1} of ${widget.questions.length}', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            LinearProgressIndicator(value: (questionIndex + 1) / widget.questions.length),
            const SizedBox(height: 28),
            Text(q.question, style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ...List.generate(q.options.length, (i) {
              final correct = i == q.answer;
              final chosen = i == selected;
              Color tileColor = Colors.white;
              Color borderColor = Colors.black12;
              if (answered && correct) {
                tileColor = Colors.green.shade50;
                borderColor = Colors.green;
              } else if (answered && chosen) {
                tileColor = Colors.red.shade50;
                borderColor = Colors.red;
              }
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: InkWell(
                  onTap: answered ? null : () => selectAnswer(i),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: tileColor,
                      border: Border.all(color: borderColor, width: 1.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(child: Text('${String.fromCharCode(65 + i)}. ${q.options[i]}', style: const TextStyle(fontSize: 16))),
                        if (answered && correct) const Icon(Icons.check_circle, color: Colors.green),
                        if (answered && chosen && !correct) const Icon(Icons.cancel, color: Colors.red),
                      ],
                    ),
                  ),
                ),
              );
            }),
            if (answered) ...[
              const SizedBox(height: 6),
              Text(selected == q.answer ? 'Correct answer!' : 'Incorrect. Correct answer: ${q.options[q.answer]}',
                style: TextStyle(fontWeight: FontWeight.bold, color: selected == q.answer ? Colors.green : Colors.red)),
              const SizedBox(height: 6),
              Text(q.explanation),
            ],
            const Spacer(),
            FilledButton(
              onPressed: answered ? nextQuestion : null,
              child: Text(questionIndex == widget.questions.length - 1 ? 'See Result' : 'Next Question'),
            ),
          ],
        ),
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  final String category;
  final int score;
  final int total;

  const ResultPage({super.key, required this.category, required this.score, required this.total});

  @override
  Widget build(BuildContext context) {
    final percent = (score * 100 / total).round();

    return Scaffold(
      appBar: AppBar(title: const Text('Quiz Result'), automaticallyImplyLeading: false, centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.emoji_events, size: 90, color: Colors.amber),
              const SizedBox(height: 16),
              const Text('Well done!', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(category, style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 20),
              Text('$score / $total', style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
              Text('$percent% correct answers', style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const HomePage()), (route) => false);
                  },
                  child: const Text('Play Again'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
