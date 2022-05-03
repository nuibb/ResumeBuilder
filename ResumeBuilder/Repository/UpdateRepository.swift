//
//  UpdateRepository.swift
//  ResumeBuilder
//
//  Created by ReliSource Technologies Ltd. on 5/3/22.
//

import Foundation

protocol DelegateForUpdatingRepository: AnyObject {
    func updateRepository<T>(object: T)
}
