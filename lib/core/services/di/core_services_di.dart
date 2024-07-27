import 'package:get_it/get_it.dart';
import 'package:hi_bob/core/services/permissions/data/permissions_service_impl.dart';
import 'package:hi_bob/core/services/permissions/domain/models/permissions_service.dart';
import 'package:hi_bob/core/services/photo/data/photo_services_impl.dart';
import 'package:hi_bob/core/services/photo/domain/photo_services.dart';

void init() {
  final GetIt di = GetIt.instance;
  di.registerLazySingleton<PermissionsService>(
    PermissionsServiceImpl.new,
  );
  di.registerLazySingleton<PhotoServices>(
    () => PhotoServicesImpl(di()),
  );
}
