//
//  JSONAPIError.swift
//  SwiftyJSONAPI
//
//  Created by Billy Tobon on 10/15/15.
//  Copyright © 2015 Thomas Sunde Nielsen. All rights reserved.
//

import Foundation


open class JSONAPIError: JSONPrinter, Error {

    open var id = ""
    open var links: [String:URL] = [:]
    open var status = ""
    open var code = ""
    open var title = ""
    open var detail = ""
    open var source: JSONAPIErrorSource?
    open var meta: Dictionary<String,Any>?
    
    public init(){}
    
    public convenience init(_ json: NSDictionary) {
        self.init(json as! [String:Any])
    }
    
    public convenience init(_ json: [String:Any]) {
        self.init()
        if let objectId = json["id"] {
            id = "\(objectId)"
        }
        
        if let strings = json["links"] as? [String:String] {
            for (key, value) in strings {
                links[key] = URL(string: value)!
            }
        }
        
        if let objectStatus = json["status"] {
            status = "\(objectStatus)"
        }
        
        if let objectCode = json["code"] {
            code = "\(objectCode)"
        }
        
        if let objectTitle = json["title"] {
            title = "\(objectTitle)"
        }
        
        if let objectDetail = json["details"] {
            detail = "\(objectDetail)"
        }
        
        if let objectSource = json["source"] as? [String:Any] {
            source = JSONAPIErrorSource(objectSource)
        }
        
        if let objectMeta = json["meta"] as? [String:Any] {
            meta = objectMeta
        }

    }
    
    open func toDict() -> [String:Any] {
        var dict: [String:Any] = [
            "id":id as Any,
            "links":links as Any,
            "status":status as Any,
            "code":code as Any,
            "title":title as Any,
            "detail":detail as Any,
        ]
        
        if let source = source {
            dict["source"] = source
        }
        
        if let meta = meta {
            dict["meta"] = meta as Any?
        }
        
        return dict
    }


}
