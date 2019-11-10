//
//  TimeTable.swift
//  TodoList
//
//  Created by Hirohisa Suzuki on 2019/10/31.
//  Copyright © 2019 Hirohisa Suzuki. All rights reserved.
//

import Foundation

class TimeTable: NSObject, NSSecureCoding{
    static var supportsSecureCoding: Bool{
        return true
    }
    var tableName: String?
    var hour: Int?
    var minuts: [Int]?

    override init(){
        
    }

    required init?(coder aDecoder: NSCoder){
        self.tableName = aDecoder.decodeObject(forKey: "tableName") as? String
        self.hour = aDecoder.decodeInteger(forKey: "hour")
        self.minuts = (aDecoder.decodeObject(forKey: "minuts") as? [Int])
    }

    func encode(with aCoder: NSCoder) {
           aCoder.encode(self.tableName, forKey: "tableName")
           aCoder.encode(self.hour, forKey: "hour")
           aCoder.encode(self.minuts, forKey: "minuts")
    }
}
