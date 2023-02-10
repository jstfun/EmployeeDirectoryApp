//
//  EmployeesRepositoryImp.swift
//  EmployeeDirectory
//
//  Created by hope on 2/8/23.
//

import Foundation

struct EmployeeRepositoryImp: EmployeesRepository {
    private let localSource: EmployeeDataSource
    private let remoteSource: EmployeeDataSource
    
    init(localDataSource: EmployeeDataSource = EmployeeLocalDataSource(),
         remoteDataSource: EmployeeDataSource = EmployeeRemoteDataSource()) {
        localSource = localDataSource
        remoteSource = remoteDataSource
    }
    
    func get() async -> [EmployeeModel]? {
        let entities = try? await localSource.getAll()
        return entities?.map { EmployeeModel(from: $0) }
    }
    
    func fetch() async throws -> [EmployeeModel] {
        let entities = try await remoteSource.getAll()
        return entities?.map { EmployeeModel(from: $0) } ?? []
    }
}
