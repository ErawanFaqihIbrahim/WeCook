import 'package:flutter/material.dart';
import '../models/recipe_model.dart';
import '../services/database_service.dart';

class RecipeDetailPage extends StatefulWidget {
  Recipe recipe;

  RecipeDetailPage({required this.recipe});

  @override
  _RecipeDetailPageState createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  final DatabaseService _databaseService = DatabaseService.instance;

  void _deleteRecipe() async {
    final confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Recipe'),
        content: Text('Are you sure you want to delete this recipe?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await _databaseService.deleteRecipe(widget.recipe.id);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Recipe deleted successfully')),
      );
    }
  }

  void _updateRecipe() {
    final TextEditingController titleController = TextEditingController(text: widget.recipe.title);
    final TextEditingController descriptionController = TextEditingController(text: widget.recipe.description);
    final TextEditingController imageUrlController = TextEditingController(text: widget.recipe.imageUrl);
    final TextEditingController ingredientsController = TextEditingController(text: widget.recipe.ingredients.join(', '));
    final TextEditingController stepsController = TextEditingController(text: widget.recipe.steps.join(', '));
    final TextEditingController categoryController = TextEditingController(text: widget.recipe.category);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Update Recipe'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Recipe Title',
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Description',
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: imageUrlController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Image URL',
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: ingredientsController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Ingredients (comma-separated)',
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: stepsController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Steps (comma-separated)',
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: categoryController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Category',
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  final updatedRecipe = Recipe(
                    id: widget.recipe.id,
                    title: titleController.text.trim(),
                    description: descriptionController.text.trim(),
                    imageUrl: imageUrlController.text.trim(),
                    ingredients: ingredientsController.text.split(',').map((e) => e.trim()).toList(),
                    steps: stepsController.text.split(',').map((e) => e.trim()).toList(),
                    category: categoryController.text.trim(),
                  );

                  await _databaseService.updateRecipe(updatedRecipe);
                  Navigator.pop(context);
                  setState(() {
                    widget.recipe = Recipe(
                      id: widget.recipe.id,
                      title: updatedRecipe.title,
                      description: updatedRecipe.description,
                      imageUrl: updatedRecipe.imageUrl,
                      ingredients: updatedRecipe.ingredients,
                      steps: updatedRecipe.steps,
                      category: updatedRecipe.category,
                    );
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Recipe updated successfully')),
                  );
                },
                child: Text('Update Recipe'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe.title),
        backgroundColor: Colors.orangeAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: _updateRecipe,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _deleteRecipe,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.recipe.imageUrl,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.grey.shade300,
                  child: Icon(
                    Icons.fastfood,
                    size: 100,
                    color: Colors.orangeAccent,
                  ),
                );
              },
            ),
            SizedBox(height: 16),
            Text(
              widget.recipe.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Ingredients',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.recipe.ingredients.length,
              itemBuilder: (context, index) {
                return Text(
                  '- ${widget.recipe.ingredients[index]}',
                  style: TextStyle(fontSize: 16),
                );
              },
            ),
            SizedBox(height: 16),
            Text(
              'Steps',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.recipe.steps.length,
              itemBuilder: (context, index) {
                return Text(
                  '${index + 1}. ${widget.recipe.steps[index]}',
                  style: TextStyle(fontSize: 16),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}