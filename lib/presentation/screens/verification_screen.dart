import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:janganan/bloc/cubit/cubit/sign_in_cubit.dart';
import 'package:janganan/bloc/cubit/cubit/verification_cubit.dart';
import 'package:janganan/presentation/widgets/reusable_alert_dialog.dart';
import 'package:janganan/presentation/widgets/reusable_progress_dialog.dart';
import 'package:janganan/utils/constants/colors.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  bool _onEditing = true;
  String? _code;
  int requestOtpCounter = 0;

  @override
  Widget build(BuildContext context) {
    final verificationCubit = BlocProvider.of<VerificationCubit>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  'Verification',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  'Please enter your 6 digit one-time password that has been sent to your mobile number',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SizedBox(
                child: VerificationCode(
                  textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                  keyboardType: TextInputType.number,
                  underlineColor: AppColor.secondaryColor,
                  length: 6,
                  itemSize: 40,
                  clearAll: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      'Clear All',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                  onCompleted: (String value) {
                    setState(() {
                      _code = value;
                    });
                  },
                  onEditing: (bool value) {
                    setState(() {
                      _onEditing = value;
                    });
                    if (!_onEditing) FocusScope.of(context).unfocus();
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SizedBox(
                child: BlocConsumer<VerificationCubit, VerificationState>(
                  listener: (context, verificationState) {
                    if (verificationState.status ==
                        VerificationStatus.requestingCode) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Meminta kode OTP....')));
                    } else if (verificationState.status ==
                        VerificationStatus.requestFailed) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(verificationState.errorMessage!)));
                    } else if (verificationState.status ==
                        VerificationStatus.verifying) {
                      showDialog(
                        context: context,
                        builder: (context) => const ReusableProgressDialog(),
                      );
                    } else if (verificationState.status ==
                        VerificationStatus.verificationCompleted) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/screen-navigation', (route) => false);
                    } else if (verificationState.status ==
                        VerificationStatus.verificationFailed) {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (context) => ReusableAlertDialog(
                          title: 'Verification Failed',
                          content: verificationState.errorMessage!,
                          // 'Verifikasi gagal kredensial tidak cocok, periksa kembali kode otp atau koneksi internet.',
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
                  builder: (context, verificationState) {
                    return BlocBuilder<SignInCubit, SignInState>(
                      builder: (context, signInState) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: SizedBox(
                                width: 300,
                                child: ElevatedButton(
                                  onPressed: verificationState.status ==
                                          VerificationStatus.codeSent
                                      ? null
                                      : () {
                                          if (requestOtpCounter < 2) {
                                            verificationCubit.requestOtp();
                                            verificationCubit.startCountdown();
                                            requestOtpCounter++;
                                          } else {
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  ReusableAlertDialog(
                                                title: 'Kesalahan',
                                                content:
                                                    'Permintaan terlalu sering, coba lagi lain waktu.',
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text(
                                                      'Tutup',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleMedium!
                                                          .copyWith(
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .onBackground),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                        },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColor.secondaryColor,
                                  ),
                                  child: verificationState.status ==
                                          VerificationStatus.codeSent
                                      ? Text(
                                          'REQUEST CODE AGAIN IN : ${verificationCubit.state.remainingTime}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .background),
                                        )
                                      : Text(
                                          'REQUEST CODE',
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
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: SizedBox(
                                width: 300,
                                child: ElevatedButton(
                                  onPressed: _code != null
                                      ? () {
                                          verificationCubit.verifyOtp(_code!);
                                        }
                                      : null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColor.secondaryColor,
                                  ),
                                  child: Text(
                                    'VERIFY',
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
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
