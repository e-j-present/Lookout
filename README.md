# Lookout
*For best results, we ran the app on the iPhone 17 Pro.*

We decided to create components because many UI elements are reused throughout the project. 

## Components:
- AnalyticSquare 
    - Used in the dashboard to show the number of jobs with a specific status
- CButton 
    - Main button style used throughout the app
- Chip 
    - Capsule-shaped tag used throughout the app
- CTextField
    - Main text field style used throughout the app
- DateDropdown
    - Lets the user select a date from the calendar UI
- OptionSelect
    - Used in the timeline to select how far along in the process the user is
- PageBar
    - Used to indicate how far along in the onboarding process the user is
    - Currently, the skip button does not function
- ReminderCard
    - Made to be used on the dashboard as a quick reminder for upcoming events (not actually used yet)
- SavedApplicationCard
    - Used in the dashboard. Contains the main application data.
- SearchBar
    - Allows the user to enter text for a search

## Screen:
- Welcome
    - First screen the user will see when the app loads. They will have to sign in or create an account.
 - Create Account 
    - Asks the user for their first name, email, and password. If any of these fields are left empty, a UI element appears letting the user know that they must type something.
    - Once the user starts typing a password, a password strength bar appears. Right now, it is based on the password length. You must type a password stronger than weak to proceed. If not, red text below the text field will appear. 
    - If you remember that you actually have a login, you can go directly to the login screen without having to go back to the welcome screen
        - If you go to the login screen from here, pushing the back button will skip going back to the create account screen and will take you directly back to the welcome screen
    - After successfully creating an account, you will be taken to the onboarding screen
- Log in
    - Asks the user for their email and password. 
    - We have a default account set up:
        - **Email: john@utexas.edu**
        - **Password: 12345678**
    - If you log in, you will skip the onboarding pipeline and be taken directly to MainNavScreen
- Roles
    - Lets the user select which roles they are interested in
- TimeLine
    - The user enters their graduation date and when they would like to have an offer by. They also select where in the application / recruiting process they are at.
- Notifications
    - Prompts the user to allow notifications to get reminders. If they select allow it takes them to FirstApplication. If they do not allow it takes them to NoNotifs.
- NoNotifs
    - Asks the user if they are sure they do not want any notifications from the app
- FirstApplication
    - In onboarding, the very first application they will add to the app. Asks for a link to the job posting to auto-fill in data. Doesn’t actually add the job for the purpose of showing what an empty dashboard looks like. 
- SubmitFirst
    - After fetching data from the link in FirstApplication, lets the user review information to ensure accuracy and select the stage in the process they are at.
- Main Nav Screen
    - The main screen of the app
    - Shows DashboardEmpty when the user has no jobs created
    - Shows DashboardFirstRun when the user has jobs created
    - Clicking on profile will change the screen, but there is no content on this screen
    - Clicking on the plus button will present a new view modally. Currently, there is only a button to take you to a screen to manually add a job to the app. 
- Dashboard Empty
    - This is what the dashboard looks like when the user has no job data. 
    - For the purpose of the demo, if you click the Add Application button in the no application section, this will create 20 random jobs and move to DashboardFirstRun
    - If you long-press the plus button in the menu bar for at least two seconds, it will clear all jobs and take you back to this screen
- Dashboard First Run
    - Contains an alert message at the top
    - Displays basic analytics such as how many jobs you applied for, have an interview for, and have an offer for
    - List of jobs
        - The Chips will be used in the future for filtering by stage. This is embedded in a horizontal scroll view
    - If you long-press the plus button in the menu bar for at least two seconds, it will clear all jobs and take you back to DashboardEmpty
- Add Screen
    - Basic screen for adding job entries (does not match Figma)
    - Asks the user for a role, company, source (i.e., LinkedIn, Handshake, Indeed), and what stage the user is in. 
    - Both the cancel button and save button will take the user back to the dashboard


We were able to follow the Figma document containing the low-fi and mid-fi app interface very well. There were no deviations we felt were necessary at this time, as we were able to recreate the interface in SwiftUI.
