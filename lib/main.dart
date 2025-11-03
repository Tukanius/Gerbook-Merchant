import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:merchant_gerbook_flutter/provider/user_provider.dart';
import 'package:merchant_gerbook_flutter/services/navigation.dart';
import 'package:merchant_gerbook_flutter/src/auth/login_page.dart';
import 'package:merchant_gerbook_flutter/src/auth/onboarding_page.dart';
import 'package:merchant_gerbook_flutter/src/auth/register_pages/register_create_password.dart';
import 'package:merchant_gerbook_flutter/src/auth/register_pages/register_page.dart';
import 'package:merchant_gerbook_flutter/src/auth/register_pages/register_otp_page.dart';
import 'package:merchant_gerbook_flutter/src/auth/register_pages/register_stepper.dart/camera_page.dart';
import 'package:merchant_gerbook_flutter/src/auth/register_pages/register_stepper.dart/register_bank.dart';
import 'package:merchant_gerbook_flutter/src/auth/register_pages/register_stepper.dart/register_info.dart';
import 'package:merchant_gerbook_flutter/src/auth/register_pages/register_stepper.dart/register_sign.dart';
import 'package:merchant_gerbook_flutter/src/localization/change_language.dart';
import 'package:merchant_gerbook_flutter/src/localization/localization_local.dart';
import 'package:merchant_gerbook_flutter/src/main_page.dart';
import 'package:merchant_gerbook_flutter/src/notification_page/notification_page.dart';
import 'package:merchant_gerbook_flutter/src/splash_page/splash_page.dart';
import 'package:merchant_gerbook_flutter/src/tabs/add_ger_page/create_camp_comps/create_camp_data.dart';
import 'package:merchant_gerbook_flutter/src/tabs/ger_page/ger_detail_page.dart';
import 'package:merchant_gerbook_flutter/src/tabs/order_page/order_detail_page.dart';
// import 'package:gerbook_flutter/src/widget/dialog/dialog_manager.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:app_links/app_links.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final seen = prefs.getBool('seenOnboarding') ?? false;
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await NotifyService().initNotify();

  // final GoogleMapsFlutterPlatform mapsImplementation =
  //     GoogleMapsFlutterPlatform.instance;
  // if (mapsImplementation is GoogleMapsFlutterAndroid) {
  //   // await mapsImplementation.initializeWithRenderer(AndroidMapRenderer.latest);
  //   mapsImplementation.useAndroidViewSurface = true;
  // }
  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   NotifyService().showNotification(
  //     title: message.notification?.title,
  //     body: message.notification?.body,
  //   );
  // });

  locator.registerLazySingleton(() => NavigationService());

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => LocalizationProvider()),
          // ChangeNotifierProvider(create: (_) => ToolsProvider()),
          // ChangeNotifierProvider(create: (_) => SearchProvider()),
          // ChangeNotifierProvider(create: (_) => SocketProvider()),
        ],
        child: MyApp(seenOnboarding: seen),
      ),
    );
  });
}

GetIt locator = GetIt.instance;

class MyApp extends StatefulWidget {
  final bool seenOnboarding;

  const MyApp({super.key, required this.seenOnboarding});
  static int invalidTokenCount = 0;

