import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: Practice1.entity(),
        sortDescriptors: []
    ) var items: FetchedResults<Practice1>

    @State private var name: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""
    @State private var age: String = ""
    @State private var selectedEntry: Practice1? // Track the selected entry for editing

    var body: some View {
        VStack {
            Button(selectedEntry == nil ? "Add Entry" : "Update Entry") {
                if selectedEntry == nil {
                    addEntry()
                } else {
                    updateEntry()
                }
            }
            .padding()
            .buttonStyle(.borderedProminent)

            TextField("Enter Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .padding(.bottom, 8) // Reduced spacing

            TextField("Enter Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .padding(.bottom, 8) // Reduced spacing

            TextField("Enter Phone", text: $phone)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .padding(.bottom, 8) // Reduced spacing

            TextField("Enter Age", text: $age)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            List {
                ForEach(items, id: \.self) { item in
                    VStack(alignment: .leading) {
                        Text("Name: \(item.name ?? "Unknown")")
                        Text("Email: \(item.email ?? "Unknown")")
                        Text("Phone: \(item.phone ?? "Unknown")")
                        Text("Age: \(item.age)")
                    }
                    .onTapGesture {
                        editEntry(item)
                    }
                }
                .onDelete(perform: deleteEntry)
            }
        }
        .padding()
    }

    private func addEntry() {
        guard !name.isEmpty, !email.isEmpty, !phone.isEmpty, let ageInt = Int64(age) else { return }

        let newEntry = Practice1(context: viewContext)
        newEntry.name = name
        newEntry.email = email
        newEntry.phone = phone
        newEntry.age = ageInt

        do {
            try viewContext.save()
            clearFields()
        } catch {
            print("Error saving entry: \(error.localizedDescription)")
        }
    }

    private func editEntry(_ item: Practice1) {
        selectedEntry = item
        name = item.name ?? ""
        email = item.email ?? ""
        phone = item.phone ?? ""
        age = String(item.age)
    }

    private func updateEntry() {
        guard let entry = selectedEntry, !name.isEmpty, !email.isEmpty, !phone.isEmpty, let ageInt = Int64(age) else { return }

        entry.name = name
        entry.email = email
        entry.phone = phone
        entry.age = ageInt

        do {
            try viewContext.save()
            clearFields()
        } catch {
            print("Error updating entry: \(error.localizedDescription)")
        }
    }

    private func deleteEntry(at offsets: IndexSet) {
        for index in offsets {
            let entry = items[index]
            viewContext.delete(entry)
        }

        do {
            try viewContext.save()
        } catch {
            print("Error deleting entry: \(error.localizedDescription)")
        }
    }

    private func clearFields() {
        name = ""
        email = ""
        phone = ""
        age = ""
        selectedEntry = nil
    }
}

#Preview {
    ContentView()
}
