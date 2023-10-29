import 'package:budgeting_app/home/data/data_source/local_data_source.dart';
import 'package:budgeting_app/home/data/repository/home_repository.dart';
import 'package:budgeting_app/home/domain/repository/base_home_repository.dart';
import 'package:budgeting_app/home/domain/usecases/add_folder_usecase.dart';
import 'package:budgeting_app/home/domain/usecases/delete_folder_usecase.dart';
import 'package:budgeting_app/home/domain/usecases/edit_folder_usecase.dart';

import 'package:budgeting_app/home/domain/usecases/get_business_plan_details.usecase.dart';
import 'package:budgeting_app/home/domain/usecases/get_employee_plan_details_usecase.dart';
import 'package:budgeting_app/home/domain/usecases/get_expenses_usecase.dart';
import 'package:budgeting_app/home/domain/usecases/get_folders_usecase.dart';
import 'package:budgeting_app/plans/data/data_source/local_data_source.dart';
import 'package:budgeting_app/plans/data/repository/plans_repository.dart';
import 'package:budgeting_app/plans/domain/repository/base_plans_repository.dart';
import 'package:budgeting_app/plans/domain/usecases/create_business_plan_usecase.dart';
import 'package:budgeting_app/plans/domain/usecases/create_employee_plan_usecase.dart';
import 'package:budgeting_app/plans/domain/usecases/set_created_plan_status_usecase.dart';
import 'package:budgeting_app/plans/domain/usecases/set_intro_status_usecase.dart';
import 'package:get_it/get_it.dart';

import 'package:budgeting_app/home/domain/usecases/add_expense_to_folder.dart';
import 'package:budgeting_app/home/domain/usecases/add_to_expense_usecase.dart';
import 'package:budgeting_app/home/domain/usecases/delete_expense_from_folder_usecase.dart';
import 'package:budgeting_app/home/domain/usecases/delete_expense_usecase.dart';
import 'package:budgeting_app/home/domain/usecases/edit_expense_usecase.dart';

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
    getIt.registerLazySingleton<GetExpensesUsecase>(
        () => GetExpensesUsecase(getIt()));
    getIt.registerLazySingleton<AddToExpenseUsecase>(
        () => AddToExpenseUsecase(getIt()));
    getIt.registerLazySingleton<AddExpensesFolderUsecase>(
        () => AddExpensesFolderUsecase(getIt()));
    getIt.registerLazySingleton<GetExpensesFolderUsecase>(
        () => GetExpensesFolderUsecase(getIt()));
    getIt.registerLazySingleton<AddExpenseToFolderUsecase>(
        () => AddExpenseToFolderUsecase(getIt()));
    getIt.registerLazySingleton<DeleteExpenseUsecase>(
        () => DeleteExpenseUsecase(getIt()));
    getIt.registerLazySingleton<RemoveExpenseFromFolderUsecase>(
        () => RemoveExpenseFromFolderUsecase(getIt()));
    getIt.registerLazySingleton<EditExpenseUsecase>(
        () => EditExpenseUsecase(getIt()));
    getIt.registerLazySingleton<DeleteFolderUsecase>(
        () => DeleteFolderUsecase(getIt()));
    getIt.registerLazySingleton<EditFolderUsecase>(
        () => EditFolderUsecase(getIt()));
  }
}
