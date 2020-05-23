//
//  DamageNode+CoreDataProperties.swift
//  NLR AR
//
//  Created by Geart Otten on 23/05/2020.
//  Copyright © 2020 Geart Otten. All rights reserved.
//
//

import Foundation
import CoreData


extension DamageNode {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DamageNode> {
        return NSFetchRequest<DamageNode>(entityName: "DamageNode")
    }

    @NSManaged public var name: String?
    @NSManaged public var coordinates: Coordinates?

}
