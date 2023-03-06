import 'package:budgeting_app/plans/data/data_source/local_data_source.dart';
import 'package:budgeting_app/plans/data/repository/plans_repository.dart';
import 'package:budgeting_app/plans/domain/repository/base_plans_repository.dart';
import 'package:budgeting_app/plans/domain/usecases/create_business_plan_usecase.dart';
import 'package:budgeting_app/plans/domain/usecases/create_employee_plan_usecase.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class ServiceLocator {
  static Future<void> init() async {
    // getIt.registerLazySingletonAsync(
    //     () async => await SharedPreferences.getInstance());

    getIt.registerLazySingleton<BaseLocalDataSource>(() => LocalDataSource());

    getIt.registerLazySingleton<BasePlansRepository>(
        () => PlansRepository(getIt()));

    getIt.registerLazySingleton<CreateEmployeePlanUsecase>(
        () => CreateEmployeePlanUsecase(getIt()));
    getIt.registerLazySingleton<CreateBusinessPlanUsecase>(
        () => CreateBusinessPlanUsecase(getIt()));
  }
}
