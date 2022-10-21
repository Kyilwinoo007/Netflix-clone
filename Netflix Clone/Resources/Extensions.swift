//
//  Extensions.swift
//  Netflix Clone
//
//  Created by boss1234 on 29/09/2022.
//

import Foundation

extension String{
    func capitalizeFirstLetter() -> String{
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
