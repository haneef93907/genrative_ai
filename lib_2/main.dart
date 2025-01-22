

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

const apiKey = 'AIzaSyDzcjhYVE9G3d7TwuVSiv8N2QnG2VpFgHI';

void main() async {

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 TextEditingController _promptTextEditingController = TextEditingController();

 bool isLoading = false;

 getAIResponse(String prompt) async{

    final model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: apiKey,
  );
  final content = [Content.text(prompt)];
  final response = await model.generateContent(content);
  airesponse = response.text ?? "";
setState(() {
  isLoading = false;
});
 }
 String airesponse = "";
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: Text(
        widget.title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _promptTextEditingController,
                  decoration: InputDecoration(
                    labelText: "Enter your prompt",
                    hintText: "Type something here...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: () {
                  if (_promptTextEditingController.text.isNotEmpty) {
                    setState(() {
                      isLoading = true;
                      airesponse = "";
                    });
                    getAIResponse(_promptTextEditingController.text);
                  }
                },
                icon: Icon(Icons.send),
                label: Text("Send"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Center(
              child: isLoading
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        const SizedBox(height: 10),
                        Text(
                          "Generating response...",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    )
                  : airesponse.isEmpty
                      ? Text(
                          "No Response Yet",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        )
                      : SingleChildScrollView(
                          child: Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              airesponse,
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
            ),
          ),
        ],
      ),
    ),
  );
}

}
