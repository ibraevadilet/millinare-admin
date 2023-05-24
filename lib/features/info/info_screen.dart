import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millioner_admin/features/info/info_add_screen.dart';
import 'package:millioner_admin/features/info/widgets/info_widget.dart';
import 'package:millioner_admin/helpers/app_text_styles.dart';
import 'package:millioner_admin/logic/cubits/get_info_cubit/get_info_cubit.dart';
import 'package:millioner_admin/widgets/app_error_text.dart';
import 'package:millioner_admin/widgets/app_indicator.dart';
import 'package:millioner_admin/widgets/custom_app_bar.dart';
import 'package:millioner_admin/widgets/custom_button.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetInfoCubit()..getInfo(),
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Лента информаций'),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<GetInfoCubit, GetInfoState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () => const AppIndicator(),
                      error: (error) => AppErrorText(
                        error: error,
                      ),
                      success: (model) => model.isEmpty
                          ? Center(
                              child: Text(
                                'Лента пуста',
                                style: AppTextStyles.s16W600(),
                              ),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: ListView.separated(
                                itemCount: model.length,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 12),
                                itemBuilder: (context, index) => InfoWidget(
                                  model: model[index],
                                ),
                              ),
                            ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              Builder(
                builder: (context) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomButton(
                    text: 'Добавить информацию',
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const InfoAddScreen(),
                        ),
                      );
                      context.read<GetInfoCubit>().getInfo();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
