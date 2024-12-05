import 'package:flutter/material.dart';
import '../models/recipe_model.dart';
import '../services/database_service.dart';

class RecipeListPage extends StatelessWidget {
  final DatabaseService _databaseService = DatabaseService.instance;
  final String category;

  RecipeListPage({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('We Cook'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: FutureBuilder<List<Recipe>>(
        future: _databaseService.getAllRecipes().then((recipes) {
          return recipes.where((recipe) => recipe.category == category).toList();
        }),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No recipes found for this category.'));
          } else {
            final filteredRecipes = snapshot.data!;
            return ListView.builder(
              itemCount: filteredRecipes.length,
              itemBuilder: (context, index) {
                final recipe = filteredRecipes[index];
                return Card(
                  color: Colors.orange.shade100,
                  child: ListTile(
                    leading: Image.network(
                      recipe.imageUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.fastfood,
                          size: 50,
                          color: Colors.orangeAccent,
                        );
                      },
                    ),
                    title: Text(
                      recipe.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(recipe.description),
                    onTap: () {
                      Navigator.pushNamed(context, '/recipeDetail', arguments: recipe);
                    },
                    onLongPress: () async {
                      final shouldDelete = await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Delete Recipe'),
                            content: Text('Are you sure you want to delete this recipe?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: Text('Delete', style: TextStyle(color: Colors.red)),
                              ),
                            ],
                          );
                        },
                      );

                      if (shouldDelete == true) {
                        await _databaseService.deleteRecipe(recipe.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${recipe.title} has been deleted.')),
                        );
                        // Trigger UI refresh
                      }
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
