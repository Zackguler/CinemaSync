//
//  AnyCoordinator.swift
//  CinemaSync
//
//  Created by Semih Güler on 27.07.2024.
//

import UIKit

public enum CoordinatorCompletionReason {
    case cancelled
    case finished
}

public protocol AnyCoordinator: AnyObject {
    var rootViewController: UIViewController { get }
    
    var parent: AnyCoordinator? { get set }
    
    func start()
    
    func start(child: AnyCoordinator)
    
    func child(_ child: AnyCoordinator, didCompleteWithReason reason: CoordinatorCompletionReason)
}

public enum CoordinatorCompletionResult<Result> {
    case cancelled
    case finished(Result)
    
    public var asReason: CoordinatorCompletionReason {
        switch self {
        case .cancelled:
            return .cancelled
        case .finished:
            return .finished
        }
    }

    public var result: Result? {
        switch self {
        case .cancelled:
            return nil
        case .finished(let result):
            return result
        }
    }
}
