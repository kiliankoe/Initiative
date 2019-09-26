//
//  HostingController.swift
//  Initiative WatchKit Extension
//
//  Created by Kilian Koeltzsch on 26.09.19.
//  Copyright © 2019 Kilian Koeltzsch. All rights reserved.
//

import WatchKit
import Foundation
import SwiftUI

class HostingController: WKHostingController<RollView> {
    override var body: RollView {
        return RollView()
    }
}
