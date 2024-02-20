//
//  Coordinator.swift
//
//
//  Created by Laryssa Castagnoli on 20/02/24.
//

import UIKit

public protocol Coordinator: AnyObject {

    var childCoordinators: [Coordinator] { get set }
    func start()
}

extension Coordinator {

    public var presentingCoordinator: Coordinator? { childCoordinators.last }

    public func add(_ childCoordinator: Coordinator) {

        childCoordinators.append(childCoordinator)
    }

    public func remove(_ childCoordinator: Coordinator) {

        childCoordinators = childCoordinators.filter { $0 !== childCoordinator }
    }
}
