import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/report.dart';

class DatabaseService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'reports_database.db');
    return await openDatabase(
      path,
      version: 2, // Incrementa la versión
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE reports(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            description TEXT,
            date TEXT,
            imagePaths TEXT,
            "group" TEXT
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('ALTER TABLE reports ADD COLUMN "group" TEXT');
        }
      },
    );
  }

  Future<Report> insertReport(Report report) async {
    final db = await database;
    report.id = await db.insert('reports', report.toMap());
    print('Reporte insertado con id: ${report.id}');
    return report;
  }

  Future<int> updateReport(Report report) async {
    final db = await database;
    return await db.update(
      'reports',
      report.toMap(),
      where: 'id = ?',
      whereArgs: [report.id],
    );
  }

  Future<List<Report>> getReports() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('reports');
    return List.generate(maps.length, (i) => Report.fromMap(maps[i]));
  }

  Future<List<String>> getGroups() async {
    final db = await database;
    final List<Map<String, dynamic>> result =
        await db.rawQuery('SELECT DISTINCT "group" FROM reports');
    return result.map((map) => map['group'] as String).toList();
  }

  Future<List<Report>> getReportsByGroup(String group) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'reports',
      where: '"group" = ?',
      whereArgs: [group],
    );
    return List.generate(maps.length, (i) => Report.fromMap(maps[i]));
  }
}
