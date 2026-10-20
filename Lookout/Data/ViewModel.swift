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
enum JobStatus: String, CaseIterable, Hashable{
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

enum JobSource: CaseIterable, Hashable{
    static var allCases: [JobSource] {
        return [.linkedin, .indeed, .handshake, .other(nil)]
    }
    
    case linkedin
    case indeed
    case handshake
    case other(String?)
    
    var label: String{
        switch self{
        case .linkedin:
            return "LinkedIn"
        case .indeed:
            return "Indeed"
        case .handshake:
            return "Handshake"
        case .other(let source):
            return source?.capitalized ?? "Other"
        }
    }
    
    static func stringToJobSource(_ string: String) -> JobSource {
        switch string.lowercased() {
        case "linkedin":
            return .linkedin
        case "indeed":
            return .indeed
        case "handshake":
            return .handshake
        default:
            return .other(string)
        }
    }
}

enum JobFilter: Hashable{
    case status(JobStatus)
    case source(JobSource)
    
    var type: String {
        switch self{
        case .status:
            return "status"
        case .source:
            return "source"
        }
    }
    
    var label: String {
        switch self{
        case .status(let s):
            return s.label
        case .source(let s):
            return s.label
        }
    }
}


// store job related info
struct Job: Identifiable{
    var role: String
    var company: String
    var source: JobSource
    var status: JobStatus
    var isFavorite: Bool = false
    let id = UUID()
}

// MARK: - Reminder Struct
struct Reminder: Identifiable{
    var date: Date!
    
    var year: Int
    var month: Int
    var day: Int
    var hour: Int?
    var min: Int?
    var title: String
    var company: String
    
    var id = UUID()
    
    private var components: DateComponents!
    
    init(year: Int, month: Int, day: Int, hour: Int? = nil, min: Int? = nil, title: String, company: String) {
        self.year = year
        self.month = month
        self.day = day
        self.hour = hour
        self.min = min
        self.title = title
        self.company = company
        
        self.components = DateComponents()
        
        updateDate(year: self.year, month: self.month, day: self.day, hour: self.hour, min: self.min)
    }
    
    init(date: Date, title: String, company: String) {
        self.date = date
        self.title = title
        self.company = company
        self.components = DateComponents()
        
        // Extract the exact integer components reliably using the user's current calendar
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        
        // Assign the extracted values
        self.year = dateComponents.year ?? -1
        self.month = dateComponents.month ?? -1
        self.day = dateComponents.day ?? -1
        
        // Matching your first init where hour and min are Int?
        self.hour = dateComponents.hour
        self.min = dateComponents.minute
        
        // Don't forget to sync everything if needed
        updateDate(year: self.year, month: self.month, day: self.day, hour: self.hour, min: self.min)
    }
    
    mutating func updateDate(year: Int? , month: Int?, day: Int?, hour: Int?, min: Int?){
        if let year = year{
            self.components.year = year
        }
        if let month = month{
            self.components.month = month
        }
        if let day = day{
            self.components.day = day
        }
        if let hour = hour{
            self.components.hour = hour
        }
        if let min = min{
            self.components.minute = min
        }
        
        self.date = Calendar.current.date(from: self.components)
    }
    
