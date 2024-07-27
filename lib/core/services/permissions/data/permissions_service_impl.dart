import 'package:hi_bob/core/services/permissions/domain/models/permission_types.dart';
import 'package:hi_bob/core/services/permissions/domain/models/permissions_service.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsServiceImpl implements PermissionsService {
  @override
  Future<bool> requestPermissionIfNotGranted(
    PermissionTypes forPermission,
  ) async {
    try {
      switch (forPermission) {
        case PermissionTypes.gallery:
          return _requestGalleryPermissions();
      }
    } on Exception catch (_, __) {
      rethrow;
    }
  }

  Future<bool> _requestGalleryPermissions() async {
    PermissionStatus status = await Permission.photos.status;
    if (status.isGranted) {
      return true;
    }
    status = await Permission.storage.status;
    if (status.isGranted) {
      return true;
    }
    status = await Permission.photos.request();
    if (status.isGranted) {
      return true;
    }
    status = await Permission.storage.request();
    return status.isGranted;
  }
}
