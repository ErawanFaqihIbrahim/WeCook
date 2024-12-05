import 'package:flutter/material.dart';
import '../services/database_service.dart';
import '../models/recipe_model.dart';

class AddRecipeButton extends StatefulWidget {
  const AddRecipeButton({super.key});

  @override
  State<AddRecipeButton> createState() => _AddRecipeButtonState();
}

class _AddRecipeButtonState extends State<AddRecipeButton> {
  final DatabaseService _databaseService = DatabaseService.instance;

  // Form fields
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _ingredientsController = TextEditingController();
  final TextEditingController _stepsController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  void _addRecipe() async {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();
    final imageUrl = _imageUrlController.text.trim();
    final ingredients = _ingredientsController.text
        .split(',')
        .map((e) => e.trim())
        .toList();
    final steps =
        _stepsController.text.split(',').map((e) => e.trim()).toList();
    final category = _categoryController.text.trim();

    if (title.isEmpty ||
        description.isEmpty ||
        imageUrl.isEmpty ||
        ingredients.isEmpty ||
        steps.isEmpty ||
        category.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill out all fields')),
      );
      return;
    }

    final recipe = Recipe(
      id: 0, // ID akan diatur oleh database (AUTOINCREMENT)
      title: title,
      description: description,
      imageUrl: imageUrl,
      ingredients: ingredients,
      steps: steps,
      category: category,
    );

    await _databaseService.addRecipe(recipe);
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Recipe added successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Add Recipe'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Recipe Title',
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Description',
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _imageUrlController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Image URL',
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _ingredientsController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Ingredients (comma-separated)',
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _stepsController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Steps (comma-separated)',
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _categoryController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Category',
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _addRecipe,
                    child: const Text('Add Recipe'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    _ingredientsController.dispose();
    _stepsController.dispose();
    _categoryController.dispose();
    super.dispose();
  }
}
