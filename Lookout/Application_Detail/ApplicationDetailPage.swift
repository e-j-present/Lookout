//
//  ApplicationDetailPage.swift
//  Lookout
//
//

import SwiftUI

struct DetailSection<Content: View>: View{
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View{
        ZStack{
            content
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.gray, lineWidth: 1)
        )
        
    }
}

struct ApplicationDetailPage: View {
    var body: some View {
        ScrollView {
            VStack{
                HStack{
                    Label {
                        Text("Dashboard")
                    } icon: {
                        Image(systemName: "chevron.left")
                    }
                    
                    
                    Spacer()
                    
                    Image(systemName: "star.fill")
                }
                
                DetailSection {
                    DetailsTitleCard()
                }
                
                DetailSection {
                    VStack {
                        HStack{
                            Text("Stage")
                                .font(.title3)
                                .fontWeight(.semibold)
                            Spacer()
                            Button{
                                
                            } label: {
                                Text("Update")
                                    .font(.headline)
                            }
                            .tint(.primary)
                        }
                        
                        ProgressTimeline(
                            steps: [
                                .init(title: "Saved"),
                                .init(title: "Applied"),
                                .init(title: "Online Assessment", alias: "OA"),
                                .init(title: "Interview 1", alias: "Int. 1"),
                                .init(title: "Interview 2", alias: "Int. 2"),
                                .init(title: "Offer")
                            ],
                            currentStep: 2,
                        minimumStepWidth: 45)
                    }
                }
                
                DetailSection {
                    ReminderDetails(reminders: [
                        .init(title: "Prepare for interview", subtitle: "Wed, Oct 15 • 6:00 PM • 1 day before"),
                        .init(title: "Interview 2 with hiring manager", subtitle: "Thu, Oct 16 • 2:00 PM • 1 hour before")
                    ])
                }
                
                DetailSection {
                    DetailsCard(title: "Details", details: [.init(title: "title", value: "value"), .init(title: "title", value: "value")])
                }
                
                DetailSection {
                    JobDescriptionCard(description: "Job Description")
                }
                
                DetailSection {
                    MaterialsCard()
                }
                
                DetailSection {
                    NotesCard(notes: [
                        .init(tag: "Interview 1", date: "Oct 8", notes: "Product sense case: improve Maps for commuters. Went well —— brush up on metrics and priortization before round 2"),
                        .init(tag: "Recruiter", date: "Oct 2", notes: "Sarah Kim —— perfers email. Team decision about a week after the final round"),
                        .init(tag: "Referral", date: "Sep 27", notes: "Referred by Jordan Lee (APM, UT '24). Mention the Maps project.")
                    ])
                }
                
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding()
            .border(.black)
        }
    }
}

#Preview {
    ApplicationDetailPage()
}
