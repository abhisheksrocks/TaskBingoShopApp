import 'package:bingo_shop/core/constants/enums.dart';
import 'package:bingo_shop/domain/entities/item_info.dart';
import 'package:bingo_shop/domain/entities/order_info.dart';
import 'package:bingo_shop/presentation/router/app_router.dart';
import 'package:bingo_shop/presentation/screens/order_screen/order_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/constants/app_theme.dart';
import '../../../../../../dependency_injection.dart';
import '../../../../../cubit/orders_page/orders_page_cubit.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);

  double totalAmountWidget(
    BuildContext context, {
    required List<ItemInfo> itemsInfo,
    required double shippingFee,
  }) {
    double total = 0;
    for (var item in itemsInfo) {
      total += item.itemPrice;
    }
    total += shippingFee;
    return total;
  }

  Widget paidInfoWidget(BuildContext context, {required bool paid}) {
    if (paid) {
      return const Text(
        'PAID',
        style: TextStyle(
          color: AppTheme.colorGreen,
          fontWeight: FontWeight.w600,
        ),
      );
    }
    return const Text(
      'NOT PAID',
      style: TextStyle(
        color: AppTheme.colorYellow,
        fontWeight: FontWeight.w600,
      ),
    );
    // switch (paymentMethod) {
    //   case PaymentMethod.yetToPay:
    //     return const Text('YET TO PAID');
    //   default:
    //     return const Text(
    //       'PAID',
    //       style: TextStyle(
    //         color: AppTheme.colorGreen,
    //       ),
    //     );
    // }
  }

  Widget deliveryStatusWidget(
    BuildContext context, {
    required DeliveryStatus deliveryStatus,
  }) {
    switch (deliveryStatus) {
      case DeliveryStatus.accepted:
        return Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).primaryColor,
              ),
              height: 10,
              width: 24,
              // child: AspectRatio(
              //   aspectRatio: 1,
              //   child: Container(
              //     height: 10,
              //     decoration: BoxDecoration(),
              //   ),
              // ),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              'Accepted',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        );
      case DeliveryStatus.pending:
        return Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.colorYellow,
              ),
              height: 10,
              width: 24,
              // child: AspectRatio(
              //   aspectRatio: 1,
              //   child: Container(
              //     height: 10,
              //     decoration: BoxDecoration(),
              //   ),
              // ),
            ),
            const SizedBox(
              width: 8,
            ),
            const Text(
              'Pending',
              style: TextStyle(
                color: AppTheme.colorYellow,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        );
      case DeliveryStatus.declined:
        return Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.pureBlack,
              ),
              height: 10,
              width: 24,
              // child: AspectRatio(
              //   aspectRatio: 1,
              //   child: Container(
              //     height: 10,
              //     decoration: BoxDecoration(),
              //   ),
              // ),
            ),
            const SizedBox(
              width: 8,
            ),
            const Text(
              'Declined',
              style: TextStyle(
                color: AppTheme.pureBlack,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        );
      case DeliveryStatus.shipped:
        return Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.secondary,
              ),
              height: 10,
              width: 24,
              // child: AspectRatio(
              //   aspectRatio: 1,
              //   child: Container(
              //     height: 10,
              //     decoration: BoxDecoration(),
              //   ),
              // ),
            ),
            // const SizedBox(
            //   width: 8,
            // ),
            Text(
              'Shipped',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersPageCubit, OrdersPageState>(
      builder: (context, state) {
        if (state is OrdersPageLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is OrdersPageLoaded) {
          List<Widget> _orderList = [];
          for (var i = 0; i < state.orderInfo.length; i++) {
            _orderList.add(
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                child: Material(
                  color: AppTheme.pureWhite,
                  borderRadius: BorderRadius.circular(12),
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image.network(
                        //   state.orderInfo[i].itemOrdered[0].imageURL.toString(),
                        // ),
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: AppTheme.pureBlack.withOpacity(0.1),
                              )),
                          child: SizedBox(
                            height: 50,
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: CachedNetworkImage(
                                imageUrl: state
                                    .orderInfo[i].itemOrdered[0].imageURL
                                    .toString(),
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
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Order No. - ${state.orderInfo[i].orderNumber}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'Rs. ${totalAmountWidget(
                                      context,
                                      itemsInfo: state.orderInfo[i].itemOrdered,
                                      shippingFee:
                                          state.orderInfo[i].shippingFee,
                                    )}',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              // Text('${state.orderInfo[i].orderTime}'),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    DateFormat('dd/MM/yyyy      hh:mm a')
                                        .format(state.orderInfo[i].orderTime),
                                    style: TextStyle(
                                        color: AppTheme.pureBlack
                                            .withOpacity(0.3)),
                                  ),
                                  paidInfoWidget(
                                    context,
                                    paid: state.orderInfo[i].paid,
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  deliveryStatusWidget(
                                    context,
                                    deliveryStatus:
                                        state.orderInfo[i].deliveryStatus,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                        AppRouter.orderDetailsScreen,
                                        arguments: OrderDetailsScreenParams(
                                          orderInfo: state.orderInfo[i],
                                        ),
                                      );
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.1),
                                    ),
                                    child: Text(
                                      'Details',
                                      style: TextStyle(
                                        color:
                                            Theme.of(context).primaryFontColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return ListView(
            children: [
              Container(
                color: AppTheme.pureWhite,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            fillColor: Theme.of(context).backgroundColor,
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 2,
                              horizontal: 16,
                            ),
                            hintText: 'Order id or Name',
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                style: BorderStyle.none,
                              ),
                              // borderRadius: BorderRadius.circular(12),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.zero,
                                bottomRight: Radius.zero,
                                bottomLeft: Radius.circular(12),
                                topLeft: Radius.circular(12),
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              // borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                style: BorderStyle.none,
                              ),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.zero,
                                bottomRight: Radius.zero,
                                bottomLeft: Radius.circular(12),
                                topLeft: Radius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ),
                      AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          color: Theme.of(context).backgroundColor,
                          child: Material(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(12),
                            child: InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(12),
                              child: const Icon(
                                Icons.search_outlined,
                                color: AppTheme.pureWhite,
                              ),
                              // child: Icon(Icons.menu),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 8,
                ),
                child: Row(
                  children: const [
                    Text('All Orders - 1543'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Center(
                          child: Text(
                            'All Times - 1543',
                            style: TextStyle(
                              color: AppTheme.pureWhite,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Text(
                            'Today - ${state.orderInfo.length}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Icon(
                      Icons.calendar_view_month,
                      size: 40,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
              ..._orderList,
              const SizedBox(
                height: 50,
              ),
            ],
          );
          // return ListView.builder(
          //   itemBuilder: (context, index) {
          //     if (index == 0) {
          //       return Container(
          //         color: AppTheme.pureWhite,
          //         padding: const EdgeInsets.symmetric(
          //           horizontal: 24,
          //           vertical: 12,
          //         ),
          //         child: IntrinsicHeight(
          //           child: Row(
          //             crossAxisAlignment: CrossAxisAlignment.stretch,
          //             children: [
          //               Expanded(
          //                 child: TextField(
          //                   decoration: InputDecoration(
          //                     fillColor: Theme.of(context).backgroundColor,
          //                     filled: true,
          //                     contentPadding: const EdgeInsets.symmetric(
          //                       vertical: 2,
          //                       horizontal: 16,
          //                     ),
          //                     hintText: 'Order id or Name',
          //                     focusedBorder: const OutlineInputBorder(
          //                       borderSide: BorderSide(
          //                         style: BorderStyle.none,
          //                       ),
          //                       // borderRadius: BorderRadius.circular(12),
          //                       borderRadius: BorderRadius.only(
          //                         topRight: Radius.zero,
          //                         bottomRight: Radius.zero,
          //                         bottomLeft: Radius.circular(12),
          //                         topLeft: Radius.circular(12),
          //                       ),
          //                     ),
          //                     enabledBorder: const OutlineInputBorder(
          //                       // borderRadius: BorderRadius.circular(12),
          //                       borderSide: BorderSide(
          //                         style: BorderStyle.none,
          //                       ),
          //                       borderRadius: BorderRadius.only(
          //                         topRight: Radius.zero,
          //                         bottomRight: Radius.zero,
          //                         bottomLeft: Radius.circular(12),
          //                         topLeft: Radius.circular(12),
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //               AspectRatio(
          //                 aspectRatio: 1,
          //                 child: Container(
          //                   color: Theme.of(context).backgroundColor,
          //                   child: Material(
          //                     color: Theme.of(context).primaryColor,
          //                     borderRadius: BorderRadius.circular(12),
          //                     child: InkWell(
          //                       onTap: () {},
          //                       borderRadius: BorderRadius.circular(12),
          //                       child: const Icon(
          //                         Icons.search_outlined,
          //                         color: AppTheme.pureWhite,
          //                       ),
          //                       // child: Icon(Icons.menu),
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       );
          //     }
          //     return ListTile(
          //       title: Text(
          //           "OrderId: ${(state).orderInfo.elementAt(index - 1).orderNumber}"),
          //     );
          //   },
          //   itemCount: state.orderInfo.length + 1,
          // );
        }
        return const Center(
          child: Text("Error!"),
        );
      },
    );
    // return ListView.builder(
    //   itemBuilder: (context, index) {
    //     if (index == 0) {
    //       return Container(
    //         color: AppTheme.pureWhite,
    //         padding: const EdgeInsets.symmetric(
    //           horizontal: 24,
    //           vertical: 12,
    //         ),
    //         child: IntrinsicHeight(
    //           child: Row(
    //             crossAxisAlignment: CrossAxisAlignment.stretch,
    //             children: [
    //               Expanded(
    //                 child: TextField(
    //                   decoration: InputDecoration(
    //                     fillColor: Theme.of(context).backgroundColor,
    //                     filled: true,
    //                     contentPadding: const EdgeInsets.symmetric(
    //                       vertical: 2,
    //                       horizontal: 16,
    //                     ),
    //                     hintText: 'Order id or Name',
    //                     focusedBorder: const OutlineInputBorder(
    //                       borderSide: BorderSide(
    //                         style: BorderStyle.none,
    //                       ),
    //                       // borderRadius: BorderRadius.circular(12),
    //                       borderRadius: BorderRadius.only(
    //                         topRight: Radius.zero,
    //                         bottomRight: Radius.zero,
    //                         bottomLeft: Radius.circular(12),
    //                         topLeft: Radius.circular(12),
    //                       ),
    //                     ),
    //                     enabledBorder: const OutlineInputBorder(
    //                       // borderRadius: BorderRadius.circular(12),
    //                       borderSide: BorderSide(
    //                         style: BorderStyle.none,
    //                       ),
    //                       borderRadius: BorderRadius.only(
    //                         topRight: Radius.zero,
    //                         bottomRight: Radius.zero,
    //                         bottomLeft: Radius.circular(12),
    //                         topLeft: Radius.circular(12),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               AspectRatio(
    //                 aspectRatio: 1,
    //                 child: Container(
    //                   color: Theme.of(context).backgroundColor,
    //                   child: Material(
    //                     color: Theme.of(context).primaryColor,
    //                     borderRadius: BorderRadius.circular(12),
    //                     child: InkWell(
    //                       onTap: () {},
    //                       borderRadius: BorderRadius.circular(12),
    //                       child: const Icon(
    //                         Icons.search_outlined,
    //                         color: AppTheme.pureWhite,
    //                       ),
    //                       // child: Icon(Icons.menu),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       );
    //     }
    //     return ListTile(
    //       title: Text("$index item"),
    //     );
    //   },
    //   itemCount: 20,
    // );
  }
}
