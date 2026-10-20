//
//  RootView.swift
//  Lookout
//
//  The app's single NavigationStack. Every screen is reachable by adding
//  a case to Screen and a branch below - no other view should declare its own NavigationStack or navigationDestination.
import SwiftUI
struct RootView: View {
    @Bindable var vm = ViewModel.shared

    var body: some View {
        NavigationStack(path: $vm.path) {
            Welcome()
                .navigationDestination(for: Screen.self) { screen in
                    destination(for: screen)
                }
        }
    }

    @ViewBuilder
    private func destination(for screen: Screen) -> some View {
        switch screen {
        case .welcome:
            Welcome()
        case .logIn:
            LogIn()
        case .createAccount:
            CreateAccount()

        case .roles:
            Roles()
        case .timeline:
            TimeLine()
        case .notifications:
            Notifications()
        case .noNotifs:
            NoNotifs()
        case .firstApplication:
            FirstApplication()
        case .submitFirst:
            SubmitFirst()

        case .mainNavScreen:
            MainNavScreen()
        case let .addScreen(roleText, companyText, sourceText, selectedStage):
            AddScreen(
                roleText: roleText,
                companyText: companyText,
                sourceText: sourceText,
                selectedStage: selectedStage
            )
        }
    }
}

#Preview {
    RootView()
}
