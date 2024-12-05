import 'dart:convert'; // For JSON encoding/decoding
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/recipe_model.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();

  final String recipeTableName = "recipes";
  final String recipeIdColumnName = "id";
  final String recipeTitleColumnName = "title";
  final String recipeDescriptionColumn = "description";
  final String recipeImageUrlColumnName = "imageUrl";
  final String recipeIngredientsColumn = "ingredients";
  final String recipeStepsColumn = "steps";
  final String recipeCategoryColumnName = "category";

  DatabaseService._constructor();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "recipe_db.db");

    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE recipes (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            description TEXT NOT NULL,
            imageUrl TEXT NOT NULL,
            ingredients TEXT NOT NULL,
            steps TEXT NOT NULL,
            category TEXT NOT NULL
          )
        ''');
      },
    );

    return database;
  }

  Future<void> addRecipe(Recipe recipe) async {
    final db = await database;
    await db.insert(
      recipeTableName,
      {
        recipeTitleColumnName: recipe.title,
        recipeDescriptionColumn: recipe.description,
        recipeImageUrlColumnName: recipe.imageUrl,
        recipeIngredientsColumn: jsonEncode(recipe.ingredients),
        recipeStepsColumn: jsonEncode(recipe.steps),
        recipeCategoryColumnName: recipe.category,
      },
    );
  }

  Future<void> updateRecipe(Recipe recipe) async {
    final db = await database;
    await db.update(
      recipeTableName,
      {
        recipeTitleColumnName: recipe.title,
        recipeDescriptionColumn: recipe.description,
        recipeImageUrlColumnName: recipe.imageUrl,
        recipeIngredientsColumn: jsonEncode(recipe.ingredients),
        recipeStepsColumn: jsonEncode(recipe.steps),
        recipeCategoryColumnName: recipe.category,
      },
      where: '$recipeIdColumnName = ?',
      whereArgs: [recipe.id],
    );
  }

  Future<void> deleteRecipe(int id) async {
    final db = await database;
    await db.delete(
      recipeTableName,
      where: '$recipeIdColumnName = ?',
      whereArgs: [id],
    );
  }

  Future<List<Recipe>> getAllRecipes() async {
    final db = await database;
    final maps = await db.query(recipeTableName);
    return maps.map((map) {
      return Recipe(
        id: map[recipeIdColumnName] as int,
        title: map[recipeTitleColumnName] as String,
        description: map[recipeDescriptionColumn] as String,
        imageUrl: map[recipeImageUrlColumnName] as String,
        ingredients: List<String>.from(jsonDecode(map[recipeIngredientsColumn] as String)),
        steps: List<String>.from(jsonDecode(map[recipeStepsColumn] as String)),
        category: map[recipeCategoryColumnName] as String,
      );
    }).toList();
  }
}
