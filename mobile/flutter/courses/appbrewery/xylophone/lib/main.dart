import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';

void main() => runApp(XylophoneApp());

class XylophoneApp extends StatelessWidget {
  static AudioCache player = AudioCache();

  Widget _buildNoteButton(int noteNumber, Color color) {
    return Expanded(
      child: TextButton(
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(color)),
        child: null,
        onPressed: () => player.play('note$noteNumber.wav'),
      ),
    );
  }

  Widget _noteButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildNoteButton(1, Colors.red),
        _buildNoteButton(2, Colors.orange),
        _buildNoteButton(3, Colors.teal),
        _buildNoteButton(4, Colors.blue),
        _buildNoteButton(5, Colors.amber),
        _buildNoteButton(6, Colors.pink),
        _buildNoteButton(7, Colors.yellow),
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
