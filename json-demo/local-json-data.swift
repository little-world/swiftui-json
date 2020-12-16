//
//  json-data.swift
//  json-demo
//
//  Created by peter van rijn on 16/12/2020.
//

import Foundation
import SwiftUI


func loadFile(_ filename: String) -> [Event] {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Cannot find \(filename)")
    }
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Cannot load \(filename):\n\(error)")
    }
    do {
        let decoder = JSONDecoder()
        return try decoder.decode([Event].self, from: data)
    } catch {
        fatalError("Cannot't parse \(filename): Event:\n\(error)")
    }
}


let eventsData: [Event] = loadFile("events.json")
