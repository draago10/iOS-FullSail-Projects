//
//  Player+CoreDataProperties.swift
//  WendelDaniel_CoreDataProject
//
//  Created by Daniel Wendel on 6/24/21.
//
//

import Foundation
import CoreData


extension Player {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Player> {
        return NSFetchRequest<Player>(entityName: "Player")
    }

    @NSManaged public var dateCompleted: Date?
    @NSManaged public var playerName: String?
    @NSManaged public var tapsToComplete: Int16
    @NSManaged public var timeToComplete: Int16

}

extension Player : Identifiable {

}
