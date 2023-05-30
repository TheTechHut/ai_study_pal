import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summarize_app/views/providers/mainpage/app_bottom_nav_bar.dart';
import 'package:summarize_app/views/providers/mainpage/mainpage_provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MainPageProvider>(
      builder: (_, pageProvider, ___) {
        return Scaffold(
          body: PageView(
            children: pageProvider.pageViews,
            onPageChanged: (value) {},
          ),
          bottomNavigationBar: const AppBottomNavBar(),
        );
      },
    );
  }
}
