//
//  MaterialsCard.swift
//  Lookout
//
import SwiftUI
struct MaterialsCard: View {
    
    let vm = ViewModel.shared
    
    var body: some View {
        VStack{
            HStack{
                Text("Materials")
                Spacer()
                Image(systemName: "plus")
                Text("Attach")
            }
            .font(.title3)
            .fontWeight(.medium)
            
            ForEach(vm.uploadedMaterials, id: \.id){mat in
                HStack(){
                    // icon
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.quaternary)
                        .aspectRatio(1, contentMode: .fit)
                        .frame(width: 50)
                    
                    // Text
                    VStack(alignment: .leading){
                        Text(mat.title)
                            .fontWeight(.semibold)
                        HStack{
                            Text(mat.type.rawValue)
                            Text("•")
                            Text("uploaded \(mat.uploadedDate)")
                        }
                        .foregroundStyle(.secondary)
                        .fontWeight(.medium)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.gray, lineWidth: 1)
        )
    }
}

#Preview {
    MaterialsCard()
        .padding()
}
