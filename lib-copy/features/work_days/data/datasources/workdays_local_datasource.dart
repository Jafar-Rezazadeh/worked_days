import 'package:sqflite/sqflite.dart';

import '../../../../core/constacts/constacts.dart';
import '../../../../core/shared_functions/local_data_source.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/workday_model.dart';

abstract class WorkDaysLocalDataSource {
  Future<List<WorkDayModel>> getWorkDays();
  Future<int> insertWorkDay(WorkDayModel workDayModel);
  Future<int> deleteWorkDay(int id);
}

class WorkDaysLocalDataSourceImpl implements WorkDaysLocalDataSource {
  @override
  Future<List<WorkDayModel>> getWorkDays() async {
    final Database database = await openLocalDataSource();
    try {
      final List<Map<String, dynamic>> rawData = await database.query(workDayTableName);

      final listOfWorkDayModel = List.generate(
        rawData.length,
        (i) => WorkDayModel.fromMap(rawData[i]),
      );

      listOfWorkDayModel.sort((a, b) => a.date.compareTo(b.date));

      // await Future.delayed(const Duration(seconds: 2));

      return listOfWorkDayModel;
    } catch (e) {
      throw LocalDataSourceException();
    }
  }

  @override
  Future<int> insertWorkDay(WorkDayModel workDayModel) async {
    final Database database = await openLocalDataSource();
    try {
      final int id = await database.insert(workDayTableName, workDayModel.toMap());
      return id;
    } catch (e) {
      throw LocalDataSourceException();
    }
  }

  @override
  Future<int> deleteWorkDay(int id) async {
    final Database database = await openLocalDataSource();
    try {
      final int count = await database.delete(
        workDayTableName,
        where: '${WorkDayColumns.id.name} = ?',
        whereArgs: [id],
      );
      return count;
    } catch (e) {
      throw LocalDataSourceException();
    }
  }
}
