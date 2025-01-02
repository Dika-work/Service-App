import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:service/routes/app_pages.dart';
import 'package:service/utils/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await GetStorage.init();

  final localStorage = GetStorage();
  final bool isFirstTime = localStorage.read('IsFirstTime') ?? true;

  final bool isLoggedIn = localStorage.read('isLoggedIn') ?? false;

  final String? typeUser = localStorage.read('type_user');

  String initialLocation;
  if (isFirstTime) {
    initialLocation = AppPages.INITIAL;
    await localStorage.write('IsFirstTime', false);
  } else if (isLoggedIn) {
    if (typeUser == 'super admin') {
      initialLocation = Routes.HOME_SUPER_ADMIN;
    } else if (typeUser == 'kpool') {
      initialLocation = Routes.HOME_KPOOL;
    } else if (typeUser == 'mekanik') {
      initialLocation = Routes.HOME_MEKANIK;
    } else if (typeUser == 'staff') {
      initialLocation = Routes.HOME_STAFF;
    } else {
      initialLocation = AppPages.INITIAL;
    }
  } else {
    initialLocation = AppPages.INITIAL;
  }
  runApp(MyApp(initialRoute: initialLocation));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: AppTheme.lightTheme,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialRoute: initialRoute,
      getPages: AppPages.routes,
    );
  }
}
