import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Убираем debug баннер
      theme: ThemeData.light().copyWith( // Используем светлую тему
        primaryColor: Colors.blueGrey,
        scaffoldBackgroundColor: Colors.grey[850], // Белый фон
      ),
      home: QuizScreen(),
    );
  }
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0; // Индекс текущего вопроса
  int score = 0; // Баллы
  List<Map<String, Object>> questions = [
    {'question': 'Кыргызстанда 7 область барбы?', 'answer': true,},
    {'question': 'ongo ondu koshso jyrmaby ?', 'answer': true},
    {'question': 'adam jannybarlardan taraganby ?', 'answer': false},
    {'question': 'Oshmu Kyrgyztandagy aldynnky univerbi ?', 'answer': true},
  ];

  String resultText = ''; // Текст результата
  List<Widget> resultWidgets = []; // Виджеты для отображения результатов

  // Проверка ответа пользователя
  void checkAnswer(bool userAnswer) {
    bool correctAnswer = questions[currentQuestionIndex]['answer'] as bool;

    setState(() {
      if (userAnswer == correctAnswer) {
        score++; // Увеличиваем баллы за правильный ответ
        resultText = 'Туура!';
        resultWidgets.add(Icon(Icons.check_circle, color: Colors.green, size: 30));
      } else {
        resultText = 'Ката!';
        resultWidgets.add(Icon(Icons.error_outline, color: Colors.red, size: 30));
      }

      // Переход к следующему вопросу или завершение викторины
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
      } else {
        // Завершение викторины, показываем итоговый результат
        Future.delayed(Duration(seconds: 1), () {
          _showScoreDialog();
        });
      }
    });
  }

  // Показать диалог с результатами
  void _showScoreDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Тест завершён!'),
          content: Text('Ваш результат: $score/${questions.length}'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Закрытие диалога
                setState(() {
                  currentQuestionIndex = 0; // Сброс индекса вопроса
                  score = 0; // Сброс баллов
                  resultText = ''; // Очистка текста результата
                  resultWidgets.clear(); // Очистка виджетов результатов
                });
              },
              child: Text('Перезапустить'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tapshyrma 7'),
        backgroundColor: Colors.white, // Белый фон в AppBar
        foregroundColor: Colors.black, // Черный цвет для текста в AppBar
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Центрирование по вертикали
          crossAxisAlignment: CrossAxisAlignment.center, // Центрирование по горизонтали
          children: <Widget>[
            SizedBox(height: 100),
            // Вопрос с белым цветом текста
            Container(
              padding: EdgeInsets.all(16.0),
             
              child: Text(
                questions[currentQuestionIndex]['question'] as String,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Белый цвет текста
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 40),
            // Кнопки для ответа
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Первая кнопка
                SizedBox(
                  width: 400, // Ширина кнопки
                  child: ElevatedButton(
                    onPressed: () => checkAnswer(true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: Size(250, 70),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text('Туура', style: TextStyle(fontSize: 50, color: Colors.white)),
                  ),
                ),
                SizedBox(height: 40), // Отступ между кнопками
                // Вторая кнопка
                SizedBox(
                  width: 400, // Ширина кнопки
                  child: ElevatedButton(
                    onPressed: () => checkAnswer(false),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: Size(250, 70),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text('Tuura emes', style: TextStyle(fontSize: 50, color: Colors.white)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            // Отображение иконок результатов
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: resultWidgets,
            ),
            SizedBox(height: 30),
            // Отображение результата с увеличенным размером текста
            Text(
              resultText,
              style: TextStyle(
                fontSize: 15, // Увеличение размера текста
                color: resultText == 'Туура!' ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}