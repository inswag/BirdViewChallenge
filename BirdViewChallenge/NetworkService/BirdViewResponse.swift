//
//  BirdViewResponse.swift
//  BirdViewChallenge
//
//  Created by 박인수 on 2020/01/22.
//  Copyright © 2020 inswag. All rights reserved.
//

import Foundation

struct BirdViewResponse<T: Decodable>: Decodable {
  let data: BirdViewResults<T>
}

struct BirdViewResults<T: Decodable>: Decodable {
  let results: T
}
