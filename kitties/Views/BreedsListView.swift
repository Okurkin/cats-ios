//
//  BreedsListView.swift
//  kitties
//
//  Created by Okurkin on 04.06.2023.
//

import Foundation
import SwiftUI

struct CatBreedListView: View {
    
    @StateObject var viewModel = BreedsListViewModel()
    
    
    var body: some View {
        ZStack{
            NavigationView{
                
                switch viewModel.state {
                case .initial, .loading:
                    ProgressView()
                case .fetched:
                        

                    List(viewModel.items) { item in
                        ZStack {
                            NavigationLink(destination: BreedDetailView(breed: item)){
                                EmptyView()
                            }.buttonStyle(PlainButtonStyle()).opacity(0)
                            CatBreedRowView(item: item).padding(.vertical, 4)
                        }


                    }.navigationTitle("Breeds")
                    
                case .failed:
                    Text("Something went wrong 😕")
                }
                
            }}.onAppear {
            Task {
                await viewModel.load()
            }
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
                url: URL(string: "ASD")) { image in
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


