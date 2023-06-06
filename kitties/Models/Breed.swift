//
//  Breed.swift
//  kitties
//
//  Created by Okurkin on 04.06.2023.
//

import Foundation

struct BreedImage: Codable {
    let id: String
    let url: String
    let width: Int
    let height: Int
    
    enum CodingKeys: String, CodingKey {
        case id, url, width, height
    }
}
 
// MARK: - WelcomeElement
struct CatBreed: Codable, Identifiable {
    let weight: Weight
    let id, name: String
    let cfaURL: String?
    let vetstreetURL: String?
    let vcahospitalsURL: String?
    let temperament, origin, countryCodes, countryCode: String
    let description, lifeSpan: String
    let indoor: Int
    let lap: Int?
    let altNames: String?
    let adaptability, affectionLevel, childFriendly, dogFriendly: Int
    let energyLevel, grooming, healthIssues, intelligence: Int
    let sheddingLevel, socialNeeds, strangerFriendly, vocalisation: Int
    let experimental, hairless, natural, rare: Int
    let rex, suppressedTail, shortLegs: Int
    let wikipediaURL: String?
    let hypoallergenic: Int
    let referenceImageID: String?
    let catFriendly, bidability: Int?
 
    enum CodingKeys: String, CodingKey {
        case weight, id, name
        case cfaURL = "cfa_url"
        case vetstreetURL = "vetstreet_url"
        case vcahospitalsURL = "vcahospitals_url"
        case temperament, origin
        case countryCodes = "country_codes"
        case countryCode = "country_code"
        case description
        case lifeSpan = "life_span"
        case indoor, lap
        case altNames = "alt_names"
        case adaptability
        case affectionLevel = "affection_level"
        case childFriendly = "child_friendly"
        case dogFriendly = "dog_friendly"
        case energyLevel = "energy_level"
        case grooming
        case healthIssues = "health_issues"
        case intelligence
        case sheddingLevel = "shedding_level"
        case socialNeeds = "social_needs"
        case strangerFriendly = "stranger_friendly"
        case vocalisation, experimental, hairless, natural, rare, rex
        case suppressedTail = "suppressed_tail"
        case shortLegs = "short_legs"
        case wikipediaURL = "wikipedia_url"
        case hypoallergenic
        case referenceImageID = "reference_image_id"
        case catFriendly = "cat_friendly"
        case bidability
    }
}
 
// MARK: - Weight
struct Weight: Codable {
    let imperial, metric: String
}


extension CatBreed {
    func getCountryCodeFlag() -> String {
        var string = ""

        for v in countryCode.unicodeScalars {
            string.unicodeScalars.append(UnicodeScalar(127397+v.value)!)
        }

        return String(string)
    }
    func getMainImage() -> URL {
        return URL(string: "https://api.thecatapi.com/v1/images/\(referenceImageID)")!
    }
}

// MARK: - Mock
#if DEBUG

//extension BreedImage{
//    static let mock = BreedImage(    id: "ozEvzdVM-",
//                                     url: URL(string: "https://cdn2.thecatapi.com/images/ozEvzdVM-.jpg")!, breeds: [], width: 1200, height: 800)
//}

//extension CatBreed {
//    static let mock: [CatBreed] = Array(repeating: CatBreed(
//        weight: Weight(imperial: "str", metric: "str"),
//        id: "aege",
//        name: "Aegean",
//        cfaUrl: URL(string: "asd")!,
//        vetstreetUrl: URL(string: "asd")!,
//        vcahospitalsUrl: URL(string: "asd")!,
//        temperament: "Affectionate, Social, Intelligent, Playful, Active",
//        origin: "Greece",
//        countryCodes: "GR",
//        countryCode: "GR",
//        description: "Native to the Greek islands known as the Cyclades in the Aegean Sea, these are natural cats, meaning they developed without humans getting involved in their breeding. As a breed, Aegean Cats are rare, although they are numerous on their home islands. They are generally friendly toward people and can be excellent cats for families with children.",
//        lifeSpan: "9 - 12",
//        indoor: 0,
//        lap: 0,
//        altNames: "",
//        adaptability: 5,
//        affectionLevel: 4,
//        childFriendly: 4,
//        dogFriendly: 4,
//        energyLevel: 3,
//        grooming: 3,
//        healthIssues: 1,
//        intelligence: 3,
//        sheddingLevel: 3,
//        socialNeeds: 4,
//        strangerFriendly: 4,
//        vocalisation: 3,
//        experimental: 0,
//        hairless: 0,
//        natural: 0,
//        rare: 0,
//        rex: 0,
//        suppressedTail: 0,
//        shortLegs: 0,
//        wikipediaUrl: URL(string: "https://en.wikipedia.org/wiki/Aegean_cat")!,
//        hypoallergenic: 0,
//        referenceImageId: "ozEvzdVM-"
//    ), count: 20)
//}
#endif
