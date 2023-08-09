//
//  CarParkResponse.swift
//  qshr
//
//  Created by Shah Qays on 09/08/2023.
//


import Foundation

struct CarParkResponse: Codable {
    let items: [Item]
}

struct Item: Codable {
    let timestamp: Date
    let carparkData: [CarParkData]

    enum CodingKeys: String, CodingKey {
        case timestamp
        case carparkData = "carpark_data"
    }
}

struct CarParkData: Codable {
    let carparkInfo: [CarParkInfo]
    let carparkNumber, updateDatetime: String

    enum CodingKeys: String, CodingKey {
        case carparkInfo = "carpark_info"
        case carparkNumber = "carpark_number"
        case updateDatetime = "update_datetime"
    }
}

struct CarParkInfo: Codable {
    let totalLots, lotType, lotsAvailable: String

    enum CodingKeys: String, CodingKey {
        case totalLots = "total_lots"
        case lotType = "lot_type"
        case lotsAvailable = "lots_available"
    }
}


