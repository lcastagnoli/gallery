//
//  HomeViewModel.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 15/02/24.
//

import Combine
import Network
import Foundation

protocol HomeViewModelProtocol {

    var tabs: [TabItemType] { get }
}

final class HomeViewModel {}

// MARK: - HomeViewModelProtocol
extension HomeViewModel: HomeViewModelProtocol {

    var tabs: [TabItemType] { [.list, .favorites] }
}
