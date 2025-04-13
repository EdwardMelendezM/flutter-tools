# testapp

## Set Up locally

### Install tools
- Install Flutter
- Install Android studio
- Install Visual Code
- Make sure to add environment variables
  ```
  PATH=C:\Users\edu\dev\flutter\bin
  JAVA_HOME=C:\Program Files\Android\Android Studio\jbr
  ```
- Additional installation required
  - Download Command line tools only [Click here](https://developer.android.com/studio#cmdline-tools) and setup
  - Add Command line tools in this folder C:\Users\your_user\AppData\Local\Android\Sdk

### Set Up Your Phone
- Go in settings
- Additional Settings
- Developer options
- Active Developer Options Switch
- And scroll down to the section debugging and to active USB debugging

### Run the app
- Version
```
flutter --version
```
- Install dependecies
```
flutter pub get
```
- Check devices
```
flutter devices
# Found 4 connected devices:
#   Redmi Note 10 (mobile) • 14ff4efb • android-arm64  • Android 11 (API 30)
#   Windows (desktop)     • windows  • windows-x64    • Microsoft Windows [Version 10.0.19045.5737]
#   Chrome (web)          • chrome   • web-javascript • Google Chrome 135.0.7049.85
#   Edge (web)            • edge     • web-javascript • Microsoft Edge 135.0.3179.54
```
- Run the app (Make sure of having Android Studio and your phone connected)
```
flutter run
```

## Generate APK
### Android
- Generate apk without sign
```
flutter build apk --debug
```
- Generate release without sign
```
flutter build apk --release --no-shrink
```
- Genereate AAB without sign
```
flutter build appbundle --release
```
- For production we need to follow the next steps
  - Create new key
  ```
  keytool -genkey -v -keystore ~/my-release-key.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias my-key-alias
  ```
  - Move keystore to flutter project
  ```
  mkdir android/keystore
  mv ~/my-release-key.jks android/keystore/
  ```
  - Configure key.properties
  ```
  #android/key.properties
  storePassword=tu_contraseña_del_keystore
  keyPassword=tu_contraseña_del_alias
  keyAlias=my-key-alias
  storeFile=keystore/my-release-key.jks
  ```
  - Configure build.gradle
  ```
  android {
    ...
    signingConfigs {
        release {
            if (project.hasProperty('keyProperties')) {
                keyAlias keystoreProperties['keyAlias']
                keyPassword keystoreProperties['keyPassword']
                storeFile file(keystoreProperties['storeFile'])
                storePassword keystoreProperties['storePassword']
            }
        }
    }

    buildTypes {
        release {
            signingConfig signingConfigs.release
            minifyEnabled true
            shrinkResources true
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }
  } 
  ```
  Add this above
  ```
  def keystorePropertiesFile = rootProject.file("key.properties")
  def keystoreProperties = new Properties()
  keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
  ```
  - Generate signed APK
  ```
  flutter clean
  flutter pub get
  flutter build apk --release
  ```
  - Verify APK
  ```
  apksigner verify build/app/outputs/flutter-apk/app-release.apk
  ```

### iOS
- Generate with Xcode and macOS
```
flutter build ios --debug
```
- For production we need to follow the next steps
  - Build the app release mode
  ```
  flutter build ios --release
  ```
  - Open Xcode
  ```
  open ios/Runner.xcworkspace
  ```
  - Select Runner  "Any iOS Device (arm64)".
  - In this part you can deploy the app directly to TestFlight or App Store