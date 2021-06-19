import 'package:flutter/material.dart';
import 'package:understanding_navigation/book.dart';

class BookListScreen extends StatelessWidget {
  const BookListScreen({Key? key, required this.books, required this.onTapped})
      : super(key: key);

  final List<Book> books;
  final ValueChanged<Book> onTapped;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          for (Book book in books)
            ListTile(
              title: Text(book.title),
              subtitle: Text(book.author),
              onTap: () => onTapped(book),
            )
        ],
      ),
    );
  }
}
