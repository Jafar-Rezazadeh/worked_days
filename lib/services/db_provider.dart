import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:worked_days/model/worked_day_model.dart';
import 'package:path/path.dart' show join;
import 'package:worked_days/services/tables_column_names.dart';

class DataBaseHandler {
  final workedDayTable = "WorkedDays";

  _openDb() async {
    if (Platform.isAndroid) {
      Database db;
      final databasePath = await getDatabasesPath();
      final path = join(databasePath, "WD.db");
      db = await openDatabase(
        path,
        version: 3,
        onCreate: (db, version) async {
          await db.execute('''
          CREATE TABLE $workedDayTable (
            ${WorkedDaysColumnNames.id.name} INTEGER PRIMARY KEY AUTOINCREMENT,
            ${WorkedDaysColumnNames.title.name} TEXT,
            ${WorkedDaysColumnNames.shortDescription.name} TEXT,
            ${WorkedDaysColumnNames.dateTime.name} TEXT,
            ${WorkedDaysColumnNames.inTime.name} TEXT,
            ${WorkedDaysColumnNames.outTime.name} TEXT,
            ${WorkedDaysColumnNames.workDay.name} INTEGER,
            ${WorkedDaysColumnNames.dayOff.name} INTEGER,
            ${WorkedDaysColumnNames.publicHoliday.name} INTEGER
          )
          ''');
        },
        onUpgrade: (db, oldVersion, newVersion) async {},
      );
      return db;
    }
  }

  Future<List<WorkDayModel>> getWorkDays() async {
    final Database db = await _openDb();
    List<Map<String, dynamic>> dataAsMap = await db.query(workedDayTable);

    return List.generate(
      dataAsMap.length,
      (i) => WorkDayModel(
        id: dataAsMap[i][WorkedDaysColumnNames.id.name],
        title: dataAsMap[i][WorkedDaysColumnNames.title.name],
        shortDescription: dataAsMap[i][WorkedDaysColumnNames.shortDescription.name],
        dateTime: DateTime.parse(dataAsMap[i][WorkedDaysColumnNames.dateTime.name]),
        inTime: dataAsMap[i][WorkedDaysColumnNames.inTime.name],
        outTime: dataAsMap[i][WorkedDaysColumnNames.outTime.name],
        workDay: dataAsMap[i][WorkedDaysColumnNames.workDay.name] == 1 ? true : false,
        dayOff: dataAsMap[i][WorkedDaysColumnNames.dayOff.name] == 1 ? true : false,
        publicHoliday: dataAsMap[i][WorkedDaysColumnNames.publicHoliday.name] == 1 ? true : false,
      ),
    );
  }

  Future<int> insertWorkDay(WorkDayModel workDayModel) async {
    final Database db = await _openDb();
    int id = await db.insert(workedDayTable, workDayModel.toMap_());
    return id;
  }

  deleteWorkDay(int id) async {
    final Database db = await _openDb();
    await db.delete(workedDayTable, where: "${WorkedDaysColumnNames.id.name} = ?", whereArgs: [id]);
  }
}
