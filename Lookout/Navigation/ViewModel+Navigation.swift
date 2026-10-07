//
//  ViewModel+Navigation.swift
//  Lookout
//
import Foundation

//  All navigation logic for the app lives here so every screen drives
//  navigation through the ViewModel instead of managing its own state.
//  RootView owns the single NavigationStack bound to `vm.path`. These
//  methods are the only thing that should ever mutate it.
extension ViewModel {
    // Pushes a new screen on top of the stack. Use this for normal
    // "forward" navigation where the user should be able to go back.
    func push(_ screen: Screen) {
        path.append(screen)
    }

    // Pops the top screen off the stack. Use this for custom back
    // controls (i.e. PageBar's back chevron) or "Cancel"/"Save" buttons
    // that should return to the previous screen.
    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }

    // Clears the entire stack. Rarely needed directly, prefer `setRoot`.
    func popToRoot() {
        path.removeAll()
    }

    // Replaces the top of the stack with a different screen, instead of
    // pushing on top of it. Use this when two screens are siblings that
    // should swap for one another without growing the back stack
    // (e.g. Log In <-> Create Account).
    func replaceTop(with screen: Screen) {
        if path.isEmpty {
            path.append(screen)
        } else {
            path[path.count - 1] = screen
        }
    }

    // Clears the stack and starts fresh at `screen`, so there is nothing
    // left to go back to. Use this when a flow finishes and the user
    // should not be able to return to it (e.g. after login/signup, or
    // finishing onboarding). Pair with `.navigationBarBackButtonHidden(true)`
    // on that screen, since a back button would still appear otherwise.
    func setRoot(_ screen: Screen) {
        path = [screen]
    }
}
