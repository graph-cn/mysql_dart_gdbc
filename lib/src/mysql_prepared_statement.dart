// Copyright (c) 2025- All mysql_dart_gdbc authors. All rights reserved.
//
// This source code is licensed under Apache 2.0 License.

part of '../mysql_dart_gdbc.dart';

class MySqlPreparedStatement extends PreparedStatement {
  final mc.PreparedStmt? pstmt;
  final MySqlConnectionProxy conn;

  MySqlPreparedStatement(this.pstmt, this.conn);

  @override
  Future<bool> execute({Map<String, dynamic>? params, String? gql}) async {
    return false;
  }

  @override
  Future<ResultSet> executeQuery(
      {Map<String, dynamic>? params, String? gql}) async {
    var rs = await pstmt?.execute(params?.values.toList() ?? []);
    if (rs == null) return MySqlResultSet();
    return conn.handler.handle(rs);
  }

  @override
  Future<int> executeUpdate({Map<String, dynamic>? params, String? gql}) {
    // TODO: implement executeUpdate
    throw UnimplementedError();
  }
}
