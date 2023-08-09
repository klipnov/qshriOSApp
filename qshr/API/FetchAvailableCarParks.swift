//
//  FetchAvailableCarParks.swift
//  qshr
//
//  Created by Shah Qays on 09/08/2023.
//

import Foundation

struct CarParksData {
    
    static func fetchCarParksData() {
        guard let url = URL(string: "https://api.data.gov.sg/v1/transport/carpark-availability") else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    //let json = String(data: data, encoding: .utf8)
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let decodedData = try decoder.decode(CarParkResponse.self, from: data)
                    print(decodedData)
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            } else if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
            }
        }.resume()
    }
    
}
