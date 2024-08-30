import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseConnection {
  static DataBaseConnection instance = DataBaseConnection._internal();

  DataBaseConnection._internal();

  factory DataBaseConnection() {
    return instance;
  }

  Database? database;

  String salesTable = "salesdetails";
  String stockTable = "stockdetails";
  // String stockHistoryTable = "stockhistory";
  // String dailyHistoryTable = "dailyhistory";

  Future<Database> getDatabase() async {
    return database ?? await initDatabase();
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'fruitshop.db');

    return openDatabase(
      path,
      version: 2,
      onCreate: (db, ver) async {},
    );
  }

  Future onCreate(Database db, int version) async {
    await db.execute(
        '''CREATE TABLE $salesTable(id INTEGER PRIMARY KEY AUTOINCREMENT, fruit TEXT, salequantity REAL, saleprice REAL, date TEXT)''');

    await db.execute(
        '''CREATE TABLE $stockTable(id INTEGER PRIMARY KEY AUTOINCREMENT, fruit TEXT, stockquantity REAL, investment REAL, date TEXT)''');
  }

  // to upgrade the table ....................................................................................

  Future<void> upgradeDatabase(
      Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      // Create the new table
      await db.execute('''
      CREATE TABLE new_salesdetails(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        fruit TEXT,
        salequantity REAL,
        saleprice REAL,
        date TEXT
      )
    ''');

      // Migrate data from the old table to the new one
      await db.execute('''
      INSERT INTO new_salesdetails (id, fruit, salequantity, saleprice, date)
      SELECT id, fruit, salequantity, saleprice, date
      FROM salesdetails
    ''');

      // Drop the old table
      await db.execute('DROP TABLE salesdetails');

      // Rename the new table to the original name
      await db.execute('ALTER TABLE new_salesdetails RENAME TO salesdetails');
    }
  }
}
