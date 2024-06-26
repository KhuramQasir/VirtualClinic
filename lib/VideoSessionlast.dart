import 'package:flutter/material.dart';
import 'package:mcqs/GetStart.dart';
import 'package:mcqs/PatientHome.dart';
import 'package:mcqs/patienthomeNavigation.dart';
import 'package:video_player/video_player.dart';

class VideoSessionLast extends StatefulWidget {
  @override
  _VideoSessionLastState createState() => _VideoSessionLastState();
}

class _VideoSessionLastState extends State<VideoSessionLast> {
  late VideoPlayerController _controller;
  int currentVideoIndex = 0;
  bool _isVideoCompleted = false;

  final List<String> videoPaths = [
    'lib/Videos/video3.mp4',
    'lib/Videos/Psychology_in_30_Seconds.mp4', // Replace with your second video file path
  ];

  final List<List<Question>> quizzes = [
    [
      Question(
        questionText: 'Based on the video presented, which emotion best resonates with your response?',
        options: ['Sadness', 'Shock', 'Indifference', 'Sympathy'],
        correctOptionIndex: 1,
      ),
      Question(
        questionText: 'When viewing the joyful video, which sentiment aligns most with your response?',
        options: ['Happiness', 'Elation', 'Indifference', 'Contentment'],
        correctOptionIndex: 2,
      ),
      Question(
        questionText: 'Please select the option that aligns most with your emotional response?',
        options: ['Disgusting', 'Unsettling', 'Indifferent', 'Neutral'],
        correctOptionIndex: 2,
      ),
    ],
    [
      Question(
        questionText: 'Based on the video presented, which emotion best resonates with your response?',
        options: ['Sadness', 'Shock', 'Indifference', 'Sympathy'],
        correctOptionIndex: 1,
      ),
      Question(
        questionText: 'When viewing the joyful video, which sentiment aligns most with your response?',
        options: ['Happiness', 'Elation', 'Indifference', 'Contentment'],
        correctOptionIndex: 2,
      ),
      Question(
        questionText: 'Please select the option that aligns most with your emotional response?',
        options: ['Disgusting', 'Unsettling', 'Indifferent', 'Neutral'],
        correctOptionIndex: 2,
      ),
    ],
  ];

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  void _initializeVideo() {
    _controller = VideoPlayerController.asset(videoPaths[currentVideoIndex])
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });

    _controller.addListener(() {
      if (_controller.value.position == _controller.value.duration) {
        setState(() {
          _isVideoCompleted = true;
        });
      }
    });
  }

  void _loadNextVideo() {
    if (currentVideoIndex < videoPaths.length - 1) {
      setState(() {
        currentVideoIndex++;
        _isVideoCompleted = false;
        _controller.dispose();
        _initializeVideo();
      });
    } else {
      _navigateToDashboard();
    }
  }

  void _navigateToDashboard() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => PatientHomeNavigation()),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Session'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : CircularProgressIndicator(),
            ),
          ),
          if (_isVideoCompleted)
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizScreen(
                      questions: quizzes[currentVideoIndex],
                      onQuizComplete: _loadNextVideo,
                    ),
                  ),
                );
              },
              child: Text('Start'),
            ),
        ],
      ),
      floatingActionButton: _controller.value.isInitialized
          ? FloatingActionButton(
              onPressed: () {
                setState(() {
                  _controller.value.isPlaying ? _controller.pause() : _controller.play();
                });
              },
              child: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
            )
          : null,
    );
  }
}

class QuizScreen extends StatelessWidget {
  final List<Question> questions;
  final VoidCallback onQuizComplete;

  QuizScreen({required this.questions, required this.onQuizComplete});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: Quiz(
        questions: questions,
        onQuizComplete: onQuizComplete,
      ),
    );
  }
}

class Question {
  final String questionText;
  final List<String> options;
  final int correctOptionIndex;

  Question({
    required this.questionText,
    required this.options,
    required this.correctOptionIndex,
  });
}

class Quiz extends StatefulWidget {
  final List<Question> questions;
  final VoidCallback onQuizComplete;

  Quiz({required this.questions, required this.onQuizComplete});

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int currentQuestionIndex = 0;
  int score = 0;

  void _answerQuestion(int selectedIndex) {
    if (selectedIndex == widget.questions[currentQuestionIndex].correctOptionIndex) {
      score++;
    }

    if (currentQuestionIndex < widget.questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      _showScoreDialog();
    }
  }

  void _showScoreDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Completed'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.of(context).pop(); // Go back to the video screen
              widget.onQuizComplete();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = widget.questions[currentQuestionIndex];
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            currentQuestion.questionText,
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(height: 20.0),
          ...currentQuestion.options.asMap().entries.map((entry) {
            final index = entry.key;
            final option = entry.value;
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Background color
                foregroundColor: Colors.white, // Text color
              ),
              onPressed: () => _answerQuestion(index),
              child: Text(option),
            );
          }).toList(),
        ],
      ),
    );
  }
}

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Center(
        child: Text('Welcome to the Dashboard!'),
      ),
    );
  }
}
