import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../../domain/entities/order_info.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/api.dart';

class RealApi implements Api {
  @override
  Future<Either<Failure, List<OrderInfo>>> getAllOrders() {
    // TODO: implement getAllOrders
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> login(
      {required String username, required String password}) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
