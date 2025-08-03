import 'package:counter/imagepicker.dart';
import 'package:counter/theme_switch.dart';
import 'package:flutter/material.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: HomePage(),
      routes: {
        '/theme': (_) => ThemeSwitcherPage(),
        '/picker': (_) => ImagePickerPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Theme Switcher'),
              onPressed: () {
                Navigator.pushNamed(context, '/theme');
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Image Picker'),
              onPressed: () {
                Navigator.pushNamed(context, '/picker');
              },
            ),
          ],
        ),
      ),
    );
  }
}
