import 'package:flutter/material.dart';
import 'login_form.dart';

class BottomSection extends StatelessWidget {
  final Size mediaSize;

  const BottomSection({required this.mediaSize, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: mediaSize.width,
      child: const Card(
        shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child:  Padding(
          padding: EdgeInsets.all(32.0),
          child: LoginForm(),
        ),
      ),
    );
  }
}
