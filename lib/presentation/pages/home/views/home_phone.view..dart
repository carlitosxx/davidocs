import 'package:davidocs/presentation/pages/home/widgets/my_drawer.dart';
import 'package:flutter/material.dart';

class HomePhoneView extends StatelessWidget {
  const HomePhoneView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
        // leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
      ),
      drawer: const MyDrawer(),
    );
  }
}
