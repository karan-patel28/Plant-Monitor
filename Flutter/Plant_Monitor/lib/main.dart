import 'dart:async';

// Import packages
import 'package:at_app_flutter/at_app_flutter.dart' show AtEnv;
import 'package:at_client_mobile/at_client_mobile.dart';
import 'package:at_onboarding_flutter/at_onboarding_flutter.dart';
import 'package:at_utils/at_logger.dart' show AtSignLogger;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart'
    show getApplicationSupportDirectory;
import 'Pages/HomePage.dart';

/// Logger to log messages related to the @sign
final AtSignLogger _logger = AtSignLogger(AtEnv.appNamespace);

/// Entry point of the application
Future<void> main() async {
  // Load environment variables from .env file using AtEnv
  try {
    await AtEnv.load();
  } catch (e) {
    _logger.finer('Environment failed to load from .env: ', e);
  }

  runApp(const MyApp());
}

/// Function to load [AtClientPreference] for the [AtClientMobile].
/// Returns a [Future] that completes with an [AtClientPreference] instance.
Future<AtClientPreference> loadAtClientPreference() async {
  // Get the application support directory
  var dir = await getApplicationSupportDirectory();

  // Create an instance of AtClientPreference and set its properties
  return AtClientPreference()
    ..rootDomain = AtEnv.rootDomain
    ..namespace = AtEnv.appNamespace
    ..hiveStoragePath = dir.path
    ..commitLogPath = dir.path
    ..isLocalStoreRequired = true;
}

/// Root widget of the application
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Load [AtClientPreference] in the background
  Future<AtClientPreference> futurePreference = loadAtClientPreference();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // The onboarding screen (first screen)
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Plant Monitor',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.lightGreen,
        ),
        body: Builder(
          builder: (context) => Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.lightGreen,
              ),
              onPressed: () async {
                // Perform the onboarding process
                AtOnboardingResult onboardingResult =
                    await AtOnboarding.onboard(
                  context: context,
                  config: AtOnboardingConfig(
                    atClientPreference: await futurePreference,
                    rootEnvironment: AtEnv.rootEnvironment,
                    domain: AtEnv.rootDomain,
                    appAPIKey: AtEnv.appApiKey,
                  ),
                );

                // Handle the result of the onboarding process
                switch (onboardingResult.status) {
                  case AtOnboardingResultStatus.success:
                    // If onboarding is successful, navigate to the HomePage
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => HomePage()));
                    break;
                  case AtOnboardingResultStatus.error:
                    // If an error occurred during onboarding, show an error message
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text('An error has occurred'),
                      ),
                    );
                    break;
                  case AtOnboardingResultStatus.cancel:
                    // If onboarding is canceled, do nothing
                    break;
                }
              },
              child: const Text(
                'Onboard an @sign',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
