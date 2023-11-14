import 'package:flutter/material.dart';
import 'package:janganan/presentation/widgets/reusable_form_field.dart';
import 'package:janganan/utils/constants/colors.dart';
import 'package:janganan/utils/regex_validator.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _forgotPasswordEmailController = TextEditingController();
  final _forgotPasswordFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Bidang ini tidak boleh kosong';
                        }
                        if (!validEmail.hasMatch(text)) {
                          return msgInvalidEmail;
                        }
                        return null;
                      },
                      label: 'Email',
                      hint: 'johndoe@example.com',
                    ),
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
    );
  }
}
