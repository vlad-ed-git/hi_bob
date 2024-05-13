# Hi Bob App Repository

Built with Flutter

## TEST RUN COMMANDS

### Run Development Flavor
```
flutter run -t ./lib/main_development.dart --flavor=development
```

### Run Production Flavor
``` 
flutter run -t ./lib/main_production.dart --flavor=production
```

## BUILD COMMANDS

### Development Archive
```
flutter build ipa -t ./lib/main_development.dart --flavor=development && cp -r ./build/ios/archive/Runner.xcarchive ./builds/development.xcarchive
```
### Development APK
```
flutter build apk --target-platform android-arm,android-arm64 -t ./lib/main_development.dart --flavor=development && cp ./build/app/outputs/flutter-apk/app-development-release.apk ./builds/development.apk 
```

### Production Archive
```
flutter build ipa -t ./lib/main_production.dart --flavor=production && cp -r ./build/ios/archive/Runner.xcarchive ./builds/production.xcarchive
```

### Production APK
```
flutter build apk --release --target-platform android-arm,android-arm64 -t ./lib/main_production.dart --flavor=production && cp ./build/app/outputs/flutter-apk/app-production-release.apk ./builds/production.apk 
```

#### CODE GENERATION
```
flutter pub run build_runner build --delete-conflicting-outputs
```

#### CLEAN 
```
flutter clean && cd ios && pod install --repo-update && cd ..
```