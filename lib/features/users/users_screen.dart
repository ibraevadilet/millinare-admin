import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millioner_admin/features/users/widgets/user_widget.dart';
import 'package:millioner_admin/helpers/app_text_styles.dart';
import 'package:millioner_admin/logic/cubits/get_users_cubit/get_users_cubit.dart';
import 'package:millioner_admin/widgets/app_error_text.dart';
import 'package:millioner_admin/widgets/app_indicator.dart';
import 'package:millioner_admin/widgets/custom_app_bar.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetUsersCubit(),
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Список пользователей'),
        body: BlocBuilder<GetUsersCubit, GetUsersState>(
          builder: (context, state) {
            return state.when(
              loading: () => const AppIndicator(),
              error: (error) => AppErrorText(
                error: error,
              ),
              success: (model) => model.isEmpty
                  ? Center(
                      child: Text(
                        'Пользователи отсутстуют',
                        style: AppTextStyles.s16W600(),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ListView.separated(
                        itemCount: model.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) => UserWidget(
                          model: model[index],
                        ),
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }
}
