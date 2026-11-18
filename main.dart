import 'dart:math';
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

  const QuizQuestion(
    this.question,
    this.options,
    this.answer,
    this.explanation,
  );
}

const Map<String, List<QuizQuestion>> quizData = {
  'General Knowledge': [
    QuizQuestion(
      'Which is the largest planet?',
      ['Earth', 'Jupiter', 'Mars', 'Venus'],
      1,
      'Jupiter is the largest planet in our solar system.',
    ),
    QuizQuestion(
      'What is the capital of India?',
      ['Mumbai', 'New Delhi', 'Chennai', 'Kolkata'],
      1,
      'New Delhi is the capital of India.',
    ),
    QuizQuestion(
      'How many days are in a leap year?',
      ['365', '366', '364', '360'],
      1,
      'A leap year has 366 days.',
    ),
    QuizQuestion(
      'Which animal is called the Ship of the Desert?',
      ['Horse', 'Camel', 'Elephant', 'Lion'],
      1,
      'The camel is called the Ship of the Desert.',
    ),
    QuizQuestion(
      'What is the national bird of India?',
      ['Parrot', 'Peacock', 'Eagle', 'Swan'],
      1,
      'The peacock is the national bird of India.',
    ),
    QuizQuestion(
      'Which is the largest ocean?',
      ['Atlantic', 'Indian', 'Arctic', 'Pacific'],
      3,
      'The Pacific Ocean is the largest ocean.',
    ),
    QuizQuestion(
      'How many colours are traditionally named in a rainbow?',
      ['Five', 'Six', 'Seven', 'Eight'],
      2,
      'A rainbow is traditionally described as having seven colours.',
    ),
    QuizQuestion(
      'Which is the smallest continent?',
      ['Asia', 'Australia', 'Europe', 'Africa'],
      1,
      'Australia is the smallest continent by land area.',
    ),
    QuizQuestion(
      'Who wrote the Indian national anthem?',
      [
        'Bankim Chandra Chatterjee',
        'Rabindranath Tagore',
        'Sarojini Naidu',
        'Subhas Chandra Bose',
      ],
      1,
      'Rabindranath Tagore wrote Jana Gana Mana.',
    ),
    QuizQuestion(
      'Which festival is known as the Festival of Lights?',
      ['Holi', 'Eid', 'Diwali', 'Baisakhi'],
      2,
      'Diwali is widely known as the Festival of Lights.',
    ),
    QuizQuestion(
      'How many players from one team are on the field in cricket?',
      ['9', '10', '11', '12'],
      2,
      'A cricket team has eleven players on the field.',
    ),
    QuizQuestion(
      'Which is the fastest land animal?',
      ['Lion', 'Cheetah', 'Horse', 'Leopard'],
      1,
      'The cheetah is the fastest land animal.',
    ),
    QuizQuestion(
      'Which Indian city is called the Pink City?',
      ['Udaipur', 'Jaipur', 'Jodhpur', 'Bhopal'],
      1,
      'Jaipur is popularly known as the Pink City.',
    ),
    QuizQuestion(
      'How many sides does an octagon have?',
      ['Six', 'Seven', 'Eight', 'Nine'],
      2,
      'An octagon has eight sides.',
    ),
    QuizQuestion(
      'Which instrument is used to measure temperature?',
      ['Barometer', 'Thermometer', 'Compass', 'Hygrometer'],
      1,
      'A thermometer measures temperature.',
    ),
    QuizQuestion(
      'Which is the largest mammal?',
      ['Elephant', 'Blue whale', 'Giraffe', 'Hippopotamus'],
      1,
      'The blue whale is the largest mammal.',
    ),
    QuizQuestion(
      'Which country is famous for the Great Wall?',
      ['India', 'Japan', 'China', 'Thailand'],
      2,
      'The Great Wall is in China.',
    ),
    QuizQuestion(
      'What is the currency of Japan?',
      ['Won', 'Yen', 'Dollar', 'Rupee'],
      1,
      'The currency of Japan is the yen.',
    ),
    QuizQuestion(
      'Which day comes after Friday?',
      ['Thursday', 'Saturday', 'Sunday', 'Monday'],
      1,
      'Saturday comes after Friday.',
    ),
    QuizQuestion(
      'How many minutes are there in one hour?',
      ['30', '45', '60', '90'],
      2,
      'One hour has sixty minutes.',
    ),
  ],
  'Science': [
    QuizQuestion(
      'Which gas do plants absorb?',
      ['Oxygen', 'Nitrogen', 'Carbon dioxide', 'Hydrogen'],
      2,
      'Plants absorb carbon dioxide during photosynthesis.',
    ),
    QuizQuestion(
      'What is the chemical formula of water?',
      ['CO2', 'H2O', 'O2', 'NaCl'],
      1,
      'Water is H2O.',
    ),
    QuizQuestion(
      'Which part of a plant absorbs water?',
      ['Flower', 'Leaf', 'Root', 'Fruit'],
      2,
      'Roots absorb water from the soil.',
    ),
    QuizQuestion(
      'Which planet is called the Red Planet?',
      ['Mars', 'Saturn', 'Mercury', 'Neptune'],
      0,
      'Mars is known as the Red Planet.',
    ),
    QuizQuestion(
      'Which force pulls objects towards Earth?',
      ['Friction', 'Gravity', 'Magnetism', 'Sound'],
      1,
      'Gravity pulls objects towards Earth.',
    ),
    QuizQuestion(
      'Which organ pumps blood around the body?',
      ['Lungs', 'Brain', 'Heart', 'Kidney'],
      2,
      'The heart pumps blood around the body.',
    ),
    QuizQuestion(
      'At what temperature does water boil at sea level?',
      ['0°C', '50°C', '100°C', '150°C'],
      2,
      'At standard atmospheric pressure, water boils at 100°C.',
    ),
    QuizQuestion(
      'Which vitamin can the body make with help from sunlight?',
      ['Vitamin A', 'Vitamin B12', 'Vitamin C', 'Vitamin D'],
      3,
      'Sunlight helps the body produce vitamin D.',
    ),
    QuizQuestion(
      'What is the centre of an atom called?',
      ['Nucleus', 'Cell', 'Core', 'Electron'],
      0,
      'The centre of an atom is its nucleus.',
    ),
    QuizQuestion(
      'Which gas do humans need for respiration?',
      ['Carbon dioxide', 'Oxygen', 'Helium', 'Neon'],
      1,
      'Humans use oxygen in cellular respiration.',
    ),
    QuizQuestion(
      'Which part of the cell contains genetic material?',
      ['Nucleus', 'Cell wall', 'Vacuole', 'Cytoplasm only'],
      0,
      'The nucleus contains most of a cell’s genetic material.',
    ),
    QuizQuestion(
      'What is the SI unit of force?',
      ['Joule', 'Watt', 'Newton', 'Pascal'],
      2,
      'The SI unit of force is the newton.',
    ),
    QuizQuestion(
      'Which material is attracted by a magnet?',
      ['Wood', 'Plastic', 'Iron', 'Glass'],
      2,
      'Iron is a magnetic material.',
    ),
    QuizQuestion(
      'Which organ helps humans breathe?',
      ['Stomach', 'Lungs', 'Liver', 'Pancreas'],
      1,
      'The lungs help in breathing and gas exchange.',
    ),
    QuizQuestion(
      'What is the closest star to Earth?',
      ['Sirius', 'The Sun', 'Polaris', 'Alpha Centauri'],
      1,
      'The Sun is the closest star to Earth.',
    ),
    QuizQuestion(
      'Which state of matter has a fixed shape and volume?',
      ['Gas', 'Liquid', 'Solid', 'Plasma'],
      2,
      'A solid generally has a fixed shape and volume.',
    ),
    QuizQuestion(
      'Which blood cells help fight infections?',
      [
        'Red blood cells',
        'White blood cells',
        'Platelets',
        'All blood cells equally',
      ],
      1,
      'White blood cells help the body fight infections.',
    ),
    QuizQuestion(
      'Which simple machine is a seesaw an example of?',
      ['Pulley', 'Lever', 'Wheel and axle', 'Screw'],
      1,
      'A seesaw is an example of a lever.',
    ),
    QuizQuestion(
      'Which layer protects Earth from much of the Sun’s ultraviolet radiation?',
      ['Ozone layer', 'Cloud layer', 'Crust', 'Mantle'],
      0,
      'The ozone layer absorbs much of the Sun’s ultraviolet radiation.',
    ),
    QuizQuestion(
      'What is the process by which liquid changes into gas?',
      ['Freezing', 'Condensation', 'Evaporation', 'Melting'],
      2,
      'Evaporation changes a liquid into a gas.',
    ),
  ],
  'Mathematics': [
    QuizQuestion(
      'What is 12 × 8?',
      ['84', '96', '108', '88'],
      1,
      '12 × 8 = 96.',
    ),
    QuizQuestion(
      'What is the square root of 81?',
      ['7', '8', '9', '10'],
      2,
      '9 × 9 = 81.',
    ),
    QuizQuestion(
      'How many sides does a hexagon have?',
      ['5', '6', '7', '8'],
      1,
      'A hexagon has six sides.',
    ),
    QuizQuestion(
      'What is 25% of 200?',
      ['25', '40', '50', '75'],
      2,
      '25% of 200 is 50.',
    ),
    QuizQuestion(
      'What is 15 + 27?',
      ['32', '40', '42', '45'],
      2,
      '15 + 27 = 42.',
    ),
    QuizQuestion(
      'What is 9 × 7?',
      ['56', '63', '72', '79'],
      1,
      '9 multiplied by 7 is 63.',
    ),
    QuizQuestion(
      'What is 144 ÷ 12?',
      ['10', '11', '12', '14'],
      2,
      '144 divided by 12 is 12.',
    ),
    QuizQuestion(
      'What is the perimeter of a square with side 5 cm?',
      ['10 cm', '15 cm', '20 cm', '25 cm'],
      2,
      'Perimeter of a square is 4 × side = 20 cm.',
    ),
    QuizQuestion(
      'What is 3/4 expressed as a percentage?',
      ['25%', '50%', '75%', '80%'],
      2,
      'Three quarters is equal to 75%.',
    ),
    QuizQuestion(
      'What is the next prime number after 7?',
      ['8', '9', '10', '11'],
      3,
      '11 is the next prime number after 7.',
    ),
    QuizQuestion(
      'How many degrees are in a right angle?',
      ['45°', '90°', '180°', '360°'],
      1,
      'A right angle measures 90 degrees.',
    ),
    QuizQuestion(
      'What is 2 to the power of 5?',
      ['10', '16', '25', '32'],
      3,
      '2 × 2 × 2 × 2 × 2 = 32.',
    ),
    QuizQuestion(
      'What is the average of 4, 6 and 8?',
      ['5', '6', '7', '8'],
      1,
      'The average is (4 + 6 + 8) ÷ 3 = 6.',
    ),
    QuizQuestion(
      'What is 0.5 written as a fraction in simplest form?',
      ['1/4', '1/2', '2/3', '3/4'],
      1,
      '0.5 is equal to one half.',
    ),
    QuizQuestion(
      'A triangle has how many angles?',
      ['Two', 'Three', 'Four', 'Five'],
      1,
      'A triangle has three angles.',
    ),
    QuizQuestion(
      'What is 1000 minus 375?',
      ['525', '575', '625', '675'],
      2,
      '1000 − 375 = 625.',
    ),
    QuizQuestion(
      'What is the Roman numeral for 10?',
      ['V', 'X', 'L', 'C'],
      1,
      'X represents 10 in Roman numerals.',
    ),
    QuizQuestion(
      'What is the area of a rectangle 6 cm long and 4 cm wide?',
      ['10 cm²', '20 cm²', '24 cm²', '28 cm²'],
      2,
      'Area = length × width = 24 cm².',
    ),
    QuizQuestion(
      'Which number is an even number?',
      ['13', '17', '22', '29'],
      2,
      '22 is divisible by 2.',
    ),
    QuizQuestion(
      'What is 15% of 100?',
      ['5', '10', '15', '20'],
      2,
      '15% of 100 is 15.',
    ),
  ],
  'English Vocabulary': [
    QuizQuestion(
      'Choose the synonym of Happy.',
      ['Sad', 'Joyful', 'Angry', 'Tired'],
      1,
      'Joyful means happy.',
    ),
    QuizQuestion(
      'What is the opposite of Ancient?',
      ['Old', 'Historic', 'Modern', 'Past'],
      2,
      'Modern is the opposite of ancient.',
    ),
    QuizQuestion(
      'Choose the correct spelling.',
      ['Beautifull', 'Beutiful', 'Beautiful', 'Beautifal'],
      2,
      'Beautiful is the correct spelling.',
    ),
    QuizQuestion(
      'What is the plural of Child?',
      ['Childs', 'Children', 'Childes', 'Childrens'],
      1,
      'The plural of child is children.',
    ),
    QuizQuestion(
      'Choose the synonym of Quick.',
      ['Slow', 'Rapid', 'Late', 'Quiet'],
      1,
      'Rapid means quick or fast.',
    ),
    QuizQuestion(
      'What is the opposite of Generous?',
      ['Kind', 'Selfish', 'Helpful', 'Friendly'],
      1,
      'Selfish is the opposite of generous.',
    ),
    QuizQuestion(
      'Choose the correctly spelled word.',
      ['Necessary', 'Neccessary', 'Necesary', 'Necessery'],
      0,
      'Necessary is the correct spelling.',
    ),
    QuizQuestion(
      'What does “Enormous” mean?',
      ['Tiny', 'Very large', 'Quiet', 'Angry'],
      1,
      'Enormous means very large.',
    ),
    QuizQuestion(
      'Choose the antonym of “Brave”.',
      ['Courageous', 'Fearless', 'Cowardly', 'Bold'],
      2,
      'Cowardly is an antonym of brave.',
    ),
    QuizQuestion(
      'What is the past tense of “Go”?',
      ['Goed', 'Gone', 'Went', 'Going'],
      2,
      'The simple past tense of go is went.',
    ),
    QuizQuestion(
      'Which word is a noun?',
      ['Quickly', 'Honesty', 'Beautiful', 'Run'],
      1,
      'Honesty is a noun naming a quality.',
    ),
    QuizQuestion(
      'Choose the synonym of “Begin”.',
      ['Finish', 'Start', 'Close', 'Stop'],
      1,
      'Start means begin.',
    ),
    QuizQuestion(
      'What is the opposite of “Victory”?',
      ['Success', 'Defeat', 'Prize', 'Reward'],
      1,
      'Defeat is the opposite of victory.',
    ),
    QuizQuestion(
      'Which word describes a person, place or thing?',
      ['Verb', 'Adjective', 'Noun', 'Adverb'],
      2,
      'A noun names a person, place, thing or idea.',
    ),
    QuizQuestion(
      'Choose the correct article: “___ apple a day”.',
      ['A', 'An', 'The', 'No article'],
      1,
      'Use “an” before a vowel sound, as in an apple.',
    ),
    QuizQuestion(
      'What is the plural of “Mouse”?',
      ['Mouses', 'Mices', 'Mice', 'Mouse'],
      2,
      'The plural of mouse is mice.',
    ),
    QuizQuestion(
      'Choose the synonym of “Silent”.',
      ['Noisy', 'Quiet', 'Bright', 'Busy'],
      1,
      'Quiet means making little or no noise.',
    ),
    QuizQuestion(
      'Which is a verb?',
      ['Happiness', 'Blue', 'Dance', 'Careful'],
      2,
      'Dance is an action word, so it is a verb.',
    ),
    QuizQuestion(
      'What is the opposite of “Accept”?',
      ['Receive', 'Agree', 'Reject', 'Allow'],
      2,
      'Reject is the opposite of accept.',
    ),
    QuizQuestion(
      'Choose the correct spelling.',
      ['Environment', 'Enviroment', 'Envirnment', 'Enviornment'],
      0,
      'Environment is the correct spelling.',
    ),
  ],
};

