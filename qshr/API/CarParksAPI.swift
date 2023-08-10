//
//  FetchAvailableCarParks.swift
//  qshr
//
//  Created by Shah Qays on 09/08/2023.
//

import Foundation

struct CarParksAPI {
    
//    static func fetchCarParksData() -> CarParkResponse? {
//        guard let url = URL(string: "https://api.data.gov.sg/v1/transport/carpark-availability") else { return }
//        URLSession.shared.dataTask(with: url) { data, _, error in
//            if let data = data {
//                do {
//                    let decoder = JSONDecoder()
//                    decoder.dateDecodingStrategy = .iso8601
//                    let decodedData = try decoder.decode(CarParkResponse.self, from: data)
//                    return decodedData
//                } catch {
//                    print("Error decoding JSON: \(error)")
//                    return
//                }
//            } else if let error = error {
//                print("Error fetching data: \(error.localizedDescription)")
//            }
//        }.resume()
//    }
    
    static func getCarParks() async throws -> CarParksResponse? {
        guard let url = URL(string: "https://api.data.gov.sg/v1/transport/carpark-availability") else { return nil }
        
        let session = URLSession.shared
        let (data, _) = try await session.data(from: url)
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        let decodedData = try decoder.decode(CarParksResponse.self, from: data)
        return decodedData
    }
    
    
    
}
