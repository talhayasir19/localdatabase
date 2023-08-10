import 'dart:async';

import 'package:localdatabase/LaptopModel.dart';
import 'package:localdatabase/TableProperties.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDb {
  static LocalDb? _instance;
  static const int version = 1;
  static Database? _db;
  Future<Database> get db async {
    return _db ??= await _initialize();
  }

  static LocalDb createInstance() {
    return _instance ??= LocalDb();
  }

  Future<Database> _initialize() async {
    return await openDatabase(join(await getDatabasesPath(), "localdb.db"),
        onCreate: _create, version: version);
  }

  FutureOr<void> _create(Database db, int version) async {
    await db.execute(TableProperties.CREATETABLE);
  }

  Future<int> insertData(LaptopModel laptopModel) async {
    final database = await db;
    int id =
        await database.insert(TableProperties.TABLENAME, laptopModel.toMap());
    print(id.toString());
    return id;
  }

  Future<List<LaptopModel>> getData() async {
    final database = await db;
    final List<Map<String, dynamic>> maps =
        await database.query(TableProperties.TABLENAME);
    return List.generate(
        maps.length,
        (index) => LaptopModel(
              Id: maps[index][TableProperties.IdColumn],
              Model: maps[index][TableProperties.ModelColumn],
              Price: maps[index][TableProperties.PriceColumn],
            ));
  }

  void updateDate(LaptopModel laptopModel) async {
    final database = await db;

    int x = await database.update(
        TableProperties.TABLENAME, laptopModel.toMap(),
        where: TableProperties.ModelColumn.toString() + " = ?",
        whereArgs: [laptopModel.Model]);
    print(x);
  }
}
