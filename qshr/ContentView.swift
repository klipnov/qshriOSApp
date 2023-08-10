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
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
        }
        .padding()
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
