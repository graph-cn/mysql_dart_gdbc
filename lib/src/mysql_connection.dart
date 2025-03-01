part of '../mysql_dart_gdbc.dart';

class MySqlConnectionProxy implements Connection {
  @override
  String? databaseName;
  @override
  String? version;
  mc.MySQLConnection? client;
  late Map<String, dynamic> properties;
  MysqlResultHandler handler = MysqlResultHandler();

  MySqlConnectionProxy._create(
    Uri address, {
    Map<String, dynamic>? properties,
    required Completer waiter,
  }) {
    this.properties = properties ?? <String, dynamic>{};
    databaseName = this.properties['db'];
    mc.MySQLConnection.createConnection(
      host: address.host,
      port: address.port,
      userName: this.properties[DriverManager.usrKey],
      password: this.properties[DriverManager.usrKey],
      databaseName: this.properties['db'],
    ).then((conn) {
      client = conn;
      client!.connect().then((v) {
        waiter.complete();
      });
    });
  }

  @override
  Future<void> close() {
    return client!.close();
  }

  @override
  Future<void> commit() async {}

  @override
  Future<Statement> createStatement() async {
    // TODO: implement createStatement
    throw UnimplementedError();
  }

  @override
  Future<ResultSet> executeQuery(String gql,
      {Map<String, dynamic>? params}) async {
    var rs = await client!.execute(gql, params);
    return await handler.handle(rs);
  }

  @override
  Future<int> executeUpdate(String gql) {
    // TODO: implement executeUpdate
    throw UnimplementedError();
  }

  @override
  Future<bool> getAutoCommit() {
    // TODO: implement getAutoCommit
    throw UnimplementedError();
  }

  @override
  Future<ResultSetMetaData> getMetaData() {
    // TODO: implement getMetaData
    throw UnimplementedError();
  }

  @override
  Future<bool> isClosed() {
    // TODO: implement isClosed
    throw UnimplementedError();
  }

  @override
  Future<PreparedStatement> prepareStatement(String gql,
      {String Function(String p1, Map<String, dynamic>? p2)? render}) async {
    var pstmt = await client?.prepare(gql);
    return MySqlPreparedStatement(pstmt, this);
  }

  @override
  Future<PreparedStatement> prepareStatementWithParameters(
      String gql, List<ParameterMetaData> parameters) {
    // TODO: implement prepareStatementWithParameters
    throw UnimplementedError();
  }

  @override
  Future<void> rollback() {
    // TODO: implement rollback
    throw UnimplementedError();
  }

  @override
  Future<void> setAutoCommit(bool autoCommit) {
    // TODO: implement setAutoCommit
    throw UnimplementedError();
  }
}
