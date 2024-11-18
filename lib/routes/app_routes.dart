import 'package:flutter/material.dart';
import '../models/recipe_model.dart';
import '../screens/recipe__list.dart';
import '../screens/recipe_detail.dart';
import '../widgets/recipe_tabs.dart';
import '../screens/about_me.dart';

class AppRoutes {
  static const recipeList = '/recipeList';
  static const recipeDetail = '/recipeDetail';
  static const main = '/main';
  static const aboutMe = '/aboutMe';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case recipeList:
      final category = settings.arguments as String;
      return MaterialPageRoute(builder: (_) => RecipeListPage(category: category)
      );
      case recipeDetail:
      final recipe = settings.arguments as Recipe;
      return MaterialPageRoute(builder: (_) => RecipeDetailPage(recipe: recipe)
      );
      case main:
      return MaterialPageRoute(builder: (_) => RecipeTabs()
      );
      case aboutMe:
      return MaterialPageRoute(builder: (_) => AboutMe()
      );
      default:
      return MaterialPageRoute(builder: (_) => Scaffold(
        body: Center(child: Text('No Route defined'),),
      ));
    }
  }
}