import 'package:firstui/widgets/recipe_tabs.dart';
import 'package:flutter/material.dart';
import '../widgets/recipe_add_btn.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => HomePageState();
//   }

//   class HomePageState extends State<HomePage> {
//     final DatabaseService _databaseService = DatabaseService.instance;


//     @override
//     Widget build(Object context) {
//       return Scaffold(
//         floatingActionButton: AddRecipeButton(),
//       );
//   }
// }

class HomePage extends StatelessWidget {
  const HomePage({super.key});
    @override
    Widget build(Object context) {
      return Scaffold(
        floatingActionButton: const AddRecipeButton(),
        body: RecipeTabs(),
      );
  }
}