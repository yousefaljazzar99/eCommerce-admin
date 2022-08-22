import 'package:ecommerce/Provider/auth_provider.dart';
import 'package:ecommerce/Provider/firestore_provider.dart';
import 'package:ecommerce/Provider/storage_provider.dart';
import 'package:ecommerce/firebase_options.dart';
import 'package:ecommerce/models/router.dart';
import 'package:ecommerce/view/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // AuthProvider
        ChangeNotifierProvider<AuthProvider>(
            create: (context) => AuthProvider()),
        // FirestoreProvider
        ChangeNotifierProvider<FirestoreProvider>(
            create: (context) => FirestoreProvider()),
        // StorageProvider
        ChangeNotifierProvider<StorageProvider>(
            create: (context) => StorageProvider()),
      ],
      child: MaterialApp(
        navigatorKey: AppRouter.navKey,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Firebase',
        theme: ThemeData(
            primaryColor: GreenColors,
            scaffoldBackgroundColor: Colors.white,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                primary: GreenColors,
                shape: const StadiumBorder(),
                maximumSize: const Size(double.infinity, 56),
                minimumSize: const Size(double.infinity, 56),
              ),
            ),
            inputDecorationTheme: const InputDecorationTheme(
              filled: true,
              fillColor: kPrimaryLightColor,
              iconColor: GreenColors,
              prefixIconColor: GreenColors,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: defaultPadding, vertical: defaultPadding),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide.none,
              ),
            )),
        home: SplachScreen(),
      ),
    );
  }
}
