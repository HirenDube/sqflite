import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/foundation.dart';

class SQLHelper {
  static bool created = false;
  static List<Map> dbase = <Map>[];

  static getDataBase() async {
    Database database = await openDatabase(
        "${getApplicationDocumentsDirectory()}/zDevDb.db",
        version: 1, onCreate: (db, version) {
      db.execute("""create table Students 
                 (RollNo INTEGER PRIMARY KEY,
                  FName TEXT NOT NULL, LName TEXT NOT NULL, College TEXT NOT NULL, ImageBytes BLOB );""");
      created = true;
    });

    return database;
  }

  static insertInto(
      {required int rollNo,
      required String fname,
      required String lname,
      required String college,
      required Uint8List imgBytes}) async {
    Database database = await getDataBase();

    // database.transaction((txn) async {
    //   txn.rawInsert(
    //       "INSERT INTO Students (RollNo,FName,LName,College,ImageBytes) VALUES ($rollNo,'$fname','$lname','$college','$imgBytes');");
    // });
    database.insert("Students", {
      "RollNo": rollNo,
      "FName": "$fname",
      "LName": "$lname",
      "College": "$college",
      "ImageBytes": "$imgBytes"
    });
  }

  static getData() async {
    Database database = await getDataBase();
    dbase = await database.rawQuery("SELECT * FROM Students;");
    return dbase;
  }

  static removeFrom(rollNo) async {
    Database database = await getDataBase();
    Batch batch = database.batch();
    batch.delete("Students", where: "RollNo = $rollNo");
    batch.commit();
  }

  static update(
      {required int rollNo,
      required int oldroll,
      required String fname,
      required String lname,
      required String college,
      required Uint8List imgBytes}) async {
    var database = await getDataBase();
    Batch btc = database.batch();
    btc.update(
        "Students",
        {
          "RollNo": rollNo,
          "FName": "$fname",
          "LName": "$lname",
          "College": "$college",
          "ImageBytes": "$imgBytes"
        },
        where: "RollNo = $oldroll");
    btc.commit();
  }
}
