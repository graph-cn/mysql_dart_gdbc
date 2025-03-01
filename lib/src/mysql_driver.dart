part of '../mysql_dart_gdbc.dart';

class MySqlDriver extends Driver {
  @override
  bool acceptsURL(String url) {
    return url.startsWith('gdbc.mysql:');
  }

  @override
  Future<Connection> connect(
    String url, {
    Map<String, dynamic>? properties,
  }) async {
    var address = _parseURL(url);
    address.queryParameters.forEach((key, value) {
      properties![key] = value;
    });
    Completer waiter = Completer();
    var conn = MySqlConnectionProxy._create(address,
        properties: properties, waiter: waiter);
    await waiter.future;
    return conn;
  }

  Uri _parseURL(String url) {
    var uri = Uri.parse(url);
    if (uri.scheme != 'gdbc.mysql' || uri.host.isEmpty || uri.port <= 0) {
      throw ArgumentError('Invalid URL: $url');
    }
    return uri;
  }
}
