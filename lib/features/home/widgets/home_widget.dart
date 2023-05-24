import 'package:flutter/material.dart';
import 'package:millioner_admin/helpers/app_colors.dart';
import 'package:millioner_admin/helpers/app_text_styles.dart';
import 'package:millioner_admin/widgets/spaces.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
    required this.onTap,
    required this.title,
  });

  final Function() onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: getWidth(context),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.color38B6FFBLue,
          ),
          child: Text(
            title,
            style: AppTextStyles.s16W500(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
