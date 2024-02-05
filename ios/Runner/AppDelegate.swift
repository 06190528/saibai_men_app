import UIKit
import Flutter
import StoreKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  private var channel: FlutterMethodChannel?
  
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    guard let controller = window?.rootViewController as? FlutterViewController else {
      fatalError("Invalid root view controller")
    }
    channel = FlutterMethodChannel(name: "app.channel.shared/review", binaryMessenger: controller.binaryMessenger)
    channel?.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      if call.method == "requestReview" {
        self.requestReview()
      } else {
        result(FlutterMethodNotImplemented)
      }
    })
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func requestReview() {
    if #available(iOS 10.3, *) {
      SKStoreReviewController.requestReview()
    }
  }
}
