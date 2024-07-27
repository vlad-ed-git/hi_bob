import 'package:flutter/material.dart';
import 'package:hi_bob/core/utils/extensions/context_ext.dart';

enum UserPreferencesErrors {
  unknownUserPreferencesErr;

  String uiFriendlyMessage(BuildContext context) {
    switch (this) {
      case UserPreferencesErrors.unknownUserPreferencesErr:
        return context.translated.unknownUserPreferencesErr;
    }
  }
}
