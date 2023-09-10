import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:janganan/bloc/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:janganan/presentation/screens/home_screen.dart';
import 'package:janganan/presentation/screens/order_screen.dart';
import 'package:janganan/presentation/screens/user_screen.dart';

class ScreenNavigation extends StatelessWidget {
  const ScreenNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomNavigationBloc = BlocProvider.of<BottomNavigationBloc>(context);

    return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
      builder: (context, bottomNavigationState) {
        if (bottomNavigationState is BottomNavigationChanged) {
          return Scaffold(
            body: _buildCurrentScreen(bottomNavigationState.navIndex),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: bottomNavigationState.navIndex,
              onTap: (index) {
                bottomNavigationBloc
                    .add(BottomNavigationSelected(navIndex: index));
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Beranda',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.note),
                  label: 'Pesanan',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profil',
                ),
              ],
              selectedLabelStyle: Theme.of(context).textTheme.titleSmall,
              unselectedLabelStyle: Theme.of(context).textTheme.titleSmall,
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget _buildCurrentScreen(int navIndex) {
    switch (navIndex) {
      case 0:
        return const HomeScreen();
      case 1:
        return const OrderScreen();
      case 2:
        return const UserScreen();
      default:
        return Container();
    }
  }
}
