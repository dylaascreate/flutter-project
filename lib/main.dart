import 'package:flutter/material.dart';
import 'color_circle.dart';
import 'color_value_changer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
    return MaterialApp(
    title: 'Color Mixer',
    home: ColorMixerPage(),
    ); // MaterialApp
  }
}
class ColorMixerPage extends StatefulWidget {
  @override
  _ColorMixerPageState createState() => _ColorMixerPageState();
}

class _ColorMixerPageState extends State<ColorMixerPage> {
  double red = 0;
  double green = 0;
  double blue = 0;

  void updateColor(String channel, double value) {
    setState(() {
    if (channel == 'red') red = value;
    if (channel == 'green') green = value;
    if (channel == 'blue') blue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Color Mixer')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ColorCircle(
            color: Color.fromRGBO(red.toInt(), green.toInt(), blue.toInt(), 1),
            size: 150,
             ), // ColorCircle
            SizedBox(height: 30),
            ColorValueChanger(
              label: "Red",
              value: red,
              activeColor: Colors.red,
              onChanged: (val) => updateColor('red', val),
            ), // ColorValueChanger
            ColorValueChanger(
              label: "Green",
              value: green,
              activeColor: Colors.green,
              onChanged: (val) => updateColor('green', val),
            ), // ColorValueChanger
              ColorValueChanger(
              label: "Blue",
              value: blue,
              activeColor: Colors.blue,
              onChanged: (val) => updateColor('blue', val),
            ), // ColorValueChanger
          ],
        ), // Column
      ), // Padding
    ); // Scaffold
  }
}