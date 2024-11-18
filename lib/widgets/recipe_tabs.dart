import 'package:firstui/screens/recipe__list.dart';
import 'package:firstui/widgets/recipe_drawer.dart';
import 'package:flutter/material.dart';

class RecipeTabs extends StatelessWidget {
   @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Foods', icon: Icon(Icons.fastfood)),
                Tab(text: 'Drinks', icon: Icon(Icons.local_drink)),
              ],
            ),
          ),
          drawer: AppDrawer(),
          body: TabBarView(
            children: [
              RecipeListPage(category: 'foods'),
              RecipeListPage(category: 'drinks'),
            ],
          ),
        ),
      );
  }
}