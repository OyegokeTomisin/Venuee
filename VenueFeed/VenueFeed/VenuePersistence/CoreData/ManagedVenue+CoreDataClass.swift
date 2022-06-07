//
//  ManagedVenue+CoreDataClass.swift
//  VenueFeed
//
//  Created by Oyegoke Oluwatomisin on 07/06/2022.
//
//

import Foundation
import CoreData

public class ManagedVenue: NSManagedObject {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedVenue> {
        return NSFetchRequest<ManagedVenue>(entityName: "ManagedVenue")
    }
    
    @NSManaged public var items: String
}

extension ManagedVenue : Identifiable {
    
}

extension ManagedVenue {
    static func find(in context: NSManagedObjectContext) throws -> ManagedVenue? {
        return try context.fetch(fetchRequest()).first
    }
    
    static func deleteCache(in context: NSManagedObjectContext) throws {
        try find(in: context).map(context.delete).map(context.save)
    }
    
    static func newUniqueInstance(in context: NSManagedObjectContext) throws -> ManagedVenue {
        try deleteCache(in: context)
        return ManagedVenue(context: context)
    }
    
    var localVenueItems: [LocalVenue] {
        get {
            let data = try? JSONDecoder().decode([LocalVenue].self, from: Data(items.utf8))
            return data ?? []
        }
        set {
            do {
                let reminderData = try JSONEncoder().encode(newValue)
                items = String(data: reminderData, encoding:.utf8)!
            } catch { items = "" }
        }
    }
}
