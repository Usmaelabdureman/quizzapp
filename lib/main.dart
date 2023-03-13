import 'package:flutter/material.dart';
import 'questions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuizApp(),
    );
  }
}

class QuizApp extends StatefulWidget {
  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  int _questionIndex = 0;
  int _score = 0;
  List<int> _userAnswers = [];

  void _nextQuestion(int selectedOptionIndex) {
    setState(() {
      _userAnswers.add(selectedOptionIndex);
      if (selectedOptionIndex ==
          QuizData.questions[_questionIndex]['answer_index']) {
        _score++;
      }
      if (_questionIndex < QuizData.questions.length - 1) {
        _questionIndex++;
      } else {
        _showResult();
      }
    });
  }

  void _retryQuiz() {
    setState(() {
      _questionIndex = 0;
      _score = 0;
      _userAnswers = [];
    });
  }

  void _showResult() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You got $_score out of ${QuizData.questions.length} questions right!',
                style: const TextStyle(fontSize: 20.0),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _retryQuiz,
                child: const Text('Retry Quiz'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Quiz App')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
           
            Text(
              QuizData.questions[_questionIndex]['question'],
              style: const TextStyle(fontSize: 24.0),
            ),
            const SizedBox(height: 20.0),
            ...QuizData.questions[_questionIndex]['options']
                .asMap()
                .entries
                .map(
                  (entry) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: ElevatedButton(
                      child: Text(entry.value),
                      onPressed: () {
                        _nextQuestion(entry.key);
                      },
                    ),
                  ),
                )
                .toList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 100.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.facebook),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.favorite),
                      
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.favorite),
                      onPressed: () {},
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(Icons.share),
      ),
    );
  }
}
