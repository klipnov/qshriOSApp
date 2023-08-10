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
                    processCarParksResponse(response: data)
                }
            }
        } catch {
            carParksError = "Error fetching car park data."
            print("Error fetching car park data.")
        }
        
    }
    
    func processCarParksResponse(response: CarParksResponse?) -> Void {
        if let carParkItems = response?.items {
            processCarParkItems(items: carParkItems)
        }
        carParks = response
    }
    
    func processCarParkItems(items: [Item]) -> Void {
        for item in items {
            processCarParkData(carParkData: item.carparkData)
        }
    }
    
    func processCarParkData(carParkData: [CarParkData]) -> Void {
        var listCarParkItems: [ListCarParkItem] = []
        for item in carParkData {
            let totalLots = getSumOfTotalLots(carParkInfo: item.carparkInfo)
            let totalAvailableLots = getSumOfTotalAvailableLots(carParkInfo: item.carparkInfo)
            
            let listCarParkItem = ListCarParkItem (
                carParkNumber: item.carparkNumber,
                totalLots: totalLots,
                totalAvailableLots: totalAvailableLots
            )
            
            listCarParkItems.append(listCarParkItem)
        }
        
        categorizeCarParksBasedOnTotalLots(listCarParkItems: listCarParkItems)
    }
    
    func categorizeCarParksBasedOnTotalLots(listCarParkItems: [ListCarParkItem]) -> Void {
        
        var small: [ListCarParkItem] = []
        var medium: [ListCarParkItem] = []
        var big: [ListCarParkItem] = []
        var large: [ListCarParkItem] = []
        
        for item in listCarParkItems {
            if (item.totalAvailableLots < 100) {
                small.append(item)
            } else if(item.totalAvailableLots >= 100 && item.totalAvailableLots < 300) {
                medium.append(item)
            } else if(item.totalAvailableLots >= 300 && item.totalAvailableLots < 400) {
                big.append(item)
            } else {
                large.append(item)
            }
        }
        
        print(small)
    }
    
    func getSumOfTotalLots(carParkInfo: [CarParkInfo]) -> Int {
        return carParkInfo.reduce(0) { (partialResult, item) -> Int in
            return partialResult + (Int(item.totalLots) ?? 0)
        }
    }
    
    func getSumOfTotalAvailableLots(carParkInfo: [CarParkInfo]) -> Int {
        return carParkInfo.reduce(0) { (partialResult, item) in
            return partialResult + (Int(item.lotsAvailable) ?? 0)
        }
    }
    
    
 
}
