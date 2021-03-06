// Flutter code sample for BottomNavigationBar

// This example shows a [BottomNavigationBar] as it is used within a [Scaffold]
// widget. The [BottomNavigationBar] has three [BottomNavigationBarItem]
// widgets and the [currentIndex] is set to index 0. The selected item is
// amber. The `_onItemTapped` function changes the selected item's index
// and displays a corresponding message in the center of the [Scaffold].
//
// ![A scaffold with a bottom navigation bar containing three bottom navigation
// bar items. The first one is selected.](https://flutter.github.io/assets-for-api-docs/assets/material/bottom_navigation_bar.png)
import 'package:bookifyapp/Pages/LoginPages/Welcome/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:bookifyapp/Models/User.dart';
import 'package:provider/provider.dart';

import 'Design/SizeConfig.dart';

void main() => runApp(MyApp());

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MultiProvider(
                providers: [
                  // In this sample app, CatalogModel never changes, so a simple Provider
                  // is sufficient.
                  //Provider(create: (context) => User.getMockUser()),

                  ChangeNotifierProvider<User>(
                      create: (context) => User.getMockUser())

                  // CartModel is implemented as a ChangeNotifier, which calls for the use
                  // of ChangeNotifierProvider. Moreover, CartModel depends
                  // on CatalogModel, so a ProxyProvider is needed.
                  /*ChangeNotifierProxyProvider<CatalogModel, CartModel>(
                    create: (context) => CartModel(),
                    update: (context, catalog, cart) {
                      cart.catalog = catalog;
                      return cart;
                    },
                  ),*/
                ],
                child: MaterialApp(
                  home: WelcomePage(),
                ));
            /*return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Learning Platform Application',
              theme: AppTheme.lightTheme,
              home: WelcomeScreen(),
            );*/
          },
        );
      },
    );
  }
}
