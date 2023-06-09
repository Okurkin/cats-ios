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
    @StateObject var galleryViewModel: BreedDetailGalleryViewModel

        
    // whether or not to show the Safari ViewController
    @State var showSafari = false
    
    @ViewBuilder
    var body: some View {
        ZStack(alignment: .topLeading) {
            ScrollView {
                LazyVStack(spacing: 16) {
                    
                    switch galleryViewModel.state {
                    case .initial, .loading, .failed:
                        if (self.breed.image != nil) {
                            makeImage(url: URL(string:self.breed.image!.url))
                        }
                        else
                        {
                            makeImagePlaceholder()
                        }
                    case .fetched:
                        self.makeGallery()
                    }
                    
                    makeInfo(breed: self.breed)
                    makeAbilities(breed: self.breed)
                    makeProperties(breed: self.breed)
                }.navigationTitle(self.breed.name).navigationBarItems(trailing: HStack {
                    
                    if (self.breed.wikipediaURL != nil)
                    {
                        self.makeWikipediaButton()
                    }
                })
            }.padding(.horizontal, 8)
        }.onFirstAppear{
            Task {
                await galleryViewModel.fetch()
            }
            
        }
    }
}

private extension BreedDetailView {
    
    func makeImagePlaceholder() -> some View {
        ZStack{
            Spacer().padding(.bottom, 300)
            Image(systemName: "questionmark.circle").resizable().scaledToFit().frame(height: 150)
        }
    }
    
    func makeImage(url: URL?) -> some View {
        
        AsyncImage(url: url) { image in
            image
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 8))
        } placeholder: {
            ZStack{
                Spacer().padding(.bottom, 300)
                ProgressView()

            }
        }
        .frame(height: 300).padding(.horizontal, 8)
    }
    
    func makeGallery() -> some View {
        
        Group {
            self.makeImage(url: URL(string: self.galleryViewModel.photos[self.galleryViewModel.currentShownPhotoIndex].url))
                .gesture(DragGesture(minimumDistance: 5, coordinateSpace: .global)
                .onEnded { value in
                    let horizontalAmount = value.translation.width
                    let verticalAmount = value.translation.height

                    if abs(horizontalAmount) > abs(verticalAmount) {

                        if(horizontalAmount < 0){
//                            left swipe

                            self.galleryViewModel.showNextPhoto()

                        }else {
//                            right swipe
                            self.galleryViewModel.showPreviousPhoto()
                        }

                        print(horizontalAmount < 0 ? "left swipe" : "right swipe")
                    }
                })
            HStack {
                ForEach(0..<self.galleryViewModel.photos.count) { index in
                    
                    Circle().fill(self.galleryViewModel.currentShownPhotoIndex == index ? Color.black : Color.gray).frame(width: 10, height: 10)
                    
                }
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
            SafariView(url:URL(string:breed.wikipediaURL!)!)
        }
        
    }
}

private extension BreedDetailView{
    
    func concatenateStringsAndMakeList(string1: String, string2: String) -> String {
        let parts = (string1 + ", " + string2).split(separator: ", ").map { String($0) }
        let distinctParts = Array(Set(parts))

        return distinctParts.joined(separator: ", ")
    }
    
