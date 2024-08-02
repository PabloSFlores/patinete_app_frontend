import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/patinete_model.dart';
import '../cubit/patinete_cubit.dart';

class PatineteForm extends StatelessWidget {
  final PatineteModel? patinete;

  PatineteForm({super.key, this.patinete});

  final _formKey = GlobalKey<FormState>();
  final _marcaController = TextEditingController();
  final _modeloController = TextEditingController();
  final _tipoController = TextEditingController();
  final _colorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (patinete != null) {
      _marcaController.text = patinete!.marca;
      _modeloController.text = patinete!.modelo;
      _tipoController.text = patinete!.tipo;
      _colorController.text = patinete!.color;
    }

    return AlertDialog(
      title: Text(
        patinete == null ? 'Crear Patinete' : 'Editar Patinete',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField(_marcaController, 'Marca'),
              _buildTextField(_modeloController, 'Modelo'),
              _buildTextField(_tipoController, 'Tipo'),
              _buildTextField(_colorController, 'Color'),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final patineteCubit = context.read<PatineteCubit>();
              if (patinete == null) {
                patineteCubit.crearPatinete(
                  PatineteModel(
                    marca: _marcaController.text,
                    modelo: _modeloController.text,
                    tipo: _tipoController.text,
                    color: _colorController.text,
                  ),
                );
              } else {
                patineteCubit.actualizarPatinete(
                  PatineteModel(
                    id: patinete!.id,
                    marca: _marcaController.text,
                    modelo: _modeloController.text,
                    tipo: _tipoController.text,
                    color: _colorController.text,
                  ),
                );
              }
              Navigator.of(context).pop();
            }
          },
          child: Text(patinete == null ? 'Crear' : 'Actualizar'),
        ),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor ingrese $label';
          }
          return null;
        },
      ),
    );
  }
}
