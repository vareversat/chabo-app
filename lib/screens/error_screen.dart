import 'package:chabo_app/custom_properties.dart';
import 'package:chabo_app/custom_widget_state.dart';
import 'package:chabo_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatefulWidget {
  final String errorMessage;

  /// Optional callback invoked when the user taps the retry button. When `null`
  /// (the default) the retry button is not displayed.
  final VoidCallback? onRetry;

  const ErrorScreen({super.key, required this.errorMessage, this.onRetry});

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
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: CustomProperties.padding,
          ),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${AppLocalizations.of(context)!.errorScreenContentTechnical_Info} : ${widget.errorMessage}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      if (widget.onRetry != null) ...[
                        const SizedBox(height: 16),
                        FilledButton.tonalIcon(
                          onPressed: widget.onRetry,
                          icon: const Icon(Icons.refresh),
                          label: Text(
                            AppLocalizations.of(context)!.refreshData,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
