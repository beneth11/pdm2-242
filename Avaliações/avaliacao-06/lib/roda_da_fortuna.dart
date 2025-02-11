import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

void main() {
  runApp(GiraRoleta());
}

class GiraRoleta extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fortune Wheel Example',
      home: ExamplePage(),
    );
  }
}

class ExamplePage extends StatefulWidget {
  @override
  _ExamplePageState createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  final StreamController<int> _selected = StreamController<int>();
  final List<String> _winners = [];

  @override
  void dispose() {
    _selected.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = <String>[
      'Grogu',
      'Mace Windu',
      'Obi-Wan Kenobi',
      'Han Solo',
      'Luke Skywalker',
      'Darth Vader',
      'Yoda',
      'Ahsoka Tano',
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Flutter Fortune Wheel')),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text('Spin Wheel'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ExamplePage()),
                );
              },
            ),
            ListTile(
              title: Text('Winners'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WinnersPage(winners: _winners)),
                );
              },
            ),
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () {
          final winnerIndex = Fortune.randomInt(0, items.length);
          _selected.add(winnerIndex);
          setState(() {
            _winners.add(items[winnerIndex]);
          });

          // Show a dialog with the winner after a slight delay
          Future.delayed(Duration(milliseconds: 5000), () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Winner'),
                  content: Text('The winner is: ${items[winnerIndex]}'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Close'),
                    ),
                  ],
                );
              },
            );
          });
        },
        child: Center(
          child: SizedBox(
            width: 500,  // Fixed width for the wheel
            height: 500, // Fixed height for the wheel
            child: FortuneWheel(
              selected: _selected.stream,
              items: [
                for (var item in items) FortuneItem(child: Text(item)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WinnersPage extends StatelessWidget {
  final List<String> winners;

  WinnersPage({required this.winners});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Winners')),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text('Spin Wheel'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ExamplePage()),
                );
              },
            ),
            ListTile(
              title: Text('Winners'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => WinnersPage(winners: winners)),
                );
              },
            ),
          ],
        ),
      ),
      body: winners.isEmpty
          ? Center(child: Text('No winners yet!'))
          : ListView.builder(
              itemCount: winners.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(winners[index]),
                );
              },
            ),
    );
  }
}
