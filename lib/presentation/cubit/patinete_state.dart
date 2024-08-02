import 'package:equatable/equatable.dart';

import '../../data/models/patinete_model.dart';

abstract class PatineteState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PatineteInitial extends PatineteState {}

class PatineteLoading extends PatineteState {}

class PatineteSuccess extends PatineteState {
  final List<PatineteModel> patinetes;

  PatineteSuccess({required this.patinetes});

  @override
  List<Object?> get props => [patinetes];
}

class PatineteError extends PatineteState {
  final String message;

  PatineteError({required this.message});

  @override
  List<Object?> get props => [message];
}
