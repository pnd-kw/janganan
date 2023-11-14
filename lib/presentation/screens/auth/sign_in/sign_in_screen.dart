import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:janganan/bloc/cubit/cubit/sign_in_cubit.dart';
import 'package:janganan/presentation/widgets/reusable_alert_dialog.dart';
import 'package:janganan/presentation/widgets/reusable_form_field.dart';
import 'package:janganan/presentation/widgets/reusable_progress_dialog.dart';
import 'package:janganan/utils/constants/colors.dart';
import 'package:janganan/utils/regex_validator.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _isLoginPasswordVisible = false;
  bool _isButtonEnabled = false;

  final _loginEmailController = TextEditingController();
  final _loginPasswordController = TextEditingController();

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
                        controller: _loginEmailController,
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
                        hint: 'johndoe@example.com',
                      ),
                      ReusableFormField(
                        controller: _loginPasswordController,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isLoginPasswordVisible =
                                  !_isLoginPasswordVisible;
                            });
                          },
                          icon: Icon(
                            _isLoginPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                        obscureText: !_isLoginPasswordVisible,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Bidang ini tidak boleh kosong.';
                          }
                          if (!validPassword.hasMatch(text)) {
                            return msgInvalidPassword;
                          }
                          return null;
                        },
                        onChanged: (text) {
                          if (text.length >= 8) {
                            setState(() {
                              _isButtonEnabled = true;
                            });
                          }
                        },
                        label: 'Password',
                        hint: 'Min 8 karakter, angka, huruf kapital',
                      ),
                    ],
                  ),
                ),
                Builder(
                  builder: (context) => Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: SizedBox(
                      width: double.infinity,
                      child: BlocListener<SignInCubit, SignInState>(
                        listener: (context, signInState) {
                          if (signInState.status ==
                              SignInStatus.sendingRequest) {
                            showDialog(
                              context: context,
                              builder: (context) =>
                                  const ReusableProgressDialog(),
                            );
                          } else if (signInState.status ==
                              SignInStatus.success) {
                            if (signInState.method ==
                                SignInMethod.emailAndPassword) {
                              if (signInState.userVerificationStatus ==
                                  UserVerificationStatus.unverifiedUser) {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/verification-screen', (route) => false);
                              } else if (signInState.userVerificationStatus ==
                                  UserVerificationStatus.verifiedUser) {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/screen-navigation', (route) => false);
                              }
                            }
                          } else if (signInState.status ==
                              SignInStatus.failure) {
                            showDialog(
                              context: context,
                              builder: (context) => ReusableAlertDialog(
                                title: 'Terdapat Kesalahan',
                                content:
                                    'Otentikasi gagal, periksa kembali alamat email, password, dan koneksi internet.',
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'Tutup',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onBackground),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        child: ElevatedButton(
                          onPressed: _isButtonEnabled
                              ? () {
                                  if (_loginFormKey.currentState!.validate()) {
                                    signInCubit.logInWithCredentials(
                                      _loginEmailController.text,
                                      _loginPasswordController.text,
                                    );
                                  }
                                }
                              : null,
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
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background),
                          ),
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
                            if (googleSignInState.userVerificationStatus ==
                                UserVerificationStatus.unverifiedUser) {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/link-google-screen', (route) => false);
                            } else if (googleSignInState
                                    .userVerificationStatus ==
                                UserVerificationStatus.verifiedUser) {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/screen-navigation', (route) => false);
                            }
                          }
                        } else if (googleSignInState.status ==
                            SignInStatus.failure) {
                          showDialog(
                            context: context,
                            builder: (context) => ReusableAlertDialog(
                              title: 'Terdapat Kesalahan',
                              content:
                                  'Masalah kredensial atau sambungan internet.',
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Tutup',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground),
                                  ),
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
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed('/forgot-password-screen');
                          },
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
