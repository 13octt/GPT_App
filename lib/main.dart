import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';

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
  var result = "results...";
  late OpenAI openAI;
  var token = "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";
  late CompleteResponse response;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    openAI = OpenAI.instance.build(token: token,baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5)),enableLog: true);
    openAI.setToken(token);
    openAI.token;
  }
  @override
  Widget build(BuildContext context) {
    // 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
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(result),
            Text(response as String),
            Row(children: [
              const Expanded(child: TextField()),
              ElevatedButton(onPressed: () async {
                final request = CompleteText(prompt:'What is human life expectancy in the United States?',
                    model: TextDavinci3Model(), maxTokens: 200);

                response = (await openAI.onCompletion(request:request))! ;
              }, child: const Icon(Icons.send))
            ],)
          ],
        ),
      ),
    );
  }
}
