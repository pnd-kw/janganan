import 'package:flutter/material.dart';
import 'package:janganan/presentation/widgets/reusable_form_field.dart';
import 'package:janganan/utils/constants/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 600,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Text(
                    'Janganan',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                ),
                Form(
                  key: _loginFormKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    children: [
                      ReusableFormField(
                        controller: _emailController,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Bidang ini tidak boleh kosong.';
                          }
                          return null;
                        },
                        label: 'Email',
                        hint: 'johndoe@gmail.com',
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //       vertical: 10, horizontal: 10),
                      //   child: TextFormField(
                      //     controller: _emailController,
                      //     validator: (text) {
                      //       if (text == null || text.isEmpty) {
                      //         return 'Bidang ini tidak boleh kosong.';
                      //       }
                      //       return null;
                      //     },
                      //     decoration: InputDecoration(
                      //       labelText: 'Email',
                      //       hintText: 'johndoe@gmail.com',
                      //       border: OutlineInputBorder(
                      //         borderSide: const BorderSide(width: 1),
                      //         borderRadius: BorderRadius.circular(10),
                      //       ),
                      //       focusedBorder: OutlineInputBorder(
                      //         borderSide: BorderSide(
                      //           width: 1,
                      //           color: Theme.of(context).colorScheme.primary,
                      //         ),
                      //         borderRadius: BorderRadius.circular(10),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      ReusableFormField(
                        controller: _passwordController,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Bidang ini tidak boleh kosong.';
                          }
                          return null;
                        },
                        label: 'Password',
                        hint: 'Xa8ji4opq9',
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //       vertical: 10, horizontal: 10),
                      //   child: TextFormField(
                      //     controller: _passwordController,
                      //     validator: (text) {
                      //       if (text == null || text.isEmpty) {
                      //         return 'Bidang ini tidak boleh kosong.';
                      //       }
                      //       return null;
                      //     },
                      //     decoration: InputDecoration(
                      //       labelText: 'Password',
                      //       hintText: 'Password',
                      //       border: OutlineInputBorder(
                      //         borderSide: const BorderSide(width: 1),
                      //         borderRadius: BorderRadius.circular(10),
                      //       ),
                      //       focusedBorder: OutlineInputBorder(
                      //         borderSide: BorderSide(
                      //           width: 1,
                      //           color: Theme.of(context).colorScheme.primary,
                      //         ),
                      //         borderRadius: BorderRadius.circular(10),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.secondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 2,
                      ),
                      child: Text(
                        'LOGIN',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                color:
                                    Theme.of(context).colorScheme.background),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Lupa Password',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'Belum punya akun? ',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed('/register-screen');
                              },
                              child: Text(
                                'Daftar',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
