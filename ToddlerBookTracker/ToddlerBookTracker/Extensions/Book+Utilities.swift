//
//  Book+Utilities.swift
//  ToddlerBookTracker
//
//  Created by Charles Joseph on 2021-02-20.
//

import CoreData
import UIKit

extension Book {
    var coverImage: UIImage? {
        get {
            if let data = coverData {
                return UIImage(data: data)
            }
            else {
                return nil
            }
        }
        set {
            coverData = newValue?.jpegData(compressionQuality: 0.8)
        }
    }

    func logReading(forDate date: Date = Date(), withContext context: NSManagedObjectContext) {
        let reading = Reading(context: context)
        reading.book = self
        reading.date = date

        if date > (dateLastRead ?? Date.distantPast) {
            dateLastRead = date
            sortDate = date
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
