import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:janganan/bloc/cubit/cubit/sign_in_cubit.dart';
import 'package:janganan/presentation/widgets/reusable_form_field.dart';
import 'package:janganan/utils/constants/colors.dart';
import 'package:janganan/utils/regex_validator.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final signInCubit = BlocProvider.of<SignInCubit>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                        obscureText: false,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Bidang ini tidak boleh kosong.';
                          }
                          if (!validEmail.hasMatch(text)) {
                            return msgInvalidEmail;
                          }
                          return null;
                        },
                        label: 'Email',
                        hint: 'johndoe@gmail.com',
                      ),
                      ReusableFormField(
                        controller: _passwordController,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                          icon: Icon(_isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                        obscureText: !_isPasswordVisible,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Bidang ini tidak boleh kosong.';
                          }
                          return null;
                        },
                        label: 'Password',
                        hint: 'Xa8ji4opq9',
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: SizedBox(
                    width: double.infinity,
                    child: BlocListener<SignInCubit, SignInState>(
                      listener: (context, signInState) {
                        if (signInState.status == SignInStatus.success) {
                          Navigator.of(context)
                              .pushReplacementNamed('/bottom-navigation');
                        } else if (signInState.status == SignInStatus.failure) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Terdapat Kesalahan'),
                              content: const Text(
                                  'Otentikasi gagal, periksa kembali alamat email, password, dan koneksi anda.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Tutup'),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      child: ElevatedButton(
                        onPressed: () {
                          if (_loginFormKey.currentState!.validate()) {
                            signInCubit.logInWithCredentials(
                              _emailController.text,
                              _passwordController.text,
                            );
                          }
                        },
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
                                    .pushNamed('/sign-up-screen');
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
                // if (signInCubit.state.isLoading)
                //   const CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
