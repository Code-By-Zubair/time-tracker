import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/firebase_options.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/dashboard_main_screen.dart';
import 'package:time_tracker/presentation/auth_screens/login_screen.dart';
import 'package:time_tracker/constants/app_colors.dart';
import 'package:time_tracker/presentation/user_side/app_side_bar.dart';
import 'package:time_tracker/providers/dash_board_provider.dart';
import 'package:time_tracker/providers/profile_provider.dart';
import 'package:time_tracker/providers/report_provider_user_side.dart';
import 'package:time_tracker/providers/reports_provider.dart';
import 'package:time_tracker/providers/settings_provider.dart';
import 'package:time_tracker/providers/settings_provider_user_side.dart';
import 'package:time_tracker/providers/shared_pref_provider.dart';
import 'package:time_tracker/providers/task_provider.dart';
import 'package:time_tracker/providers/task_provider_user_side.dart';
import 'package:time_tracker/providers/user_dash_board_provider.dart';
import 'package:time_tracker/providers/user_management_provider.dart';
import 'package:window_manager/window_manager.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;

late final FirebaseApp app;
late final FirebaseAuth auth;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  auth = FirebaseAuth.instanceFor(app: app);
  await windowManager.ensureInitialized();
  WindowOptions windowOptions = const WindowOptions(
    minimumSize: Size(896, 700),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
    alwaysOnTop: false,
    title: 'Time Tracker',
    windowButtonVisibility: false,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  launchAtStartup.setup(
    appName: packageInfo.appName,
    appPath: Platform.resolvedExecutable,
  );

  await launchAtStartup.enable();
  // await launchAtStartup.disable();
  bool isEnabled = await launchAtStartup.isEnabled();

  HttpOverrides.global = MyHttpOverrides();
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => DashBoardProvider()),
          ChangeNotifierProvider(create: (_) => ProfileProvider()),
          ChangeNotifierProvider(create: (_) => SettingsProvider()),
          ChangeNotifierProvider(create: (_) => ReportProvider()),
          ChangeNotifierProvider(create: (_) => UserDashBoardProvider()),
          ChangeNotifierProvider(create: (_) => TaskProviderUserSide()),
          ChangeNotifierProvider(create: (_) => SettingsProviderUserSide()),
          ChangeNotifierProvider(create: (_) => ReportProviderUserSide()),
          ChangeNotifierProvider(create: (_) => SharedPrefProvider()),
          ChangeNotifierProvider(create: (_) => UserManagementProvider()),
          ChangeNotifierProvider(create: (_) => TaskProvider()),
        ],
        child: Builder(builder: (context) {
          Provider.of<SharedPrefProvider>(context, listen: false).getPrefData();
          return const MyApp();
        })),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

GlobalKey<ScaffoldMessengerState> globalKey =
    GlobalKey<ScaffoldMessengerState>();

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: globalKey,
      scrollBehavior: const MaterialScrollBehavior().copyWith(dragDevices: {
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        PointerDeviceKind.trackpad,
        PointerDeviceKind.touch,
        PointerDeviceKind.unknown,
        PointerDeviceKind.invertedStylus
      }),
      debugShowCheckedModeBanner: false,
      title: 'Time Tracker',
      theme: ThemeData(
        fontFamily: GoogleFonts.inter().fontFamily,
        colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.appPrimaryColor, surfaceTint: Colors.white),
        scaffoldBackgroundColor: AppColors.bgColor,
        useMaterial3: true,
      ),
      home: const FirstPage(),
    );
  }
}

class FirstPage extends StatefulWidget {
  const FirstPage({
    super.key,
  });

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> with WindowListener {
  bool hasInternet = true;
  late Future future;
  @override
  void initState() {
    Provider.of<SharedPrefProvider>(context, listen: false).getPrefData();
    future = Future.delayed(Duration.zero);
    method();
    windowManager.addListener(this);
    init();
    super.initState();
  }

  void init() async {
    await windowManager.setPreventClose(true);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  method() async {
    try {
      log('Timer:');
      var url = Uri.https('www.example.com');
      await http.get(url);
      hasInternet = true;

      if (mounted) {
        setState(() {});
      }
      await Future.delayed(const Duration(seconds: 20));
      method();
    } catch (e) {
      log(e.toString());
      if (e.toString().contains('Failed host lookup:')) {
        hasInternet = false;
        setState(() {});
        await Future.delayed(const Duration(seconds: 5));
        method();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (!hasInternet) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: LottieBuilder.asset('assets/lottie/no_internet.json'),
            ),
          );
        }

        return Provider.of<SharedPrefProvider>(context, listen: true).data ==
                null
            ? const LoginScreen()
            : Provider.of<SharedPrefProvider>(context, listen: true)
                        .data
                        ?.role ==
                    'user'
                ? const AppSideBarUser()
                : const DashboardMainScreen();
      },
    );
  }

  @override
  void onWindowClose() async {
    bool isPreventClose = await windowManager.isPreventClose();
    if (isPreventClose) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Text('Are you sure you want to close this window?'),
            ),
            actions: [
              SizedBox(
                height: 40,
                width: 150,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 150,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.appPrimaryColor,
                      foregroundColor: Colors.white),
                  child: const Text('Exit'),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await windowManager.destroy();
                  },
                ),
              ),
            ],
          );
        },
      );
    }
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
