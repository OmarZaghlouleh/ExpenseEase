import 'package:budgeting_app/core/base_usecase.dart';
import 'package:budgeting_app/plans/domain/repository/base_plans_repository.dart';

class SetCreatedPlanStatus extends BaseUsecase<Future<void>, bool> {
  final BasePlansRepository basePlansRepository;

  SetCreatedPlanStatus(this.basePlansRepository);
  @override
  Future<void> call(p) async {
    await basePlansRepository.setCreatedPlanStatus(status: p);
  }
}
