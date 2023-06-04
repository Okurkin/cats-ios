//
//  BreedsListView.swift
//  kitties
//
//  Created by Okurkin on 04.06.2023.
//

import Foundation
import SwiftUI

struct CatBreedListView: View {
    let items: [CatBreed]  = CatBreed.mock// Pole datového modelu CatBreed
    
    var body: some View {
        NavigationView{
            List(items, id: \.id) { item in
                CatBreedRowView(item: item).padding(.vertical, 4)
            }.navigationTitle("Breeds")
        }
        
    }
}


struct CatBreedRowView: View {
    let item: CatBreed
    
    init(item: CatBreed) {
        self.item = item
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Text(item.name)
                Text(item.getCountryCodeFlag())
            }.font(.title2).fontWeight(.bold)
            
            AsyncImage(
                url: BreedImage.mock.url) { image in
                    image
                        .resizable()
                        .frame(width: .infinity, height: 200)
                        .cornerRadius(8)
                } placeholder: {
                    ProgressView()
                }
            
            Text(item.temperament)
                .font(.caption).fontWeight(.semibold)
        }
    }
}

struct CatBreedListView_Previews: PreviewProvider {
    static var previews: some View {
        CatBreedListView()
    }
}


