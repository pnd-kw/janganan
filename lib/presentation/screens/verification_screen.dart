import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:janganan/bloc/cubit/cubit/verification_cubit.dart';
import 'package:janganan/utils/constants/colors.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  bool _onEditing = true;
  String? _code;

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
                          content: Text('Sedang mengirimkan kode OTP.')));
                    } else if (verificationState.status ==
                        VerificationStatus.verifying) {
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
                                    Theme.of(context).colorScheme.background),
                                strokeWidth: 5,
                              ),
                            ),
                          ),
                        ),
                      );
                    } else if (verificationState.status ==
                        VerificationStatus.verificationCompleted) {
                      Navigator.of(context)
                          .pushReplacementNamed('/screen-navigation');
                    } else if (verificationState.status ==
                        VerificationStatus.verificationFailed) {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Verification Failed'),
                          content: const Text(
                              'Verifikasi gagal, periksa kembali kode otp atau koneksi internet.'),
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
                  builder: (context, verificationState) {
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
                                      verificationCubit.requestOtp();
                                      verificationCubit.startCountdown();
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.secondaryColor,
                              ),
                              child: verificationState.status ==
                                      VerificationStatus.codeSent
                                  ? Text(
                                      // verificationCubit.state.countdownText,
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}