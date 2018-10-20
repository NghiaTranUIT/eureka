//
//  Result.swift
//  Assignment
//
//  Created by Nghia Tran on 10/20/18.
//  Copyright © 2018 com.nsproxy.proxy. All rights reserved.
//

import Foundation

enum Result<T> {

    case success(T)
    case error(Error)

    var isError: Bool {
        switch self {
        case .error:
            return true
        default:
            return false
        }
    }

    var isSuccess: Bool {
        switch self {
        case .success:
            return true
        default:
            return false
        }
    }

    var error: Error {
        switch self {
        case .error(let error):
            return error
        default:
            fatalError()
        }
    }

    var value: T {
        switch self {
        case .success(let value):
            return value
        default:
            fatalError()
        }
    }
}
