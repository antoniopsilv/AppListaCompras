import 'dart:ffi';

import 'package:flutter/material.dart';
import '../components/cellDelete.dart';
import '../components/padding.dart';
import '../components/cell.dart';
import '../model/item.dart';
import '../repository/itemDAO.dart';

class DeleteItem extends StatelessWidget {

  ItemDatabase itemDatabase = ItemDatabase();

  final int? itemId;
  final String item;
  final String marca;
  final String qtde;

  DeleteItem(this.itemId,this.item,this.marca,this.qtde);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Remover item na lista"),
          backgroundColor: Colors.blue,
        ),
        body:
          SingleChildScrollView(
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                padding(10.0, 10.0),
                cellDelete("Item",item),
                padding(10.0, 10.0),
                cellDelete("Marca",marca),
                padding(10.0, 10.0),
                cellDelete("Qtde",qtde),
                padding(10.0, 10.0),
                SizedBox(
                  height: 50.0,
                  width: 380.0,
                  child: ElevatedButton(
                    child: Text(
                      'Remover',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                      ),
                    ),
                    onPressed: () {
                      debugPrint("\n\n\n  Id do Item a ser removido" +itemId.toString());
                      Future id = itemDatabase.deleteItem(itemId!);

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          item + " removido!",
                          style: TextStyle(fontSize: 18),
                        ),
                        duration: Duration(milliseconds: 900),
                        width: 180.0, // Width of the SnackBar.
                        padding: EdgeInsets.all(16.0),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ));
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue),
                    ),

                  ),
                ),
              ],
            ),
          ),
    );
  }
}
