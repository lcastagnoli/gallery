//
//  TabItem.swift
//
//
//  Created by Laryssa Castagnoli on 20/02/24.
//

public class TabItem {

    let title: String?
    let icon: String
    let item: Presentable

    public init(title: String? = nil,
                icon: String,
                item: Presentable) {

        self.title = title
        self.icon = icon
        self.item = item
    }
}
