//
//  Database.swift
//  COMP3097_ShoppingList_Group2
//
//  Created by Stefan Kepinski on 2024-03-24.
//

import Foundation
import SQLite

class Database{
    private var db: Connection?

    private let usersTable = Table("users")
    private let id = Expression<Int64>("id")
    private let firstName = Expression<String>("firstName")
    private let lastName = Expression<String>("lastName")
    private let email = Expression<String>("email")
    private let password = Expression<String>("password")

    init() {
        do {
            let path = NSSearchPathForDirectoriesInDomains(
                .documentDirectory, .userDomainMask, true
            ).first!
            db = try Connection("\(path)/db.sqlite3")

            createTable()
        } catch {
            print("Unable to initialize database: \(error)")
        }
    }

    private func createTable() {
        let createTable = usersTable.create { table in
            table.column(id, primaryKey: .autoincrement)
            table.column(firstName)
            table.column(lastName)
            table.column(email, unique: true)
            table.column(password)
        }

        do {
            try db?.run(createTable)
            print("Created table")
        } catch {
            print("Unable to create table: \(error)")
        }
    }

    func addUser(firstName: String, lastName: String, email: String, password: String) -> Bool {
        let insert = usersTable.insert(self.firstName <- firstName, self.lastName <- lastName, self.email <- email, self.password <- password)

        do {
            let rowId = try db?.run(insert)
            print("Inserted user with ID: \(rowId ?? -1)")
            return true
        } catch {
            print("Insert failed: \(error)")
            return false
        }
    }
    
    func userExists(email: String, password: String) -> Bool {
        let query = usersTable.filter(self.email == email && self.password == password)
        do {
            let user = try db?.pluck(query)
            return user != nil
        } catch {
            print("Query failed: \(error)")
            return false
        }
    }
    
    func getUser(email: String, password: String) -> (id: Int64, firstName: String)? {
        let query = usersTable.filter(self.email == email && self.password == password)
        do {
            if let user = try db?.pluck(query) {
                let userId = user[id]
                let userFirstName = user[firstName]
                return (userId, userFirstName)
            }
        } catch {
            print("Login query failed: \(error)")
        }
        return nil
    }

}

