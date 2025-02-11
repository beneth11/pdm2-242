import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'config.dart';

void main() {
  runApp(GiraRoleta());
}

class GiraRoleta extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Config.appName,
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
  final TextEditingController _textController = TextEditingController();
  List<String> items = [
    'Obi-Wan Kenobi',
    'Han Solo',
    'Luke Skywalker',
    'Darth Vader',
    'Ahsoka Tano',
  ];

  void _addItem() {
    if (_textController.text.isNotEmpty) {
      setState(() {
        items.add(_textController.text);
        _textController.clear();
      });
    }
  }

  @override
  void dispose() {
    _selected.close();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Config.appName)),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text(Config.appName),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ExamplePage()),
                );
              },
            ),
            ListTile(
              title: Text(Config.viewList1),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WinnersPage(winners: _winners)),
                );
              },
            ),
            ListTile(
              title: Text(Config.viewList2),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutMePage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Digite algo...'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addItem,
                ),
              ],
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                final winnerIndex = Fortune.randomInt(0, items.length);
                _selected.add(winnerIndex);
                setState(() {
                  _winners.add(items[winnerIndex]);
                });

                Future.delayed(Duration(milliseconds: 5000), () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Venceu🥳'),
                        content: Text('O vencedor é: ${items[winnerIndex]}'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Fechar'),
                          ),
                        ],
                      );
                    },
                  );
                });
              },
              child: Center(
                child: SizedBox(
                  width: 500,
                  height: 500,
                  child: FortuneWheel(
                    selected: _selected.stream,
                    items: [
                      for (var item in items) FortuneItem(child: Text(item)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
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
      appBar: AppBar(title: Text(Config.viewList1)),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text(Config.appName),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ExamplePage()),
                );
              },
            ),
            ListTile(
              title: Text(Config.viewList1),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WinnersPage(winners: winners)),
                );
              },
            ),
            ListTile(
              title: Text(Config.viewList2),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutMePage()),
                );
              },
            ),
          ],
        ),
      ),
      body: winners.isEmpty
          ? Center(child: Text('Nenhum vencedor ainda!'))
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

class AboutMePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Config.viewList2)),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Leandro Cândido",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                "Eu criei esse aplicativo para uma atividade e como um projeto pessoal",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
