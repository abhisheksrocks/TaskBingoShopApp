import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/order_info.dart';
import '../../../domain/repositories/api.dart';

part 'orders_page_state.dart';

class OrdersPageCubit extends Cubit<OrdersPageState> {
  final Api api;
  OrdersPageCubit({
    required this.api,
  }) : super(OrdersPageLoading()) {
    startFetching();
  }

  void startFetching() async {
    final response = await api.getAllOrders();
    response.fold(
      (failure) => emit(OrdersPageError()),
      (listOfOrderInfo) => emit(OrdersPageLoaded(orderInfo: listOfOrderInfo)),
    );
  }
}
