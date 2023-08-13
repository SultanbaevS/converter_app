import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../features/converter/widget/home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 703),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Converter App',
          theme: ThemeData(
            useMaterial3: true,
            // primarySwatch: Colors.blue,
            // textTheme: Typography.blackCupertino,
          ),
          home: const HomePage(),
        );
      },
    );
  }
}
