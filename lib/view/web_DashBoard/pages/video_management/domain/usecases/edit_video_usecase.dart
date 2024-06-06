import 'package:dartz/dartz.dart';
import 'package:vidyaveechi_website/view/web_DashBoard/errors/failures.dart';
import 'package:vidyaveechi_website/view/web_DashBoard/pages/video_management/domain/entity/video_entity.dart';
import 'package:vidyaveechi_website/view/web_DashBoard/pages/video_management/domain/repository/video_repository.dart';
import 'package:vidyaveechi_website/view/web_DashBoard/pages/video_management/usecase/usecase.dart';


class EditVideoUseCase extends UseCase<Unit, VideoEntity> {
  final VideoRepository repo;

  EditVideoUseCase({
    required this.repo,
  });
  @override
  Future<Either<Failure, Unit>> call(VideoEntity params) async {
    return await repo.edit(params);
  }
}
