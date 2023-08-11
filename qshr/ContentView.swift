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
        ScrollView(.vertical) {
                    ForEach(carParkViewModel.carParkMinMaxItems) { item in
                        VStack {
                            Text("\(item.category.rawValue.uppercased())")
                                .font(.title)
                                .fontWeight(.bold)
                            
                            Divider()
                                .padding(.bottom)
                                
                            Text("HIGHEST (\(item.max[0].totalAvailableLots) lots available)")
                                .font(.headline)
                                .multilineTextAlignment(.leading)
                                .padding(.bottom, 2.0)
                            
                            VStack {
                                ForEach(0..<item.max.count, id: \.self) { index in
                                    Text("\(item.max[index].carParkNumber)")
                                }.padding(.bottom)
                            }
                            
                            Text("LOWEST (\(item.min[0].totalAvailableLots) lots available)")
                                .font(.headline)
                            
                            VStack {
                                ForEach(0..<item.min.count, id: \.self) { index in
                                    Text("\(item.min[index].carParkNumber)")
                                }
                            }.padding(.bottom)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 16.0)
                    }
                }
        .task {
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
