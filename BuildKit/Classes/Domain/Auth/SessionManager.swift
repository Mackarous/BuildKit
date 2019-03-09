//
//  SessionManager.swift
//  BuildKit
//
//  Created by Andrew Mackarous on 2019-01-10.
//

import Foundation

public protocol SessionManager {
    var currentSession: Session! { get }
    func authorizeSession(with network: Network, idToken: String, completion: @escaping (Result<Session>) -> Void)
}
