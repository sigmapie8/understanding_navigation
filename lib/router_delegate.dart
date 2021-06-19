import 'package:flutter/material.dart';
import 'package:understanding_navigation/book_route_path.dart';
import 'package:understanding_navigation/book.dart';
import 'package:understanding_navigation/book_list_screen.dart';
import 'package:understanding_navigation/book_detail_screen.dart';
import 'package:understanding_navigation/unknown_screen.dart';

class BookRouterDelegate extends RouterDelegate<BookRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BookRoutePath> {
  final GlobalKey<NavigatorState> _navigatorKey;

  Book? _selectedBook;
  bool show404 = false;
  List<Book> books = [
    Book(title: 'Left Hand of Darkness', author: 'Ursula K. Le Guin'),
    Book(title: 'Too Like the Lightning', author: 'Ada Palmer'),
    Book(title: 'Kindred', author: 'Octavia E. Butler'),
  ];

  BookRouterDelegate() : _navigatorKey = GlobalKey<NavigatorState>();

  @override
  BookRoutePath get currentConfiguration {
    print('currentConfiguration is called, $show404, $_selectedBook');
    if (show404) {
      return BookRoutePath.unknown();
    }
    return _selectedBook == null
        ? BookRoutePath.home()
        : BookRoutePath.details(id: books.indexOf(_selectedBook!));
  }

  void _handleBookTapped(Book book) {
    _selectedBook = book;
    notifyListeners();
    print('RouterDelegate: _handleBookTapped is called');
  }

  @override
  Widget build(BuildContext context) {
    print('RouterDelegate: build is called book id ${_selectedBook?.title}');
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          key: ValueKey('BooksListPage'),
          child: BookListScreen(
            books: books,
            onTapped: _handleBookTapped,
          ),
        ),
        if (show404)
          MaterialPage(key: ValueKey('UnknownPage'), child: UnknownScreen())
        else if (_selectedBook != null)
          MaterialPage(
              child: BookDetailScreen(
            key: ValueKey(_selectedBook!),
            book: _selectedBook!,
          )),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        // Update the list of pages by setting _selectedBook to null
        _selectedBook = null;
        show404 = false;
        notifyListeners();

        print('Route $route was popped');
        return true;
      },
    );
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  @override
  Future<void> setNewRoutePath(BookRoutePath path) async {
    print('RouterDelegate: setNewRoutePath is called with path: ${path.id}');
    if (path.isUnknown) {
      _selectedBook = null;
      show404 = true;
      return;
    }

    if (path.isDetailsPage) {
      if (path.id! < 0 || path.id! > books.length - 1) {
        show404 = true;
        return;
      }
      _selectedBook = books[path.id!];
    } else {
      _selectedBook = null;
    }

    show404 = false;
  }
}
