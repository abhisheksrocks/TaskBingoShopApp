import 'package:equatable/equatable.dart';

import '../../core/constants/enums.dart';
import 'delivery_details.dart';
import 'item_info.dart';

class OrderInfo extends Equatable {
  final String orderNumber;
  final DateTime orderTime;
  final DeliveryStatus deliveryStatus;
  final List<ItemInfo> itemOrdered;
  final double shippingFee;
  final DeliveryDetails deliveryDetails;
  final bool paid;

  const OrderInfo({
    required this.orderNumber,
    required this.orderTime,
    required this.deliveryStatus,
    required this.itemOrdered,
    required this.shippingFee,
    required this.deliveryDetails,
    required this.paid,
  });

  @override
  List<Object?> get props => [
        orderNumber,
        orderTime,
        deliveryStatus,
        itemOrdered,
        shippingFee,
        deliveryDetails,
      ];
}
