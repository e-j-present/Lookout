# Lookout
*For best results, we ran the app on the iPhone 17 Pro.*

## Beta: 
### New components we added:
The following components will be used for the Application Detail Page

- JobDescriptionCard
	- Used to show the job title and description of the role. Can be collapsed and expanded by pressing the show more / less button.
- DetailsCard
	- Used to show specific details about the job application, including the website where the posting is found, the date applied, the application deadline, and the date the user added it to the app. 
- MaterialsCard
	- Used to show the user’s uploaded material such as resume and cover letter

### Page Modifications: 
- Dashboard
    - The quick add feature, for the purpose of the demo, is still functional
        - Clicking on “+ Add application” on the empty state of the dashboard will fill it with random data
    - Dashboard now shows reminders
        - Reminders contain a title, company, and due date
            - Due date is formatted as month abbreviation + day and as a string based on the following: 
                - If the reminder is set for today -> today
                - If the reminder is set for tomorrow -> tomorrow
                - If the reminder already happened, if it's still within the first week, it will display it as x days ago, but if it's longer than the first week, it will display it as x weeks ago
            - Reminders are also auto-filled for the purpose of the demo when you click on “+ Add application” from the empty state. Since these are randomly generated, you might need to clear out the data and re-add them. Long-pressing the main plus button at the bottom of the screen returns to the empty state
    - Dashboard now supports filters. Clicking on the button to the right of the search bar opens up the filter page
        - At the bottom of the filter page, there is a confirmation button that will show the number of applications with the filters selected i.e., “Show 20 applications”
            - Clicking on different filters will update this count live.
            - In order to save the filters, you must click on “show x applications.” Clicking on the x button at the top right will not save the filters and will show the previously selected filters, if there were any.
            - Using filters takes you to a modified version of the dashboard screen where you can see all filters applied as chips. Clicking on the chips removes that specific filter
    - Dashboard now supports searching
        - You can search for a job role, company, or source
        - Searching is applied to the filtered list, meaning if you filtered for applied jobs and then search, your search results will be an applied job. If no filters are selected, searching is applied on all the jobs
    - Dashboard supports favorites
        - Favorite a job, then view it by filtering for only favorites
- Add-Job
    - Clicking on the + button will bring up a sheet where the user can paste a link to the job application. The user also has the option to manually enter details. If the link field is empty, the user can only click on the manual entry as the button is grayed out.
    - Both options bring you to the Add Job page. If you use the link “in your clipboard” it will auto-populate all the forms. However, if you enter any other link it will bring up an error message indicating that it was not able to scrape the data. 
    - The manual entry page is shown without the banner at the top that the other two screens show. 
    - Also allows the user to toggle whether or not to receive notifications 2 days before the deadline is due. 

- SubmitFirst (apart of onboarding)
    - The screen now enters a “loading state” to imitate the app searching the internet for the job details. It lasts for 2.5 seconds before transitioning to having all the data filled out. 

### Other Modifications: 
- Fixed login screen to say “Enter password”
- For the purpose of the demo, if you want to avoid logging in, you can tap on the logo on the welcome screen, and it will take you straight to the welcome screen. Login credentials are still the following: 
    - **Email: john@utexas.edu**
    - **Password: 12345678**


## Alpha: 
We decided to create components because many UI elements are reused throughout the project. 

### Components:
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

### Screen:
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


