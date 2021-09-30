import 'package:bingo_shop/core/constants/app_theme.dart';
import 'package:bingo_shop/core/constants/enums.dart';
import 'package:bingo_shop/domain/entities/item_info.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:bingo_shop/domain/entities/order_info.dart';

class OrderDetailsScreenParams {
  final OrderInfo orderInfo;
  OrderDetailsScreenParams({
    required this.orderInfo,
  });
}

class OrderDetailsScreen extends StatelessWidget {
  final OrderDetailsScreenParams orderDetailsScreenParams;
  const OrderDetailsScreen(
    this.orderDetailsScreenParams, {
    Key? key,
  }) : super(key: key);

  String paymentMethodText(PaymentMethod paymentMethod) {
    switch (paymentMethod) {
      case PaymentMethod.cod:
        return 'COD (Cash On Delivery)';
      case PaymentMethod.onlinePayment:
        return 'Online Payment';
    }
  }

  Widget paidOrNotWidget(bool isPaid) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: (isPaid ? AppTheme.colorGreen : AppTheme.pureBlack),
        ),
        borderRadius: BorderRadius.circular(4),
        color: (isPaid ? AppTheme.colorGreen : AppTheme.pureBlack)
            .withOpacity(0.1),
      ),
      child: Text(
        isPaid ? 'Received' : 'Not Paid',
        style: TextStyle(
          color: (isPaid ? AppTheme.colorGreen : AppTheme.pureBlack),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: AppTheme.pureWhite,
        ),
        centerTitle: true,
        title: Text(
          'ORDER NO - ${orderDetailsScreenParams.orderInfo.orderNumber}',
          style: const TextStyle(
            color: AppTheme.pureWhite,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Builder(
          builder: (context) {
            double totalPrice = 0;
            List<Widget> listOfWidgets = [];
            List<ItemInfo> referenceItems =
                List.from(orderDetailsScreenParams.orderInfo.itemOrdered);
            referenceItems.sort((a, b) => a.itemName.compareTo(b.itemName));
            for (int index = 0; index < referenceItems.length; index++) {
              final item = referenceItems[index];
              int totalItems = 1;
              totalPrice += item.itemPrice;
              for (int j = index + 1; j < referenceItems.length; j++) {
                final jItem = referenceItems[j];
                if (jItem.itemId == item.itemId) {
                  totalItems += 1;
                  totalPrice += item.itemPrice;
                  referenceItems.removeAt(j);
                } else {
                  break;
                }
              }
              listOfWidgets.add(Container(
                color: AppTheme.pureWhite,
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.check_box_outlined,
                        color: Theme.of(context).primaryColor.withOpacity(0.5),
                      ),
                    ),
                    Container(
                      height: 80,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Theme.of(context)
                              .primaryFontColor
                              .withOpacity(0.3),
                        ),
                      ),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: CachedNetworkImage(
                          imageUrl: item.imageURL.toString(),
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  CircularProgressIndicator(
                                      value: downloadProgress.progress),
                          errorWidget: (context, url, error) {
                            return const Icon(Icons.error);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item.itemName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                height: 20,
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).backgroundColor,
                                    ),
                                    child: Center(
                                        child: Text(
                                      '$totalItems',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )),
                                  ),
                                ),
                              ),
                              Text(
                                ' X Rs ${item.itemPrice}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                'Rs ${item.itemPrice * totalItems}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ));
            }

            listOfWidgets.add(
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Selected Item',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Rs. $totalPrice',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Shipping Fee',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Rs. ${orderDetailsScreenParams.orderInfo.shippingFee}',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Subtotal',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Rs. ${totalPrice + orderDetailsScreenParams.orderInfo.shippingFee}',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      'Customer Details',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        const Expanded(
                          flex: 25,
                          child: Text(
                            'Name:',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 75,
                          child: Text(
                            orderDetailsScreenParams
                                .orderInfo.deliveryDetails.customerName,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        const Expanded(
                          flex: 25,
                          child: Text(
                            'Mobile No:',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 75,
                          child: Text(
                            "+${orderDetailsScreenParams.orderInfo.deliveryDetails.mobileNumberExtension} ${orderDetailsScreenParams.orderInfo.deliveryDetails.mobileNumber}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        const Expanded(
                          flex: 25,
                          child: Text(
                            'Address:',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 75,
                          child: Text(
                            orderDetailsScreenParams
                                .orderInfo.deliveryDetails.address,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        const Expanded(
                          flex: 25,
                          child: Text(
                            'Payment:',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 75,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                paymentMethodText(
                                  orderDetailsScreenParams
                                      .orderInfo.deliveryDetails.paymentMethod,
                                ),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              paidOrNotWidget(
                                  orderDetailsScreenParams.orderInfo.paid)
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary,
                              primary: Colors.transparent,
                            ),
                            child: const Text(
                              'Reject Order',
                              style: TextStyle(
                                color: AppTheme.pureWhite,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              primary: Colors.transparent,
                            ),
                            child: const Text(
                              'Accept Order',
                              style: TextStyle(
                                color: AppTheme.pureWhite,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );

            // listOfWidgets.add(

            // );
            // listOfWidgets.add();
            // listOfWidgets.add(

            // );
            // listOfWidgets.add(
            //   // const Divider(),
            // );
            // listOfWidgets.add(

            // );
            // listOfWidgets.add(
            //   Row(
            //     children: [
            //       const Text('Name:'),
            //       Text(orderDetailsScreenParams
            //           .orderInfo.deliveryDetails.customerName),
            //     ],
            //   ),
            // );
            // listOfWidgets.add(
            //   Row(
            //     children: [
            //       const Text('Mobile No:'),
            //       Text(
            //           "+${orderDetailsScreenParams.orderInfo.deliveryDetails.mobileNumberExtension} ${orderDetailsScreenParams.orderInfo.deliveryDetails.mobileNumber}"),
            //     ],
            //   ),
            // );
            // listOfWidgets.add(
            //   Row(
            //     children: [
            //       const Text('Address:'),
            //       Text(orderDetailsScreenParams
            //           .orderInfo.deliveryDetails.address),
            //     ],
            //   ),
            // );
            // listOfWidgets.add(
            //   Row(
            //     children: [
            //       const Text('Payment:'),
            //       Text(orderDetailsScreenParams
            //           .orderInfo.deliveryDetails.paymentMethod
            //           .toString()),
            //     ],
            //   ),
            // );
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: listOfWidgets,
            );
          },
        ),
      ),
    );
  }
}
