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
    @State var cover: UIImage?

    @State var pickingImage = false

    var body: some View {
        Form {
            Section {
                HStack {
                    Spacer()
                    VStack(spacing: 8) {
                        Button(action: {
                            pickingImage = true
                        }) {
                            SelectedCover(cover: cover)
                                .padding(2)
                        }
                        Text("Cover Image")
                            .foregroundColor(Color(UIColor.placeholderText))
                    }
                    Spacer()
                }
                .padding()
            }
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
        .sheet(isPresented: $pickingImage) {
            ImagePicker(image: $cover, isPresented: $pickingImage)
        }
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
            book.coverImage = cover

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

// MARK: -

struct SelectedCover: View {
    var cover: UIImage?

    var body: some View {
        if let cover = cover {
            Image(uiImage: cover)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: 120, alignment: .center)
                .shadow(radius: 3)
        }
        else {
            Image(systemName: "photo.on.rectangle.angled")
                .font(.title2)
        }
    }
}
