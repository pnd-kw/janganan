import 'package:flutter/material.dart';
import 'package:janganan/utils/constants/colors.dart';
import 'package:janganan/utils/regex_validator.dart';

import '../widgets/reusable_form_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isChecked = false;
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordMatchController = TextEditingController();
  final _registerFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10, top: 50, right: 10, bottom: 10),
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
                          hint: 'Contoh Xa8ji4opq9',
                        ),
                        ReusableFormField(
                          controller: _passwordMatchController,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Bidang ini tidak boleh kosong.';
                            }
                            if (!validPassword.hasMatch(text)) {
                              return msgInvalidPassword;
                            }
                            return null;
                          },
                          label: 'Ulangi Password',
                          hint: 'Contoh Xa8ji4opq9',
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Terms and Agreement',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                        ),
                        Checkbox(
                            value: _isChecked,
                            onChanged: (bool? newValue) {
                              setState(() {
                                _isChecked = newValue!;
                              });
                            }),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
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
                          'REGISTER',
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
