import UIKit
import Flutter
import StoreKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let reviewChannel = FlutterMethodChannel(name: "app.channel.shared/review",
                                              binaryMessenger: controller.binaryMessenger)
    reviewChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: FlutterResult) -> Void in
      if call.method == "requestReview" {
        if #available(iOS 10.3, *) {
          SKStoreReviewController.requestReview()
        }
      }
    })

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
