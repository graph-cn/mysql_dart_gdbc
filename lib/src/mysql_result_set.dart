part of '../mysql_dart_gdbc.dart';

class MySqlResultSet extends ResultSet {
  @override
  late List<ValueMetaData> metas = [];

  @override
  late List<List<dynamic>> rows = [];
}
