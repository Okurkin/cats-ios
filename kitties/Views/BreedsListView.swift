//
//  BreedsListView.swift
//  kitties
//
//  Created by Okurkin on 04.06.2023.
//

import Foundation
import SwiftUI

struct BreedsListView: View {
    
    @StateObject var viewModel = BreedsListViewModel()
    
    
    var body: some View {
        ZStack{
            NavigationView{
                
                switch viewModel.state {
                case .initial, .loading:
                    ProgressView()
                case .fetched:
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 12) {
                            ForEach(viewModel.items) { item in
                                NavigationLink(destination: BreedDetailView(breed: item, galleryViewModel: BreedDetailGalleryViewModel(breed_id: item.id))) {
                                    BreedRowView(item: item)
                                }.buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal, 16)
                    }.navigationTitle("Breeds")
                    
                case .failed:
                    Text("OOPS!! All cats are dead.. 😕 (JOKE, try it later)")
                }
                
            }}.onFirstAppear {
            Task {
                await viewModel.load()
            }
        }
        
    }
}

struct BreedsListView_Previews: PreviewProvider {
    static var previews: some View {
        BreedsListView()
    }
}


