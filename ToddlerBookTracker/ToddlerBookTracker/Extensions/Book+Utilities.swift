//
//  Book+Utilities.swift
//  ToddlerBookTracker
//
//  Created by Charles Joseph on 2021-02-20.
//

import CoreData

extension Book {
    func logReading(forDate date: Date = Date(), withContext context: NSManagedObjectContext) {
        let reading = Reading(context: context)
        reading.book = self
        reading.date = date

        if date > (lastRead ?? Date.distantPast) {
            lastRead = date
        }

        timesRead += 1

        do {
            try context.save()
        }
        catch {
            // TODO: error handling
        }
    }
}
