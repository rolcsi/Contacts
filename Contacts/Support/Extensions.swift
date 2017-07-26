//
//  Extensions.swift
//  Contacts
//
//  Created by Roland Beke on 25.7.17.
//  Copyright © 2017 Roland Beke. All rights reserved.
//

import UIKit
import Sync

extension CDItem {

    static func swapItems(from dict: [[String: Any]], for userId: String, in dataStack: DataStack?) {
        
        dataStack?.performInNewBackgroundContext({ (context) in
            
            guard let fetch = try? context.fetch(userId, inEntityNamed: "CDUser"), let user = fetch as? CDUser else { return }
            
            user.removeFromItems(user.items!)
            
            for item in dict {
                
                guard let entity = NSEntityDescription.entity(forEntityName: "CDItem", in: context) else { return }
                
                let object = NSManagedObject(entity: entity, insertInto: context)
                object.setValue(item["name"], forKey: "name")
                object.setValue(item["count"], forKey: "count")
                object.setValue(user, forKey: "user")
            }
            
            try? context.save()
        })
    }
}

extension String {
    
    static func bindNilOrEmpty(_ text: Any?) -> String {
        
        switch text {
        case is String:
            
            guard let string = text as? String, !string.isEmpty else { return "-" }
            return string
        case is Int:
            
            guard let string = text as? Int else { return "-" }
            return String(string)
        default:
            
            return "-"
        }
    }
}

extension UIAlertController {
    
    static func simpleAlert(text: String, completion: (() -> Void)? = nil) -> UIAlertController {
        
        let alertController = UIAlertController(title: "Alert", message: text, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action) in
            
            if let completion = completion {
                completion()
            }
        }))
        
        return alertController
    }
}

extension UIImageView {
    
    func downloadImage(from url: Any?) {
        
        if let pictureUrl = url as? String {
            
            guard let url = URL(string: pictureUrl) else { return }
            
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                
                guard let imgData = data else { return }
                
                DispatchQueue.main.async {
                    self.image = UIImage(data: imgData)
                }
            }
        }
    }
}

@IBDesignable extension UIButton {
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}
