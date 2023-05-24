import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millioner_admin/features/info/widgets/add_photo_widget.dart';
import 'package:millioner_admin/helpers/app_colors.dart';
import 'package:millioner_admin/helpers/app_text_styles.dart';
import 'package:millioner_admin/logic/cubits/get_enjoy_cubit/get_enjoy_cubit.dart';
import 'package:millioner_admin/logic/model/enjoy_model.dart';
import 'package:millioner_admin/widgets/custom_app_bar.dart';
import 'package:millioner_admin/widgets/custom_button.dart';
import 'package:millioner_admin/widgets/custom_text_field.dart';
import 'package:millioner_admin/widgets/styled_toasts.dart';

class EnjoyAddScreen extends StatefulWidget {
  const EnjoyAddScreen({
    super.key,
    required this.ref,
    required this.appBarTitle,
  });
  final String ref;
  final String appBarTitle;
  @override
  State<EnjoyAddScreen> createState() => _EnjoyAddScreenState();
}

class _EnjoyAddScreenState extends State<EnjoyAddScreen> {
  String title = '';
  String description = '';
  String url = '';
  String? image;

  bool isAllSelected() =>
      title.isNotEmpty &&
      description.isNotEmpty &&
      url.isNotEmpty &&
      image != null;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetEnjoyCubit(),
      child: Scaffold(
        appBar:
            CustomAppBar(title: 'Добавить ${widget.appBarTitle.toLowerCase()}'),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
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
                    maxLines: 8,
                  ),
                  const SizedBox(height: 12),
                  CustomTextField(
                    hintText: 'Ссылка',
                    onChanged: (urlFrom) {
                      setState(() {
                        url = urlFrom;
                      });
                    },
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
                  BlocConsumer<GetEnjoyCubit, GetEnjoyState>(
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
                            final String id = DateTime.now()
                                .millisecondsSinceEpoch
                                .toString();
                            final model = EnjoyModel(
                              description: description,
                              title: title,
                              image: image!,
                              id: id,
                              url: url,
                            );
                            context.read<GetEnjoyCubit>().addEnjoy(
                                  model,
                                  widget.ref,
                                );
                          } else {
                            showErrorSnackBar('Заполните все поля');
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
