// Copyright (c) 2025- All mysql_dart_gdbc authors. All rights reserved.
//
// This source code is licensed under Apache 2.0 License.

part of '../mysql_dart_gdbc.dart';

class MySqlResultSet extends ResultSet {
  @override
  late List<ValueMetaData> metas = [];

  @override
  late List<List<dynamic>> rows = [];
}
