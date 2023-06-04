//
//  BreedDetailView.swift
//  kitties
//
//  Created by Okurkin on 04.06.2023.
//

import SwiftUI

struct BreedDetailView: View {
    
    let breed = CatBreed.mock[0]
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            ScrollView {
                VStack(spacing: 16) {
                    makeImage(url: BreedImage.mock.url)
                }.navigationTitle("Breed")
            }
        }
    }
}


private extension BreedDetailView {
    func makeImage(url: URL?) -> some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        } placeholder: {
            ProgressView()
        }
        .frame(maxWidth: .infinity)
    }
}

struct BreedDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BreedDetailView()
    }
}
