import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:janganan/bloc/cubit/cubit/sign_in_cubit.dart';
import 'package:janganan/presentation/widgets/reusable_alert_dialog.dart';
import 'package:janganan/presentation/widgets/reusable_elevated_button.dart';
import 'package:janganan/presentation/widgets/reusable_form_field.dart';
import 'package:janganan/presentation/widgets/reusable_progress_dialog.dart';
import 'package:janganan/utils/constants/colors.dart';
import 'package:janganan/utils/regex_validator.dart';

class LinkGoogleScreen extends StatefulWidget {
  const LinkGoogleScreen({super.key});

  @override
  State<LinkGoogleScreen> createState() => _LinkGoogleScreenState();
}

class _LinkGoogleScreenState extends State<LinkGoogleScreen> {
  bool _isPasswordLinkToGoogleVisible = false;
  final _passwordToLinkGoogleController = TextEditingController();
  final _linkGoogleFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final signInCubit = BlocProvider.of<SignInCubit>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
        child: Container(
          height: 500,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  offset: const Offset(0, 3),
                )
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    height: 20,
                    decoration: const BoxDecoration(
                      color: AppColor.secondaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: 50,
                  child: Image.asset(
                    'assets/images/google-logo.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Text(
                    'Terdeteksi akun dengan email yang sama, masukkan password untuk mengaitkan.',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Form(
                    key: _linkGoogleFormKey,
                    autovalidateMode: AutovalidateMode.always,
                    child: ReusableFormField(
                      controller: _passwordToLinkGoogleController,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isPasswordLinkToGoogleVisible =
                                !_isPasswordLinkToGoogleVisible;
                          });
                        },
                        icon: Icon(_isPasswordLinkToGoogleVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                      obscureText: !_isPasswordLinkToGoogleVisible,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Bidang ini tidak boleh kosong.';
                        }
                        if (!validPassword.hasMatch(text)) {
                          return msgInvalidPassword;
                        }
                        return null;
                      },
                      label: 'Password',
                      hint: 'Min 8 karakter, angka, huruf kapital',
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: BlocListener<SignInCubit, SignInState>(
                      listener: (context, signInState) {
                        if (signInState.linkStatus == LinkStatus.linking) {
                          showDialog(
                            context: context,
                            builder: (context) =>
                                const ReusableProgressDialog(),
                          );
                        } else if (signInState.linkStatus ==
                            LinkStatus.linked) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/screen-navigation', (route) => false);
                        } else if (signInState.linkStatus ==
                            LinkStatus.failed) {
                          showDialog(
                            context: context,
                            builder: (context) => ReusableAlertDialog(
                              title: 'Terdapat Kesalahan',
                              content:
                                  'Gagal mengaitkan akun, periksa kembali credential anda.',
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
                                )
                              ],
                            ),
                          );
                        }
                        //   }
                        // }
                      },
                      child: ReusableElevatedButton(
                        onPressed: () {
                          if (_linkGoogleFormKey.currentState!.validate()) {
                            signInCubit.linkCredential(
                                _passwordToLinkGoogleController.text);
                          }
                        },
                        text: 'KAITKAN AKUN',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: ReusableElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/sign-in-screen', (route) => false);
                      },
                      text: 'GANTI METODE LAIN',
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
