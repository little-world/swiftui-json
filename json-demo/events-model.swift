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

  private var cancellable: AnyCancellable? = nil

  // var urlBase = "http://programmeren.org/swift/events.json"
  var urlBase = "https://github.com/little-world/swiftui-json/blob/master/Resources/events.json"


  init() {
    //fetchEvents()
  }

  func fetchEvents() {
    print("in fetch events")

    let url: String = "https://github.com/little-world/swiftui-json/blob/master/Resources/events.json"

    let urlComponents = URLComponents(string: url)!
    let request = URLRequest(url: urlComponents.url!)
      struct Response<T> {
        let value: T
        let response: URLResponse
      }

      let decoder: JSONDecoder = JSONDecoder()

      cancellable = URLSession.shared.dataTaskPublisher(for: request)
      .tryMap { result -> Response<[Event]> in

        do {
          let value = try decoder.decode([Event].self, from: result.data)
          return Response(value: value, response: result.response) //
        } catch DecodingError.keyNotFound(let key, let context) {
          fatalError("Failed to decode due to missing key '\(key.stringValue)' not found – \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
          fatalError("Failed to decode due to type mismatch – \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
          fatalError("Failed to decode due to missing \(type) value – \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(let context) {
          fatalError("Failed to decode, because it appears to be invalid JSON:  – \(context.debugDescription)")
        } catch {
          fatalError("Failed to decode: \(error.localizedDescription)")
        }


      }
      .receive(on: DispatchQueue.main)
      //          .replaceError(with: [Question(id: 0, type: QuestionType.single, text: "error")])
      .eraseToAnyPublisher()
      .sink(receiveCompletion:
      { completion in
        print(".sink() received the completion ", String(describing: completion))
        switch completion {
        case .finished:
          break
        case .failure(let anError):
          print("received error: ", anError)
        }
      },
      receiveValue: { file in
        self.events = file.value
      })
    }
  }