  static setInvalidToken(int count) {
    invalidTokenCount = count;
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with AfterLayoutMixin {
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    // final userProvider = Provider.of<UserProvider>(context, listen: false);
    // FirebaseMessaging.instance.requestPermission();
    // FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    // String? token = await _firebaseMessaging.getToken();
    // if (token != null) {
    //   userProvider.setDeviceToken(token);
    // }
  }

  void initState() {
    super.initState();
    loadTranslations();
  }

  Future<void> loadTranslations() async {
    final localizationProvider = Provider.of<LocalizationProvider>(
      context,
      listen: false,
    );
    String? locale = await getLocale();
    if (locale == null) {
      await saveLocale('mn');
      locale = await getLocale();
    } else {
      locale = await getLocale();
    }
    await localizationProvider.loadTranslations('${locale}');
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityProvider(
      child: MaterialApp(
        navigatorKey: NavigationService.navigatorKey,
        // builder: (context, widget) => Navigator(
        //   onGenerateRoute: (settings) => MaterialPageRoute(
        //     builder: (context) =>
        //         DialogManager(child: loading(context, widget)),
        //   ),
        // ),
        builder: (context, child) {
          return MediaQuery.withNoTextScaling(child: child ?? const SizedBox());
        },
        title: 'GerBook Merchant',
        theme: ThemeData(useMaterial3: false),
        debugShowCheckedModeBanner: false,
        initialRoute: SplashPage.routeName,
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case SplashPage.routeName:
              return MaterialPageRoute(
                builder: (context) {
                  return SplashPage(seenPage: widget.seenOnboarding);
                },
              );
            case LoginPage.routeName:
              return MaterialPageRoute(
                builder: (context) {
                  return const LoginPage();
                },
              );
            case OnboardingPage.routeName:
              return MaterialPageRoute(
                builder: (context) {
                  return const OnboardingPage();
                },
              );
            case RegisterPage.routeName:
              RegisterPageArguments arguments =
                  settings.arguments as RegisterPageArguments;
              return MaterialPageRoute(
                builder: (context) {
                  return RegisterPage(isRegister: arguments.isRegister);
                },
              );
            case RegisterOtpPage.routeName:
              RegisterOtpPageArguments arguments =
                  settings.arguments as RegisterOtpPageArguments;
              return MaterialPageRoute(
                builder: (context) {
                  return RegisterOtpPage(
                    method: arguments.method,
                    userName: arguments.userName,
                  );
                },
              );
            case RegisterCreatePassword.routeName:
              RegisterCreatePasswordArguments arguments =
                  settings.arguments as RegisterCreatePasswordArguments;
              return MaterialPageRoute(
                builder: (context) {
                  return RegisterCreatePassword(method: arguments.method);
                },
              );
            case MainPage.routeName:
              MainPageArguments arguments =
                  settings.arguments as MainPageArguments;
              return MaterialPageRoute(
                builder: (context) {
                  return MainPage(changeIndex: arguments.changeIndex);
                },
              );
            case RegisterSign.routeName:
              return MaterialPageRoute(
                builder: (context) {
                  return const RegisterSign();
                },
              );
            case RegisterInfo.routeName:
              return MaterialPageRoute(
                builder: (context) {
                  return const RegisterInfo();
                },
              );
            case RegisterBank.routeName:
              return MaterialPageRoute(
                builder: (context) {
                  return const RegisterBank();
                },
              );
            case CameraPage.routeName:
              CameraPageArguments arguments =
                  settings.arguments as CameraPageArguments;
              return MaterialPageRoute(
                builder: (context) {
                  return CameraPage(
                    listenController: arguments.listenController,
                  );
                },
              );
            case ChangeLanguagePage.routeName:
              return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return const ChangeLanguagePage();
                },
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                      const begin = Offset(0.0, 1.0);
                      const end = Offset.zero;
                      const curve = Curves.easeInOut;

                      var tween = Tween(
                        begin: begin,
                        end: end,
                      ).chain(CurveTween(curve: curve));
                      var offsetAnimation = animation.drive(tween);

                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
              );
            case NotificationPage.routeName:
              return MaterialPageRoute(
                builder: (context) {
                  return const NotificationPage();
                },
              );
            case CreateCampData.routeName:
              return MaterialPageRoute(
                builder: (context) {
                  return const CreateCampData();
                },
              );
            case GerDetailPage.routeName:
              GerDetailPageArguments arguments =
                  settings.arguments as GerDetailPageArguments;
              return MaterialPageRoute(
                builder: (context) {
                  return GerDetailPage(id: arguments.id);
                },
              );
            case OrderDetailPage.routeName:
              OrderDetailPageArguments arguments =
                  settings.arguments as OrderDetailPageArguments;
              return MaterialPageRoute(
                builder: (context) {
                  return OrderDetailPage(id: arguments.id);
                },
              );
            default:
              return MaterialPageRoute(
                builder: (_) => SplashPage(seenPage: widget.seenOnboarding),
              );
          }
        },
      ),
    );
  }
}
