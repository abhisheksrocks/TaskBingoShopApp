import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_nav_state.dart';

class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavCubit() : super(const BottomNavState(index: 0));

  void changeIndex({required double newIndex}) {
    emit(BottomNavState(index: newIndex));
  }
}
