import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String uid;
  final String name;
  const User({
    required this.uid,
    required this.name,
  });

  @override
  List<Object?> get props => [uid, name];
}
