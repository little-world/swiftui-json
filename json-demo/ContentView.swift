//
//  ContentView.swift
//  json-demo
//
//  Created by peter van rijn on 16/12/2020.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        List(eventsData) { event in
            
            VStack {
                Text(event.name)
                    .font(.title2)
                Text(event.location)
                    .font(.caption2)
                    .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
