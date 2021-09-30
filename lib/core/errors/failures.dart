import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class InvalidUserFailure implements Failure {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => false;
}

class UnexpectedFailure implements Failure {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => false;
}