    func formatRelativeDate() -> String {
        let calendar = Calendar.current
        let now = Date()
        
        // Normalize dates to midnight to calculate accurate day differences
        let startOfNow = calendar.startOfDay(for: now)
        let startOfTarget = calendar.startOfDay(for: date)
        
        // Calculate the difference in days
        let dayComponents = calendar.dateComponents([.day], from: startOfNow, to: startOfTarget)
        guard let dayDifference = dayComponents.day else { return "" }
        
        // Determine the date prefix (Today, Tomorrow, X days/weeks ago, or Abbreviated Weekday)
        var datePrefix = ""
        
        if dayDifference == 0 {
            datePrefix = "Today"
        } else if dayDifference == 1 {
            datePrefix = "Tomorrow"
        } else if dayDifference < 0 {
            let absDays = abs(dayDifference)
            if absDays <= 7 {
                datePrefix = "\(absDays) \(absDays == 1 ? "day" : "days") ago"
            } else {
                let weeksAgo = absDays / 7
                datePrefix = "\(weeksAgo) \(weeksAgo == 1 ? "week" : "weeks") ago"
            }
        } else {
            // Future dates beyond tomorrow use the abbreviated weekday
            let weekdayFormatter = DateFormatter()
            weekdayFormatter.dateFormat = "E" // e.g., "Mon", "Tue"
            datePrefix = weekdayFormatter.string(from: date)
        }
        
        // Format the time component (12-hour format with am/pm)
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "h:mm a" // e.g., "3:30 PM"
        let timeString = timeFormatter.string(from: date).lowercased()
        
        return "\(datePrefix) \(timeString)"
    }
    
    func getMonthAsName() -> String{
        date.formatted(.dateTime.month(.abbreviated))
    }
    
    // used to turn the reminder into an alert in the dashboard
    // if the date is with x days of current date, return true, false otherwise
    func isWithinDays(days: Int) -> Bool {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let targetDate = calendar.startOfDay(for: date)

        guard let endDate = calendar.date(byAdding: .day, value: days, to: today) else {
            return false
        }

        return targetDate >= today && targetDate <= endDate
    }
    // used to turn the reminder into an alert in the dashboard
    // if the date for the reminder is past the current date, return true, false otherwise.
    func isPastDate() -> Bool {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let targetDate = calendar.startOfDay(for: date)

        return targetDate < today
    }
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
    var jobs: [Job] = [] // [Job(role: "Test Role", company: "Test Company", source: .other("Test Source"), status: .applied)]
    // list of favorite jobs
    var favoriteJobs: [Job] = [] // TODO: Remove this array and replace with showFavorites Bool
    // true to show only favorites, false otherwise
    var showFavorites: Bool = false
    // list of all the filters
    var filters: Set<JobFilter> = []
    // set used to add filters to but does not save them in the main filters set until the user selects show
    var tempFilters: Set<JobFilter> = []
    // count of jobs shown; number of filtered items or the size of jobs if there are no filters
    var jobCount: Int = 0
    // text typed into the dashboard search bar; matched against role, company and source
    var searchText: String = ""
    
    var reminders: [Reminder] = []

    var filteredJobs: [Job] {
        return jobs.filter { getItemFromFilter(job: $0) && matchesSearch(job: $0) }
    }
    var isFiltered: Bool { !filters.isEmpty || !searchText.isEmpty || showFavorites }
    var hasFilters: Bool { !filters.isEmpty }

    // true if the job matches the current search text (case insensitive).
    // An empty search matches everything.
    func matchesSearch(job: Job) -> Bool {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        if query.isEmpty { return true }

        return job.role.localizedCaseInsensitiveContains(query)
            || job.company.localizedCaseInsensitiveContains(query)
            || job.source.label.localizedCaseInsensitiveContains(query)
    }

    // stack of pushed screens, on top of the root view in RootView. See ViewModel+Navigation.swift
    var path: [Screen] = []

    func saveFilters(){
        filters = tempFilters
        tempFilters.removeAll()
    }
    
    func clearTempFilters(){
        tempFilters.removeAll()
    }
    
    func clearFilters(){
        filters.removeAll()
        tempFilters.removeAll()
        showFavorites = false
    }
    
