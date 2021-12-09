import 'package:app_prueba/src/modules/auth/auth_page.dart';
import 'package:app_prueba/src/modules/auth/auth_provider.dart';
import 'package:app_prueba/src/modules/auth/bloc/global_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  return runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlobalAuth(
      child: MaterialApp(
          title: 'Prueba App',
          debugShowCheckedModeBanner: false,
          home: AuthPage(),
        ),
      
    );
  }
}
