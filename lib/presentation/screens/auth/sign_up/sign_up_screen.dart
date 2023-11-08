import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:janganan/bloc/cubit/cubit/sign_up_cubit.dart';
import 'package:janganan/presentation/widgets/reusable_alert_dialog.dart';
import 'package:janganan/presentation/widgets/reusable_elevated_button.dart';
import 'package:janganan/presentation/widgets/reusable_form_field.dart';
import 'package:janganan/presentation/widgets/reusable_progress_dialog.dart';
import 'package:janganan/utils/regex_validator.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isTermsAccepted = false;
  bool _isPasswordVisible = false;
  bool _isPasswordMatchVisible = false;
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordMatchController = TextEditingController();
  final _registerFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final signUpCubit = BlocProvider.of<SignUpCubit>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Text(
                    'Pendaftaran Pengguna',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                ),
                Form(
                  key: _registerFormKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    children: [
                      ReusableFormField(
                        controller: _usernameController,
                        obscureText: false,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return msgEmptyField;
                          }
                          if (text.length < 3) {
                            return msgMinInput;
                          }
                          if (!validCharacters.hasMatch(text)) {
                            return msgInvalidCharacters;
                          }
                          return null;
                        },
                        label: 'Nama',
                        hint: 'John Doe',
                      ),
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
                        controller: _phoneController,
                        obscureText: false,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Bidang ini tidak boleh kosong.';
                          }
                          if (!validPhone.hasMatch(text)) {
                            return msgInvalidPhone;
                          }
                          return null;
                        },
                        label: 'Telepon',
                        hint: '080808080808',
                      ),
                      ReusableFormField(
                        controller: _passwordController,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                        obscureText: !_isPasswordVisible,
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
                      ReusableFormField(
                        controller: _passwordMatchController,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isPasswordMatchVisible =
                                  !_isPasswordMatchVisible;
                            });
                          },
                          icon: Icon(
                            _isPasswordMatchVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                        obscureText: !_isPasswordMatchVisible,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Bidang ini tidak boleh kosong.';
                          }
                          if (!validPassword.hasMatch(text)) {
                            return msgInvalidPassword;
                          }
                          if (text != _passwordController.text) {
                            return msgPasswordDidNotMatch;
                          }
                          return null;
                        },
                        label: 'Ulangi Password',
                        hint: 'Min 8 karakter, angka, huruf kapital',
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Terms and Agreement',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                      Checkbox(
                          value: _isTermsAccepted,
                          onChanged: (bool? newValue) {
                            setState(() {
                              _isTermsAccepted = newValue!;
                            });
                          }),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: SizedBox(
                    width: double.infinity,
                    child: BlocListener<SignUpCubit, SignUpState>(
                      listener: (context, signUpState) {
                        if (signUpState.status == SignUpStatus.sendingRequest) {
                          showDialog(
                            context: context,
                            builder: (context) =>
                                const ReusableProgressDialog(),
                          );
                        } else if (signUpState.status == SignUpStatus.success) {
                          Navigator.pop(context);
                          Navigator.of(context)
                              .pushReplacementNamed('/sign-in-screen');
                          showDialog(
                            context: context,
                            builder: (context) => ReusableAlertDialog(
                              title: 'Pendaftaran Berhasil',
                              content:
                                  'Selamat pendaftaran telah berhasil, silahkan melakukan login.',
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
                        } else {
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (context) => ReusableAlertDialog(
                              title: 'Terdapat Kesalahan',
                              content: signUpState.errorMessage!,
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
                      child: ReusableElevatedButton(
                        onPressed: _isTermsAccepted
                            ? () {
                                if (_registerFormKey.currentState!.validate()) {
                                  signUpCubit.signUpFormSubmitted(
                                    _usernameController.text,
                                    _emailController.text,
                                    _passwordController.text,
                                    _phoneController.text,
                                  );
                                }
                              }
                            : null,
                        text: 'REGISTER',
                      ),
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
