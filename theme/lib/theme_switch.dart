import 'package:flutter/material.dart';

class ThemeSwitcherPage extends StatefulWidget {
  const ThemeSwitcherPage({super.key});

  @override
  _ThemeSwitcherPageState createState() => _ThemeSwitcherPageState();
}

class _ThemeSwitcherPageState extends State<ThemeSwitcherPage> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Theme Switcher')),
      body: Center(
        child: AnimatedContainer(
          duration: Duration(seconds: 1),
          color: isDark ? Colors.black : Colors.white,
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: Switch(
              value: isDark,
              onChanged: (value) {
                setState(() {
                  isDark = value;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
