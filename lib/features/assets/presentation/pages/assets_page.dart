import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tractian/features/assets/presentation/controllers/assets_controller.dart';
import 'package:tractian/features/assets/presentation/widgets/tree_view_widget.dart';
import 'package:tractian/l10n/translate.dart';
import 'package:tractian/shared/ui/app_colors.dart';
import 'package:tractian/shared/ui/typography/typography.dart';

class AssetsPage extends StatefulWidget {
  final String companyId;

  const AssetsPage({super.key, required this.companyId});

  @override
  State<AssetsPage> createState() => _AssetsPageState();
}

class _AssetsPageState extends State<AssetsPage> {
  final AssetsController _controller = GetIt.I<AssetsController>();

  @override
  void initState() {
    super.initState();
    _controller.getAssets(widget.companyId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.appBar,
        iconTheme: const IconThemeData(color: AppColors.primaryIcon),
        title: Text(Translate.strings.assets).bodySmallMedium(),
      ),
      body: ValueListenableBuilder(
        valueListenable: _controller.isLoading,
        builder: (context, value, child) => ModalProgressHUD(inAsyncCall: value, child: child!),
        child: ListenableBuilder(
          listenable: _controller,
          builder: (_, __) => TreeViewWidget(tree: _controller.assetsTree),
        ),
      ),
    );
  }
}
