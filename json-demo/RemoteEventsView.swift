//
//  RemoteEventsView.swift
//  json-demo
//
//  Created by peter van rijn on 16/12/2020.
//

import SwiftUI
import Combine

struct RemoteEventsView: View {
    @ObservedObject var model = EventsModel()
    
    var body: some View {
        List(model.events) { event in
            
            VStack {
                Text(event.name)
                    .font(.title2)
                Text(event.location)
                    .font(.caption2)
                    .padding()
            }
        }
//        .onAppear {
//            print ("onAppear")
//            model.fetchEvents()
//        }
    }
}

struct RemoteEventsView_Previews: PreviewProvider {
    static var previews: some View {
        RemoteEventsView()
    }
}
