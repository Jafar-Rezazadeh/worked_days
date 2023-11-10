import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:worked_days/bloc/entities/salary_model.dart';
import 'package:worked_days/bloc/entities/worked_day_model.dart';
import 'package:path/path.dart' show join;
import 'package:worked_days/bloc/entities/tables_column_names.dart';

class DbProvider {
  final workedDayTable = "WorkedDays";
  final salariesTable = "Salaries";

  _openDb() async {
    if (Platform.isAndroid) {
      Database db;
      final databasePath = await getDatabasesPath();
      final path = join(databasePath, "WD.db");
      db = await openDatabase(
        path,
        version: 2,
        onCreate: (db, version) async {
          await db.execute(
            '''
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
          ''',
          );
          await db.execute(
            '''
              CREATE TABLE $salariesTable (
                ${SalariesColumnNames.id.name} INTEGER PRIMARY KEY AUTOINCREMENT,
                ${SalariesColumnNames.salary.name} INTEGER,
                ${WorkedDaysColumnNames.dateTime.name} TEXT
              )
            ''',
          );
        },
        onUpgrade: (db, oldVersion, newVersion) async {
          if (await _salaryTableNotExsist(db)) {
            await db.execute(
              '''
              CREATE TABLE $salariesTable (
                ${SalariesColumnNames.id.name} INTEGER PRIMARY KEY AUTOINCREMENT,
                ${SalariesColumnNames.salary.name} INTEGER,
                ${WorkedDaysColumnNames.dateTime.name} TEXT
              )
              ''',
            );
          }
        },
      );
      return db;
    }
  }

  Future<bool> _salaryTableNotExsist(Database db) async {
    var tableInfo = await db
        .rawQuery("SELECT name FROM sqlite_master WHERE type='table' AND name='$salariesTable';");

    return tableInfo.isEmpty;
  }

  //?=================================== worked days Table===================================
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

  //?=================================== salaries Table ===================================

  // deleteAllDataInSalariesTable() async {
  //   final Database db = await _openDb();

  //   await db.rawDelete("DELETE FROM $salariesTable");
  // }

  Future<int> insertSalary(SalaryModel salaryModel) async {
    final Database db = await _openDb();

    int id = await db.insert(salariesTable, salaryModel.tomap_());
    return id;
  }

  deleteSalary(int id) async {
    final Database db = await _openDb();
    await db.delete(salariesTable, where: "id = ?", whereArgs: [id]);
  }

  Future<List<SalaryModel>> getSalaries() async {
    final Database db = await _openDb();

    List<Map<String, dynamic>> dataAsMap = await db.query(salariesTable);

    return List.generate(
      dataAsMap.length,
      (i) => SalaryModel(
        id: dataAsMap[i][SalariesColumnNames.id.name],
        salaryAmount: dataAsMap[i][SalariesColumnNames.salary.name],
        dateTime: DateTime.parse(dataAsMap[i][SalariesColumnNames.dateTime.name]),
      ),
    );
  }
}
