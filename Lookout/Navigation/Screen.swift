//
//  Screen.swift
//  Lookout
//
import Foundation

// Every destination that can be pushed onto the app's single navigation stack.
// Add a case here, add its view to RootView's destination switch, and it's wired in.
enum Screen: Hashable {
    // Account
    case welcome
    case logIn
    case createAccount

    // Onboarding
    case roles
    case timeline
    case notifications
    case noNotifs
    case firstApplication
    case submitFirst

    // Main app
    case mainNavScreen
    case addScreen
}
