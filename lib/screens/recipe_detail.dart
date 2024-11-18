import 'package:firstui/models/recipe_model.dart';
import 'package:flutter/material.dart';

class RecipeDetailPage extends StatelessWidget {
  final Recipe recipe;

  RecipeDetailPage({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Padding(padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            recipe.imageUrl,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 16),
          Text(
            recipe.title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            'Bahan-bahan',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: recipe.ingredients.length,
            itemBuilder: (context, index) {
              return Text(
                '-${recipe.ingredients[index]}',
                style: TextStyle(fontSize: 16),
              );
            },
          ),
          SizedBox(height: 16),
          Text(
            'Langkah Pembuatan:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: recipe.steps.length,
            itemBuilder: (context, index) {
              return Text(
                '${index + 1}. ${recipe.steps[index]}',
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