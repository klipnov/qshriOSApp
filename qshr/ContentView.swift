//
//  ContentView.swift
//  qshr
//
//  Created by Shah Qays on 09/08/2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var carParkViewModel = CarParkViewModel()
    
    var body: some View {
        NavigationStack{
            List {
                    ForEach(carParkViewModel.carParkMinMaxItems) { item in
                        VStack {
                            Text("\(item.category.rawValue.uppercased())").fontWeight(.bold)
                            Text("HIGHEST (\(item.max[0].totalAvailableLots) lots available)")
                                .multilineTextAlignment(.leading)
                            
                            VStack {
                                ForEach(0..<item.max.count, id: \.self) { index in
                                    Text("\(item.max[index].carParkNumber)")
                                }
                            }
                            
                            Text("LOWEST (\(item.min[0].totalAvailableLots) lots available)")
                            
                            VStack {
                                ForEach(0..<item.min.count, id: \.self) { index in
                                    Text("\(item.min[index].carParkNumber)")
                                }
                            }
                        }
                    }
                }
        }.task {
            do {
                try await carParkViewModel.loadCarParksData()
            } catch {
                print("Error loading car parks data.")
            }
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
