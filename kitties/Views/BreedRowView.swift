//
//  BreedRowView.swift
//  kitties
//
//  Created by Okurkin on 08.06.2023.
//

import SwiftUI

struct BreedRowView: View {
    let item: CatBreed
    
    init(item: CatBreed) {
        self.item = item
    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 16) {
            HStack{
                Text(item.name)
                Text(item.getCountryCodeFlag())
            }.font(.title2).fontWeight(.bold)
            VStack {
                if (item.image != nil)
                {
                    AsyncImage(
                        url: URL(string: item.image!.url)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 200, alignment: .topLeading)
                                .cornerRadius(8)
                                .clipped()

                        } placeholder: {
                            ZStack{
                                Spacer().padding(.bottom, 200)
                                ProgressView()
                            }
                        }
                }
                else
                {
                    ZStack{
                        Spacer().padding(.bottom, 200)
                        Image(systemName: "questionmark.circle").resizable().scaledToFit().frame(height: 100)
                    }
                }
            }

            Text(item.temperament)
                .font(.caption).fontWeight(.semibold)
        }
        
        
    }
}

struct BreedRowView_Previews: PreviewProvider {
    static var previews: some View {
        BreedRowView(item:CatBreed.mock[0])
    }
}

