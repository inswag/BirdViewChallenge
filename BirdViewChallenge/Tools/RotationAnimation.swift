//
//  RotationAnimation.swift
//  BirdViewChallenge
//
//  Created by Insu Park on 2020/01/27.
//  Copyright © 2020 inswag. All rights reserved.
//

import UIKit

struct RotationAnimation {
    
    let rotationAnimation: CABasicAnimation = {
        let ca = CABasicAnimation(keyPath: "transform.rotation.z")
        ca.toValue = NSNumber(value: .pi * 2.0)
        ca.duration = 0.5
        ca.isCumulative = true
        ca.repeatCount = .infinity
        return ca
    }()
    
}
