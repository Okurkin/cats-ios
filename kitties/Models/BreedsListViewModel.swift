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
        state = .loading
        await fetch()
    }
    
    
    func fetch() async {
        
        do {
            
            var session: URLSession = {
                let config = URLSessionConfiguration.default
                config.timeoutIntervalForRequest = 30
                
                return URLSession(configuration: config)
            }()
            
            let endpoint = BreedsEndpoint()
            
            let request = try endpoint.asURLRequest()
            
            let (data, response) = try await session.data(for: request)
            
            
            print(String(data:data, encoding: String.Encoding.utf8))
            
            let httpResponse = response as? HTTPURLResponse
            
            debugPrint("Finished request: \(response)")
                    
            guard let status =  httpResponse?.statusCode, (200...299).contains(status) else {
                throw APIError.unaceptableStatusCode
            }
            
            let decoder = JSONDecoder()
            
            do {
                let result = try decoder.decode([CatBreed].self, from: data)
                items = result

            } catch {
                
                print(error)
                
                throw APIError.decodingFailed(error: error)
            }

            state = .fetched


        } catch {

            if let error = error as? URLError, error.code == .cancelled {
//                Logger.log("URL request was cancelled", .info)

                state = .fetched

                return
            }

            debugPrint(error)
            state = .failed
        }
    }
}
