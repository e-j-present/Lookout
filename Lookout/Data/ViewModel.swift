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

enum JobStatus: CaseIterable{
    case saved
    case applied
    case onlineAssesment
    case interviewing
    case offer
    
    var label: String{
        switch self{
        case .saved:
            return "Saved"
        case .applied:
            return "Applied"
        case .onlineAssesment:
            return "Online Assesment"
        case .interviewing:
            return "Interviewing "
        case .offer:
            return "Offer"
        @unknown default:
            return "Unknown Status"
        }
    }
}

// store job related info
struct Job: Hashable{
    let role: String
    let company: String
    let source: String
    var status: JobStatus
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
    // singleton class
    static let shared = ViewModel()

    // prevents external inits (ensures you always use shared)
    private init() {}

    // list of users with an account
    var users: [User] = [User(name: "John", email: "john@utexas.edu", password: "12345678")]
    
    var loggedInUser: User? = nil
    
    // list of jobs
    var jobs: [Job] = []

    // stack of pushed screens, on top of the root view in RootView. See ViewModel+Navigation.swift
    var path: [Screen] = []

    // method to create a job
    func createJob(job: Job){
        jobs.append(job)
    }
    
    // dummy method used for demostration that populates the jobs list with random data just to fill it
    func populateJobList(){
        let roles = ["iOS Developer", "Software Engineer", "Frontend Engineer", "Backend Developer", "Mobile Engineer", "Data Scientist", "Product Manager"]
        let companies = ["Apple", "Google", "Meta", "Netflix", "Amazon", "Spotify", "Stripe", "Airbnb", "Uber", "Lyft", "Microsoft"]
        let sources = ["LinkedIn", "Indeed", "Handshake"]
        let statuses = JobStatus.allCases
        
        var dummyJobs: [Job] = []
        
        for _ in 1...20 {
            let randomRole = roles.randomElement() ?? "Software Engineer"
            let randomCompany = companies.randomElement() ?? "Tech Corp"
            let randomSource = sources.randomElement() ?? "LinkedIn"
            let randomStatus = statuses.randomElement() ?? .saved
            
            let job = Job(role: randomRole, company: randomCompany, source: randomSource, status: randomStatus)
            dummyJobs.append(job)
        }
        
        jobs = dummyJobs
    }
    // dummy method used for demostration that removes all jobs from the list
    func clearJobList(){
        jobs = []
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
