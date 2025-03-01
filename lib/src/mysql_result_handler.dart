part of '../mysql_dart_gdbc.dart';

class MysqlResultHandler {
  Map<MySQLColumnType, GdbTypes> typeMapping = {
    MySQLColumnType.decimalType: GdbTypes.double,
    MySQLColumnType.tinyType: GdbTypes.byte,
    MySQLColumnType.shortType: GdbTypes.short,
    MySQLColumnType.longType: GdbTypes.long,
    MySQLColumnType.floatType: GdbTypes.float,
    MySQLColumnType.doubleType: GdbTypes.double,
    MySQLColumnType.nullType: GdbTypes.none,
    MySQLColumnType.timestampType: GdbTypes.timestamp,
    MySQLColumnType.longLongType: GdbTypes.long,
    MySQLColumnType.int24Type: GdbTypes.int,
    MySQLColumnType.dateType: GdbTypes.date,
    MySQLColumnType.timeType: GdbTypes.time,
    MySQLColumnType.dateTimeType: GdbTypes.dateTime,
    MySQLColumnType.yearType: GdbTypes.int,
    MySQLColumnType.newDateType: GdbTypes.date,
    MySQLColumnType.vatChartType: GdbTypes.unknown,
    MySQLColumnType.bitType: GdbTypes.unknown,
    MySQLColumnType.timestamp2Type: GdbTypes.timestamp,
    MySQLColumnType.dateTime2Type: GdbTypes.dateTime,
    MySQLColumnType.time2Type: GdbTypes.time,
    MySQLColumnType.newDecimalType: GdbTypes.double,
    MySQLColumnType.enumType: GdbTypes.short,
    MySQLColumnType.setType: GdbTypes.set,
    MySQLColumnType.tinyBlobType: GdbTypes.bytes,
    MySQLColumnType.mediumBlobType: GdbTypes.bytes,
    MySQLColumnType.longBlobType: GdbTypes.bytes,
    MySQLColumnType.blocType: GdbTypes.bytes,
    MySQLColumnType.varStringType: GdbTypes.string,
    MySQLColumnType.stringType: GdbTypes.string,
    MySQLColumnType.geometryType: GdbTypes.geo,
  };

  Future<ResultSet> handle(mc.IResultSet rs) async {
    var metas = rs.cols.map((e) {
      return ValueMetaData()
        ..name = e.name
        ..type = typeMapping[e.type];
    }).toList();
    MySqlResultSet result = MySqlResultSet()..metas = metas;
    Completer waiter = Completer();
    var colIdx = rs.numOfColumns;
    rs.rowsStream.listen((event) {
      List<dynamic> row = List.filled(colIdx, null);
      Map<String, dynamic> rowRs = event.typedAssoc();
      rowRs.forEach((key, value) {
        var idx = metas.indexWhere((element) => element.name == key);
        row[idx] = value;
      });
      result.rows.add(row);
    }, onDone: () {
      waiter.complete();
    });
    await waiter.future;

    return result;
  }
}
