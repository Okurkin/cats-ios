//
//  BreedDetailView.swift
//  kitties
//
//  Created by Okurkin on 04.06.2023.
//

import SwiftUI
import SafariServices

struct BreedDetailView: View {
    
    let breed: CatBreed
    
    // whether or not to show the Safari ViewController
    @State var showSafari = false
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            ScrollView {
                VStack(spacing: 16) {
                    makeImage(url: BreedImage.mock.url)
                    makeInfo(breed: self.breed)
                    makeRating(breed: self.breed)
                }.navigationTitle(self.breed.name ?? "").navigationBarItems(trailing: HStack {
                    
                    if (self.breed.wikipediaUrl != nil)
                    {
                        self.makeWikipediaButton()
                    }
                })
            }
        }
    }
}

private extension BreedDetailView{
    func makeWikipediaButton() -> some View {
        Button(action: {
                    
                    // tell the app that we want to show the Safari VC
                    self.showSafari = true
                }) {
                    Text("Wikipedia")
                }
                // summon the Safari sheet
                .sheet(isPresented: $showSafari) {
                    SafariView(url:breed.wikipediaUrl!)
        }
        
    }
}

private extension BreedDetailView{
    func makeInfo(breed: CatBreed) -> some View {
        
        
        VStack(alignment: .leading, spacing: 8) {
            Text("Info").font(.title2).fontWeight(.bold)

            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 8) {
                    makeInfoRow(title: !(breed.altNames.isEmpty) ? breed.altNames:breed.name, iconName: "creditcard")
                    makeInfoRow(title: breed.temperament, iconName: "person.fill.questionmark")
                    makeInfoRow(title: breed.getCountryCodeFlag(), iconName: "globe")
                    makeInfoRow(title: "\(breed.lifeSpan) years", iconName: "cross.fill")
                    
                    makeInfoRow(title: breed.description, iconName: "text.alignleft")
                }
                Spacer()
            }
        }
        .padding(.horizontal, 8)
        
    }
    func makeRating(breed: CatBreed) -> some View {
        
        
        VStack(alignment: .leading, spacing: 8) {
            Text("Ratings").font(.title2).fontWeight(.bold)

            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 8) {
                    Group {
                        //                adaptability: 5,
                        
                        self.makeRatingRow(title: "Adaptability", rating: breed.adaptability, iconName: "leaf.fill")

                        //                affectionLevel: 4,
                        self.makeRatingRow(title: "Affection", rating: breed.adaptability, iconName: "flame.fill")
                        //                childFriendly: 4,
                        self.makeRatingRow(title: "Child friendly", rating: breed.childFriendly, iconName: "figure.2.and.child.holdinghands")
                        //                dogFriendly: 4,
                        self.makeRatingRow(title: "Dog friendly", rating: breed.dogFriendly, iconName: "tortoise.fill")
                        //                energyLevel: 3,
                        self.makeRatingRow(title: "Energy", rating: breed.energyLevel, iconName: "bolt.heart.fill")
                        //                grooming: 3,
                        self.makeRatingRow(title: "Grooming", rating: breed.grooming, iconName: "drop.degreesign.fill")
                        //                healthIssues: 1,
                        self.makeRatingRow(title: "Health issues", rating: breed.healthIssues, iconName: "cross.case.fill")
                        //                intelligence: 3,
                        self.makeRatingRow(title: "Intelligence", rating: breed.intelligence, iconName: "brain.head.profile")
                        
                        //                sheddingLevel: 3,
                        self.makeRatingRow(title: "Shedding level", rating: breed.sheddingLevel, iconName: "brain.head.profile")
                        //                socialNeeds: 4,
                        self.makeRatingRow(title: "Social needs", rating: breed.socialNeeds, iconName: "figure.socialdance")

                    }
                    
                    Group{
                        //                strangerFriendly: 4,
                        self.makeRatingRow(title: "Stranger friendly", rating: breed.strangerFriendly, iconName: "person.crop.circle.fill.badge.checkmark")

                        //                vocalisation: 3,
                        self.makeRatingRow(title: "Vocalisation", rating: breed.vocalisation, iconName: "person.wave.2.fill")
                    }
                    
                }
                Spacer()
            }
        }
        .padding(.horizontal, 8)
        
    }
    
    
    func makeRatingRow(title: String, rating: Int, iconName: String) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: iconName)
            let stars = String.init(repeating:"★", count: rating)
            Text("\(title):")
            Text(stars)
        }
        .font(.caption)
        .fontWeight(.bold)
    }
    
    func makeInfoRow(title: String, iconName: String) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: iconName)

            Text(title)
        }
        .font(.caption)
        .fontWeight(.bold)
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

struct SafariView: UIViewControllerRepresentable {

    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {

    }

}

struct BreedDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BreedDetailView(breed: CatBreed.mock[0])
    }
}
