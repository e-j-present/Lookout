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
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
                
                Image(systemName: "plus")
                    .font(.headline)
                Text("Attach")
                    .font(.headline)
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
    }
}

#Preview {
    MaterialsCard()
        .padding()
}
