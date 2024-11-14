import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

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
        theme: ThemeData(scaffoldBackgroundColor: AppColors.primaryGray, useMaterial3: true),
      ),
    );
  }
}
