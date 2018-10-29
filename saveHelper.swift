//
//  saveHelper.swift
//  TichuCounter
//
//  Created by Teodoro Gomes on 25/10/2018.
//

import Foundation

class saveHelper {
    
    
    //archive
    
    private static func archive(_ points: [points]) -> NSData?  {
//        var data:NSData = nil
        
        do{
            data = try NSKeyedArchiver.archivedData(withRootObject: points, requiringSecureCoding: false) as NSData
        }catch{
            
        }
       
        return data
    }
    
    
    //Fetch
    
    
    
    //Save
    
    
    
}
