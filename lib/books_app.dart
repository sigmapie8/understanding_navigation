import 'package:flutter/material.dart';
import 'package:understanding_navigation/book_route_information_parser.dart';
import 'package:understanding_navigation/router_delegate.dart';

class BooksApp extends StatefulWidget {
  const BooksApp({Key? key}) : super(key: key);

  @override
  _BooksAppState createState() => _BooksAppState();
}

class _BooksAppState extends State<BooksApp> {
  BookRouteInformationParser _bookRouteInformationParser =
      BookRouteInformationParser();
  BookRouterDelegate _bookRouterDelegate = BookRouterDelegate();

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        title: 'Books App',
        routeInformationParser: _bookRouteInformationParser,
        routerDelegate: _bookRouterDelegate);
  }
}
