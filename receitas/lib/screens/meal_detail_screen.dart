import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receitas/models/meal.dart';
import 'package:receitas/provider/meal_list_provider.dart';

class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen({super.key, required this.meal});

  final Meal meal;

  Widget _createSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 23,
        ),
      ),
    );
  }

  Widget _createContainer(Widget child, double maxWidthContainer) {
    return Container(
        height: 250,
        width: maxWidthContainer,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: const Border(bottom: BorderSide(color: Colors.black)),
            borderRadius: BorderRadius.circular(10)),
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final provider = Provider.of<MealListProvider>(context);
    final double maxWidthImage =
        mediaQuery.size.width > 500 ? 500 : mediaQuery.size.width;

    final double maxWidthContainer =
        mediaQuery.size.width > 350 ? 350 : mediaQuery.size.width;

    final Widget listIngredientes = ListView.builder(
      itemCount: meal.ingredients.length,
      itemBuilder: (ctx, index) {
        return Card(
          color: Colors.amber,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(meal.ingredients[index]),
          ),
        );
      },
    );

    final Widget listWorking = ListView.builder(
      itemCount: meal.steps.length,
      itemBuilder: (ctx, index) {
        final step = meal.steps[index];
        return Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.pink,
                foregroundColor: Colors.white,
                child: Text((index + 1).toString()),
              ),
              title: Text(step),
            ),
            const Divider()
          ],
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(
          meal.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: Colors.pink,
        centerTitle: true,
        toolbarHeight: 80,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 50),
        child: SafeArea(
            child: Column(
          children: [
            Center(
              child: Hero(
                tag: meal.id,
                child: Image.network(
                  meal.imageUrl,
                  height: 300,
                  width: maxWidthImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            _createSectionTitle(context, 'Ingredientes'),
            _createContainer(listIngredientes, maxWidthContainer),
            const SizedBox(
              height: 20,
            ),
            _createSectionTitle(context, 'Modo de preparo'),
            _createContainer(listWorking, maxWidthContainer),
          ],
        )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          provider.toggleFavorite(meal);
        },
        backgroundColor: Colors.amber,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: Icon(provider.isFavorite(meal)
            ? Icons.favorite
            : Icons.favorite_border),
      ),
    );
  }
}
