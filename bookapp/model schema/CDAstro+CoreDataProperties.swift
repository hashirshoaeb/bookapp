//
//  CDAstro+CoreDataProperties.swift
//  
//
//  Created by Muhammad Hashir Shoaib on 09/05/2022.
//
//

import Foundation
import CoreData


extension CDAstro {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDAstro> {
        return NSFetchRequest<CDAstro>(entityName: "CDAstro")
    }

    @NSManaged public var copyright: String?
    @NSManaged public var date: String?
    @NSManaged public var explanation: String?
    @NSManaged public var hdurl: String?
    @NSManaged public var isFavourite: Bool
    @NSManaged public var mediaType: String?
    @NSManaged public var serviceVersion: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?

}
