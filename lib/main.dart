import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/bloc/cubit/news_cubit.dart';
import 'package:myapp/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context)=>NewsCubit(),
      child:const MaterialApp(
        home: MainScreen(),
      ),
    );
  }
}