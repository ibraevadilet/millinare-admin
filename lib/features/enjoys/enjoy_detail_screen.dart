import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millioner_admin/features/enjoys/web_view_screen.dart';
import 'package:millioner_admin/helpers/app_colors.dart';
import 'package:millioner_admin/helpers/app_text_styles.dart';
import 'package:millioner_admin/logic/cubits/get_enjoy_cubit/get_enjoy_cubit.dart';
import 'package:millioner_admin/logic/model/enjoy_model.dart';
import 'package:millioner_admin/widgets/custom_app_bar.dart';
import 'package:millioner_admin/widgets/custom_button.dart';
import 'package:millioner_admin/widgets/spaces.dart';
import 'package:millioner_admin/widgets/styled_toasts.dart';
import 'package:shimmer/shimmer.dart';

class EnjoyDetailScreen extends StatelessWidget {
  const EnjoyDetailScreen({
    super.key,
    required this.model,
    required this.ref,
  });
  final EnjoyModel model;
  final String ref;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetEnjoyCubit(),
      child: Scaffold(
        appBar: CustomAppBar(title: model.title),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const SizedBox(height: 12),
                Flexible(
                  child: CachedNetworkImage(
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
                const SizedBox(height: 12),
                const Text('Ссылка:'),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(50, 30),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    alignment: Alignment.center,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WebViewScreen(
                          title: model.title,
                          url: model.url,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    model.url,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.s19W600(
                      color: AppColors.colorF0912FFDartBLue,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                BlocConsumer<GetEnjoyCubit, GetEnjoyState>(
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
                          await context.read<GetEnjoyCubit>().deleteEnjoy(
                                model.id,
                                ref,
                              );
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
