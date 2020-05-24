//
//  Coordinates+CoreDataProperties.swift
//  NLR AR
//
//  Created by Geart Otten on 24/05/2020.
//  Copyright © 2020 Geart Otten. All rights reserved.
//
//

import Foundation
import CoreData


extension Coordinates {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Coordinates> {
        return NSFetchRequest<Coordinates>(entityName: "Coordinates")
    }

    @NSManaged public var x: Float
    @NSManaged public var y: Float
    @NSManaged public var z: Float
    @NSManaged public var node: DamageNode?

}
