//
//  AddBookView.swift
//  ToddlerBookTracker
//
//  Created by Charles Joseph on 2021-02-19.
//

import SwiftUI

struct AddBookView: View {
    @Binding var isPresented: Bool
    @Environment(\.managedObjectContext) private var viewContext

    @State var title: String = ""
    @State var author: String = ""

    var body: some View {
        Form {
            Section {
                TextField("Title", text: $title)
                TextField("Author(s)", text: $author)
            }
            Section {
                HStack {
                    Spacer()
                    Button(action: {
                        addBook()
                    }) {
                        Text("Add")
                    }
                    .disabled(formComplete == false)
                    Spacer()
                }
            }
        }
        .navigationTitle("Add a book")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            leading: Button(action: {
                isPresented = false
            }, label: {
                Image(systemName: "xmark.circle")
            })
        )
    }

    var formComplete: Bool {
        !title.isEmpty
    }

    func addBook() {
        withAnimation {
            let book = Book(context: viewContext)
            book.title = title
            if author.isEmpty == false {
                book.author = author
            }

            do {
                try viewContext.save()
            }
            catch {
                // TODO: error handling
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }

            isPresented = false
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddBookView(isPresented: Binding.constant(true))
        }
    }
}
