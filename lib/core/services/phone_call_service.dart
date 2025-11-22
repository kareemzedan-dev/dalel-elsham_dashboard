import 'package:url_launcher/url_launcher.dart';

class PhoneCallService {
  static Future<void> callNumber(String phoneNumber) async {
    final cleaned = phoneNumber.replaceAll(RegExp(r'[^0-9]'), "");
    final Uri uri = Uri(scheme: 'tel', path: cleaned);

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception("لا يمكن فتح تطبيق الاتصال");
    }
  }
}
