//
//  BookList.swift
//  ToddlerBookTracker
//
//  Created by Charles Joseph on 2021-02-19.
//

import SwiftUI
import CoreData

struct BookList: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Book.lastRead, ascending: false)],
        animation: .default
    )
    private var books: FetchedResults<Book>

    var body: some View {
        List {
            ForEach(books) { book in
                HStack {
                    Image(systemName: "book.closed.fill")
                        .font(.largeTitle)
                        .frame(width: 80, height: 80, alignment: .center)
                    VStack(alignment: .leading) {
                        Text(book.title ?? "Untitled")
                            .font(.headline)
                        if let author = book.author {
                            Text("by \(author)")
                                .font(.callout)
                        }
                        if let lastRead = book.lastRead {
                            Text("Last read: \(lastRead, formatter: dateFormatter)")
                                .font(.caption)
                        }
                    }
                }
            }
        }
        .toolbar {
            ToolbarItemGroup {
                Button(action: addItem) {
                    Label("Add Book", systemImage: "plus.rectangle.portrait")
                }
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Book(context: viewContext)
            newItem.lastRead = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let dateFormatter: RelativeDateTimeFormatter = {
    let formatter = RelativeDateTimeFormatter()
    formatter.dateTimeStyle = .named    
    return formatter
}()

struct BookList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BookList()
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
