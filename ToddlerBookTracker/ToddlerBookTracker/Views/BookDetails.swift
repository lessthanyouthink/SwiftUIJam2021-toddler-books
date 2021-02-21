//
//  BookDetails.swift
//  ToddlerBookTracker
//
//  Created by Charles Joseph on 2021-02-21.
//

import SwiftUI
import CoreData

struct BookDetails: View {
    @ObservedObject var book: Book

    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        ScrollView {
            HStack(spacing: 16) {
                BookCover(cover: book.coverImage)
                    .frame(maxWidth: 160, maxHeight: 160)
                VStack(spacing: 4) {
                    Text(book.title!)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                    if let author = book.author {
                        Text("By \(author)")
                            .font(.subheadline)
                    }
                    Button(action: {
                        withAnimation {
                            book.logReading()
                        }
                    }, label: {
                        HStack {
                            Text(displayableTimesRead)
                                .font(Font.system(.subheadline).monospacedDigit())
                                .fontWeight(.semibold)
                            Image(systemName: "text.badge.checkmark")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                        .padding(12)
                    })
                    .frame(maxHeight: 50, alignment: .center)
                    .buttonStyle(CapsuleButtonStyle())
                    .padding(.top, 6)
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding()
        }
    }

    var displayableTimesRead: String {
        switch book.timesRead {
        case 0:
            return "Unread"
        case 1:
            return "Read once"
        default:
            return "Read \(book.timesRead) times"
        }
    }
}

struct BookDetails_Previews: PreviewProvider {
    static let book: Book? = {
        let request = NSFetchRequest<Book>(entityName: "Book")
        let books = try? PersistenceController.preview.container.viewContext.fetch(request)
        return books?.first
    }()
    static var previews: some View {
        BookDetails(book: book!)
    }
}
