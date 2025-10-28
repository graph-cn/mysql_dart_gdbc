// Copyright (c) 2025- All mysql_dart_gdbc authors. All rights reserved.
//
// This source code is licensed under Apache 2.0 License.

import 'package:mysql_dart_gdbc/mysql_dart_gdbc.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    setUp(() {
      DriverManager.registerDriver(MySqlDriver());
    });

    test('test mysql driver', () async {
      var conn = await DriverManager.getConnection(
          'gdbc.mysql://localhost:3306?username=root&password=root&db=tmalldemodb');
      var rs =
          await conn.executeQuery('SELECT * FROM mysql.db LIMIT 1 OFFSET 0');
      print(rs);
    });
  });
}
