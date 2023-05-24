import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millioner_admin/features/enjoys/enjoy_detail_screen.dart';
import 'package:millioner_admin/helpers/app_colors.dart';
import 'package:millioner_admin/helpers/app_text_styles.dart';
import 'package:millioner_admin/logic/cubits/get_enjoy_cubit/get_enjoy_cubit.dart';
import 'package:millioner_admin/logic/model/enjoy_model.dart';
import 'package:millioner_admin/widgets/delete_dismissible_widget.dart';
import 'package:millioner_admin/widgets/spaces.dart';

class EnjoyWidget extends StatelessWidget {
  const EnjoyWidget({
    super.key,
    required this.model,
    required this.ref,
  });

  final EnjoyModel model;
  final String ref;

  @override
  Widget build(BuildContext context) {
    return DeleteDismissibleWidget(
      onDelete: () async {
        await context.read<GetEnjoyCubit>().deleteEnjoy(model.id, ref);
      },
      child: InkWell(
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EnjoyDetailScreen(
                model: model,
                ref: ref,
              ),
            ),
          );
          context.read<GetEnjoyCubit>().getEnjoy(ref);
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
                'Тема: ${model.title}',
                style: AppTextStyles.s16W400(),
              ),
              const SizedBox(height: 5),
              Text(
                'Описание: ${model.description}',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.s16W400(),
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
