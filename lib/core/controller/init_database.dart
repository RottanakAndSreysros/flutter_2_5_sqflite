import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_2_5_sqflite/core/model/text_note_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class InitDatabase {
  final table = "dating_note";

  Future<Database> initDatabase() async {
    Directory derectory = await getApplicationDocumentsDirectory();
    String path = "${derectory.path}/database.db";
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (db, version) async {
        await _oncreateTable(db.batch());
      },
      onUpgrade: (db, oldVersion, newVersion) {},
    );
  }

  Future<void> _oncreateTable(Batch batch) async {
    batch.execute(
      "CREATE TABLE $table (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,title TEXT,description TEXT,date_time TEXT);",
    );
    await batch.commit();
  }
}


