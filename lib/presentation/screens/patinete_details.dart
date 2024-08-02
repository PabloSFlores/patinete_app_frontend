import 'package:flutter/material.dart';

import '../../data/models/patinete_model.dart';

class PatineteDetails extends StatelessWidget {
  final PatineteModel patinete;

  const PatineteDetails({super.key, required this.patinete});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Detalles del Patinete',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow('ID:', patinete.id.toString()),
          _buildDetailRow('Marca:', patinete.marca),
          _buildDetailRow('Modelo:', patinete.modelo),
          _buildDetailRow('Tipo:', patinete.tipo),
          _buildDetailRow('Color:', patinete.color),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cerrar'),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[700],
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
