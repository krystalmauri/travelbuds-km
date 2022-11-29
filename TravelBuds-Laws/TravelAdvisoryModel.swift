//
//  TravelAdvisoryModel.swift
//  TravelBuds-Laws
//
//  Created by Krys Welch on 11/28/22.
//

import Foundation

struct TravelAdvisoryModel: Decodable {
    
    let countryname: String?
    let officialcountryname: String?
    let traveladvisorylevel: String?
    let traveladvisorymore: String?
    let quickfacts: [TravelAccordion]?
    let accordion: [TravelAccordion]?
 
}

struct TravelAccordion: Decodable {
    let sectionheader: String?
    let sectioncontent: String?
}
