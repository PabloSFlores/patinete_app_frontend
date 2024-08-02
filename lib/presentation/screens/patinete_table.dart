import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/cubit/patinete_state.dart';
import '../cubit/patinete_cubit.dart';
import 'patinete_delete_confirmation.dart';
import 'patinete_details.dart';
import 'patinete_form.dart';

class PatineteTable extends StatelessWidget {
  const PatineteTable({super.key});

  @override
  Widget build(BuildContext context) {
    // Realiza la petición para cargar los patinetes
    context.read<PatineteCubit>().consultarPatinetes();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Patinetes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => PatineteForm(),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<PatineteCubit, PatineteState>(
        builder: (context, state) {
          if (state is PatineteLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PatineteSuccess) {
            return DataTable(
              columns: const [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Marca')),
                DataColumn(label: Text('Modelo')),
                DataColumn(label: Text('Tipo')),
                DataColumn(label: Text('Color')),
                DataColumn(label: Text('Acciones')),
              ],
              rows: state.patinetes.map((patinete) {
                return DataRow(cells: [
                  DataCell(Text(patinete.id.toString())),
                  DataCell(Text(patinete.marca)),
                  DataCell(Text(patinete.modelo)),
                  DataCell(Text(patinete.tipo)),
                  DataCell(Text(patinete.color)),
                  DataCell(Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.visibility),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) =>
                                PatineteDetails(patinete: patinete),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) =>
                                PatineteForm(patinete: patinete),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) =>
                                PatineteDeleteConfirmation(patinete: patinete),
                          );
                        },
                      ),
                    ],
                  )),
                ]);
              }).toList(),
            );
          } else if (state is PatineteError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return Center(child: Text('No hay patinetes disponibles.'));
        },
      ),
    );
  }
}
