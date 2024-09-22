
import 'package:flutter/material.dart';
import '../model/item.dart';
import '../repository/itemDAO.dart';
import 'addItem.dart';
import 'deleteItem.dart';

// StatefulWidget ListaCompras
class ListaCompras extends StatefulWidget {
  @override
  State createState() => ListaComprasState();
}
// State de ListaCompras
class ListaComprasState extends State<ListaCompras> {
  ItemDatabase itemDatabase = ItemDatabase();
  List<Item>? itens;
  int count = 0; // número de registros na tabela
  int countUpdate = 0;

  void getData() {
    // abre ou cria o banco de dados
    var dbFuture = itemDatabase.initializeDb();
    // quando o resultado chega... (banco de dados aberto)
    dbFuture.then( (result) {
    // cria a lista com todos os dados (lista de mapas)
    var itensFuture = itemDatabase.getItens();
    // quando o resultado chega...
    itensFuture.then( (result) {
    // cria uma lista temporaria de objetos itens, chamada itensList (vazia):
    List<Item> itensList = [];
    // vê quantos registros retornaram, guarda em count:
    count = result.length;
        for (int i=0; i<count; i++) {
          itensList.add(Item.fromMap(result[i])); // result[i] é um Map
          debugPrint("\n\n\n " +itensList[i].item);
          debugPrint(itensList[i].marca);
          debugPrint(itensList[i].qtde);
        }
    // Chamando setState, e dentro dela, atualizando os atributos:
        setState(() {
          itens = itensList;
        });
    // mostra a quantidade, só pra conferência:
        debugPrint("Itens " + count.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    countUpdate = count -1;
    if (itens == null ) {
      itens = [];
      getData();
    }
  return
    Scaffold(
       appBar:
          AppBar(
              title: Text('Lista de Compras'),
              backgroundColor: Colors.blue,
          ),
    body: showItems(),
      floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return
                      AddItem();
                  },
                ),
              );
            },
            tooltip: "Add new Todo",
            child: new Icon(Icons.add),
          ),
    );
  }

  ListView showItems()
  {
    // Força atualização para contemplar as inclusões e exclusões dos itens
    if ( count != countUpdate) {
        getData();
        setState(() {
          countUpdate = count;
        });
    }
    return
      ListView.builder(
        itemCount: count, // total de elementos na lista
        itemBuilder: (BuildContext context, int position) {
        return
          ListTile(
            title: RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: "Item: "+this.itens![position].item+"\n", style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: "Marca: "+this.itens![position].marca!+"\n"),
                  TextSpan(text: "Qtde: "+this.itens![position].qtde),
                ],
                style: TextStyle(color: Colors.black),
              ),
            ),
            onTap: () {
              debugPrint("Tapped on " + this.itens![position].item);
              debugPrint("Item Id enviado " +this.itens![position].id.toString());
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return
                      DeleteItem(
                          this.itens![position].id,
                          this.itens![position].item,
                          this.itens![position].marca!,
                          this.itens![position].qtde
                      );
                  },
                ),
              );
            },
          );
      },
    );
  }
}

