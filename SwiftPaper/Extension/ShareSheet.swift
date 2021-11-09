//
//  ShareSheet.swift
//  iSubscribe
//
//  Created by 吕丁阳 on 2021/10/3.
//

import Foundation
import UIKit
import SwiftUI

// For iPhone
func ShareAppSheet() {
    // UIActivityViewController
    let controller = UIActivityViewController(activityItems: [AppURL], applicationActivities: nil)
    UIApplication.shared.keyWindow?.rootViewController?.present(controller, animated: true, completion: nil)
}

extension UIApplication {
    
    var keyWindow: UIWindow? {
        // Get connected scenes
        return UIApplication.shared.connectedScenes
            // Keep only active scenes, onscreen and visible to the user
            .filter { $0.activationState == .foregroundActive }
            // Keep only the first `UIWindowScene`
            .first(where: { $0 is UIWindowScene })
            // Get its associated windows
            .flatMap({ $0 as? UIWindowScene })?.windows
            // Finally, keep only the key window
            .first(where: \.isKeyWindow)
    }
}


// For iPad
struct ActivityViewController: UIViewControllerRepresentable {

    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityViewController>) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityViewController>) {}

}

var AppURL = URL(string: "https://itunes.apple.com/app/id1594295556")!
