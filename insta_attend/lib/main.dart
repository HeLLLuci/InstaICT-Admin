import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Screens/LayoutEntry.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyBj4Ru3oX0d2XcUQ3yLKxu6O2HJ5fMkImc",
        appId: "1:990644961746:web:ca0b97d8f8189c9ae7080b",
        messagingSenderId: "990644961746",
        projectId: "insta-ams",
    )
  );
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Admin Dashboard",
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
        primarySwatch: Colors.blue
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

