//
//  Moya+Async.swift
//  mega
//
//  Created by 이경민 on 11/11/25.
//

import Moya

extension MoyaProvider {
    func requestAsync(_ target: Target) async throws -> Response {
        try await withCheckedThrowingContinuation { continuation in
            self.request(target) { result in
                switch result {
                case .success(let response):
                    continuation.resume(returning: response)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}

