// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pill_cart/controller/bindings/home_controller_bindings.dart';
import 'package:pill_cart/controller/bindings/login_controller_bindings.dart';
import 'package:pill_cart/controller/bindings/register_controller_bindings.dart';
import 'package:pill_cart/localization/local_controller.dart';
import 'package:pill_cart/screens/cart_screen.dart';
import 'package:pill_cart/screens/orders_screen.dart';
import 'package:pill_cart/screens/all_drugs_screen.dart';
import 'package:pill_cart/screens/categories_screen.dart';
import 'package:pill_cart/screens/companies_screen.dart';
import 'package:pill_cart/screens/dash_board.dart';
import 'package:pill_cart/screens/home_screen.dart';
import 'package:pill_cart/screens/login_screen.dart';
import 'package:pill_cart/screens/register_screen.dart';
import 'package:pill_cart/screens/search_result_scree.dart';
import 'package:pill_cart/screens/settings_scree.dart';
import 'package:pill_cart/localization/localization.dart';
import 'package:pill_cart/utils/api_endpoints.dart';
import 'package:pill_cart/utils/theme.dart';

/// This is the entry point of the PillCart application.
/// It initializes the GetStorage and runs the app.
void main() async {
  // Ensures that the widget binding is initialized.
  // This is required for the app to interact with the Flutter engine.
  WidgetsFlutterBinding.ensureInitialized();

  // Initializes GetStorage, a persistent storage solution.
  // This is likely used for storing user preferences, tokens, or other data that needs to persist across app launches.
  await GetStorage.init();

  // Runs the app and displays the widget returned by the MyApp widget.
  runApp(const MyApp());
}

/// The main application widget.
/// It sets up the GetMaterialApp with various configurations.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the LocalController. This controller likely handles localization or other local-specific logic.
    Get.put(LocalController());

    // Return a GetMaterialApp widget, which is a version of MaterialApp that integrates with GetX for state management.
    return GetMaterialApp(
      // Prevents the debug banner from showing in the top right corner of the app.
      debugShowCheckedModeBanner: false,

      // Sets the theme of the app. This is likely defined elsewhere in your code.
      theme: customLightTheme,

      // Sets the translations for the app. This is used for internationalization.
      translations: LocalClass(),

      // Sets the default locale of the app to English.
      locale: const Locale('en'),

      // Sets the fallback locale to English. This is used if the device's locale is not supported by the app.
      fallbackLocale: const Locale('en'),

      // Sets the default transition animation for navigating between pages.
      defaultTransition: Transition.cupertino,

      // Sets the duration of the transition animation.
      transitionDuration: const Duration(milliseconds: 300),

      // Determines the initial route of the app based on whether a token is stored.
      // If no token is found, the app navigates to the '/register_user' route.
      // Otherwise, it navigates to the '/dash' route.
      initialRoute: storage.read('token') == null ? '/register_user' : '/dash',

      // Defines the routes and their corresponding widgets that the app can navigate to.
      getPages: [
        GetPage(
          // The name of the route.
          name: '/all_drugs',
          // The widget that is displayed when navigating to this route.
          page: () => AllDrugsScreen(),
          // The binding for this route, which likely sets up controllers or other dependencies.
          binding: HomeControllerBindings(),
        ),

        // Additional GetPage configurations would be defined here...
        GetPage(
          name: '/categories',
          page: () => CategoriesScreen(),
          binding: HomeControllerBindings(),
        ),
        GetPage(
          name: '/companies',
          page: () => CompaniesScreen(),
          binding: HomeControllerBindings(),
        ),
        GetPage(
          name: '/dash',
          page: () => DashBoardScreen(),
          binding: HomeControllerBindings(),
        ),
        GetPage(
          name: '/home_user',
          page: () => HomeScreen(),
          binding: HomeControllerBindings(),
        ),
        GetPage(
          name: '/register_user',
          page: () => RegisterScreen(),
          binding: RegisterUserControllerBindings(),
        ),
        GetPage(
          name: '/login',
          page: () => const LoginScreen(),
          binding: LoginControllerBindings(),
        ),
        GetPage(
          name: '/settings',
          page: () => SettingsScreen(),
        ),
        GetPage(
          name: '/about_us',
          page: () => CartScreen(),
        ),
        GetPage(
          name: '/search_result',
          page: () => SearchResultsScreen(),
          binding: HomeControllerBindings(),
        ),
        GetPage(
          name: '/account_settings',
          page: () => OrdersScreen(),
        ),
      ],
    );
  }
}
