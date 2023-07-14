import 'dart:developer' as developer;

import 'package:google_mobile_ads/google_mobile_ads.dart';

class ConsentFormService {
  final ConsentRequestParameters consentRequestParameters;

  ConsentFormService({required this.consentRequestParameters});

  void showConsentForm() {
    ConsentInformation.instance.requestConsentInfoUpdate(
      consentRequestParameters,
      () {
        /// Check if one form is available
        ConsentInformation.instance.isConsentFormAvailable().then(
              (value) => {
                developer.log(
                  'Is a form available : $value',
                  name: 'consent-form-service._loadConsentForm',
                ),
                if (value) _loadConsentForm(),
              },
            );
      },
      (FormError formError) {
        developer.log(
          '##### Error while loading the consent form : ${formError.message}',
          name: 'consent-form-service.showConsentForm',
        );
      },
    );
  }

  void _loadConsentForm() {
    ConsentForm.loadConsentForm(
      (ConsentForm consentForm) {
        /// Check if the form has to be displayed
        ConsentInformation.instance.getConsentStatus().then((value) => {
              developer.log(
                'Form consent status : ${value.name}',
                name: 'consent-form-service._loadConsentForm',
              ),
              if (value == ConsentStatus.required)
                {
                  consentForm.show(
                    (FormError? formError) {
                      developer.log(
                        '##### Error while loading the consent form : ${formError?.message}',
                        name: 'consent-form-service._loadConsentForm',
                      );
                      _loadConsentForm();
                    },
                  ),
                },
            });
      },
      (FormError formError) {
        developer.log(
          '##### Error while loading the consent form : ${formError.message}',
          name: 'consent-form-service._loadConsentForm',
        );
      },
    );
  }
}