    // function used to get which items are viewed in the dashboard based on filters
    // true means the job is in the filtered set and should be displayed,
    // false means the job should not be displayed
    func getItemFromFilter(job: Job) -> Bool{
        if showFavorites{
            if filters.isEmpty && job.isFavorite{
                return true
            }
           
        } else if filters.isEmpty{
            return true
        }
        
        
        if filters.contains(where: { $0.type == "status"}) && filters.contains(where: {$0.type == "source"}){
            if filters.contains(.status(job.status)) && filters.contains(.source(job.source)){
                if showFavorites{
                    if job.isFavorite{
                        return true
                    }
                } else{
                    return true
                }
            }
        } else if filters.contains(where: { $0.type == "status"}){
            if filters.contains(.status(job.status)){
                if showFavorites{
                    if job.isFavorite{
                        return true
                    }
                } else  {
                    return true
                }
            }
        } else if filters.contains(where: {$0.type == "source"}){
            if filters.contains(.source(job.source)){
                if showFavorites {
                    if job.isFavorite{
                        return true
                    }
                } else {
                    return true
                }
                
            }
        }
        
        
        return false
    }
    
    // method to create a job
    func createJob(job: Job){
        jobs.append(job)
    }
    // dummy method used for demostration that populates the jobs list with random data just to fill it
    func populateJobList() {
        let roles = ["iOS Developer", "Software Engineer", "Frontend Engineer",
                     "Backend Developer", "Mobile Engineer", "Data Scientist",
                     "Product Manager"]

        let companies = ["Apple", "Google", "Meta", "Netflix", "Amazon",
                         "Spotify", "Stripe", "Airbnb", "Uber", "Lyft", "Microsoft"]

        let sources: [JobSource] = [.handshake, .indeed, .linkedin, .other("ZipRecruiter")]
        let statuses = JobStatus.allCases

        var dummyJobs: [Job] = []

        // Generate 20 random jobs
        for _ in 1...20 {
            let job = Job(
                role: roles.randomElement()!,
                company: companies.randomElement()!,
                source: sources.randomElement()!,
                status: statuses.randomElement()!
            )
            dummyJobs.append(job)
        }

        jobs = dummyJobs

        // Generate 5 reminders associated with random jobs
        var dummyReminders: [Reminder] = []
        let calendar = Calendar.current
        let reminderTitles = [
            "Follow up on application",
            "Prepare for interview",
            "Complete assessment",
            "Send thank-you email",
            "Check application status"
        ]

        for index in 0..<5 {
            let job = dummyJobs.randomElement()!

            let randomDays = Int.random(in: -5...14)
            let date = calendar.date(byAdding: .day, value: randomDays, to: Date())!
            let components = calendar.dateComponents([.year, .month, .day], from: date)

            // First 3 reminders have a time
            let hasTime = index < 3

            let reminder = Reminder(
                year: components.year!,
                month: components.month!,
                day: components.day!,
                hour: hasTime ? Int.random(in: 9...17) : nil,
                min: hasTime ? [0, 15, 30, 45].randomElement()! : nil,
                title: reminderTitles[index],
                company: job.company
            )

            dummyReminders.append(reminder)
        }

        reminders = dummyReminders
    }
    
    // dummy method used for demostration that removes all jobs from the list
    func clearJobList(){
        jobs = []
        reminders = []
    }
    // create an account, first checks user information (ie email not empty, password is good) and displays a UI element if there is an error
    func createAccount(firstName: String, email: String, password: String, passwordStrength: PasswordStrength, UIElement: (AccountErrors) -> Void){
        var isError = false
        if firstName.isEmpty{
            isError = true
            UIElement(.emptyAccountInfo(.name))
        }
        else if email.isEmpty{
            isError = true
            UIElement(.emptyAccountInfo(.email))
        }
        else if password.isEmpty{
            isError = true
            UIElement(.emptyAccountInfo(.password))
        }
        else {
            UIElement(.emptyAccountInfo(.reset))
        }
        
        if passwordStrength == .weak && !password.isEmpty{
            isError = true
            UIElement(.passwordInfo(.weak))
        }
        else{
            UIElement(.passwordInfo(.reset))
        }
        
        guard !isError else {return}
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
