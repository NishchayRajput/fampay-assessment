import 'package:url_launcher/url_launcher.dart';

Future<void> tryLaunch(String? url) async {
  if (url == null || url.trim().isEmpty) return;
  final uri = Uri.tryParse(url);
  if (uri == null) return;
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}