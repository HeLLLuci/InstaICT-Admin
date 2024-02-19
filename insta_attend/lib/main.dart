import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:insta_attend/Screens/LayoutEntry.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyB0W1hjYZ8N7HkJa8Ghski2YkpVmuaMuBU",
        appId: "1:953909964234:web:65bfd132fa17876ce53333",
        messagingSenderId: "953909964234",
        projectId: "attendance-management-50dfb",
    )
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
        primarySwatch: Colors.blue
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
