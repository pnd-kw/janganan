import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:janganan/bloc/cubit/cubit/reset_password_cubit.dart';
import 'package:janganan/presentation/widgets/reusable_alert_dialog.dart';
import 'package:janganan/presentation/widgets/reusable_form_field.dart';
import 'package:janganan/utils/constants/colors.dart';
import 'package:janganan/utils/regex_validator.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool _isButtonEnabled = false;

  final _forgotPasswordEmailController = TextEditingController();
  final _forgotPasswordFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final resetPasswordCubit = BlocProvider.of<ResetPasswordCubit>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SizedBox(
          height: 500,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Forgot Password',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, top: 20, right: 20, bottom: 10),
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Masukkan email anda untuk melakukan reset password',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Form(
                    key: _forgotPasswordFormKey,
                    autovalidateMode: AutovalidateMode.always,
                    child: ReusableFormField(
                      controller: _forgotPasswordEmailController,
                      obscureText: false,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Bidang ini tidak boleh kosong';
                        }
                        if (!validEmail.hasMatch(text)) {
                          return msgInvalidEmail;
                        }
                        return null;
                      },
                      onChanged: (text) {
                        setState(() {
                          _isButtonEnabled = true;
                        });
                      },
                      label: 'Email',
                      hint: 'johndoe@example.com',
                    ),
                  ),
                ),
                Builder(builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: SizedBox(
                      width: double.infinity,
                      child:
                          BlocListener<ResetPasswordCubit, ResetPasswordState>(
                        listener: (context, resetPasswordState) {
                          if (resetPasswordState.resetStatus ==
                              ResetPasswordStatus.sendingRequest) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Mengirimkan email reset password...'),
                              ),
                            );
                          } else if (resetPasswordState.resetStatus ==
                              ResetPasswordStatus.resetPasswordSuccess) {
                            Navigator.of(context).pop();
                            Navigator.of(context)
                                .pushReplacementNamed('/sign-in-screen');
                            showDialog(
                              context: context,
                              builder: (context) => ReusableAlertDialog(
                                title: 'Permintaan Berhasil',
                                content:
                                    'Silahkan cek email yang terdaftar dan ikuti link yang diberikan untuk merubah password.',
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
                          } else if (resetPasswordState.resetStatus ==
                              ResetPasswordStatus.resetPasswordFailed) {
                            showDialog(
                              context: context,
                              builder: (context) => ReusableAlertDialog(
                                title: 'Terdapat Kesalahan',
                                content: resetPasswordState.errorMessage!,
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
                                  resetPasswordCubit.resetPassword(
                                      _forgotPasswordEmailController.text);
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
                            'RESET PASSWORD',
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
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
