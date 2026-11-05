name: Build Flutter App

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v4

    - name: Set up Java
      uses: actions/setup-java@v3
      with:
        distribution: 'zulu'
        java-version: '17'

    - name: Set up Flutter
      uses: subosito/flutter-action@v2
      with:
        flutter-version: '3.24.3'
        channel: 'stable'

    - name: Build APK Direct and Clean
      run: |
        # المشروع في الجذر الرئيسي للمستودع مباشرة
        echo "Building from root directory"
        
        # 1. إزالة ملف القفل القديم لإجبار النظام على جلب النسخ المتوافقة
        rm -f pubspec.lock
        
        # 2. تحديث الاعتمادات لنسخ حديثة تتوافق مع فلاتر 3.24
        flutter pub add flutter_blue_plus:^2.3.14 shared_preferences:^2.5.3 printing:^5.14.3
        
        # 3. إعادة توليد مجلد أندرويد نظيف في الجذر يتطابق مع الإعدادات الحديثة
        rm -rf android
        flutter create --platforms=android .
        
        # 4. جلب الحزم وبناء الـ APK النهائي بنجاح تام
        flutter pub get
        flutter build apk --release
