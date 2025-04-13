# testapp

## Set Up locally
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

## Set Up Your Phone
- Go in settings
- Additional Settings
- Developer options
- Active Developer Options Switch
- And scroll down to the section debugging and to active USB debugging

## Run the app
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
