// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/HomePage.dart';
import 'bloc/CartBloc.dart';

void main() {
  runApp(
    MaterialApp(
      home: BlocProvider(
        create: (context) => CartBloc(),
        child: MenuPage(),
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}
