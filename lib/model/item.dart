class Item {
// Atributos:
  int? _id;
  String _item;
  String? _marca; // este atributo é opcional
  String _qtde;

  Item( this._item, this._qtde,[this._marca] );
  // Constructor com Id
  Item.withId( this._id, this._item, this._qtde,[this._marca]  );

  // Getters...
  String  get item  => _item;
  String? get marca => _marca;
  String  get qtde  => _qtde;
  int?    get id    => _id;

// Setters...
  set item (String newItem) {
    if (newItem.length <= 255) {
      _item = newItem;
    }
  }
  set marca (String? newMarca) {
    if (newMarca != null && newMarca.length <=255 ) {
      _marca = newMarca;
    }
  }
  set qtde (String newQtde) {
    //if (newQtde >"0" ) {
    if (newQtde.length <= 255) {
      _qtde = newQtde;
    }
  }

  Map <String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    map["item"] = _item;
    map["marca"] = _marca;
    map["qtde"] = _qtde;
    if (_id != null) {
      map["id"] = _id;
    }
    return map;
  }

  Item.fromMap(dynamic o)
      : _id = o["id"],
        _item = o["item"],
        _marca = o["marca"],
        _qtde = o["qtde"];
}