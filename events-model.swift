//
//  remote-json-data.swift
//  json-demo
//
//  Created by peter van rijn on 16/12/2020.
//

import Foundation
import Combine


class EventsModel : ObservableObject {
    @Published var events = [Event]()
    
    var cancellable : Set<AnyCancellable> = Set()

    var urlBase = "http://programmeren.org/swift/events.json"
   
    init() {
        fetchEvents()
    }
    
    func fetchEvents()
    {
        URLSession.shared.dataTaskPublisher(for: URL(string: urlBase)!)
            .map { $0.data }
            .decode(type: [Event].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
            .receive(on: DispatchQueue.main)
           .sink(receiveCompletion: { completion in })
             { post in self.events.append(contentsOf: post)
        }
        .store(in: &cancellable)
    }
}
