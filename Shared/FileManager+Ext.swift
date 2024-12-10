//
//  FileManager+Ext.swift
//  WidgetExamples
//
//  Created by Pawel Wiszenko on 15.10.2020.
//  Copyright © 2020 Pawel Wiszenko. All rights reserved.
//

import Foundation

extension FileManager {
    static let appGroupContainerURL: URL = {
        if let url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.zhoubo.WidgetExamples") {
            return url
        } else {
            // 如果 App Group 未配置成功，则使用临时路径作为默认值
            print("Warning: App Group URL is nil. Falling back to temporary directory.")
            return FileManager.default.temporaryDirectory
        }
    }()
}

extension FileManager {
    static let luckyNumberFilename = "LuckyNumber.txt"
}
