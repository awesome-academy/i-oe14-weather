//
//  StringExtensions.swift
//  Weather
//
//  Created by minh duc on 2/20/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

extension String {
    var ascii: String {
        return self.folding(options: .diacriticInsensitive, locale: .current)
    }
}
