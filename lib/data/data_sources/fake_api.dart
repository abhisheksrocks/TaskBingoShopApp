import '../../core/constants/enums.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/delivery_details.dart';
import '../../domain/entities/item_info.dart';
import '../../domain/entities/order_info.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/api.dart';
import 'package:dartz/dartz.dart';

class FakeData {
  static List<DeliveryDetails> listOfDeliveryDetails = [
    DeliveryDetails(
      customerName: 'Monica',
      mobileNumberExtension: '91',
      mobileNumber: '1234568790',
      address: 'South Delhi',
      paymentMethod: PaymentMethod.onlinePayment,
    ),
    DeliveryDetails(
      customerName: 'Chandler',
      mobileNumberExtension: '91',
      mobileNumber: '1234568791',
      address: 'South Delhi',
      paymentMethod: PaymentMethod.cod,
    ),
    DeliveryDetails(
      customerName: 'Ross',
      mobileNumberExtension: '91',
      mobileNumber: '1234568792',
      address: 'South Delhi',
      paymentMethod: PaymentMethod.onlinePayment,
    ),
    DeliveryDetails(
      customerName: 'Rachel',
      mobileNumberExtension: '91',
      mobileNumber: '1234568793',
      address: 'South Delhi',
      paymentMethod: PaymentMethod.cod,
    ),
    DeliveryDetails(
      customerName: 'Phoebe',
      mobileNumberExtension: '91',
      mobileNumber: '1234568794',
      address: 'South Delhi',
      paymentMethod: PaymentMethod.cod,
    ),
    DeliveryDetails(
      customerName: 'Joey',
      mobileNumberExtension: '91',
      mobileNumber: '1234568795',
      address: 'South Delhi',
      paymentMethod: PaymentMethod.cod,
    ),
  ];

  static List<ItemInfo> listOfItems = [
    ItemInfo(
      itemId: '1',
      itemName: 'Fortune Rozana Basmati Rice',
      itemPrice: 325.00,
      imageURL: Uri.parse(
          'https://cdn1.dealsmagnet.com/images/159CM2TT/2020/September/19/large/fortune-rozana-basmati-rice-5kg.jpg'),
    ),
    ItemInfo(
      itemId: '2',
      itemName: 'Unibic Cookies Assorted',
      itemPrice: 145.00,
      imageURL: Uri.parse(
          'https://www.goodsdelivery.co.in/wp-content/uploads/2020/07/unibic-cookies-assorted-pack.jpg'),
    ),
    ItemInfo(
      itemId: '3',
      itemName: 'Maggi 2 minute instant noodles masala',
      itemPrice: 68.00,
      imageURL: Uri.parse(
          'https://www.goodsdelivery.co.in/wp-content/uploads/2020/08/maggi-6-pack420g.jpg'),
    ),
    ItemInfo(
      itemId: '4',
      itemName: 'Cadbury Bournvita Health Drink',
      itemPrice: 243.00,
      imageURL: Uri.parse(
          'https://cdn1.dealsmagnet.com/images/16m3tgSH/2021/August/16/large/cadbury-bournvita-health-drink-750-gm-refill-pack.jpg'),
    ),
    ItemInfo(
      itemId: '5',
      itemName: 'Tide Plus Detergent Powder',
      itemPrice: 50.00,
      imageURL: Uri.parse(
          'https://www.goodsdelivery.co.in/wp-content/uploads/2020/08/tide-plus-detergent-washing-powder-extra-power-lemon500g.jpg'),
    ),
    ItemInfo(
      itemId: '6',
      itemName: 'Dettol Antiseptic Liquid',
      itemPrice: 377.00,
      imageURL: Uri.parse(
          'https://i1.wp.com/shimantosupershop.com/wp-content/uploads/2021/01/Dettol-Antiseptic-Liquid-500ml.jpg'),
    ),
  ];
}

class FakeApi implements Api {
  static User? currentUser;

  static const Duration _delay = Duration(seconds: 1);

  @override
  Future<Either<Failure, User>> login({
    required String username,
    required String password,
  }) async {
    await Future.delayed(_delay);
    // if (username.toLowerCase() == 'abcd' && password == 'abcd') {
    if (username.toLowerCase() == 'hello@api.com' &&
        password == 'NotsoSecure1#') {
      currentUser = const User(uid: '8055', name: 'Abhishek');
      return Right(currentUser!);
    }
    return Left(InvalidUserFailure());
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    await Future.delayed(_delay);
    if (currentUser == null) {
      return Left(UnexpectedFailure());
    } else {
      currentUser = null;
      return const Right(true);
    }
  }

  @override
  Future<Either<Failure, List<OrderInfo>>> getAllOrders() async {
    await Future.delayed(_delay);
    if (currentUser != null) {
      return Right([
        OrderInfo(
          deliveryDetails: FakeData.listOfDeliveryDetails[0],
          deliveryStatus: DeliveryStatus.shipped,
          itemOrdered: [
            FakeData.listOfItems[0],
            FakeData.listOfItems[1],
            FakeData.listOfItems[0],
          ],
          orderNumber: '134521',
          orderTime: DateTime(2021, 11, 8, 17, 1),
          shippingFee: 85,
          paid: true,
        ),
        OrderInfo(
          deliveryDetails: FakeData.listOfDeliveryDetails[2],
          deliveryStatus: DeliveryStatus.pending,
          itemOrdered: [
            FakeData.listOfItems[2],
            FakeData.listOfItems[3],
            FakeData.listOfItems[4],
            FakeData.listOfItems[5],
          ],
          orderNumber: '134522',
          orderTime: DateTime(2021, 11, 8, 17, 1),
          shippingFee: 51,
          paid: true,
        ),
        OrderInfo(
          deliveryDetails: FakeData.listOfDeliveryDetails[1],
          deliveryStatus: DeliveryStatus.accepted,
          itemOrdered: [
            FakeData.listOfItems[3],
            FakeData.listOfItems[3],
            FakeData.listOfItems[3],
          ],
          orderNumber: '134523',
          orderTime: DateTime(2021, 11, 8, 17, 1),
          shippingFee: 20,
          paid: true,
        ),
        OrderInfo(
          deliveryDetails: FakeData.listOfDeliveryDetails[4],
          deliveryStatus: DeliveryStatus.declined,
          itemOrdered: [
            FakeData.listOfItems[4],
            FakeData.listOfItems[3],
            FakeData.listOfItems[5],
          ],
          orderNumber: '134524',
          orderTime: DateTime(2021, 11, 8, 17, 1),
          shippingFee: 62,
          paid: false,
        ),
        OrderInfo(
          deliveryDetails: FakeData.listOfDeliveryDetails[3],
          deliveryStatus: DeliveryStatus.shipped,
          itemOrdered: [
            FakeData.listOfItems[1],
            FakeData.listOfItems[5],
          ],
          orderNumber: '134525',
          orderTime: DateTime(2021, 11, 8, 17, 1),
          shippingFee: 42,
          paid: true,
        ),
      ]);
    }
    return Left(UnexpectedFailure());
  }
}
