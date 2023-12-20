import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../constacts/constacts.dart';

Future<Database> openSqfliteDataSource() async {
  Future<bool> salaryTableNotExsist(Database db) async {
    var tableInfo = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name='$salariesTableName';");

    return tableInfo.isEmpty;
  }

  Database db;
  final databasePath = await getDatabasesPath();
  final path = join(databasePath, "WD.db");
  db = await openDatabase(
    path,
    version: 2,
    onCreate: (db, version) async {
      await db.execute(
        '''
          CREATE TABLE $workDayTableName (
            ${WorkDayColumns.id.name} INTEGER PRIMARY KEY AUTOINCREMENT,
            ${WorkDayColumns.title.name} TEXT,
            ${WorkDayColumns.shortDescription.name} TEXT,
            ${WorkDayColumns.dateTime.name} TEXT,
            ${WorkDayColumns.inTime.name} TEXT,
            ${WorkDayColumns.outTime.name} TEXT,
            ${WorkDayColumns.workDay.name} INTEGER,
            ${WorkDayColumns.dayOff.name} INTEGER,
            ${WorkDayColumns.publicHoliday.name} INTEGER
          )
          ''',
      );
      await db.execute(
        '''
              CREATE TABLE $salariesTableName (
                ${SalariesColumns.id.name} INTEGER PRIMARY KEY AUTOINCREMENT,
                ${SalariesColumns.salary.name} INTEGER,
                ${SalariesColumns.dateTime.name} TEXT
              )
            ''',
      );
    },
    onUpgrade: (db, oldVersion, newVersion) async {
      if (await salaryTableNotExsist(db)) {
        await db.execute(
          '''
              CREATE TABLE $salariesTableName (
                ${SalariesColumns.id.name} INTEGER PRIMARY KEY AUTOINCREMENT,
                ${SalariesColumns.salary.name} INTEGER,
                ${SalariesColumns.dateTime.name} TEXT
              )
              ''',
        );
      }
    },
  );
  return db;
}
