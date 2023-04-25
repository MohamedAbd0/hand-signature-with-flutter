// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:hand_signature/signature.dart';

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
        primarySwatch: Colors.blue,
      ),
      home: const MySignaturePad(),
    );
  }
}

class MySignaturePad extends StatefulWidget {
  const MySignaturePad({super.key});

  @override
  _MySignaturePadState createState() => _MySignaturePadState();
}

class _MySignaturePadState extends State<MySignaturePad> {
  final control = HandSignatureControl(
    threshold: 3.0,
    smoothRatio: 0.65,
    velocityRange: 2.0,
  );

  late Map<String, dynamic> jsonData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hand Signature"),
        actions: [
          IconButton(
            onPressed: () async {
              control.importData(jsonData);
            },
            icon: const Icon(Icons.import_export),
          ),
          IconButton(
            onPressed: () async {
              jsonData = control.toMap();
              control.clear();
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(border: Border.all()),
        height: MediaQuery.of(context).size.width,
        width: MediaQuery.of(context).size.width,
        child: HandSignature(
          control: control,
          color: Colors.red,
          width: 3,
          type: SignatureDrawType.shape,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: () {
          // to clear signature
          control.clear();
        },
      ),
    );
  }
}
