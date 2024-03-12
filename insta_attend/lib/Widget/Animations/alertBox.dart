import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';

class ShowAlertBox extends StatelessWidget {

  final String title;
  final String message;
  const ShowAlertBox({super.key, required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return ArtSweetAlert.show(
        context: context,
        artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.danger,
            title: title,
            text: message)
    );
  }
}