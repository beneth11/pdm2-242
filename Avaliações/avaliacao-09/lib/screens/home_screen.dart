import 'package:avaliacao_09/screens/widgets/card_location.dart';
import 'package:flutter/material.dart';

import '../constants/path_assets.dart';
import '../controllers/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final TextEditingController _isbnController = TextEditingController();
final HomeController homeController = HomeController();

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    homeController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Localizador de Livros"),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
              reverse: true,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      PathAssets.locationIcon,
                      height: 64,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _isbnController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: const Text('Informe o ISBN'),
                        suffixIcon: IconButton(
                          onPressed: () {
                            homeController.clear();
                            _isbnController.text = "";
                          },
                          icon: const Icon(Icons.close_outlined),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_isbnController.text.length == 10 || _isbnController.text.length == 13) {
                            homeController.searchAddress(
                                isbn: _isbnController.text);
                          } else {
                            const snackBar = SnackBar(
                              content: Text('O ISBN deve ter 10 ou 13 números'),
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        child: const Text("Consultar")),
                    const SizedBox(
                      height: 30,
                    ),
                    Visibility(
                        visible: homeController.isLoading.value,
                        child: const CircularProgressIndicator()),
                    Visibility(
                        visible: !homeController.isLoading.value &&
                            homeController.address.value != null,
                        child: CardLocationWidget(
                            book: homeController.address.value)),
                  ]))),
    );
  }
}