//
//  ImageRepositoryImp.swift
//  EmployeeDirectory
//
//  Created by hope on 2/8/23.
//

import Foundation

enum ImageRepositoryError: Error {
    case failedUpdate
}

struct ImageRepositoryImp: ImageRepository {
    private let localSource: ImageDataSource
    private let remoteSource: ImageDataSource
    
    init(localDataSource: ImageDataSource = ImageLocalDataSource(),
         remoteDataSource: ImageDataSource = ImageRemoteDataSource()) {
        localSource = localDataSource
        remoteSource = remoteDataSource
    }
    
    func get(for url: URL) async -> Data? {
        let data = await localSource.get(for: url)
        return data as? Data
    }
    
    func download(from url: URL) async -> AnyObject? {
        await remoteSource.get(for: url)
    }
    
    func update(to url: URL, data: AnyObject) throws {
        do {
            try localSource.update(for: url, data: data)
        } catch {
            throw ImageRepositoryError.failedUpdate
        }
    }
    
    func delete(at url: URL) {
        // TODO
    }
}
