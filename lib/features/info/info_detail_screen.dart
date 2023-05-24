import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millioner_admin/helpers/app_text_styles.dart';
import 'package:millioner_admin/logic/cubits/get_info_cubit/get_info_cubit.dart';
import 'package:millioner_admin/logic/model/info_model.dart';
import 'package:millioner_admin/widgets/custom_app_bar.dart';
import 'package:millioner_admin/widgets/custom_button.dart';
import 'package:millioner_admin/widgets/spaces.dart';
import 'package:millioner_admin/widgets/styled_toasts.dart';
import 'package:shimmer/shimmer.dart';

class InfoDetailScreen extends StatelessWidget {
  const InfoDetailScreen({super.key, required this.model});
  final InfoModel model;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetInfoCubit(),
      child: Scaffold(
        appBar: CustomAppBar(title: model.title),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const SizedBox(height: 12),
                CachedNetworkImage(
                  imageUrl: model.image,
                  placeholder: (_, url) {
                    return SizedBox(
                      width: getWidth(context),
                      height: 200,
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.withOpacity(0.4),
                        highlightColor: Colors.white,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    );
                  },
                  imageBuilder: (_, imageProvider) {
                    return CachedNetworkImage(
                      imageUrl: model.image,
                      width: getWidth(context),
                    );
                  },
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      model.description,
                      style: AppTextStyles.s19W600(),
                    ),
                  ),
                ),
                BlocConsumer<GetInfoCubit, GetInfoState>(
                  listener: (context, state) {
                    state.whenOrNull(
                      successAdd: () {
                        showSuccessSnackBar('Успншно удален!');
                        Navigator.pop(context);
                      },
                    );
                  },
                  builder: (context, state) {
                    return CustomButton(
                      isLoading: state.isLoading,
                      text: 'Удалить',
                      onPressed: () async {
                        final result = await showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text(
                              'Вы действтельно хотите удалить?',
                              textAlign: TextAlign.center,
                            ),
                            content: Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    child: const Text('Нет'),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(Colors.red),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                    },
                                    child: const Text('Да'),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );

                        if (result) {
                          await context
                              .read<GetInfoCubit>()
                              .deleteInfo(model.id);
                        }
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
