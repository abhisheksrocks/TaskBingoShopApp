import 'presentation/cubit/orders_page/orders_page_cubit.dart';
import 'package:get_it/get_it.dart';

import 'data/data_sources/fake_api.dart';
import 'data/data_sources/real_api.dart';
import 'domain/repositories/api.dart';
import 'presentation/bloc/login_bloc.dart';
import 'presentation/cubit/bottom_nav/bottom_nav_cubit.dart';

final GetIt locator = GetIt.instance;

// ignore: constant_identifier_names
const bool USE_FAKE_DATA = true;

void injector() {
  locator.registerFactory<LoginBloc>(() => LoginBloc(api: locator()));

  locator
      .registerFactory<OrdersPageCubit>(() => OrdersPageCubit(api: locator()));

  locator.registerLazySingleton<Api>(
    () => USE_FAKE_DATA ? FakeApi() : RealApi(),
  );

  locator.registerFactory<BottomNavCubit>(() => BottomNavCubit());
}
