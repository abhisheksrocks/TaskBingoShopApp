import 'package:equatable/equatable.dart';

class ItemInfo extends Equatable {
  final String itemId;
  final String itemName;
  final double itemPrice;
  final Uri imageURL;

  const ItemInfo({
    required this.itemId,
    required this.itemName,
    required this.itemPrice,
    required this.imageURL,
  });
  @override
  List<Object?> get props => [
        itemId,
        itemName,
        itemPrice,
        imageURL.toString(),
      ];
}
