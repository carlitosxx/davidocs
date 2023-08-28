import 'package:davidocs/presentation/pages/home/home.i18n.dart';
import 'package:flutter/material.dart';

class NotificationPhoneView extends StatelessWidget {
  const NotificationPhoneView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(kNotification.i18n),
      ),
    );
  }
}
