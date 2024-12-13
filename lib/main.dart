import 'package:finalprojectadmin/features/auth/presentation/pages/login_screen/bloc/auth_bloc.dart';
import 'package:finalprojectadmin/features/auth/presentation/pages/login_screen/login_screen.dart';
import 'package:finalprojectadmin/features/bottom_nav/presentation/pages/bottom_navigation_bar.dart';
import 'package:finalprojectadmin/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); 
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final bool hasAdminId =
      await hasUserId(); 

  runApp(MyApp(hasAdminId: hasAdminId));
}

class MyApp extends StatelessWidget {
  final bool hasAdminId;

  const MyApp({super.key, required this.hasAdminId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: hasAdminId ? const BottomNavigationBars() : LoginScreen(),
      ),
    );
  }
}

Future<bool> hasUserId() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.containsKey('user_id');
}
