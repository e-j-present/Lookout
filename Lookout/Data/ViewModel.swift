//
//  ViewModel.swift
//  Lookout
//
//  Created by Ethan Present on 10/4/26.
//

import Foundation
import Observation

// store key user info
struct User{
    let name: String
    let email: String
    let password: String
}
// Navigation screens
enum Screen: Hashable{
    case createAccount
    case logIn
    case welcome
}

// MARK: - Create Account Enum Errors
enum EmptyAccountInfo{
    case name
    case email
    case password
    case reset
}
enum PasswordInfo{
    case weak
    case reset
}
// main enum for account errors. Everything above are subtypes
enum AccountErrors{
    case emptyAccountInfo(EmptyAccountInfo)
    case passwordInfo(PasswordInfo)
}

// MARK: - View Model
@Observable
final class ViewModel {
    static let shared = ViewModel()

    // prevents external inits (ensures you always use shared)
    private init() {}

    // list of users
    var users: [User] = [User(name: "John", email: "john@utexas.edu", password: "12345678")]

    // list of navigations
    var navigationPath: [Screen] = []

    // Navigates to the given account screen. Swapping between login and
    // create account replaces the top of the stack instead of pushing, so
    // the back button always lands back on Welcome.
    func go(to screen: Screen) {
        if navigationPath.isEmpty {
            navigationPath.append(screen)
        } else {
            navigationPath[navigationPath.count - 1] = screen
        }
    }
    
    // create an account, first checks user information (ie email not empty, password is good) and displays a UI element if there is an error
    func createAccount(firstName: String, email: String, password: String, passwordStrength: PasswordStrength, UIElement: (AccountErrors) -> Void){
        if firstName.isEmpty { UIElement(.emptyAccountInfo(.name))}
        else if email.isEmpty { UIElement(.emptyAccountInfo(.email))}
        else if password.isEmpty { UIElement(.emptyAccountInfo(.password))}
        else {UIElement(.emptyAccountInfo(.reset))}
        
        if passwordStrength == .weak && !password.isEmpty { UIElement(.passwordInfo(.weak))}
        else { UIElement(.passwordInfo(.reset))}
        
        
        users.append(User(name: firstName, email: email, password: password))
    }
    // login method, returns true on success, false otherwise
    func login(email: String, password: String) -> Bool{
        for user in users{
            if user.email == email && user.password == password{
                return true
            }
        }
        return false
    }
}
