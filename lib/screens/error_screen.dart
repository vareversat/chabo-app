import 'package:chabo_app/custom_widget_state.dart';
import 'package:chabo_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatefulWidget {
  final String errorMessage;

  const ErrorScreen({super.key, required this.errorMessage});

  @override
  State<StatefulWidget> createState() {
    return _ErrorScreenState();
  }
}

class _ErrorScreenState extends CustomWidgetState<ErrorScreen> {
  _ErrorScreenState() : super(screenName: 'error-screen');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.errorScreenContentError,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    AppLocalizations.of(context)!.errorScreenContentMessage,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 100.0),
                child: Text(
                  '${AppLocalizations.of(context)!.errorScreenContentTechnical_Info} : ${widget.errorMessage}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
