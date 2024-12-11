import 'dart:math';

import 'package:flutter_2_5_sqflite/core/controller/init_database.dart';
import 'package:flutter_2_5_sqflite/core/model/text_note_model.dart';

class DatabashController {
  final _init = InitDatabase();

  Future<void> insertData({required TextNoteModel model}) async {
    final db = await _init.initDatabase();
    await db.insert(_init.table, model.toJson());
  }

  Future<List<TextNoteModel>> getData() async {
    final db = await _init.initDatabase();
    List<Map<String, dynamic>> list = await db.query(_init.table);
    return list.map((e) => TextNoteModel.fromJson(e)).toList();
  }

  Future<void> editData({required TextNoteModel model}) async {
    final db = await _init.initDatabase();
    await db.update(
      _init.table,
      model.toJson(),
      where: 'id=?',
      whereArgs: [model.id],
    );
  }

  Future<void> deleteData({required int id}) async{
    final db = await _init.initDatabase();
    await db.delete(_init.table,where: 'id=?',whereArgs: [id]);
  }
}
