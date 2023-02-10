//
//  ImageRepository.swift
//  EmployeeDirectory
//
//  Created by hope on 2/8/23.
//

import Foundation

protocol ImageRepository {
    
    func get(for url: URL)  async -> Data?
    
    func download(from url: URL) async -> AnyObject?
    
    func update(to url: URL, data: AnyObject) throws
    
    func delete(at url: URL)
}
