import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/patinete_model.dart';
import '../../helpers/navigator_key.dart';
import '../../presentation/cubit/patinete_state.dart';
import '../cubit/patinete_cubit.dart';
import 'patinete_delete_confirmation.dart';
import 'patinete_details.dart';
import 'patinete_form.dart';

class PatineteTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Realiza la petición para cargar los patinetes
    context.read<PatineteCubit>().consultarPatinetes();

    return BlocBuilder<PatineteCubit, PatineteState>(
      builder: (context, state) {
        if (state is PatineteLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is PatineteSuccess) {
          return ListView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: state.patinetes.length,
            itemBuilder: (context, index) {
              final patinete = state.patinetes[index];
              return Card(
                elevation: 4.0,
                margin: EdgeInsets.symmetric(vertical: 8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ID: ${patinete.id}',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      SizedBox(height: 4.0),
                      Text('Marca: ${patinete.marca}',
                          style: TextStyle(fontSize: 14)),
                      SizedBox(height: 4.0),
                      Text('Modelo: ${patinete.modelo}',
                          style: TextStyle(fontSize: 14)),
                      SizedBox(height: 4.0),
                      Text('Tipo: ${patinete.tipo}',
                          style: TextStyle(fontSize: 14)),
                      SizedBox(height: 4.0),
                      Text('Color: ${patinete.color}',
                          style: TextStyle(fontSize: 14)),
                      SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(Icons.visibility,
                                color: Colors.blue, size: 20),
                            onPressed: () {
                              showPatineteDetails(context, patinete);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.edit,
                                color: Colors.orange, size: 20),
                            onPressed: () {
                              showPatineteForm(context, patinete);
                            },
                          ),
                          IconButton(
                            icon:
                                Icon(Icons.delete, color: Colors.red, size: 20),
                            onPressed: () {
                              showPatineteDeleteConfirmation(context, patinete);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (state is PatineteError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        return Center(child: Text('No hay patinetes disponibles.'));
      },
    );
  }

  void showPatineteDetails(BuildContext context, PatineteModel patinete) {
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (context) => PatineteDetails(patinete: patinete),
    );
  }

  void showPatineteForm(BuildContext context, PatineteModel? patinete) {
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (context) => PatineteForm(patinete: patinete),
    );
  }

  void showPatineteDeleteConfirmation(
      BuildContext context, PatineteModel patinete) {
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (context) => PatineteDeleteConfirmation(patinete: patinete),
    );
  }
}
