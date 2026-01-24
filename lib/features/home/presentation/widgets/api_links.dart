import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class ApiLinks extends StatelessWidget {
  const ApiLinks({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = TextTheme.of(
      context,
    ).bodyLarge?.copyWith(fontWeight: FontWeight.bold);

    return Text.rich(
      TextSpan(
        style: textStyle,
        children: [
          const TextSpan(text: 'APIs: '),
          _buildLink(
            label: 'OpenWeather',
            url: 'https://openweathermap.org',
            style: textStyle,
          ),
          const TextSpan(text: ', '),
          _buildLink(
            label: 'GeoDB Cities',
            url: 'https://rapidapi.com/wirefreethought/api/geodb-cities',
            style: textStyle,
          ),
        ],
      ),
    );
  }

  WidgetSpan _buildLink({
    required String label,
    required String url,
    TextStyle? style,
  }) {
    return WidgetSpan(
      alignment: PlaceholderAlignment.baseline,
      baseline: TextBaseline.alphabetic,
      child: Link(
        uri: Uri.parse(url),
        target: LinkTarget.defaultTarget,
        builder: (context, followLink) {
          return MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => _openUrl(url),
              behavior: HitTestBehavior.opaque,
              child: Text(label, style: style),
            ),
          );
        },
      ),
    );
  }

  Future<void> _openUrl(String url) async {
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $uri');
    }
  }
}
