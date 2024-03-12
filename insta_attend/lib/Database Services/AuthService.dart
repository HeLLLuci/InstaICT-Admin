import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insta_attend/Screens/LayoutEntry.dart';

class AuthService {

  static Future<void> loginUser(String email, String password, BuildContext context) async {
    final auth = FirebaseAuth.instance;
    final db = FirebaseFirestore.instance;

    try {
      final userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      final userDoc = await db.collection('employeeDetails').doc(userCredential.user?.uid).get();

      if (userDoc.exists && userDoc.data()?['isAdmin'] == true) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        await auth.signOut();-
        ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.danger,
            title: "Oops...",
            text: "You don't have access to this page",
          ),
        );
      }
    } catch (e) {
      await auth.signOut();
      ArtSweetAlert.show(
        context: context,
        artDialogArgs: ArtDialogArgs(
          type: ArtSweetAlertType.danger,
          title: "Oops...",
          text: e.toString(),
        ),
      );
    }
  }
}
