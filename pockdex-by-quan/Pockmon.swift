//
//  Pockmon.swift
//  pockdex-by-quan
//
//  Created by Quan on 15/12/29.
//  Copyright © 2015年 Quan. All rights reserved.
//

import Foundation

class Pockmon {
    private var _name:String!
    private var _pockdexId:Int!
    
    var name:String {
        return _name
    }
    
    var pockdexId:Int {
        return _pockdexId
    }
    
    init(name:String, pockdexId:Int) {
        _name = name
        _pockdexId = pockdexId
    }
}