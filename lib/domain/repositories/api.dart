import '../../core/errors/failures.dart';
import '../entities/order_info.dart';
import '../entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class Api {
  Future<Either<Failure, User>> login(
      {required String username, required String password});

  Future<Either<Failure, bool>> logout();

  Future<Either<Failure, List<OrderInfo>>> getAllOrders();
}
