//
//  ImageDataSource.swift
//  EmployeeDirectory
//
//  Created by hope on 2/8/23.
//

import Foundation

protocol ImageDataSource {
    
    func get(for url: URL) async -> AnyObject?
    
    func update(for url: URL, data: AnyObject) throws
}
