import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millioner_admin/features/info/widgets/add_photo_widget.dart';
import 'package:millioner_admin/helpers/app_colors.dart';
import 'package:millioner_admin/helpers/app_text_styles.dart';
import 'package:millioner_admin/logic/cubits/get_info_cubit/get_info_cubit.dart';
import 'package:millioner_admin/logic/model/info_model.dart';
import 'package:millioner_admin/widgets/custom_app_bar.dart';
import 'package:millioner_admin/widgets/custom_button.dart';
import 'package:millioner_admin/widgets/custom_text_field.dart';
import 'package:millioner_admin/widgets/styled_toasts.dart';

class InfoAddScreen extends StatefulWidget {
  const InfoAddScreen({super.key});

  @override
  State<InfoAddScreen> createState() => _InfoAddScreenState();
}

class _InfoAddScreenState extends State<InfoAddScreen> {
  String title = '';
  String description = '';
  String? image;

  bool isAllSelected() =>
      title.isNotEmpty && description.isNotEmpty && image != null;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetInfoCubit(),
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Добавить информацию'),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 12),
                CustomTextField(
                  hintText: 'Тема',
                  onChanged: (titileFrom) {
                    setState(() {
                      title = titileFrom;
                    });
                  },
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  hintText: 'Описание',
                  onChanged: (descriptionFrom) {
                    setState(() {
                      description = descriptionFrom;
                    });
                  },
                  maxLines: 10,
                ),
                const SizedBox(height: 12),
                Text(
                  'Добавьте фото',
                  style: AppTextStyles.s19W400(),
                ),
                const SizedBox(height: 12),
                AddPhotoWidget(
                  onSelected: (imageFrom) {
                    setState(() {
                      image = imageFrom;
                    });
                  },
                ),
                const SizedBox(height: 20),
                BlocConsumer<GetInfoCubit, GetInfoState>(
                  listener: (context, state) {
                    state.whenOrNull(
                      successAdd: () {
                        showSuccessSnackBar('Успншно сохранен!');
                        Navigator.pop(context);
                      },
                    );
                  },
                  builder: (context, state) {
                    return CustomButton(
                      isLoading: state.isLoading,
                      color: isAllSelected()
                          ? null
                          : AppColors.color38B6FFBLue.withOpacity(0.5),
                      text: 'Сохранить',
                      onPressed: () {
                        if (isAllSelected()) {
                          final String id =
                              DateTime.now().millisecondsSinceEpoch.toString();
                          final model = InfoModel(
                            description: description,
                            title: title,
                            image: image!,
                            id: id,
                          );
                          context.read<GetInfoCubit>().addInfo(model);
                        } else {
                          showErrorSnackBar('Заполните все поля');
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
