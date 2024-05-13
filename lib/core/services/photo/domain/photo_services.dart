import 'dart:io';

abstract class PhotoServices {
  Future<File?> pickGalleryPhoto();
}
