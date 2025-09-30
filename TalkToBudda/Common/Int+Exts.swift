//
//  Int+Exts.swift
//  TalkToBudda
//
//  Created by mac on 30/4/25.
//

import Foundation

extension Int {
    public func getDate() -> String {
        if self == 0 { return "" }
        let date = NSDate(timeIntervalSince1970: TimeInterval(self))
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "HH:mm a"
        dayTimePeriodFormatter.timeZone = .current
        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        return "\(dateString)"
    }

    public var scaleHeightWithLandScape: CGFloat {
        let dynamicTypeValue = CGFloat(self)
        let dynamicValue: CGFloat = Common.Screen.height * (dynamicTypeValue / 430)
        return dynamicValue >= dynamicTypeValue ? dynamicTypeValue : dynamicValue
    }

    public var scaleWidthWithLandScape: CGFloat {
        let dynamicTypeValue = CGFloat(self)
        let dynamicValue: CGFloat = Common.Screen.width * (dynamicTypeValue / 932)
        return dynamicValue >= dynamicTypeValue ? dynamicTypeValue : dynamicValue
    }

    public var scaleHeight: CGFloat {
        let dynamicTypeValue = CGFloat(self)
        let dynamicValue: CGFloat = Common.Screen.height * (dynamicTypeValue / 932)
        return dynamicValue >= dynamicTypeValue ? dynamicTypeValue : dynamicValue
    }

    public var scaleWidth: CGFloat {
        let dynamicTypeValue = CGFloat(self)
        let dynamicValue: CGFloat = Common.Screen.width * (dynamicTypeValue / 430)
        return dynamicValue >= dynamicTypeValue ? dynamicTypeValue : dynamicValue
    }

    public var ratioByHeight: CGFloat {
        let dynamicTypeValue = CGFloat(self)
        let dynamicValue: CGFloat = Common.Screen.height * dynamicTypeValue
        return dynamicValue
    }

    public func scaleHeight(range: CGFloat, min: CGFloat) -> CGFloat {
        let dynamicTypeValue = CGFloat(self)
        let dynamicValue: CGFloat = Common.Screen.height * (dynamicTypeValue / 932)
        return dynamicValue >= range ? dynamicValue : min
    }

    public func scaleHeight(max: CGFloat, min: CGFloat) -> CGFloat {
        let dynamicTypeValue = CGFloat(self)
        let dynamicValue: CGFloat = Common.Screen.height * (dynamicTypeValue / 932)
        return dynamicValue >= max ? max : dynamicValue > min ? dynamicValue : min
    }

    public func scaleHeight(min: CGFloat) -> CGFloat {
        let dynamicTypeValue = CGFloat(self)
        let dynamicValue: CGFloat = Common.Screen.height * (dynamicTypeValue / 932)
        return dynamicValue >= min ? dynamicValue : min
    }

    public func scaleWidth(min: CGFloat) -> CGFloat {
        let dynamicTypeValue = CGFloat(self)
        let dynamicValue: CGFloat = Common.Screen.width * (dynamicTypeValue / 430)
        return dynamicValue >= min ? dynamicValue : min
    }

    public func scaleWidth(max: CGFloat, min: CGFloat) -> CGFloat {
        let dynamicTypeValue = CGFloat(self)
        let dynamicValue: CGFloat = Common.Screen.width * (dynamicTypeValue / 430)
        return dynamicValue >= max ? max : dynamicValue > min ? dynamicValue : min
    }
}
