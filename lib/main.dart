import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patinete_app_frontend/presentation/screens/patinete_form.dart';

import 'data/repository/patinete_repository.dart';
import 'helpers/navigator_key.dart';
import 'presentation/cubit/patinete_cubit.dart';
import 'presentation/screens/patinete_table.dart';

void main() {
  final PatineteRepository patineteRepository =
      PatineteRepository(apiUrl: 'https://a8v55x1swe.execute-api.us-west-1.amazonaws.com/Dev');
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              PatineteCubit(patineteRepository: patineteRepository),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        navigatorKey: navigatorKey, // Use the imported navigatorKey
      ),
    ),
  );
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Patinetes')),
      body: PatineteTable(),
      floatingActionButton: FloatingActionButton(
        onPressed: showCreateDialog,
        child: Icon(Icons.add),
      ),
    );
  }

  void showCreateDialog() {
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (context) => PatineteForm(),
    );
  }
}
