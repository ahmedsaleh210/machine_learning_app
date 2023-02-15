import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  final GestureTapCallback onTap;
  const CircularButton({super.key, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.6), shape: BoxShape.circle),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ),
        ));
  }
}
