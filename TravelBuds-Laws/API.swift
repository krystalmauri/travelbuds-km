//
//  API.swift
//  TravelBuds-Laws
//
//  Created by Krys Welch on 11/28/22.
//

import Foundation

final class API {
    
    static let shared = API()
    
    func callLawAPI(onCompletion: @escaping (TravelAdvisoryModel) -> ()) {
        let formattedcountry =  selectedCountryString.replacingOccurrences(of: " ", with: "")
        print("testing testing " + formattedcountry)
        let url = URL(string: "http://127.0.0.1:8000/\(formattedcountry)")!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request, completionHandler: { (data1, response1, error1) -> Void in
            
            guard let data = data1 else {
                return
            }
            
            do {
                let travelAdvModel = try JSONDecoder().decode(TravelAdvisoryModel.self, from: data)
                
                
                DispatchQueue.main.async {
                    let tmp = travelAdvModel
                    print("travel advisory model \(tmp.countryname)")
                    
                }
                
                onCompletion(travelAdvModel)
                
            } catch {
                print("Couldn't decode travel advisory json \(error1.debugDescription)")
            }
            
        })
        
        dataTask.resume()
        
    }
    
}
