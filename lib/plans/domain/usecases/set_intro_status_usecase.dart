import 'package:budgeting_app/core/base_usecase.dart';
import 'package:budgeting_app/plans/domain/repository/base_plans_repository.dart';

class SetIntroStatusUseCase extends BaseUsecase<Future<void>, bool> {
  final BasePlansRepository basePlansRepository;

  SetIntroStatusUseCase(this.basePlansRepository);
  @override
  Future<void> call(p) async {
    await basePlansRepository.setIntroStatus(status: p);
  }
}
