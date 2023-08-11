//
//  CarParkListViewModel.swift
//  qshr
//
//  Created by Shah Qays on 10/08/2023.
//

import Foundation

class CarParkViewModel: ObservableObject {
    
    @Published var carParksError = ""
    
    @Published var carParkMinMaxItems: [CarParkMinMax] = []
    @Published var carParkDataTimeStamp = ""
    
    func loadCarParksData() async throws -> Void {
        do {
            if let data = try await CarParksAPI.getCarParks() {
                await MainActor.run {
                    carParkMinMaxItems = []
                    carParkDataTimeStamp = data.items[0].timestamp
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
        
        categorizeCarParksBasedOnTotalLots(listCarParkItems: listCarParkItems, category: .small)
    }
    
    func categorizeCarParksBasedOnTotalLots(listCarParkItems: [ListCarParkItem], category: CarParkCategory) -> Void {
        
        var small: [ListCarParkItem] = []
        var medium: [ListCarParkItem] = []
        var big: [ListCarParkItem] = []
        var large: [ListCarParkItem] = []
        
        for item in listCarParkItems {
            if (item.totalLots < 100) {
                small.append(item)
            } else if(item.totalLots >= 100 && item.totalLots < 300) {
                medium.append(item)
            } else if(item.totalLots >= 300 && item.totalLots < 400) {
                big.append(item)
            } else {
                large.append(item)
            }
        }
        
        carParkMinMaxItems.append(calculateMinMaxForTheCategory(items: small, category: .small))
        carParkMinMaxItems.append(calculateMinMaxForTheCategory(items: medium, category: .medium))
        carParkMinMaxItems.append(calculateMinMaxForTheCategory(items: big, category: .big))
        carParkMinMaxItems.append(calculateMinMaxForTheCategory(items: large, category: .large))
        
    }
    
    func calculateMinMaxForTheCategory(items: [ListCarParkItem], category: CarParkCategory) -> CarParkMinMax {
        let categoryMax = items.max(by: { $0.totalAvailableLots < $1.totalAvailableLots })
        let categoryMin = items.min(by: { $0.totalAvailableLots < $1.totalAvailableLots })
        
        let finalCategoryMin = items.filter { item in
            return item.totalAvailableLots == categoryMin?.totalAvailableLots
        }
        
        let finalCategoryMax = items.filter { item in
            return item.totalAvailableLots == categoryMax?.totalAvailableLots
        }
        
        return CarParkMinMax(id: category, category: category, min: finalCategoryMin, max: finalCategoryMax)
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
