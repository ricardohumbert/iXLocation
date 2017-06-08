//
//  AddActivityDelegate.swift
//  iXLocation
//
//  Created by Ricky Humbert on 6/7/17.
//  Copyright © 2017 Ricky Humbert. All rights reserved.
//

import Foundation

protocol AddActivityDelegate {
    func didSaveActivity(activity: Activity)
    func didCancelActivity()
}
