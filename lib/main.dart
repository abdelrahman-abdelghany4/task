import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import 'package:task/module/login/cubit/cubit.dart';
import 'package:task/module/login/login_screen.dart';
import 'package:task/shared/remote/block_observer.dart';
import 'package:task/shared/components/applocal.dart';
import 'package:task/shared/cubit/cubit.dart';
import 'package:task/shared/cubit/states.dart';
import 'package:task/shared/remote/cash_helper.dart';
import 'package:task/shared/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CacheHelper.init();
  bool? isArabic = CacheHelper.getData(key: 'isArabic');

  BlocOverrides.runZoned(
    () {
      runApp(
        MyApp(isArabic),
      );
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final bool? isArabic;

  MyApp(this.isArabic);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => LoginCubit()),
          BlocProvider(
              create: (context) => AppCubit()
                ..changeAppLang(
                  fromShared: isArabic,
                )),
        ],
        child: BlocConsumer<AppCubit, AppStates>(
            builder: (context, state) {
              return MaterialApp(
                builder: (context, child) => ResponsiveWrapper.builder(
                  BouncingScrollWrapper.builder(context, child!),
                  maxWidth: 1200,
                  minWidth: 480,
                  defaultScale: true,
                  breakpoints: [
                    const ResponsiveBreakpoint.resize(480, name: MOBILE),
                    const ResponsiveBreakpoint.autoScale(800, name: TABLET),
                    const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
                    const ResponsiveBreakpoint.autoScale(2460, name: '4K'),
                  ],
                ),
                localizationsDelegates: const [
                  AppLocale.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('en'), // English, no country code
                  Locale('ar'), // Arabic, no country code
                ],
                locale: AppCubit.get(context).isArabic! ? Locale('ar') : Locale('en'),
                localeResolutionCallback: (currentLang, supportLang) {
                  if (currentLang != null) {
                    for (Locale locale in supportLang) {
                      if (locale.languageCode == currentLang.languageCode) {
                        CacheHelper.saveData(
                            key: "lang", value: currentLang.languageCode);
                        return currentLang;
                      }
                    }
                  }
                  return supportLang.first;
                },
                theme: ThemeData(
                  primarySwatch: Colors.grey,
                ),
                debugShowCheckedModeBanner: false,
                home: LoginScreen(),
              );
            },
            listener: (context, state) {}));
  }
}
