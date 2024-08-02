import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/patinete_model.dart';
import '../cubit/patinete_cubit.dart';

class PatineteDeleteConfirmation extends StatelessWidget {
  final PatineteModel patinete;

  const PatineteDeleteConfirmation({super.key, required this.patinete});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Eliminar Patinete'),
      content: const Text('¿Estás seguro de que quieres eliminar este patinete?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            context
                .read<PatineteCubit>()
                .eliminarPatinete(patinete.id.toString());
            Navigator.of(context).pop();
          },
          child: const Text('Eliminar'),
        ),
      ],
    );
  }
}
