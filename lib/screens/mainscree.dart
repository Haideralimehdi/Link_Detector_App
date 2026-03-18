import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../controller/controller.dart';
// import '../controllers/controller.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final LinkCheckerController _linkCheckerController = Get.put(
    LinkCheckerController(),
  );
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "🔗 Link Checker",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Shield Icon
            const Icon(Icons.shield, size: 100, color: Colors.blueAccent),
            const SizedBox(height: 16),

            // Heading Text
            Text(
              "Check if a link is safe or dangerous!",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 10),

            // Sub Text
            Text(
              "Paste any URL below and tap the button to scan it with Google Safe Browsing API.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),

            const SizedBox(height: 30),

            // Input Field
            TextField(
              controller: _linkCheckerController.linkController,
              keyboardType: TextInputType.url,
              decoration: InputDecoration(
                hintText: "https://example.com",
                prefixIcon: const Icon(Icons.link),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Check Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: _linkCheckerController.checkLink,
                icon: const Icon(Icons.search),
                label: const Text("Check Link", style: TextStyle(fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Result or Loading
            Obx(() {
              if (_linkCheckerController.isLoading.value) {
                return const SpinKitRipple(
                  color: Colors.blueAccent,
                  size: 80.0,
                );
              } else if (_linkCheckerController.result.value.isNotEmpty) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: _linkCheckerController.isSafe.value
                        ? Colors.green[50]
                        : Colors.red[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _linkCheckerController.isSafe.value
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        _linkCheckerController.isSafe.value
                            ? Icons.check_circle_outline
                            : Icons.warning_amber_rounded,
                        size: 50,
                        color: _linkCheckerController.isSafe.value
                            ? Colors.green
                            : Colors.red,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _linkCheckerController.result.value,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: _linkCheckerController.isSafe.value
                              ? Colors.green[800]
                              : Colors.red[800],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            }),
          ],
        ),
      ),
    );
  }
}
