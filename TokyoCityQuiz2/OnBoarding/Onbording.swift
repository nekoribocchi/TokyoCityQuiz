//
//  SwiftUIView.swift
//  TokyoCityQuiz2
//
//  Created by 羽田野真央 on 2025/02/26.
//

// In OnboardingView.swift
import SwiftUI
import UIOnboarding

struct OnboardingView: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIOnboardingViewController

    var onboardingCompleted: () -> Void // Onboarding 完了時の処理を受け取る

    func makeUIViewController(context: Context) -> UIOnboardingViewController {
        let onboardingController: UIOnboardingViewController = .init(withConfiguration: .setUp())
        onboardingController.delegate = context.coordinator
        return onboardingController
    }
    
    func updateUIViewController(_ uiViewController: UIOnboardingViewController, context: Context) {}
    
    class Coordinator: NSObject, UIOnboardingViewControllerDelegate {
        var parent: OnboardingView
        
        init(parent: OnboardingView) {
                    self.parent = parent
                }
        
        func didFinishOnboarding(onboardingViewController: UIOnboardingViewController) {
                onboardingViewController.modalTransitionStyle = .crossDissolve
                onboardingViewController.dismiss(animated: true) {
                    self.parent.onboardingCompleted() // Onboarding 終了時の処理を呼び出す
                }
            }
    }

    func makeCoordinator() -> Coordinator {
            return Coordinator(parent: self)
        }
}







