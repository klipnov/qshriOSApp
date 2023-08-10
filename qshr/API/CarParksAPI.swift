//
//  FetchAvailableCarParks.swift
//  qshr
//
//  Created by Shah Qays on 09/08/2023.
//

import Foundation

struct CarParksAPI {
    
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
