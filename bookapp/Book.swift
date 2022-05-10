//
//  Book.swift
//  bookapp
//
//  Created by Muhammad Hashir Shoaib on 25/04/2022.
//

import Foundation
import CoreData




/// Protocol to provide functionality for Core Data managed object conversion.
protocol ManagedObjectConvertible {
    associatedtype ManagedObject

    /// Converts a conforming instance to a managed object instance.
    ///
    /// - Parameter context: The managed object context to use.
    /// - Returns: The converted managed object instance.
    func toManagedObject(in context: NSManagedObjectContext) -> ManagedObject
}


/// Protocol to provide functionality for data model conversion.
protocol ModelConvertible {
    associatedtype Model

    /// Converts a conforming instance to a data model instance.
    ///
    /// - Returns: The converted data model instance.
    func toModel() -> Model
}



struct Astro: Codable {
    
    let date, explanation: String
    let hdurl: String?
    let mediaType: MediaType
    let serviceVersion: ServiceVersion
    let title: String
    let url: String
    let copyright: String?
    var isFavourite = false
    
    
    enum CodingKeys: String, CodingKey {
        case date, explanation, hdurl
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case title, url, copyright
    }
    
    var id: Int {
        print("hashshsh: " , title.hash)
        return title.hash
    }
    
    // returns latest state
    mutating func toggleFavourite() -> Void {
        self.isFavourite = !self.isFavourite
        // return self.isFavourite
    }
}


extension Astro: ManagedObjectConvertible {
    typealias ManagedObject = CDAstro
    
    func toManagedObject(in context: NSManagedObjectContext) -> CDAstro {
        let entityName = CDAstro.entity().name
        let entityDescription = NSEntityDescription.entity(forEntityName: entityName!, in: context)!
        
        let object = CDAstro.init(entity: entityDescription, insertInto: context)
        object.date = date
        object.explanation = explanation
        object.hdurl = hdurl
        object.mediaType = mediaType.rawValue
        object.serviceVersion = serviceVersion.rawValue
        object.title = title
        object.url = url
        object.copyright = copyright
        object.isFavourite = isFavourite
        try? context.save()
        return object
    }
}

extension CDAstro: ModelConvertible {
    // MARK: - ModelConvertible
    /// Converts a UserManagedObject instance to a User instance.
    ///
    /// - Returns: The converted User instance.
    func toModel() -> Astro {
        return Astro(date: date!, explanation: explanation!, hdurl: hdurl, mediaType: MediaType.fromString(mediaType!), serviceVersion: ServiceVersion.fromString(serviceVersion!), title: title!, url: url!, copyright: copyright, isFavourite: isFavourite)
                   
    }
    
    // returns latest state
    func toggleFavourite(in context: NSManagedObjectContext) -> Void {
        self.isFavourite = !self.isFavourite
        try? context.save()
        // return self.isFavourite
    }
}



enum MediaType: String, Codable {
    case image = "image"
    case video = "video"
    
    static func fromString(_ value: String) -> MediaType {
        switch value {
        case image.rawValue:
            return image
        case video.rawValue:
            return video
            // problametic
        default:
            return image
        }
    }
}

enum ServiceVersion: String, Codable {
    case v1 = "v1"
    
    static func fromString(_ value: String) -> ServiceVersion {
        switch value {
        case v1.rawValue:
            return v1
            // problametic
        default:
            return v1
        }
    }
}

typealias Response = [Astro]
