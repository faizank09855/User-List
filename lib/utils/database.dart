import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/image_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'user_images.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE user_images (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        imagePath TEXT NOT NULL,
        userId INTEGER NOT NULL
      )
    ''');
  }


  Future<List<UserImage>> getAllImages() async {
    final db = await database;
    final result = await db.query('user_images');
    return result.map((map) => UserImage.fromMap(map)).toList();
  }

  Future<List<UserImage>> getUserImages(userId) async {
    final db = await database;
    final result = await db.query('user_images' , where: "userId = ?" , whereArgs: [userId]);
    return result.map((map) => UserImage.fromMap(map)).toList();
  }

  Future<int> insertUserImage(UserImage userImage) async {
    final db = await database;
    return await db.insert('user_images', userImage.toMap());
  }

  Future<int> updateUserImage(UserImage userImage) async {
    final db = await database;
    return await db.update(
      'user_images',
      userImage.toMap(),
      where: 'userId = ?',
      whereArgs: [userImage.userId],
    );
  }

}
