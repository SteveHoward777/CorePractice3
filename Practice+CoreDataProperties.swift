//
//  Practice+CoreDataProperties.swift
//  CorePractice3
//
//  Created by Steve Howard on 2024/12/3.
//
//

import Foundation
import CoreData


extension Practice {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Practice> {
        return NSFetchRequest<Practice>(entityName: "Practice")
    }

    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var phone: String?
    @NSManaged public var age: Int64

}

extension Practice : Identifiable {

}
