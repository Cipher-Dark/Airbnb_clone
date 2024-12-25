import Flutter
import UIKit
import GoogelMaps

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    [GMSServices provideAPIKey:@"AIzaSyCPqbMGmxaKQPGZ6aMSGDps2rRNowzjjbM"];
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
