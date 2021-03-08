//
//  remote-json-data.swift
//  json-demo
//
//  Created by peter van rijn on 16/12/2020.
//

import Foundation
import Combine

class EventsModel: ObservableObject {
  @Published var events = [Event]()
  var cancellable: Set<AnyCancellable> = Set()

  init() {
    fetchEvents()
  }

  func fetchEvents() {
    let url: String = "https://raw.githubusercontent.com/little-world/swiftui-json/master/Resources/events.json"
    URLSession.shared.dataTaskPublisher(for: URL(string: url)!)
    .map {
      $0.data
    }
    .decode(type: [Event].self, decoder: JSONDecoder())
    .eraseToAnyPublisher()
    .receive(on: DispatchQueue.main)
    .sink(receiveCompletion: { completion in })
    { post in
      self.events.append(contentsOf: post)
    }
    .store(in: &cancellable)
  }
}
