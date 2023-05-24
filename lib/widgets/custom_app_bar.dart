import 'package:flutter/material.dart';
import 'package:millioner_admin/helpers/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        title: Text(title),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.color38B6FFBLue,
      ),
    );
  }
}
