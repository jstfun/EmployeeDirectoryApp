//
//  GetImageUseCase.swift
//  EmployeeDirectory
//
//  Created by hope on 2/8/23.
//

import Foundation

struct GetImageUseCase {
    private let repository: ImageRepository
    
    init(repository: ImageRepository = ImageRepositoryImp()) {
        self.repository = repository
    }
    
    func execute(for url: URL) async -> Data? {
        if let cached = await repository.get(for: url) {
            return cached
        } else {
            guard let data = await repository.download(from: url) else {
                return nil
            }
            
            do {
                try repository.update(to: url, data: data)
                return await repository.get(for: url)
            } catch {
                return nil
            }
        }
    }
}
