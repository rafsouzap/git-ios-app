//
//  NSObjectExtension.swift
//  GitHubApp
//
//  Created by Rafael de Paula on 30/12/19.
//  Copyright © 2019 Rafael de Paula. All rights reserved.
//

import Foundation

extension NSObject {
    static var identifier: String { return String(describing: self) }
}
