import 'package:flutter/material.dart';
import 'package:janganan/utils/constants/colors.dart';

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
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: TextFormField(
                            controller: _usernameController,
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Bidang ini tidak boleh kosong.';
                              }
                              if (text.length < 3) {
                                return 'Minimal 3 karakter.';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Nama',
                              hintText: 'Nama',
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: TextFormField(
                            controller: _emailController,
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Bidang ini tidak boleh kosong.';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Email',
                              hintText: 'Email',
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: TextFormField(
                            controller: _phoneController,
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Bidang ini tidak boleh kosong.';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Telepon',
                              hintText: 'Telepon',
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: TextFormField(
                            controller: _passwordController,
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Bidang ini tidak boleh kosong.';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Password',
                              hintText: 'Password',
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: TextFormField(
                            controller: _passwordMatchController,
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Bidang ini tidak boleh kosong.';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Ulangi Password',
                              hintText: 'Ulangi Password',
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
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
