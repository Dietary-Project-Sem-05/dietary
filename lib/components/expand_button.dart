import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dietary_project/utilities/constants.dart';

class ExpandButton extends StatelessWidget {
  const ExpandButton({this.labelText, this.icon});

  final String? labelText;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        primary: Color(0xEE1565c0).withOpacity(0.7),
      ),
      onPressed: () {},
      icon: Icon(
        icon,
        size: 18,
        color: Color(0xEEFFFFFF),
      ),
      label: Text(
        labelText.toString(),
        style: GoogleFonts.roboto(
          textStyle: kExpandButtonTextStyle,
        ),
      ),
    );
  }
}
