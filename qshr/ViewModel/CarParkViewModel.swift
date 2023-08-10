//
//  CarParkListViewModel.swift
//  qshr
//
//  Created by Shah Qays on 10/08/2023.
//

import Foundation

class CarParkViewModel: ObservableObject {
    
    @Published var carParks: CarParksResponse? = nil
    @Published var carParksError = ""
    
    func loadCarParksData() async throws -> Void {
        do {
            if let data = try await CarParksAPI.getCarParks() {
                await MainActor.run {
                    processCarParksData(data: data)
                }
            }
        } catch {
            carParksError = "Error fetching car park data."
            print("Error fetching car park data.")
        }
        
    }
    
    func processCarParksData(data: CarParksResponse?) -> Void {
        if let carParkItems = data?.items {
            let count = carParkItems[0].carparkData.count
            print("There are \(count) car park data items")
        }
        carParks = data
    }
 
}