    func makeInfo(breed: CatBreed) -> some View {
        
        
        VStack(alignment: .leading, spacing: 8) {
            Text("Info").font(.title2).fontWeight(.bold)
            
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 8) {
                    makeInfoRow(text: concatenateStringsAndMakeList(string1: breed.name, string2: breed.altNames ?? ""), iconName: "person.text.rectangle.fill")
                    makeInfoRow(text: breed.temperament, iconName: "person.fill.questionmark")
                    makeInfoRow(text: breed.getCountryCodeFlag(), iconName: "globe")
                    makeInfoRow(text: "\(breed.lifeSpan) years", iconName: "cross.fill")
                    
                    makeInfoRow(text: breed.description, iconName: "text.alignleft")
                    
                    makeWeightRow(weight: breed.weight, iconName: "arrow.left.and.right.righttriangle.left.righttriangle.right")
                    
                }
                Spacer()
            }
        }
        .padding(.horizontal, 8)
        
    }
    func makeInfoRow(text: String, iconName: String) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: iconName)
            
            Text(text)
        }
        .font(.caption)
        .fontWeight(.bold)
    }
    
    func makeWeightRow(weight: Weight, iconName: String) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: iconName)
            VStack(alignment: .leading)
            {
                Text("\(weight.metric) cm")
                Text("\(weight.imperial) ft")
            }
            
        }
        .font(.caption)
        .fontWeight(.bold)
    }
    
    func makeRatingRow(title: String, rating: Int, iconName: String) -> some View {
        
        
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: iconName)
            let stars = String.init(repeating:"★", count: rating)
            Text("\(title):")
            
            Spacer()
            
            Text(stars)
        }.font(.caption)
            .fontWeight(.bold)
            .padding(3)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    func makeBooleanRow(title: String, value: Int, iconName: String) -> some View {
        
        HStack(alignment: .top, spacing: 8) {
            let boolIconName = value != 0 ? "checkmark": "xmark"
            Image(systemName: iconName)
            Text("\(title):")
            Spacer()
            Image(systemName: boolIconName)
        }
        .font(.caption).fontWeight(.bold).padding(3).clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

private extension BreedDetailView {
    
    func makeProperties(breed: CatBreed) -> some View {
        
        VStack(alignment: .leading, spacing: 8){
            Text("Properties").font(.title2).fontWeight(.bold)
            Group {
                self.makeBooleanRow(title: "Indoor living", value: breed.indoor, iconName: "house.fill")
                if(breed.lap != nil){
                    self.makeBooleanRow(title: "Lap", value: breed.lap!, iconName: "bed.double.fill")
                }
                self.makeBooleanRow(title: "Experimental", value: breed.experimental, iconName: "gear.badge.questionmark")
                self.makeBooleanRow(title: "Hairless", value: breed.hairless, iconName: "camera.metering.none")
                self.makeBooleanRow(title: "Natural", value: breed.natural, iconName: "globe.europe.africa.fill")
                self.makeBooleanRow(title: "Rare", value: breed.rare, iconName: "sparkles")
                self.makeBooleanRow(title: "Rex", value: breed.rex, iconName: "laurel.leading")
                self.makeBooleanRow(title: "Supressed tail", value: breed.suppressedTail, iconName: "alternatingcurrent")
                self.makeBooleanRow(title: "Short legs", value: breed.shortLegs, iconName: "shoeprints.fill")
                self.makeBooleanRow(title: "Hypoallergenic", value: breed.hypoallergenic, iconName: "atom")
            }
            
        }.padding(.horizontal, 8)
        
    }
}

private extension BreedDetailView{
    
    func makeAbilities(breed: CatBreed) -> some View {
        
        
        VStack(alignment: .leading, spacing: 8) {
            Text("Abilities").font(.title2).fontWeight(.bold)
            
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 8) {
                    Group {
                        //                adaptability: 5,
                        
                        self.makeRatingRow(title: "Adaptability", rating: breed.adaptability, iconName: "hands.sparkles.fill")
                        
                        //                affectionLevel: 4,
                        self.makeRatingRow(title: "Affection", rating: breed.adaptability, iconName: "flame.fill")
                        //                childFriendly: 4,
                        self.makeRatingRow(title: "Child friendly", rating: breed.childFriendly, iconName: "figure.2.and.child.holdinghands")
                        //                dogFriendly: 4,
                        self.makeRatingRow(title: "Dog friendly", rating: breed.dogFriendly, iconName: "pawprint.fill")
                        //                catFriendly: 4,
                        
                        //                energyLevel: 3,
                        self.makeRatingRow(title: "Energy", rating: breed.energyLevel, iconName: "bolt.heart.fill")
                        //                grooming: 3,
                        self.makeRatingRow(title: "Grooming", rating: breed.grooming, iconName: "shower.fill")
                        //                healthIssues: 1,
                        self.makeRatingRow(title: "Health issues", rating: breed.healthIssues, iconName: "cross.case.fill")
                        //                intelligence: 3,
                        self.makeRatingRow(title: "Intelligence", rating: breed.intelligence, iconName: "brain")
                        
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
        BreedDetailView(breed: CatBreed.mock[0], galleryViewModel: BreedDetailGalleryViewModel(breed_id: CatBreed.mock[0].id))
    }
}
