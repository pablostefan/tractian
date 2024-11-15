import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tractian/core/routes/app_route.dart';
import 'package:tractian/features/menu/presentation/controllers/menu_controller.dart';
import 'package:tractian/features/menu/presentation/widgets/companies_widget/companies_list_widget.dart';
import 'package:tractian/shared/assets/svgs/app_svgs.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final AppMenuController _controller = GetIt.I<AppMenuController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: SvgPicture.asset(AppSvgs.ic_logo.path),
      ),
      body: ValueListenableBuilder(
        valueListenable: _controller.isLoadingNotifier,
        builder: (context, value, child) => ModalProgressHUD(inAsyncCall: value, child: child!),
        child: ListenableBuilder(
          listenable: _controller,
          builder: (context, child) => CompaniesListWidget(
            companies: _controller.companies,
            onTapCompany: (company) => GoRouter.of(context).pushNamed(AppRoute.assets.name, extra: company.id),
          ),
        ),
      ),
    );
  }
}
