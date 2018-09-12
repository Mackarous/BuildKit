import Foundation

extension Date {
    var isToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
    
    var startOfMonth: Date? {
        return Calendar.current.dateInterval(of: .month, for: self)?.start
    }
    
    var endOfMonth: Date? {
        return Calendar.current.dateInterval(of: .month, for: self)?.end
    }
    
    var tomorrow: Date? {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)
    }
    
    var yesterday: Date? {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)
    }
}
