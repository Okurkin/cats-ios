//
//  BreedsListViewModel.swift
//  kitties
//
//  Created by Okurkin on 06.06.2023.
//

import Foundation

@MainActor final class BreedsListViewModel: ObservableObject {

    enum State {
        case initial
        case loading
        case fetched
        case failed
    }
    
    @Published var items: [CatBreed] = []
    @Published var state: State = .initial
    
    
    func load() async {
        if(state != .fetched){
            state = .loading
            await fetch()
        }
    }
    
    
    func fetch() async {
        
        do {
            
            let endpoint = BreedsEndpoint()
            
            let response: [CatBreed] = try await APIManager().request(endpoint: endpoint)
            
            self.items += response
            
            state = .fetched
        } catch {
            
            if let error = error as? URLError, error.code == .cancelled {
                Logger.log("URL request was cancelled", .info)
                
                state = .fetched
                
                return
            }
            
            debugPrint(error)
            state = .failed
        }
        
    }
}
