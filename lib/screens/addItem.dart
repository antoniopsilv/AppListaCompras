
import '../components/padding.dart';
import 'package:flutter/material.dart';
import '../components/cell.dart';
import '../model/item.dart';
import '../repository/itemDAO.dart';

// Controladores das caixas de texto:
TextEditingController tcItem = TextEditingController();
TextEditingController tcMarca = TextEditingController();
TextEditingController tcQtde = TextEditingController();

ItemDatabase itemDatabase = ItemDatabase();

class AddItem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddItemState();
}

class AddItemState extends State<AddItem> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Incluir item na lista"),
        backgroundColor: Colors.blue,
      ),
      body:
      SingleChildScrollView(
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            padding(10.0, 10.0),
            cell("Item","Item a ser comprado",tcItem ),
            padding(10.0, 10.0),
            cell("Marca","Marca do item",tcMarca ),
            padding(10.0, 10.0),
            cell("Qtde","Qtde do item",tcQtde ),
            padding(10.0, 10.0),
            SizedBox(
              height: 50.0,
              width: 380.0,
              child: ElevatedButton(
                child: Text(
                  'Incluir',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    debugPrint("Item"+tcItem.text);
                    debugPrint("Marca"+tcMarca.text);
                    debugPrint("Qtde"+tcQtde.text);

                    Item item = Item( tcItem.text, tcQtde.text , tcMarca.text);
                    Future id = itemDatabase.insertItem(item);

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          tcItem.text + " salvo!",
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

                    tcItem.text = '';
                    tcMarca.text = '';
                    tcQtde.text = '';
                    Navigator.pop(context);
                  });
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





