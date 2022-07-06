import 'package:flutter/material.dart';
import 'package:kurdish_names/widgets/kurdish_name.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kurdish names'),
        centerTitle: true,
      ),
      body: Names(),
    );
  }
}
