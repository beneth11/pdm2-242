import 'package:avaliacao_09/models/isbn_model.dart';
import 'package:flutter/material.dart';

class CardLocationWidget extends StatelessWidget {
  const CardLocationWidget({super.key, this.book});
  final IsbnModel? book;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Título: ${book?.title ?? 'N/A'}"),
            Text("Autores: ${book?.authors?.join(', ') ?? 'N/A'}"),
            Text("Editora: ${book?.publisher ?? 'N/A'}"),
            Text("Ano: ${book?.year ?? 'N/A'}"),
            Text("Formato: ${book?.format ?? 'N/A'}"),
            Text("Páginas: ${book?.pageCount ?? 'N/A'}"),
            Text("Localização: ${book?.location ?? 'N/A'}"),
          ],
        ),
      ),
    );
  }
}
