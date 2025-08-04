import 'package:counter/bloc/bloc_counter_page.dart';
import 'package:counter/bloc/counter_bloc.dart';
import 'package:counter/provider/counter_provider.dart';
import 'package:counter/provider/provider_counter_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Wrap the whole app with MultiProvider & MultiBlocProvider
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => CounterProvider())],
      child: MultiBlocProvider(
        providers: [BlocProvider(create: (_) => CounterBloc())],
        child: MaterialApp(title: 'Provider & BLoC Counters', home: HomePage()),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Choose Counter Type')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Provider Counter (Increment Only)'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ProviderCounterPage()),
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('BLoC Counter (Increment & Decrement)'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => BlocCounterPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
