import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millioner_admin/features/enjoys/enjoy_add_screen.dart';
import 'package:millioner_admin/features/enjoys/widgets/enjoy_widget.dart';
import 'package:millioner_admin/helpers/app_text_styles.dart';
import 'package:millioner_admin/logic/cubits/get_enjoy_cubit/get_enjoy_cubit.dart';
import 'package:millioner_admin/widgets/app_error_text.dart';
import 'package:millioner_admin/widgets/app_indicator.dart';
import 'package:millioner_admin/widgets/custom_app_bar.dart';
import 'package:millioner_admin/widgets/custom_button.dart';

class EnjoyScreen extends StatelessWidget {
  const EnjoyScreen({
    super.key,
    required this.ref,
    required this.appBarTitle,
  });

  final String ref;
  final String appBarTitle;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetEnjoyCubit()..getEnjoy(ref),
      child: Scaffold(
        appBar: CustomAppBar(title: appBarTitle),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<GetEnjoyCubit, GetEnjoyState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () => const AppIndicator(),
                      error: (error) => AppErrorText(
                        error: error,
                      ),
                      success: (model) => model.isEmpty
                          ? Center(
                              child: Text(
                                '$appBarTitle отсутствуют',
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
                                itemBuilder: (context, index) => EnjoyWidget(
                                  model: model[index],
                                  ref: ref,
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
                    text: 'Добавить ${appBarTitle.toLowerCase()}',
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EnjoyAddScreen(
                            ref: ref,
                            appBarTitle: appBarTitle,
                          ),
                        ),
                      );
                      context.read<GetEnjoyCubit>().getEnjoy(ref);
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
