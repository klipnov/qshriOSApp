//
//  CarParkListViewModel.swift
//  qshr
//
//  Created by Shah Qays on 10/08/2023.
//

import Foundation

class CarParkViewModel: ObservableObject {
    
    @Published var carParks: CarParksResponse? = nil
    
    func loadCarParksData() async throws -> Void {
        do {
            if let data = try await CarParksAPI.getCarParks() {
                await MainActor.run {
                    carParks = data
                    print(carParks?.items[0].carparkData[0] ?? "")
                }
            }
        } catch {
            print("Error fetching car park data.")
        }
        
    }
    
}
