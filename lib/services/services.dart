// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants/constant.dart';

class LinkCheckerService {
  static Future<bool> checkUrlSafety(String url) async {
    final body = {
      "client": {"clientId": "your-link-checker-app", "clientVersion": "1.0"},
      "threatInfo": {
        "threatTypes": ["MALWARE", "SOCIAL_ENGINEERING", "UNWANTED_SOFTWARE"],
        "platformTypes": ["ANY_PLATFORM"],
        "threatEntryTypes": ["URL"],
        "threatEntries": [
          {"url": url},
        ],
      },
    };

    final response = await http.post(
      Uri.parse(ApiConstant.endpoint),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("Response=> $data");
      return data['matches'] == null; // If no matches, the link is safe
    } else {
      throw Exception("Failed to check link: ${response.statusCode}");
    }
  }
}
