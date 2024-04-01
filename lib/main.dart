import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Translator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final translator = GoogleTranslator();
  final englishController = TextEditingController();
  final slovenianController = TextEditingController();

  @override
  void dispose() {
    englishController.dispose();
    slovenianController.dispose();
    super.dispose();
  }

  Future<void> translateToSlovenian(String text) async {
    if (text.isNotEmpty) {
      var translation = await translator.translate(text, from: 'en', to: 'sl');
      slovenianController.text = translation.toString();
    }
  }

  Future<void> translateToEnglish(String text) async {
    if (text.isNotEmpty) {
      var translation = await translator.translate(text, from: 'sl', to: 'en');
      englishController.text = translation.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: Icon(Icons.star_border),
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Card(
        margin: EdgeInsets.all(20),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text("English"),
            const SizedBox(height: 2),
            TextField(
              controller: englishController,
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
              decoration: const InputDecoration(
                hintText: "Enter Text",
                border: InputBorder.none,
              ),
              maxLines: null,
              onChanged: (text) {
                translateToSlovenian(text);
              },
            ),
            const Divider(height: 32),
            const Text("Slovenian"),
            const SizedBox(height: 8),
            TextField(
              controller: slovenianController,
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
              decoration: const InputDecoration(
                hintText: "Enter Text",
                border: InputBorder.none,
              ),
              maxLines: null,
              onChanged: (text) {
                translateToEnglish(text);
              },
            ),
          ],
        ),
      ),
    );
  }
}
