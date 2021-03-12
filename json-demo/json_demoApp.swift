//
//  json_demoApp.swift
//  json-demo
//
//  Created by peter van rijn on 16/12/2020.
//

import SwiftUI

@main
struct json_demoApp: App {
    var body: some Scene {
        WindowGroup {
           // ContentView()
            //RemoteEventsView()
          RemoteImageView(withURL: "https://www.fiets.nl/app/uploads/Ghost-Lector.jpg")
        }
    }
}
