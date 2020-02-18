//
//  Bar.swift
//  Meu primeiro app
//
//  Created by Jonathan on 03/02/20.
//  Copyright © 2020 teste. All rights reserved.
//
import os.log
import Foundation
import UIKit

class Bar: NSObject, NSCoding {
   
   
    
    ///MARK: Initialization
    //MARK: Properties
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    
    //MARK: Types
    
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
        static let Telefone = "Telefone"
        static let Latitude = "Latitude"
        static let Longitude = "Longitude"
        static let Endereco = "Endereco"
    }
    
    var name: String
    var photo: UIImage?
    var rating: Int
    var Telefone: String
    var Longitude: Float
    var Latitude: Float
    var Endereco: String
    
    init?(name: String, photo: UIImage?, rating: Int, Telefone: String, Longitude: Float,Latitude: Float,Endereco:String) {
        // Initialization should fail if there is no name or if the rating is negative.
        guard (!name.isEmpty) else {
            return nil
        }
       
        // The rating must be between 0 and 5 inclusively
        guard (rating >= 0 && rating <= 5) else {
            return nil
        }
        
        guard (Telefone.count > 0 && Telefone.count < 15) else{
            return nil
        }
 
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.rating = rating
        self.Latitude = Latitude
        self.Longitude = Longitude
        self.Telefone = Telefone
        self.Endereco = Endereco
        
    }
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(rating, forKey: PropertyKey.rating)
        aCoder.encode(Telefone, forKey: PropertyKey.Telefone)
        aCoder.encode(Longitude, forKey: PropertyKey.Longitude)
        aCoder.encode(Latitude, forKey: PropertyKey.Latitude)
        aCoder.encode(Endereco, forKey: PropertyKey.Endereco)
        
    }
    required convenience init?(coder aDecoder: NSCoder) {
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let photo = aDecoder.decodeObject(forKey: PropertyKey.photo)as? UIImage else{
            os_log("photo", log: OSLog.default, type:.debug)
            return nil
        }
        guard let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)as? Int else{
            os_log("Rating", log: OSLog.default,type:.debug)
            return nil
        }
        
        guard let Telefone = aDecoder.decodeObject(forKey: PropertyKey.Telefone)as? String else{
            os_log("Telefone", log:OSLog.default,type:.debug)
            return nil
        }
        guard let Longitude = aDecoder.decodeFloat(forKey: PropertyKey.Longitude)as? Float else{
            os_log("Longitude", log:OSLog.default,type:.debug)
            return nil
        }
        guard let Latitude = aDecoder.decodeFloat(forKey: PropertyKey.Latitude)as? Float else{
            os_log("Latitude", log:OSLog.default,type:.debug)
            return nil
        }
        guard let Endereco = aDecoder.decodeObject(forKey: PropertyKey.Endereco)as? String else{
            os_log("Endereco", log:OSLog.default,type:.debug)
            return nil
        }
    
        // Must call designated initializer.
        self.init(name: name, photo: photo, rating: rating,Telefone: Telefone ,Longitude: Float(Longitude),Latitude: Float(Latitude),Endereco: Endereco )
        
    }
}
