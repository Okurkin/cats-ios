//
//  Breed.swift
//  kitties
//
//  Created by Okurkin on 04.06.2023.
//

import Foundation

struct BreedImage: Decodable {
    let id: String
    let url: URL
    let breeds: [CatBreed]
    let width: Int
    let height: Int
}

struct CatBreed: Decodable {
    struct Weight: Decodable {
        let imperial: String
        let metric: String
    }
    
    let weight: Weight
    let id: String
    let name: String
    let cfaUrl: URL?
    let vetstreetUrl: URL?
    let vcahospitalsUrl: URL?
    let temperament: String
    let origin: String
    let countryCodes: String
    let countryCode: String
    let description: String
    let lifeSpan: String
    let indoor: Int
    let lap: Int
    let altNames: String
    let adaptability: Int
    let affectionLevel: Int
    let childFriendly: Int
    let dogFriendly: Int
    let energyLevel: Int
    let grooming: Int
    let healthIssues: Int
    let intelligence: Int
    let sheddingLevel: Int
    let socialNeeds: Int
    let strangerFriendly: Int
    let vocalisation: Int
    let experimental: Int
    let hairless: Int
    let natural: Int
    let rare: Int
    let rex: Int
    let suppressedTail: Int
    let shortLegs: Int
    let wikipediaUrl: URL?
    let hypoallergenic: Int
    let referenceImageId: String
    
    func getCountryCodeFlag() -> String {
        var string = ""
        
        for v in countryCode.unicodeScalars {
            string.unicodeScalars.append(UnicodeScalar(127397+v.value)!)
        }
        
        return String(string)
    }
    func getMainImageURL() -> URL {
        print("https://api.thecatapi.com/v1/images/\(referenceImageId)")
        return URL(string: "https://api.thecatapi.com/v1/images/\(referenceImageId)")!
    }
}
// MARK: - Mock
#if DEBUG

extension BreedImage{
    static let mock = BreedImage(    id: "ozEvzdVM-",
                                     url: URL(string: "https://cdn2.thecatapi.com/images/ozEvzdVM-.jpg")!, breeds: [], width: 1200, height: 800)
}

extension CatBreed {
    static let mock: [CatBreed] = Array(repeating: CatBreed(
        weight: Weight(imperial: "str", metric: "str"),
        id: "aege",
        name: "Aegean",
        cfaUrl: URL(string: "asd")!,
        vetstreetUrl: URL(string: "asd")!,
        vcahospitalsUrl: URL(string: "asd")!,
        temperament: "Affectionate, Social, Intelligent, Playful, Active",
        origin: "Greece",
        countryCodes: "GR",
        countryCode: "GR",
        description: "Native to the Greek islands known as the Cyclades in the Aegean Sea, these are natural cats, meaning they developed without humans getting involved in their breeding. As a breed, Aegean Cats are rare, although they are numerous on their home islands. They are generally friendly toward people and can be excellent cats for families with children.",
        lifeSpan: "9 - 12",
        indoor: 0,
        lap: 0,
        altNames: "",
        adaptability: 5,
        affectionLevel: 4,
        childFriendly: 4,
        dogFriendly: 4,
        energyLevel: 3,
        grooming: 3,
        healthIssues: 1,
        intelligence: 3,
        sheddingLevel: 3,
        socialNeeds: 4,
        strangerFriendly: 4,
        vocalisation: 3,
        experimental: 0,
        hairless: 0,
        natural: 0,
        rare: 0,
        rex: 0,
        suppressedTail: 0,
        shortLegs: 0,
        wikipediaUrl: URL(string: "https://en.wikipedia.org/wiki/Aegean_cat")!,
        hypoallergenic: 0,
        referenceImageId: "ozEvzdVM-"
    ), count: 20)
}
#endif
