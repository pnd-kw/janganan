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
  bool _isPasswordVisible = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();

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
                          hint: '8 karakter, angka, huruf kapital'),
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
                        if (signInState.status == SignInStatus.sendingRequest) {
                          showDialog(
                            context: context,
                            builder: (context) => Center(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation(
                                        Theme.of(context)
                                            .colorScheme
                                            .background),
                                    strokeWidth: 5,
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else if (signInState.status == SignInStatus.success) {
                          if (signInState.method ==
                              SignInMethod.emailAndPassword) {
                            Navigator.of(context)
                                .pushReplacementNamed('/verification-screen');
                          }
                        } else if (signInState.status == SignInStatus.failure) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Terdapat Kesalahan'),
                              content: const Text(
                                  'Otentikasi gagal, periksa kembali alamat email, password, dan koneksi internet.'),
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
                            borderRadius: BorderRadius.circular(20),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 100,
                        child: Divider(
                          color: Theme.of(context).colorScheme.onBackground,
                          thickness: 1.0,
                        ),
                      ),
                      SizedBox(
                        child: Text(
                          'atau',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        child: Divider(
                          color: Theme.of(context).colorScheme.onBackground,
                          thickness: 1.0,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: BlocListener<SignInCubit, SignInState>(
                      listener: (context, googleSignInState) {
                        if (googleSignInState.status == SignInStatus.success) {
                          if (googleSignInState.method ==
                              SignInMethod.googleSignIn) {
                            Navigator.of(context)
                                .pushReplacementNamed('/screen-navigation');
                          }
                        } else if (googleSignInState.status ==
                            SignInStatus.failure) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Terdapat Kesalahan'),
                              content: const Text(
                                  'Masalah kredensial atau sambungan internet.'),
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
                      child: TextButton.icon(
                        onPressed: () {
                          signInCubit.logInWithGoogle();
                        },
                        icon: Image.asset(
                          'assets/images/google-logo.png',
                          fit: BoxFit.cover,
                        ),
                        label: Text(
                          'SIGN IN WITH GOOGLE',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.grey.shade200),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
