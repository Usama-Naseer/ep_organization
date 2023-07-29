
import 'package:ep_organization/providers/profile_provider.dart';
import 'package:ep_organization/utils/ep_colors.dart';
import 'package:ep_organization/views/authentication/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'bloc/authentication/authentication_bloc.dart';
import 'firebase_options.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (BuildContext context, Widget? child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<AuthenticationBloc>(
              create: (context) => AuthenticationBloc(),
            ),
          ],
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => ProfileProvider(),
              ),
            ],
            child: MaterialApp(
              title: 'Flutter Demo',
              navigatorKey: navigatorKey,
              theme: ThemeData(
                primarySwatch: EPColors.kPrimarySwatch,
                primaryColor: EPColors.kPrimaryColor,
                colorScheme: ColorScheme.fromSwatch(
                  primarySwatch: EPColors.kPrimarySwatch,
                  primaryColorDark: EPColors.kSecondaryColor,
                  accentColor: EPColors.kTertiaryColor,
                  backgroundColor: EPColors.kWhiteColor,
                  cardColor: EPColors.kWhiteColor,
                  errorColor: EPColors.kSecondaryColor,
                  brightness: Brightness.light,
                ),
                scaffoldBackgroundColor: EPColors.kPrimaryColor,
                appBarTheme: AppBarTheme(
                  backgroundColor: EPColors.kPrimaryColor,
                  elevation: 0,
                  titleTextStyle: TextStyle(
                    color: EPColors.kBlackColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                useMaterial3: true,
              ),
              home: child,
            ),
          ),
        );
      },
      child: const LoginScreen(),
    );
  }
}
