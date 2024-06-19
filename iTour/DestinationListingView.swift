//
//  DestinationListingView.swift
//  iTour
//
//  Created by Jordon Bigelow on 6/18/24.
//

import SwiftUI
import SwiftData

struct DestinationListingView: View {
    @Query var destinations: [Destination]
    @Environment(\.modelContext) var modelContext
    
    init(sort: SortDescriptor<Destination>, searchString: String) {
        _destinations = Query(filter: #Predicate {
            if searchString.isEmpty {
                return true
            } else {
                return $0.name.localizedStandardContains(searchString)
            }
        }, sort: [sort])
    }
    
    var body: some View {
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
            .onDelete(perform: deleteDestination)
        }
    }
    
    func deleteDestination(_ indexSet: IndexSet) {
        for index in indexSet {
            let destination = destinations[index]
            modelContext.delete(destination)
        }
    }
}

#Preview {
    DestinationListingView(sort: SortDescriptor(\Destination.name), searchString: "")
}
