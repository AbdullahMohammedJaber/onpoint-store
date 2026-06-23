# onpoint-store

تطبيق متجر إلكتروني مبني باستخدام Flutter، يقدّم تجربة تسوق متكاملة تشمل عرض المنتجات، التصنيفات، السلة، المفضلة، الطلبات، الملف الشخصي، المصادقة، ودعم اللغات والثيمات. المشروع مجهز للعمل على Android و iOS مع أيقونة التطبيق واسم التطبيق `onpoint-store`.

## نظرة عامة

`onpoint-store` هو تطبيق E-Commerce موبايل منظم ببنية قابلة للتوسع. يعتمد على إدارة الحالة باستخدام Bloc/Cubit، ويفصل بين طبقات البيانات والنماذج والشاشات والخدمات. يحتوي المشروع حالياً على بيانات تجريبية للكتالوج لتسهيل التطوير والمعاينة، مع وجود طبقة API جاهزة للربط بخدمات المصادقة عبر Dio.

## الخصائص

- شاشة Splash كبداية للتطبيق.
- تسجيل الدخول وإنشاء حساب واستعادة كلمة المرور والتحقق بالكود.
- صفحة رئيسية تعرض البانرات، التصنيفات، المنتجات المخفضة، المنتجات الشائعة، والأكثر مبيعاً.
- عرض كل المنتجات مع البحث والتصفية حسب التصنيف والسعر.
- صفحة تفاصيل المنتج مع معلومات السعر، التقييم، المخزون، والوصف.
- سلة مشتريات مع إدارة المنتجات وحساب الإجمالي.
- صفحة مفضلة لحفظ المنتجات.
- صفحة طلبات المستخدم.
- صفحة ملف شخصي مع بيانات المستخدم.
- إعدادات التطبيق مع دعم تغيير الثيم.
- دعم الوضع الفاتح والداكن.
- دعم الترجمة والتعدد اللغوي عبر ملفات JSON.
- تنبيهات Toast موحدة لتفاعلات المستخدم.
- فحص اتصال الشبكة.
- تصميم متجاوب قابل للمعاينة أثناء التطوير باستخدام Device Preview.
- إعدادات Android و iOS جاهزة باسم التطبيق وأيقونته.

## التقنيات المستخدمة

- Flutter
- Dart
- flutter_bloc لإدارة الحالة
- equatable لتبسيط مقارنة الحالات
- dio للتعامل مع HTTP APIs
- easy_localization لدعم اللغات
- flutter_localizations لدعم تعريب Flutter
- connectivity_plus لمراقبة اتصال الشبكة
- internet_connection_checker لفحص توفر الإنترنت
- flutter_svg لعرض ملفات SVG
- pinput لإدخال أكواد التحقق
- cherry_toast لرسائل التنبيه
- page_transition لإدارة انتقالات الصفحات
- device_preview لمعاينة الواجهات أثناء التطوير
- Zain Font كخط أساسي للتطبيق

## بنية المشروع

```text
lib/
  controller/          Cubits وحالات إدارة التطبيق
  core/
    data/              مصادر البيانات والطلبات
    domain/            العقود وطبقة الاستخدام
    localization/      إعدادات اللغات
    mock_data/         بيانات تجريبية للمنتجات والصفحة الرئيسية
    models/            نماذج البيانات
    server/            إعدادات الشبكة و Dio
  route/               أسماء ومسارات الصفحات
  screen/              شاشات التطبيق
  utils/               الثيم، الخدمات، الأدوات العامة

assets/
  fonts/               خط Zain
  icons/               أيقونات SVG
  images/              صور عامة وشعار التطبيق
  test/                صور وبيانات عرض تجريبية

language/
  ar.json              ترجمة عربية
  en.json              ترجمة إنجليزية
```

## الشاشات الرئيسية

- Auth: تسجيل الدخول، إنشاء الحساب، التحقق بالكود، إعادة تعيين كلمة المرور.
- Home: الصفحة الرئيسية، البانرات، التصنيفات، أقسام المنتجات.
- Products: قائمة المنتجات، البحث، تفاصيل المنتج.
- Cart: السلة، طريقة الدفع، الإجمالي، إجراءات الشراء.
- Favorites: المنتجات المحفوظة.
- Orders: طلبات المستخدم.
- Profile: بيانات الحساب.
- Settings: إعدادات التطبيق والثيم.

## إعدادات API

يتم تعريف رابط الخادم ومسارات المصادقة في:

```text
lib/core/server/servise.dart
```

القيمة الحالية:

```dart
static String domain = "https://apistore2.onpoint-teasting.com/";
static String login = "api/Auth/Login";
static String signup = "api/Auth/Register";
```

## التشغيل محلياً

تأكد من تثبيت Flutter ثم نفذ:

```bash
flutter pub get
flutter run
```

لتشغيل التحليل:

```bash
flutter analyze
```

لتشغيل الاختبارات:

```bash
flutter test
```

## Android

تم تجهيز Android باسم التطبيق:

```text
onpoint-store
```

وتمت إضافة صلاحية الإنترنت في ملف:

```text
android/app/src/main/AndroidManifest.xml
```

أيقونات Android موجودة داخل:

```text
android/app/src/main/res/
android/app/src/main/ic_launcher-playstore.png
```

## iOS

تم تجهيز iOS باسم التطبيق:

```text
onpoint-store
```

وتم توليد أيقونات iOS داخل:

```text
ios/Runner/Assets.xcassets/AppIcon.appiconset/
```

كما تم تجهيز صلاحيات iOS داخل:

```text
ios/Runner/Info.plist
```

الصلاحيات المضافة:

- NSCameraUsageDescription
- NSPhotoLibraryUsageDescription
- NSPhotoLibraryAddUsageDescription

وتمت إضافة ملف:

```text
ios/Podfile
```

لتجهيز إضافات Flutter الأصلية على iOS.

## اللغات والثيم

يدعم التطبيق ملفات ترجمة JSON من مجلد `language/`، ويستخدم `easy_localization` لإدارة اللغة. كما يحتوي التطبيق على ثيم فاتح وثيم داكن معرفين في:

```text
lib/utils/theme/theme_manager.dart
```

## حالة المشروع

المشروع جاهز كبنية أولية لتطبيق متجر إلكتروني قابل للتطوير. يحتوي على بيانات Mock للكتالوج والصفحة الرئيسية، ويمكن ربطه بالكامل مع API حقيقي عبر طبقات `core/data` و `core/server`.

## الترخيص

هذا المشروع خاص بتطبيق onpoint-store.
