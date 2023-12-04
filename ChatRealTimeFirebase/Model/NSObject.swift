//
//  NSOject.swift
//  RealTimeChat
//
//  Created by VanTuan on 04/12/2023.
//

import Foundation

extension NSObject {
    static var id: String {
        return String(describing: self)
    }
}
