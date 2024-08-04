import 'package:flutter/material.dart';
import 'package:receitas/components/drawer_main.dart';
import 'package:receitas/screens/categories_screen.dart';
import 'package:receitas/screens/favorite_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _indexScreeenSelected = 0;
  late List<Map<String, Object>> _screens;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _screens = [
      {
        'title': 'Lista de categorias',
        'screen': const CategoriesScreen(),
      },
      {
        'title': 'Meus favoritos',
        'screen': const FavoriteScreen()
      }
    ];
  }

  void _selectedIndex(int index) {
    setState(() {
      _indexScreeenSelected = index;
    });
  }

  void _onItemTap(int index) {
    setState(() {
      _pageController.animateToPage(index,
          duration: const Duration(milliseconds: 400), curve: Curves.fastLinearToSlowEaseIn);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            foregroundColor: Colors.white,
            title: Text(
              _screens[_indexScreeenSelected]['title'] as String,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            backgroundColor: Colors.pink,
            centerTitle: true,
            toolbarHeight: 80,
          ),
          drawer: const DrawerMain(),
          body: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _selectedIndex(index);
              });
            },
            children: _screens.map((e) => e['screen'] as Widget).toList(),
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: _onItemTap,
            selectedItemColor: Colors.amber,
            unselectedItemColor: Colors.white,
            currentIndex: _indexScreeenSelected,
            type: BottomNavigationBarType.shifting,
            items: const [
              BottomNavigationBarItem(
                  backgroundColor: Colors.pink,
                  icon: Icon(Icons.category),
                  label: 'Categorias'),
              BottomNavigationBarItem(
                  backgroundColor: Colors.pink,
                  icon: Icon(Icons.favorite),
                  label: 'Favoritos'),
            ],
          ),
        ));
  }
}
