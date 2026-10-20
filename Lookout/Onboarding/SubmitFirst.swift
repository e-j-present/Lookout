import SwiftUI

struct SubmitFirst: View {

    var vm = ViewModel.shared

    @State private var company: String = "Google"
    @State private var role: String = "Associate Product Manager"
    @State private var source: String = "LinkedIn"

    @State private var isSaved: Bool = false
    @State private var isApplied: Bool = false

    @State private var isLoading: Bool = true

    var body: some View {
        Group {
            if isLoading {
                GatheringInfoView {
                    vm.pop()
                }
                .transition(.opacity)
            } else {
                applicationForm
                    .transition(.opacity)
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            // Simulate reading and extracting the LinkedIn posting.
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation(.easeInOut(duration: 0.35)) {
                    isLoading = false
                }
            }
        }
    }

    private var applicationForm: some View {
        VStack(spacing: 1) {
            PageBar(currentPage: 4, totalPages: 4, showBack: true) {
                vm.pop()
            }
            .padding()

            Text("Look right?")
                .font(.system(size: 40))
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)

            Text("Fix anything we got wrong before saving.")
                .font(.callout)
                .foregroundStyle(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()

            VStack(spacing: 5) {
                Text("")

                Text("Found it on LinkedIn")
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)

                Text("We filled in the details below.")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)

                Text("")
            }
            .background(Color(.systemGray5))
            .cornerRadius(12)
            .padding(.horizontal)

            CTextField(
                label: "Company",
                placeholder: "",
                text: $company,
                inputType: .genericText
            )
            .padding()

            CTextField(
                label: "Role",
                placeholder: "",
                text: $role,
                inputType: .genericText
            )
            .padding()

            CTextField(
                label: "Source",
                placeholder: "",
                text: $source,
                inputType: .genericText
            )
            .padding()

            Text("Stage")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()

            HStack {
                Chip(text: "Saved", chipType: isSaved ? .black : .white) {
                    if isApplied {
                        isApplied.toggle()
                    }
                    isSaved.toggle()
                }

                Chip(text: "Applied", chipType: isApplied ? .black : .white) {
                    if isSaved {
                        isSaved.toggle()
                    }
                    isApplied.toggle()
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)

            Spacer()

            CButton(
                text: "Save application",
                buttonType: .black,
                fullWidth: true,
                cornerRadius: 8
            ) {
                // TODO: Save company, role, source, and stage.
                vm.setRoot(.mainNavScreen)
            }
            .padding()
        }
    }
}

// MARK: - Gathering Info Loading Screen


struct GatheringInfoView: View {

    var onBack: () -> Void

    @State private var isPulsing = false

    var body: some View {
        VStack(spacing: 0) {

            PageBar(currentPage: 4, totalPages: 4, showBack: true) {
                
            }
            .padding()

            // Scrollable content uses the same spacing as the form
            ScrollView(showsIndicators: false) {
                VStack(spacing: 1) {

                    Text("Pulling the details...")
                        .font(.system(size: 40))
                        .bold()
                        .frame(
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                        .padding(.horizontal)

                    Text("Reading the posting from LinkedIn. This only takes a few seconds.")
                        .font(.callout)
                        .foregroundStyle(.gray)
                        .frame(
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                        .padding()

                    // Status card in place of the LinkedIn info card
                    VStack(spacing: 5) {
                        HStack(spacing: 16) {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.gray.opacity(0.12))
                                .frame(width: 64, height: 64)

                            VStack(alignment: .leading, spacing: 12) {
                                skeletonLine(width: 180)
                                skeletonLine(width: 125)
                            }

                            Spacer(minLength: 0)
                        }
                        .padding(.horizontal)

                        HStack(spacing: 12) {
                            ProgressView()
                                .tint(.primary)

                            Text("Finding company, role, and source")
                                .font(.callout)
                                .foregroundStyle(.secondary)

                            Spacer(minLength: 0)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                    }
                    .padding(.vertical, 12)
                    .background(Color(.systemGray5))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal)

                    // Skeleton fields: same outer padding as CTextField
                    skeletonField()
                        .padding()

                    skeletonField()
                        .padding()

                    skeletonField()
                        .padding()

                    // Stage section placeholder
                    VStack(alignment: .leading, spacing: 12) {
                        skeletonLine(width: 65)

                        HStack(spacing: 10) {
                            skeletonChip(width: 85)
                            skeletonChip(width: 95)
                        }
                    }
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )
                    .padding()
                }
            }

            
            CButton(
                text: "Save application",
                buttonType: .black,
                fullWidth: true,
                cornerRadius: 8
            ) {
                // No action while loading
            }
            .disabled(true)
            .opacity(0.65)
            .padding()

        }
        .background(Color(.systemBackground))
        .navigationBarBackButtonHidden(true)
        .onAppear {
            withAnimation(
                .easeInOut(duration: 0.9)
                    .repeatForever(autoreverses: true)
            ) {
                isPulsing = true
            }
        }
    }

    // Skeleton for a text field
   
    private func skeletonField() -> some View {
        VStack(alignment: .leading) {
            // Placeholder for the CTextField label
            skeletonLine(width: 90)

            // Placeholder for the bordered text input
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.12))
                .frame(maxWidth: .infinity)
                .frame(height: 54)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(
                            Color.gray.opacity(0.18),
                            lineWidth: 1
                        )
                }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }


    // Skeleton for a label or line of text
    private func skeletonLine(width: CGFloat) -> some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color.gray.opacity(isPulsing ? 0.16 : 0.08))
            .frame(width: width, height: 12)
    }

    // Skeleton for the Saved / Applied chips
    private func skeletonChip(width: CGFloat) -> some View {
        Capsule()
            .fill(Color.gray.opacity(0.12))
            .frame(width: width, height: 36)
    }
}


#Preview {
    SubmitFirst()
}
