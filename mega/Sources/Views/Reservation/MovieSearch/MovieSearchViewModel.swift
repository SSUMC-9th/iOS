//
//  MovieSearchViewModel.swift
//  mega
//
//  Created by 이경민 on 10/7/25.
//

import Foundation
import Combine
import SwiftUI

class MovieSearchViewModel: ObservableObject {
    @Published var query: String = ""
    @Published var results: [ReservModel] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()

    private let allMovies: [ReservModel] = [
        .init(movieImage:.init(.f1), movieName:"F1 더 무비", movieEngName:"F1: The Movie", movieReserCount: "누적관객수 5만"),
        .init(movieImage:.init(.knife), movieName:"귀멸의 칼날", movieEngName:"blade animation", movieReserCount: "누적관객수 1만"),
        .init(movieImage:.init(.ajjulsu), movieName:"어쩔수가없다", movieEngName:"ajjulsu", movieReserCount: "누적관객수 20만"),
        .init(movieImage:.init(.face), movieName:"얼굴", movieEngName:"Face", movieReserCount: "누적관객수 10만"),
        .init(movieImage:.init(.monono), movieName:"모노노케 히메", movieEngName:"Mononoke Hime", movieReserCount: "누적관객수 12만"),
        .init(movieImage:.init(.boss), movieName:"보스", movieEngName:"Boss", movieReserCount: "누적관객수 1만"),
        .init(movieImage:.init(.yadang), movieName:"야당", movieEngName:"Yadang", movieReserCount: "누적관객수 2만"),
        .init(movieImage:.init(.theRoses), movieName:"The Roses", movieEngName:"The Roses", movieReserCount: "누적관객수 3만"),
    ]
    
    init() {
        $query
            .debounce(for: .milliseconds(400), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.errorMessage = nil
            })
            .flatMap { query in
                self.search(query: query)
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorMessage = "검색 실패: \(error.localizedDescription)"
                    self?.results = []
                }
            } receiveValue: { [weak self] items in
                self?.results = items
            }
            .store(in: &cancellables)
    }

    private func search(query: String) -> AnyPublisher<[ReservModel], Error> {
        if query.isEmpty {
            return Just(allMovies)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        return Future<[ReservModel], Error> { [weak self] promise in
            guard let self = self else { return }
            
            let delay = Double(Int.random(in: 300...700)) / 1000.0
            
            DispatchQueue.global().asyncAfter(deadline: .now() + delay) {
                let filtered = self.allMovies.filter { $0.movieName.localizedCaseInsensitiveContains(query) }
                promise(.success(filtered))
            }
        }

        .handleEvents(
            receiveSubscription: { _ in
                DispatchQueue.main.async { self.isLoading = true }
            },
            receiveCompletion: { _ in
                DispatchQueue.main.async { self.isLoading = false }
            }
        )
        .eraseToAnyPublisher()
    }
}
