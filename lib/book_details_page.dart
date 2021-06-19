import 'package:flutter/material.dart';
import 'package:understanding_navigation/book.dart';
import 'package:understanding_navigation/book_detail_screen.dart';

class BookDetailsPage extends Page {
  final Book book;

  BookDetailsPage({
    required this.book,
  }) : super(key: ValueKey(book));

  @override
  Route createRoute(BuildContext context) {
    print('BookDetailsPage is called');
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (context, animation, animation2) {
        final tween = Tween(begin: Offset(0.0, 1.0), end: Offset.zero);
        final curveTween = CurveTween(curve: Curves.easeInOut);
        return SlideTransition(
          position: animation.drive(curveTween).drive(tween),
          child: BookDetailScreen(
            key: ValueKey(book),
            book: book,
          ),
        );
      },
    );
  }
}
