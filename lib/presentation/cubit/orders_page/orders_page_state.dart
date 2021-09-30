part of 'orders_page_cubit.dart';

abstract class OrdersPageState extends Equatable {
  const OrdersPageState();

  @override
  List<Object> get props => [];
}

class OrdersPageLoading extends OrdersPageState {}

class OrdersPageError extends OrdersPageState {}

class OrdersPageLoaded extends OrdersPageState {
  final List<OrderInfo> orderInfo;
  const OrdersPageLoaded({
    required this.orderInfo,
  });

  @override
  List<Object> get props => [orderInfo];
}
