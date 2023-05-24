import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millioner_admin/helpers/app_colors.dart';
import 'package:millioner_admin/helpers/app_text_styles.dart';
import 'package:millioner_admin/logic/cubits/get_users_cubit/get_users_cubit.dart';
import 'package:millioner_admin/logic/model/user_model.dart';
import 'package:millioner_admin/widgets/delete_dismissible_widget.dart';
import 'package:millioner_admin/widgets/spaces.dart';

class UserWidget extends StatelessWidget {
  const UserWidget({
    super.key,
    required this.model,
  });

  final UserModel model;

  @override
  Widget build(BuildContext context) {
    return DeleteDismissibleWidget(
      onDelete: () async {
        await context.read<GetUsersCubit>().deleteUser(model.uid);
      },
      child: Container(
        width: getWidth(context),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.colorFED5E4LightBlue,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Имя: ${model.name}',
              style: AppTextStyles.s16W400(),
            ),
            const SizedBox(height: 5),
            Text(
              'email: ${model.email}',
              style: AppTextStyles.s16W400(),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
