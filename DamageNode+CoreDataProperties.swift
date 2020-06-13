//
//  DamageNode+CoreDataProperties.swift
//  NLR AR
//
//  Created by Geart Otten on 13/06/2020.
//  Copyright © 2020 Geart Otten. All rights reserved.
//
//

import Foundation
import CoreData


extension DamageNode {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DamageNode> {
        return NSFetchRequest<DamageNode>(entityName: "DamageNode")
    }

    @NSManaged public var title: String?
    @NSManaged public var coordinates: Coordinates?
    @NSManaged public var aircraft: Set<Aircraft>?
    @NSManaged public var createdAt: Date?

}

// MARK: Generated accessors for aircraft
extension DamageNode {

    @objc(addAircraftObject:)
    @NSManaged public func addToAircraft(_ value: Aircraft)

    @objc(removeAircraftObject:)
    @NSManaged public func removeFromAircraft(_ value: Aircraft)

    @objc(addAircraft:)
    @NSManaged public func addToAircraft(_ values: NSSet)

    @objc(removeAircraft:)
    @NSManaged public func removeFromAircraft(_ values: NSSet)

}
