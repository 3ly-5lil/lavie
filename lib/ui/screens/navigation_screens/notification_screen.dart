import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Padding(
          padding: EdgeInsets.all(34.0),
          child: Text(
            'Notification',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 19),
          ),
        ),
      ],
    );
  }
}
