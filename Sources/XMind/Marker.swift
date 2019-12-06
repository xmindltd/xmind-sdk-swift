//
//  Marker.swift
//  XMindSDK
//
//  Created by h on 2019/11/13.
//
//  Copyright © 2019 XMind.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation

public struct Marker: Codable {
    let markerId: String
}

extension Marker {
    public struct Priority {
        public static let p1 = Marker(markerId: "priority-1")
        public static let p2 = Marker(markerId: "priority-2")
        public static let p3 = Marker(markerId: "priority-3")
        public static let p4 = Marker(markerId: "priority-4")
        public static let p5 = Marker(markerId: "priority-5")
        public static let p6 = Marker(markerId: "priority-6")
        public static let p7 = Marker(markerId: "priority-7")
    }
    
    public struct Smiley {
        public static let laugh = Marker(markerId: "smiley-laugh")
        public static let smile = Marker(markerId: "smiley-smile")
        public static let cry = Marker(markerId: "smiley-cry")
        public static let surprise = Marker(markerId: "smiley-surprise")
        public static let boring = Marker(markerId: "smiley-boring")
        public static let angry = Marker(markerId: "smiley-angry")
        public static let embarrass = Marker(markerId: "smiley-embarrass")
    }
    
    public struct Task {
        public static let start = Marker(markerId: "task-start")
        public static let oct = Marker(markerId: "task-oct")
        public static let quarter = Marker(markerId: "task-quarter")
        public static let half = Marker(markerId: "task-half")
        public static let done = Marker(markerId: "task-done")
        public static let pause = Marker(markerId: "task-pause")
    }
    
    public struct Flag {
        public static let red = Marker(markerId: "flag-red")
        public static let orange = Marker(markerId: "flag-orange")
        public static let darkBlue = Marker(markerId: "flag-dark-blue")
        public static let purple = Marker(markerId: "flag-purple")
        public static let green = Marker(markerId: "flag-green")
        public static let blue = Marker(markerId: "flag-blue")
        public static let gray = Marker(markerId: "flag-gray")
    }
    
    public struct Star {
        public static let red = Marker(markerId: "star-red")
        public static let orange = Marker(markerId: "star-orange")
        public static let darkBlue = Marker(markerId: "star-dark-blue")
        public static let purple = Marker(markerId: "star-purple")
        public static let green = Marker(markerId: "star-green")
        public static let blue = Marker(markerId: "star-blue")
        public static let gray = Marker(markerId: "star-gray")
    }
    
    public struct People {
        public static let red = Marker(markerId: "people-red")
        public static let orange = Marker(markerId: "people-orange")
        public static let darkBlue = Marker(markerId: "people-dark-blue")
        public static let purple = Marker(markerId: "people-purple")
        public static let green = Marker(markerId: "people-green")
        public static let blue = Marker(markerId: "people-blue")
        public static let gray = Marker(markerId: "people-gray")
    }
    
    public struct Arrow {
        public static let left = Marker(markerId: "arrow-left")
        public static let right = Marker(markerId: "arrow-right")
        public static let up = Marker(markerId: "arrow-up")
        public static let down = Marker(markerId: "arrow-down")
        public static let leftRight = Marker(markerId: "arrow-left-right")
        public static let upDown = Marker(markerId: "arrow-up-down")
        public static let refresh = Marker(markerId: "arrow-refresh")
    }
    
    public struct Month {
        public static let jan = Marker(markerId: "month-jan")
        public static let feb = Marker(markerId: "month-feb")
        public static let mar = Marker(markerId: "month-mar")
        public static let apr = Marker(markerId: "month-apr")
        public static let may = Marker(markerId: "month-may")
        public static let jun = Marker(markerId: "month-jun")
        public static let jul = Marker(markerId: "month-jul")
        public static let aug = Marker(markerId: "month-aug")
        public static let sep = Marker(markerId: "month-sep")
        public static let oct = Marker(markerId: "month-oct")
        public static let nov = Marker(markerId: "month-nov")
        public static let dec = Marker(markerId: "month-dec")
    }
    
    public struct Week {
        public static let sun = Marker(markerId: "week-sun")
        public static let mon = Marker(markerId: "week-mon")
        public static let tue = Marker(markerId: "week-tue")
        public static let wed = Marker(markerId: "week-wed")
        public static let thu = Marker(markerId: "week-thu")
        public static let fri = Marker(markerId: "week-fri")
        public static let sat = Marker(markerId: "week-sat")
    }
}

extension Marker: Equatable {
    public static func == (lhs: Marker, rhs: Marker) -> Bool {
        return lhs.markerId == rhs.markerId
    }
}

extension Marker {
    func isSameGroup(with marker: Marker) -> Bool {
        return marker.markerId.split(separator: "-").first == self.markerId.split(separator: "-").first
    }
}
