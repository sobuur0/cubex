import 'package:url_launcher/url_launcher.dart';

class UrlLauncherService {
  static Future<bool> launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  static Future<bool> openGoogleMaps(String location) async {
    final encodedLocation = Uri.encodeComponent(location);
    final googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=$encodedLocation';
    return await launchURL(googleMapsUrl);
  }

  static Future<bool> openGoogleMapsWithCoordinates(
      double latitude, double longitude) async {
    final googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    return await launchURL(googleMapsUrl);
  }

  static Future<bool> openWebPage(String url) async {
    return await launchURL(url);
  }

  static Future<bool> makePhoneCall(String phoneNumber) async {
    final Uri uri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(uri)) {
      return await launchUrl(uri);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  static Future<bool> sendEmail(String email,
      {String subject = '', String body = ''}) async {
    final Uri uri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': subject,
        'body': body,
      },
    );
    if (await canLaunchUrl(uri)) {
      return await launchUrl(uri);
    } else {
      throw 'Could not launch $email';
    }
  }
}
