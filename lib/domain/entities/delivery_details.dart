import '../../core/constants/enums.dart';

class DeliveryDetails {
  final String customerName;
  final String mobileNumberExtension;
  final String mobileNumber;
  final String address;
  final PaymentMethod paymentMethod;

  DeliveryDetails({
    required this.customerName,
    required this.mobileNumberExtension,
    required this.mobileNumber,
    required this.address,
    required this.paymentMethod,
  });
}
