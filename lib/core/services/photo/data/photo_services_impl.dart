import 'dart:io';

import 'package:hi_bob/core/services/permissions/domain/models/permission_types.dart';
import 'package:hi_bob/core/services/permissions/domain/models/permissions_service.dart';
import 'package:hi_bob/core/services/photo/domain/photo_services.dart';
import 'package:image_picker/image_picker.dart';

class PhotoServicesImpl implements PhotoServices {
  final PermissionsService _permissionsService;

  PhotoServicesImpl(this._permissionsService);

  @override
  Future<File?> pickGalleryPhoto() async {
    try {
      final isGranted = await _permissionsService.requestPermissionIfNotGranted(
        PermissionTypes.gallery,
      );
      if (!isGranted) {
        return null; // permissions denied
      }
      final ImagePicker picker = ImagePicker();
      final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
      if (photo == null) {
        return null; // no photo was picked
      }
      final File photoFile = File(photo.path);
      return photoFile;
    } on Exception catch (_, __) {
      rethrow;
    }
  }
}
