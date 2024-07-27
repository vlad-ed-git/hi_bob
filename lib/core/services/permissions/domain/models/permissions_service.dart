import 'package:hi_bob/core/services/permissions/domain/models/permission_types.dart';

abstract class PermissionsService {
  Future<bool> requestPermissionIfNotGranted(
    PermissionTypes forPermission,
  );
}
