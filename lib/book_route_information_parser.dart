import 'package:flutter/material.dart';
import 'package:understanding_navigation/book_route_path.dart';

class BookRouteInformationParser extends RouteInformationParser<BookRoutePath> {
  @override
  Future<BookRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    print(
        'BookRouteInformationParser: parseRoutInformation is called with location: ${routeInformation.location!}');
    final uri = Uri.parse(routeInformation.location!);

    // path '/'
    if (uri.pathSegments.length == 0) {
      return BookRoutePath.home();
    }

    // path '/book/:id'
    if (uri.pathSegments.length == 2) {
      if (uri.pathSegments[0] != 'book') return BookRoutePath.unknown();
      int? id = int.tryParse(uri.pathSegments[1]);
      if (id == null) return BookRoutePath.unknown();
      return BookRoutePath.details(id: id);
    }

    // path unknown
    return BookRoutePath.unknown();
  }

  @override
  RouteInformation? restoreRouteInformation(BookRoutePath path) {
    print(
        'BookRouteInformationParser: restorRoutInformation is called with path: ${path.id}');

    if (path.isUnknown) return RouteInformation(location: '/404');
    if (path.isHomePage) return RouteInformation(location: '/');
    if (path.isDetailsPage)
      return RouteInformation(location: '/book/${path.id}');

    return RouteInformation(location: '/404');
  }
}
