//
//  ContentView.swift
//  iTour
//
//  Created by Jordon Bigelow on 6/18/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query var destinations: [Destination]
    @Environment(\.modelContext) var modelContext
    @State private var path = [Destination]()
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(destinations) { destintation in
                    NavigationLink(value: destintation) {
                        VStack(alignment: .leading) {
                            Text(destintation.name)
                                .font(.headline)
                            
                            Text(destintation.date.formatted(date: .long, time: .shortened))
                        }
                    }
                }
                .onDelete(perform: deleteDesinations)
            }
            .navigationTitle("iTour")
            .navigationDestination(for: Destination.self, destination: EditDestinationView.init)
            .toolbar {
                Button("Add Destination", systemImage: "plus", action: addDestination)
            }
        }
    }
    
    func deleteDesinations(_ indexSet: IndexSet) {
        for index in indexSet {
            let destination = destinations[index]
            modelContext.delete(destination)
        }
    }
    
    func addDestination() {
        let destination = Destination()
        modelContext.insert(destination)
        path = [destination]
    }
}

#Preview {
    ContentView()
}
