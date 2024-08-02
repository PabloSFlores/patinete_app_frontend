import 'package:bloc/bloc.dart';

import '../../data/models/patinete_model.dart';
import '../../data/repository/patinete_repository.dart';
import 'patinete_state.dart';

class PatineteCubit extends Cubit<PatineteState> {
  final PatineteRepository patineteRepository;

  PatineteCubit({required this.patineteRepository}) : super(PatineteInitial());

  Future<void> crearPatinete(PatineteModel patinete) async {
    try {
      emit(PatineteLoading());
      await patineteRepository.crearPatinete(patinete);
      final patinetes = await patineteRepository.consultarPatinetes();
      emit(PatineteSuccess(patinetes: patinetes));
    } catch (e) {
      emit(PatineteError(message: e.toString()));
    }
  }

  Future<void> consultarPatinete(String id) async {
    try {
      emit(PatineteLoading());
      final patinete = await patineteRepository.consultarPatinete(id);
      emit(PatineteSuccess(patinetes: [patinete]));
    } catch (e) {
      emit(PatineteError(message: e.toString()));
    }
  }

  Future<void> actualizarPatinete(PatineteModel patinete) async {
    try {
      emit(PatineteLoading());
      await patineteRepository.actualizarPatinete(patinete);
      final patinetes = await patineteRepository.consultarPatinetes();
      emit(PatineteSuccess(patinetes: patinetes));
    } catch (e) {
      emit(PatineteError(message: e.toString()));
    }
  }

  Future<void> eliminarPatinete(String id) async {
    try {
      emit(PatineteLoading());
      await patineteRepository.eliminarPatinete(id);
      final patinetes = await patineteRepository.consultarPatinetes();
      emit(PatineteSuccess(patinetes: patinetes));
    } catch (e) {
      emit(PatineteError(message: e.toString()));
    }
  }

  Future<void> consultarPatinetes() async {
    try {
      emit(PatineteLoading());
      final patinetes = await patineteRepository.consultarPatinetes();
      emit(PatineteSuccess(patinetes: patinetes));
    } catch (e) {
      emit(PatineteError(message: e.toString()));
    }
  }
}
