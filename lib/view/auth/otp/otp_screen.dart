import 'package:e_voting/controller/otp_controller.dart';
import 'package:e_voting/core/constant.dart';
import 'package:e_voting/view/auth/otp/widget/otp_screen_top_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Halaman untuk input OTP
class OTPScreen extends StatelessWidget {
  final String email;

  final List<TextEditingController> otpControllers = List.generate(
      6, (_) => TextEditingController()); // Kontroller untuk 6 input OTP
  final OTPController otpController = Get.put(OTPController());

  OTPScreen({super.key, required this.email}); // Inisialisasi OTPController

  // Membuat widget untuk input OTP
  Widget _buildOTPFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(6, (index) {
        return SizedBox(
          width: 40,
          child: TextField(
            controller: otpControllers[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1, // Maksimal 1 karakter
            decoration: const InputDecoration(
              counterText: '', // Hilangkan hitungan karakter
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              if (value.isNotEmpty && index < 5) {
                FocusScope.of(Get.context!)
                    .nextFocus(); // Pindah ke input berikutnya
              } else if (value.isEmpty && index > 0) {
                FocusScope.of(Get.context!)
                    .previousFocus(); // Kembali ke input sebelumnya
              }
              otpController
                  .checkOTPFields(otpControllers); // Periksa semua field OTP
            },
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 120),
              const OTPScreenTopImage(),
              const SizedBox(height: defaultPadding),
              _buildOTPFields(),
              const SizedBox(height: defaultPadding),
              Obx(() => TextButton(
                    onPressed: otpController.isResendEnabled.value
                        ? () => otpController.resendOTP(email)
                        : null, // Tombol resend
                    child: Text(
                      otpController.isResendEnabled.value
                          ? 'Kirim Ulang OTP'
                          : 'Kirim Ulang OTP dalam ${otpController.resendCooldown.value} detik',
                    ),
                  )),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: otpController.isSubmitEnabled.value &&
                        !otpController.isLoading.value
                    ? Colors.blue
                    : Colors.blue.withOpacity(
                        0.5), // Warna biru dengan transparansi jika disabled
              ),
              onPressed: otpController.isSubmitEnabled.value &&
                      !otpController.isLoading.value
                  ? () => otpController.verifyOTP(otpControllers, email)
                  : null, // Tombol submit di bawah
              child: otpController.isLoading.value
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
            )),
      ),
    );
  }
}
