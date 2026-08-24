import 'package:chabo_app/custom_properties.dart';
import 'package:chabo_app/l10n/app_localizations.dart';
import 'package:material_ui/material_ui.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CreditsDialog extends StatelessWidget {
  final String credits;
  final String creditsLink;

  const CreditsDialog({
    super.key,
    required this.credits,
    required this.creditsLink,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(30),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(CustomProperties.borderRadius),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 20,
        children: [
          Text(credits),
          ElevatedButton.icon(
            iconAlignment: IconAlignment.end,
            onPressed: () => {
              launchUrlString(
                creditsLink,
                mode: LaunchMode.externalApplication,
              ),
            },
            label: Text(AppLocalizations.of(context)!.webSite),
            icon: Icon(Icons.open_in_new),
          ),
        ],
      ),
    );
  }
}
