//
//  CoreDataVenueStore.swift
//  VenueFeed
//
//  Created by Oyegoke Oluwatomisin on 06/06/2022.
//

import CoreData

public final class CoreDataVenueStore {
    
    private static let modelName = "VenueStore"
    private static let model = NSManagedObjectModel.with(name: modelName, in: Bundle(for: CoreDataVenueStore.self))
    
    private let container: NSPersistentContainer
    private let context: NSManagedObjectContext
    
    enum StoreError: Error {
        case modelNotFound
        case failedToLoadPersistentContainer(Error)
    }
    
    public init(storeURL: URL) throws {
        guard let model = CoreDataVenueStore.model else {
            throw StoreError.modelNotFound
        }
        do {
            container = try NSPersistentContainer.load(name: CoreDataVenueStore.modelName, model: model, url: storeURL)
            context = container.newBackgroundContext()
        } catch {
            throw StoreError.failedToLoadPersistentContainer(error)
        }
    }
    
    func performSync<R>(_ action: (NSManagedObjectContext) -> Result<R, Error>) throws -> R {
        let context = self.context
        var result: Result<R, Error>!
        context.performAndWait { result = action(context) }
        return try result.get()
    }
    
    private func cleanUpReferencesToPersistentStores() {
        context.performAndWait {
            let coordinator = self.container.persistentStoreCoordinator
            try? coordinator.persistentStores.forEach(coordinator.remove)
        }
    }
    
    deinit {
        cleanUpReferencesToPersistentStores()
    }
}

extension CoreDataVenueStore: VenueStore {
    
    public func retrieve() throws -> [Venue]? {
        try performSync { context in
            Result {
                try ManagedVenue.find(in: context).map {
                    $0.localVenueItems.map( { Venue(name: $0.name, address: $0.address)})
                }
            }
        }
    }
    
    public func insert(_ items: [Venue]) throws {
        try performSync { context in
            Result {
                let managedCache = try ManagedVenue.newUniqueInstance(in: context)
                managedCache.localVenueItems = items.map { LocalVenue(name: $0.name, address: $0.address)}
                try context.save()
            }
        }
    }
    
    public func deleteCachedVenue() throws {
        try performSync { context in
            Result {
                try ManagedVenue.deleteCache(in: context)
            }
        }
    }
}
