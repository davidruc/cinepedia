
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class CustomButtomNavigation extends StatelessWidget {
  const CustomButtomNavigation({super.key});

  int getCurrentIndex( BuildContext context ) {
    final String location = GoRouterState.of(context).matchedLocation;

    switch (location) {
      case "/":
        return 0;
      case "/categories":
        return 1;
      case "/favorites":
        return 2;
        
      default: 
        return 0;
    }
  }


  void onItemTapped( BuildContext context, int index){
    switch( index ){
      case 0: 
        context.go("/");
        break;
      case 1: 
        context.go("/");
        break;
      case 2: 
        context.go("/favorites");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {

   
    //! con un solo hijo no funciona
    return BottomNavigationBar(
      onTap: (value) => onItemTapped(context, value),
      elevation: 0,
      currentIndex: getCurrentIndex(context),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_max),
          label: "Home"
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category_outlined),
          label: 'Categories'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          label: 'Favorite'
        ),
        ],
    );
  }
}