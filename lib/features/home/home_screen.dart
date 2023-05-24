import 'package:flutter/material.dart';
import 'package:millioner_admin/features/enjoys/enjoy_screen.dart';
import 'package:millioner_admin/features/home/widgets/home_widget.dart';
import 'package:millioner_admin/features/info/info_screen.dart';
import 'package:millioner_admin/features/users/users_screen.dart';
import 'package:millioner_admin/helpers/app_text_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 12),
                Image.asset(
                  'assets/images/logo.png',
                  height: 150,
                ),
                const SizedBox(height: 12),
                Text(
                  'ОсОО MultiMillionaire',
                  style: AppTextStyles.s19W600(),
                ),
                const SizedBox(height: 20),
                HomeWidget(
                  title: 'Пользователи',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UsersScreen(),
                      ),
                    );
                  },
                ),
                HomeWidget(
                  title: 'Лента полезной информации',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const InfoScreen(),
                      ),
                    );
                  },
                ),
                HomeWidget(
                  title: 'Фильмы',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EnjoyScreen(
                          ref: 'films',
                          appBarTitle: 'Фильмы',
                        ),
                      ),
                    );
                  },
                ),
                HomeWidget(
                  title: 'Книги',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EnjoyScreen(
                          ref: 'books',
                          appBarTitle: 'Книги',
                        ),
                      ),
                    );
                  },
                ),
                HomeWidget(
                  title: 'Страны',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EnjoyScreen(
                          ref: 'countries',
                          appBarTitle: 'Страны',
                        ),
                      ),
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
