//
//  BreedDetailGalleryViewModel.swift
//  kitties
//
//  Created by Okurkin on 09.06.2023.
//

import Foundation

@MainActor final class BreedDetailGalleryViewModel: ObservableObject {

    enum State {
        case initial
        case loading
        case fetched
        case failed
    }
    
    @Published var photos: [BreedImage] = []
    @Published var state: State = .initial
    @Published var currentShownPhotoIndex: Int = 0
    
    
    let breed_id: String
    
    init(breed_id: String) {
        self.breed_id = breed_id
    }
    
    func load() async {
        if(state != .fetched){
            state = .loading
            await fetch()
        }
    }
    
    func showPreviousPhoto() -> Void {
        if(self.currentShownPhotoIndex - 1 >= 0)
        {
            self.currentShownPhotoIndex = self.currentShownPhotoIndex - 1
        }
    }
    
    func showNextPhoto() -> Void {
        if(self.currentShownPhotoIndex + 1 < self.photos.count)
        {
            self.currentShownPhotoIndex = self.currentShownPhotoIndex + 1
        }
    }
    
    func fetch() async {
     
        do {
            
            let endpoint = ImagesEndpoint(breedId: self.breed_id)
            
            let response: [BreedImage] = try await APIManager().request(endpoint: endpoint)
            
            self.photos += response
            self.state = .fetched
            
        } catch {
            
            if let error = error as? URLError, error.code == .cancelled {
                Logger.log("URL request was cancelled", .info)
                self.state = .failed
                return
            }
            
            debugPrint(error)
            self.state = .failed
        }
    }
}
