import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:janganan/bloc/app_bloc/app_bloc.dart';
import 'package:janganan/presentation/widgets/reusable_alert_dialog.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => ReusableAlertDialog(
                title: 'Logout',
                content: 'Apakah anda yakin ingin keluar dari akun anda?',
                actions: [
                  TextButton(
                    onPressed: () {
                      context.read<AppBloc>().add(const AppLogOutRequested());
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/sign-in-screen', (route) => false);
                    },
                    child: Text(
                      'Keluar',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.red),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Batal',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onBackground)),
                  ),
                ],
              ),
            );
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            'Logout',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.background,
                ),
          ),
        ),
      ),
    );
  }
}
