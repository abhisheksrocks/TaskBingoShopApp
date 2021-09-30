part of 'bottom_nav_cubit.dart';

class BottomNavState extends Equatable {
  final double index;

  const BottomNavState({required this.index});

  @override
  List<Object?> get props => [index];

  @override
  bool get stringify => false;
}
