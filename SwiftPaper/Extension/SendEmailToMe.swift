//
//  SendEmailToMe.swift
//  iSubscribe
//
//  Created by 吕丁阳 on 2021/2/25.
//

import Foundation
//import SwiftUI
//import UIKit
//import MessageUI
//
//struct MailView: UIViewControllerRepresentable {
//    
//    @Environment(\.presentationMode) var presentation
//    @Binding var result: Result<MFMailComposeResult, Error>?
//    
//    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
//        
//        @Binding var presentation: PresentationMode
//        @Binding var result: Result<MFMailComposeResult, Error>?
//        
//        init(presentation: Binding<PresentationMode>,
//             result: Binding<Result<MFMailComposeResult, Error>?>) {
//            _presentation = presentation
//            _result = result
//        }
//        
//        func mailComposeController(_ controller: MFMailComposeViewController,
//                                   didFinishWith result: MFMailComposeResult,
//                                   error: Error?) {
//            defer {
//                $presentation.wrappedValue.dismiss()
//            }
//            guard error == nil else {
//                self.result = .failure(error!)
//                return
//            }
//            self.result = .success(result)
//        }
//    }
//    
//    func makeCoordinator() -> Coordinator {
//        return Coordinator(presentation: presentation,
//                           result: $result)
//    }
//    
//    func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
//        let vc = MFMailComposeViewController()
//        vc.setToRecipients(["support@iswiftai.com"])
//        vc.mailComposeDelegate = context.coordinator
//        return vc
//    }
//    
//    func updateUIViewController(_ uiViewController: MFMailComposeViewController,
//                                context: UIViewControllerRepresentableContext<MailView>) {
//        
//    }
//}
//struct MailComposeViewController: UIViewControllerRepresentable {
//    
//    var toRecipients: [String]
//    var mailBody: String
//    
//    var didFinish: ()->()
//    
//    func makeCoordinator() -> Coordinator {
//        return Coordinator(self)
//    }
//    
//    func makeUIViewController(context: UIViewControllerRepresentableContext<MailComposeViewController>) -> MFMailComposeViewController {
//        
//        let mail = MFMailComposeViewController()
//        mail.mailComposeDelegate = context.coordinator
//        mail.setToRecipients(self.toRecipients)
//        mail.setMessageBody(self.mailBody, isHTML: true)
//        
//        return mail
//    }
//    
//    final class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
//        
//        var parent: MailComposeViewController
//        
//        init(_ mailController: MailComposeViewController) {
//            self.parent = mailController
//        }
//        
//        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
//            parent.didFinish()
//            controller.dismiss(animated: true)
//        }
//    }
//    
//    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: UIViewControllerRepresentableContext<MailComposeViewController>) {
//        
//    }
//}

