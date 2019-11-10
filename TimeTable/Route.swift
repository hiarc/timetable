//
//  Route.swift
//  TimeTable
//
//  Created by Hirohisa Suzuki on 2019/10/30.
//  Copyright © 2019 Hirohisa Suzuki. All rights reserved.
//

import Foundation
class Route: NSObject, NSSecureCoding{
    static var supportsSecureCoding: Bool{
        return true
    }
    var name: String?
    var isDefault: Bool = false

    
    override init(){
        
    }
    required init?(coder aDecoder: NSCoder){
        self.name = aDecoder.decodeObject(forKey: "name") as? String
        self.isDefault = aDecoder.decodeBool(forKey: "isDefault")
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.isDefault, forKey: "isDefault")
    }
}
