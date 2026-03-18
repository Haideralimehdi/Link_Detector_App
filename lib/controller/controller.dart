import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/services.dart';
// import '../services/service.dart';

class LinkCheckerController extends GetxController {
  final TextEditingController linkController = TextEditingController();

  var isLoading = false.obs;
  var result = ''.obs;
  var isSafe = true.obs;

  void checkLink() async {
    String url = linkController.text.trim();

    if (url.isEmpty) {
      Get.snackbar("Error", "Please enter a valid URL");
      return;
    }

    isLoading.value = true;
    result.value = '';
    isSafe.value = true;

    try {
      bool safe = await LinkCheckerService.checkUrlSafety(url);
      isSafe.value = safe;

      if (safe) {
        result.value = "✅ This link appears to be safe.";
      } else {
        result.value = "⚠️ Warning! This link may be malicious or phishing.";
      }
    } catch (e) {
      result.value = "Something went wrong while checking the link.";
      isSafe.value = false;
    } finally {
      isLoading.value = false;
    }
  }
}
