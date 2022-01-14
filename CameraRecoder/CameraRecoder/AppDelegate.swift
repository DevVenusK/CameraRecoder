//
//  AppDelegate.swift
//  CameraRecoder
//
//  Created by Ppop on 2022/01/14.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = ViewController(
            dependency: .init(
                cameraRecoder: CameraRecoder(
                    avCaptureSession: AVCaptureSessionFactory()
                )
            )
        )
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}

