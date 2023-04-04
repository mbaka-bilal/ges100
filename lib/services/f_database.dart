import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../features/onboarding/screens/splash_screen.dart';
import '../models/questions.dart';

class FDatabase {
  ///Handle all database functions
  ///
  ///

  Future<bool> tableExists(String tableName) async {
    /// Check if table exists
    ///

    String path = await getDatabasesPath();
    String finalPath = join(path, 'questions.db');
    final db = await openDatabase(finalPath);

    var result = await db
        .query('sqlite_master', where: 'name = ?', whereArgs: [tableName]);

    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkIfTableExists(String tableName) async {
    if (await tableExists(tableName)) {
      return true;
    } else {
      return false;
    }
  }

  static Future<void> createDatabaseAndTables(String tableName) async {
    ///Create the required database and tables.
    String path = await getDatabasesPath();
    String finalPath = join(path, 'questions.db');
    final db = await openDatabase(finalPath);

    await db.execute('CREATE TABLE $tableName ('
        'id INTEGER PRIMARY KEY, '
        'question TEXT NOT NULL,'
        'answer TEXT NOT NULL,'
        'options TEXT NOT NULL,'
        'answerIndex TEXT NOT NULL'
        ')');
    // return false;
  }

  Future<void> addQuestionsToTable(String tableName) async {
    ///Add the questions to the table

    // for (int i in CourseTitles.ges100)

    String path = await getDatabasesPath();
    String finalPath = join(path, 'questions.db');
    final db = await openDatabase(finalPath);
    Batch batch = db.batch();

    /* Communication in English */
    if (tableName == "ges100") {
      // print("attempting to add questions to the database");
      for (int i = 0; i < ges100.length; i++) {
        batch.insert(tableName, ges100[i],
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }

    if (tableName == "ges102") {
      // print("attempting to add questions to the database");
      for (int i = 0; i < ges102.length; i++) {
        batch.insert(tableName, ges102[i],
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }

    if (tableName == "ges103") {
      // print("attempting to add questions to the database");
      for (int i = 0; i < ges103.length; i++) {
        batch.insert(tableName, ges103[i],
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }

    /* Computer appreciation */
    if (tableName == "ges101") {
      // print("attempting to add questions to the database");
      for (int i = 0; i < ges101.length; i++) {
        batch.insert(tableName, ges101[i],
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }

    await batch.commit();
  }

  static Future<int> countQuestions(String tableName) async {
    ///Count the number of questions in the table
    ///

    String path = await getDatabasesPath();
    String finalPath = join(path, 'questions.db');
    final db = await openDatabase(finalPath);

    try {
      List<Map<String, dynamic>> numberOfQuestions =
          await db.rawQuery('SELECT COUNT(*) FROM $tableName');
      // print("the result is ${numberOfQuestions[0]['COUNT(*)']}");
      return numberOfQuestions[0]['COUNT(*)'];
    } catch (e) {
      print("Error counting the number of questions $e");
      return 0;
    }
  }

  static Future<List<Map<String, dynamic>>> fetchQuestions(
      String tableName) async {
    ///Fetch all questions from the specific table
    ///

    String path = await getDatabasesPath();
    String finalPath = join(path, 'questions.db');
    final db = await openDatabase(finalPath);

    try {
      List<Map<String, dynamic>> questions = await db.query(tableName);
      // print("the questions is $questions");
      return questions;
    } catch (e) {
      print("Error fetching questions from the table $e");
      return [];
    }
  }

// static Future<bool> checkAnswer(int chosenIndex)
}
