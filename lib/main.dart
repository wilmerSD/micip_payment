import 'package:cip_payment_web/app/providers/auth_provider.dart';
import 'package:cip_payment_web/app/providers/bill_provider.dart';
import 'package:cip_payment_web/app/providers/reciept_provider.dart';
import 'package:cip_payment_web/app/ui/views/advancepayment/advancepayment_provider.dart';
import 'package:cip_payment_web/app/ui/views/certificateskill/certificateskill_provider.dart';
import 'package:cip_payment_web/app/ui/views/home/home_provider.dart';
import 'package:cip_payment_web/app/ui/views/iepi/iepi_controller.dart';
import 'package:cip_payment_web/app/ui/views/login/login_provider.dart';
import 'package:cip_payment_web/app/ui/views/manteiners/person/person_provider.dart';
import 'package:cip_payment_web/app/ui/views/monthlyfees/monthlyfees_provider.dart';
import 'package:cip_payment_web/app/ui/views/myprofile/myprofile_provider.dart';
import 'package:cip_payment_web/app/ui/views/recoverpass/recoverpass_provider.dart';
import 'package:cip_payment_web/app/ui/views/splash/splash_provider.dart';
import 'package:cip_payment_web/core/config/theme_app.dart';
import 'package:cip_payment_web/firebase_options.dart';
import 'package:cip_payment_web/core/preferences/shared_preferences.dart';
import 'package:cip_payment_web/core/preferences/theme_provider.dart';
import 'package:cip_payment_web/routes/go_router_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Necesario para inicializar dependencias antes de runApp()
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await PreferencesUser.init();
  await initializeDateFormatting("ES", null);
  await dotenv.load(fileName: '.env');
  

  // final authProvider = AuthProvider();
  // await authProvider.loadPerson();

  
  runApp(
    MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (_) => authProvider),
        ChangeNotifierProvider(
          create: (_) => AuthProvider()..loadPerson(), // 👈 carga apenas inicia
        ),
        ChangeNotifierProvider(create: (_) => SplashProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => MyprofileProvider()),
        ChangeNotifierProvider(create: (_) => MonthlyfeesProvider()),
        ChangeNotifierProvider(create: (_) => CertificateSkillProvider()),
        ChangeNotifierProvider(create: (_) => RecoverPassProvider()),
        ChangeNotifierProvider(create: (_) => IepiProvider()),
        ChangeNotifierProvider(create: (_) => AdvancepaymentProvider()),
        
        ChangeNotifierProvider(create: (_) => RecieptProvider()),
        ChangeNotifierProvider(create: (_) => BillProvider()),
        ChangeNotifierProvider(create: (_) => PersonProvider()),
        ChangeNotifierProvider(
            create: (_) =>
                ThemeProvider(darkMode: PreferencesUser().themeBool)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application. MaterialApp
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(390, 844) /* ScreenUtil.defaultSize */,
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MaterialApp.router(
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                DefaultWidgetsLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('es', 'ES'), // Español
                Locale('en', 'US'), // Inglés
              ],
              debugShowCheckedModeBanner: false,
              title: 'MyCip',
              theme: ThemeApp(
                      darkMode:
                          Provider.of<ThemeProvider>(context, listen: true)
                              .themeDark)
                  .getTheme(),
              routerConfig: appRouter, 
            ));
  }
}
