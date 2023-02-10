//
//  ImageLocalDataSource.swift
//  EmployeeDirectory
//
//  Created by hope on 2/8/23.
//

import Foundation

struct ImageLocalDataSource: ImageDataSource {
    private let diskCache: ImageCache
    private let memoryCache = NSCache<NSString, AnyObject>()
    
    init(diskCache: ImageCache = FileDiskImageCache()) {
        self.diskCache = diskCache
    }
    
    func get(for url: URL) async -> AnyObject? {
        if let memoryCached = memoryCache.object(forKey: url.absoluteString.hashString as NSString) {
            return memoryCached
        } else if let diskCached = diskCache.get(for: url) {
            memoryCache.setObject(diskCached, forKey: url.absoluteString.hashString as NSString)
            return diskCached
        }
        
        return nil
    }
    
    func update(for url: URL, data: AnyObject) throws {
        var cacheData = data
        
        if let urlContent = data as? URLContent {
            cacheData = urlContent.data as AnyObject
        }
        
        memoryCache.setObject(cacheData, forKey: url.absoluteString.hashString as NSString)
        try diskCache.insert(to: url, data: cacheData)
    }
}
