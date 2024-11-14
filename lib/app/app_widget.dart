import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tractian/core/injection/injection.dart';
import 'package:tractian/core/routes/app_routes.dart';
import 'package:tractian/shared/ui/app_colors.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  void initState() {
    super.initState();
    Injection.init();
  }

  @override
  Widget build(BuildContext context) {
    return OKToast(
      position: ToastPosition.top,
      textPadding: EdgeInsets.zero,
      dismissOtherOnShow: true,
      child: MaterialApp.router(
        title: 'Tractian',
        debugShowCheckedModeBanner: false,
        routerConfig: AppRoutes.router,
        theme: ThemeData(
            appBarTheme: const AppBarTheme(backgroundColor: AppColors.appBar),
            scaffoldBackgroundColor: AppColors.scaffold, useMaterial3: true),
      ),
    );
  }
}
