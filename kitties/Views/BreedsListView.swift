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
                            CatBreedRowView(item: item)
                        }

                    }.navigationTitle("Breeds")
                    
                case .failed:
                    Text("OOPS!! All cats are dead.. 😕 (JOKE, try it later)")
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
            VStack {
                if (item.image != nil)
                {
                    AsyncImage(
                        url: URL(string: item.image!.url)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 300, height: 200, alignment: .topLeading)
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


struct CatBreedListView_Previews: PreviewProvider {
    static var previews: some View {
        CatBreedListView()
    }
}


