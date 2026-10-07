//
//  ViewModel.swift
//  Lookout
//
import Foundation
import Observation

// MARK: - User Enum
struct User{
    let name: String
    let email: String
    let password: String
}

// MARK: - Job Related Enums
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
/// One of the fields below is missing information
enum EmptyAccountInfo{
    case name
    case email
    case password
    /// resets the UI when there are no issues
    case reset
}
/// Password specific issues. Right now it only checks if the password is weak.
/// In the future this is where it will check if contains the right amount of characters, special characters, etc.
enum PasswordInfo{
    case weak
    /// resets the UI when there are no  issues
    case reset
}
/// When creating an accout, an AccountError can generate.
/// Each Account Error will have a sub type with additional information
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
    
    // current signed in user. Nil means no user is signed in
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
            let randomRole = roles.randomElement()!
            let randomCompany = companies.randomElement()!
            let randomSource = sources.randomElement()!
            let randomStatus = statuses.randomElement()!
            
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
        if firstName.isEmpty { UIElement(.emptyAccountInfo(.name)); return }
        else if email.isEmpty { UIElement(.emptyAccountInfo(.email)); return }
        else if password.isEmpty { UIElement(.emptyAccountInfo(.password)); return}
        else {UIElement(.emptyAccountInfo(.reset))}
        
        if passwordStrength == .weak && !password.isEmpty { UIElement(.passwordInfo(.weak)); return}
        else { UIElement(.passwordInfo(.reset))}
        
        let user = User(name: firstName, email: email, password: password)
        users.append(user)
        loggedInUser = user
        
    }
    // login method, returns true on success, false otherwise
    func login(email: String, password: String) -> Bool{
        for user in users{
            if user.email == email && user.password == password{
                loggedInUser = user
                return true
            }
        }
        return false
    }
}