// Questions already used in the current app session.
// Each category cycles through its full question bank before repeating.
final Map<String, Set<String>> usedQuestions = {};

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = quizData.keys.toList();
    final icons = [
      Icons.public,
      Icons.science,
      Icons.calculate,
      Icons.menu_book,
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Brain Master Quiz'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.deepPurple, Colors.purpleAccent],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.lightbulb, color: Colors.white, size: 38),
                SizedBox(height: 10),
                Text(
                  'Learn something new every day!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Choose a subject and test your knowledge.',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Choose a category',
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ...List.generate(categories.length, (i) {
            final name = categories[i];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: CircleAvatar(child: Icon(icons[i])),
                title: Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text('5 multiple-choice questions'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 17),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) {
                        final used = usedQuestions.putIfAbsent(
                          name,
                          () => <String>{},
                        );
                        var available = quizData[name]!
                            .where(
                              (question) => !used.contains(question.question),
                            )
                            .toList();

                        // Start a fresh cycle only after all questions in this
                        // category have been used.
                        if (available.length < 5) {
                          used.clear();
                          available = List<QuizQuestion>.from(quizData[name]!);
                        }

                        available.shuffle(Random());
                        final selectedQuestions = available.take(5).toList();
                        used.addAll(selectedQuestions.map((q) => q.question));

                        return QuizPage(
                          category: name,
                          questions: selectedQuestions,
                        );
                      },
                    ),
                  );
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
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultPage(
            category: widget.category,
            score: score,
            total: widget.questions.length,
          ),
        ),
      );
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
            Text(
              'Question ${questionIndex + 1} of ${widget.questions.length}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: (questionIndex + 1) / widget.questions.length,
            ),
            const SizedBox(height: 28),
            Text(
              q.question,
              style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
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
                        Expanded(
                          child: Text(
                            '${String.fromCharCode(65 + i)}. ${q.options[i]}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        if (answered && correct)
                          const Icon(Icons.check_circle, color: Colors.green),
                        if (answered && chosen && !correct)
                          const Icon(Icons.cancel, color: Colors.red),
                      ],
                    ),
                  ),
                ),
              );
            }),
            if (answered) ...[
              const SizedBox(height: 6),
              Text(
                selected == q.answer
                    ? 'Correct answer!'
                    : 'Incorrect. Correct answer: ${q.options[q.answer]}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: selected == q.answer ? Colors.green : Colors.red,
                ),
              ),
              const SizedBox(height: 6),
              Text(q.explanation),
            ],
            const Spacer(),
            FilledButton(
              onPressed: answered ? nextQuestion : null,
              child: Text(
                questionIndex == widget.questions.length - 1
                    ? 'See Result'
                    : 'Next Question',
              ),
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

  const ResultPage({
    super.key,
    required this.category,
    required this.score,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final percent = (score * 100 / total).round();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Result'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.emoji_events, size: 90, color: Colors.amber),
              const SizedBox(height: 16),
              const Text(
                'Well done!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(category, style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 20),
              Text(
                '$score / $total',
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              Text(
                '$percent% correct answers',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const HomePage()),
                      (route) => false,
                    );
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
