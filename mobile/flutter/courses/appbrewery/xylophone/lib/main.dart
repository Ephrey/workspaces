import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';

void main() => runApp(XylophoneApp());

class XylophoneApp extends StatelessWidget {
  static AudioCache player = AudioCache();

  Expanded _buildNoteButton({int noteNumber, Color color}) {
    return Expanded(
      child: TextButton(
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(color)),
        child: null,
        onPressed: () => player.play('note$noteNumber.wav'),
      ),
    );
  }

  Column _noteButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildNoteButton(noteNumber: 1, color: Colors.red),
        _buildNoteButton(noteNumber: 2, color: Colors.orange),
        _buildNoteButton(noteNumber: 3, color: Colors.teal),
        _buildNoteButton(noteNumber: 4, color: Colors.blue),
        _buildNoteButton(noteNumber: 5, color: Colors.amber),
        _buildNoteButton(noteNumber: 6, color: Colors.pink),
        _buildNoteButton(noteNumber: 7, color: Colors.tealAccent),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(child: _noteButtons()),
      ),
    );
  }
}
