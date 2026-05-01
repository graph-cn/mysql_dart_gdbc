// Copyright (c) 2025- All mysql_dart_gdbc authors. All rights reserved.
//
// This source code is licensed under Apache 2.0 License.

part of '../mysql_dart_gdbc.dart';

class MySqlConnectionProxy extends Connection {
  @override
  String? databaseName;

  @override
  Function()? onClose;

  @override
  String? version;
  mc.MySQLConnection? client;
  late Map<String, dynamic> properties;
  MysqlResultHandler handler = MysqlResultHandler();

  MySqlConnectionProxy._create(
    Uri address, {
    Map<String, dynamic>? properties,
    required Completer waiter,
    this.onClose,
  }) {
    this.properties = properties ?? <String, dynamic>{};
    databaseName = this.properties['db'];
    mc.MySQLConnection.createConnection(
      host: address.host,
      port: address.port,
      userName: this.properties[DriverManager.usrKey],
      password: this.properties[DriverManager.pwdKey],
      databaseName: this.properties['db'],
      secure: bool.parse(this.properties['secure'] ?? 'true'),
      collation: this.properties['collation'] ?? 'utf8mb4_general_ci',
    ).then((conn) {
      client = conn;
      client!.connect().then((v) {
        waiter.complete();
      });
    });
  }

  @override
  Future<void> close() async {
    await client!.close();
    onClose?.call();
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
