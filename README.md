# Hi Bob App Repository

Built with Flutter

## TEST RUN COMMANDS

### Run Web
```
flutter run -d chrome -t ./lib/main_development.dart --web-hostname localhost --web-port 5050
```

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
flutter pub run build_runner build --delete-conflicting-outputs && flutter pub get
```

#### CLEAN 
```
flutter clean && cd ios && pod install --repo-update && cd ..
```

### Deploy Web
```
flutter build web -t ./lib/main_production.dart && firebase deploy
```