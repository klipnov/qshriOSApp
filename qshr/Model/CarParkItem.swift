//
//  CarParkListing.swift
//  qshr
//
//  Created by Shah Qays on 10/08/2023.
//

import Foundation

struct ListCarParkItem {
    let carParkNumber: String
    let totalLots: Int
    let totalAvailableLots: Int
}

struct CarParkMinMax: Identifiable {
    let id: CarParkCategory
    let category: CarParkCategory
    let min: [ListCarParkItem]
    let max: [ListCarParkItem]
}

enum CarParkCategory: String, CaseIterable {
    case small = "small"
    case medium = "medium"
    case big = "big"
    case large = "large"
}
