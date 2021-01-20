
import 'package:polimi/models/cartItem.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();


  static Database _database;

  Future<Database> get database async {
    if (_database != null)
      return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }


  initDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "ShoppingDB.db");
    return await openDatabase(path, version: 3, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
      _onCreate(db,version);
    }, onUpgrade: (Database db, int oldVersion, int newVersion) async{
      _onUpgrade(db, oldVersion, newVersion);
    } );
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async{
    await db.execute("DROP TABLE IF EXISTS CART_ITEMS");
    _onCreate(db, newVersion);
  }

  _onCreate (Database db, int version) async {

      await db.execute("CREATE TABLE CART_ITEMS ("
          "id TEXT PRIMARY KEY,"
          "userId TEXT,"
          "name TEXT,"
          "price REAL,"
          "color TEXT,"
          "size TEXT,"
          "qty INTEGER,"
          "brand TEXT,"
          "category TEXT,"
          "picture TEXT"
          ")");


  }

  newCartItem(CartItem item) async {
    final db = await database;
    var res = await db.insert("CART_ITEMS", item.toMap());
    return res;
  }

  getCartItem(int id) async {
    final db = await database;
    var res =await  db.query("CART_ITEMS", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? CartItem.fromMap(res.first) : Null ;
  }

  getAllCartItems(String userId) async {
    final db = await database;
    var res = await db.query("CART_ITEMS", where: "userId=?", whereArgs: [userId]);
    List<CartItem> list =
    res.isNotEmpty ? res.map((c) => CartItem.fromMap(c)).toList() : [];
    return list;
  }

  deleteCartItems(String usrId) async {
    final db = await database;
    db.rawDelete("Delete * from CART_ITEMS where userId = ?",[usrId]);
  }


  insertCartItems(List<CartItem> items, String userId) async {
    final db = await database;
    var buffer = new StringBuffer();
    items.forEach((c) {
      if (buffer.isNotEmpty) {
        buffer.write(",\n");
      }
      buffer.write("('");
      buffer.write(c.id);
      buffer.write("', '");
      buffer.write(userId);
      buffer.write("', '");
      buffer.write(c.name);
      buffer.write("', '");
      buffer.write(c.price);

      buffer.write("', '");
      buffer.write(c.qty);

      buffer.write("', '");
      buffer.write(c.color);

      buffer.write("', '");
      buffer.write(c.size);

      buffer.write("', '");
      buffer.write(c.brand);

      buffer.write("', '");
      buffer.write(c.category);

      buffer.write("', '");
      buffer.write(c.picture);

      buffer.write("')");
    });
    var raw =
    await db.rawInsert("INSERT Into CART_ITEMS (id , userId,name,price,qty,color,size,brand,category,picture)"
        " VALUES ${buffer.toString()}");
    return raw;
  }

}