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
      title: Text(patinete == null ? 'Crear Patinete' : 'Editar Patinete'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _marcaController,
              decoration: const InputDecoration(labelText: 'Marca'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese la marca';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _modeloController,
              decoration: const InputDecoration(labelText: 'Modelo'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el modelo';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _tipoController,
              decoration: const InputDecoration(labelText: 'Tipo'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el tipo';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _colorController,
              decoration: const InputDecoration(labelText: 'Color'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el color';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        TextButton(
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
                ).then((_) => Navigator.of(context).pop());
              } else {
                patineteCubit.actualizarPatinete(
                  PatineteModel(
                    id: patinete!.id,
                    marca: _marcaController.text,
                    modelo: _modeloController.text,
                    tipo: _tipoController.text,
                    color: _colorController.text,
                  ),
                ).then((_) => Navigator.of(context).pop());
              }
            }
          },
          child: Text(patinete == null ? 'Crear' : 'Actualizar'),
        ),
      ],
    );
  }
}