import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../model/item.dart';

class ItemDatabase {

  ItemDatabase._internal();

  static final ItemDatabase _itemDatabase = ItemDatabase._internal();
  static Database? _db;

  factory ItemDatabase() {
    return _itemDatabase;
  }

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db!;
  }

  // Atributos: o nome da tabela e os nomes das colunas:
  String tblItens = "itens";
  String colId = "id";
  String colItem = "item";
  String colMarca = "marca";
  String colQtde = "qtde";

  Future<Database> initializeDb() async {

    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "itemDB.db";

    var dbItem = await openDatabase(path, version: 1, onCreate: _createDb);
    return dbItem;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $tblItens($colId INTEGER PRIMARY KEY, $colItem TEXT, " +
            "$colMarca TEXT, $colQtde TEXT)");
  }


  Future<Object> retrieveItem(int id) async {
    Database db = await this.db;
    var result = await db.rawQuery("SELECT * FROM $tblItens WHERE WHERE $colId = $id");
    return result;
  }

  Future<int> insertItem(Item item) async {
    Database db = await this.db;
    var result = await db.insert(tblItens, item.toMap());
    return result;
  }

// Recuperar todos os registros.
// Retorna uma Lista de Maps com os registros.
  Future<List> getItens() async {
    Database db = await this.db;
    var result = await db.rawQuery("SELECT * FROM $tblItens ORDER BY $colItem ASC");
    return result;
  }

// Recuperar o número de registros da tabela.
// Retorna um int.
  Future<int> getCount() async {
    Database db = await this.db;
// Usa o método Sqflite.firstIntValue,
// que retorna apenas o 1o valor inteiro da resposta.
// No caso desta query, só vai ter um valor mesmo (count).
    var result = Sqflite.firstIntValue(
        await db.rawQuery("select count (*) from $tblItens")
    );
    return result!;
  }
// Método para atualizar registro.
// Passa um objeto Item.
  Future<int> updateItem(Item item) async {
    var db = await this.db;
    var result = await db.update(tblItens,
        item.toMap(),
        where: "$colId = ?",
        whereArgs: [item.id]);
    return result;
  }
// Método para apagar registro.
// Passa o id do registro a apagar.
  Future<int> deleteItem(int id) async {
    int result;
    var db = await this.db;
    result = await db.rawDelete('DELETE FROM $tblItens WHERE $colId = $id');
    return result;
  }
}