import 'package:flutter/material.dart';

import '../../data/models/patinete_model.dart';

class PatineteDetails extends StatelessWidget {
  final PatineteModel patinete;

  const PatineteDetails({super.key, required this.patinete});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Detalles del Patinete'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('ID: ${patinete.id}'),
          Text('Marca: ${patinete.marca}'),
          Text('Modelo: ${patinete.modelo}'),
          Text('Tipo: ${patinete.tipo}'),
          Text('Color: ${patinete.color}'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cerrar'),
        ),
      ],
    );
  }
}
