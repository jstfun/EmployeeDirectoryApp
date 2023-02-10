//
//  Bundle+Extension.swift
//  EmployeeDirectory
//
//  Created by hope on 2/9/23.
//

import Foundation

extension Bundle {
    enum Error: Swift.Error {
        case bundleNotFound
        case loadingDataFailed
        case decodingDataFailed
    }

    func decode<T: Decodable>(_ type: T.Type,
                              from file: String,
                              decoder: JSONDecoder = JSONDecoder()) throws -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            throw Error.bundleNotFound
        }
        guard let data = try? Data(contentsOf: url) else {
            throw Error.loadingDataFailed
        }
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw Error.decodingDataFailed
        }
    }
}
