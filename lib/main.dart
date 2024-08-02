import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/repository/patinete_repository.dart';
import 'presentation/cubit/patinete_cubit.dart';
import 'presentation/screens/patinete_table.dart';

void main() {
  final patineteRepository = PatineteRepository(apiUrl: 'https://a8v55x1swe.execute-api.us-west-1.amazonaws.com/Dev');
  runApp(MyApp(patineteRepository: patineteRepository));
}

class MyApp extends StatelessWidget {
  final PatineteRepository patineteRepository;

  const MyApp({super.key, required this.patineteRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Patinete Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) =>
            PatineteCubit(patineteRepository: patineteRepository),
        child: const PatineteTable(),
      ),
    );
  }
}
