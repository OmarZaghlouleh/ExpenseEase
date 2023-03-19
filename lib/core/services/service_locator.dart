import 'package:budgeting_app/home/data/data_source/local_data_source.dart';
import 'package:budgeting_app/home/data/repository/home_repository.dart';
import 'package:budgeting_app/home/domain/repository/base_home_repository.dart';
import 'package:budgeting_app/home/domain/usecases/get_business_plan_details.usecase.dart';
import 'package:budgeting_app/home/domain/usecases/get_employee_plan_details_usecase.dart';
import 'package:budgeting_app/plans/data/data_source/local_data_source.dart';
import 'package:budgeting_app/plans/data/repository/plans_repository.dart';
import 'package:budgeting_app/plans/domain/repository/base_plans_repository.dart';
import 'package:budgeting_app/plans/domain/usecases/create_business_plan_usecase.dart';
import 'package:budgeting_app/plans/domain/usecases/create_employee_plan_usecase.dart';
import 'package:budgeting_app/plans/domain/usecases/set_created_plan_status_usecase.dart';
import 'package:budgeting_app/plans/domain/usecases/set_intro_status_usecase.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class ServiceLocator {
  static Future<void> init() async {}

  static Future<void> initPlan() async {
    getIt.registerLazySingleton<BaseLocalDataSource>(() => LocalDataSource());

    getIt.registerLazySingleton<BasePlansRepository>(
        () => PlansRepository(getIt()));

    getIt.registerLazySingleton<CreateEmployeePlanUsecase>(
        () => CreateEmployeePlanUsecase(getIt()));
    getIt.registerLazySingleton<CreateBusinessPlanUsecase>(
        () => CreateBusinessPlanUsecase(getIt()));
    getIt.registerLazySingleton<SetCreatedPlanStatus>(
        () => SetCreatedPlanStatus(getIt()));
    getIt.registerLazySingleton<SetIntroStatusUseCase>(
        () => SetIntroStatusUseCase(getIt()));
  }

  static Future<void> initHome() async {
    getIt.registerLazySingleton<BaseHomeLocalDataSource>(
        () => HomeLocalDataSource());
    getIt.registerLazySingleton<BaseHomeRepository>(
        () => HomeRepository(getIt()));
    getIt.registerLazySingleton<GetBusinessPlanDetailsUsecase>(
        () => GetBusinessPlanDetailsUsecase(getIt()));
    getIt.registerLazySingleton<GetEmployeePlanDetailsUsecase>(
        () => GetEmployeePlanDetailsUsecase(getIt()));
  }
}
