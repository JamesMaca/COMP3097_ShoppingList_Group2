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
    
    // USER TABLE
    private let usersTable = Table("users")
    private let id = Expression<Int64>("id")
    private let firstName = Expression<String>("firstName")
    private let lastName = Expression<String>("lastName")
    private let email = Expression<String>("email")
    private let password = Expression<String>("password")
    
    //LIST TABLE
    private let listTable = Table("lists")
    private let listID = Expression<Int64>("listID")
    private let uID = Expression<Int64>("uID")
    private let listName = Expression<String>("listName")
    
    //PRODUCT OR ITEM TABLE
    private let productTable = Table("products")
    private let productID = Expression<Int64>("productID")
    private let productName = Expression<String>("productName")
    private let productCategory = Expression<String>("productCategory")
    private let productPrice = Expression<Double>("productPrice")
    
    
    
    init() {
        do {
            let path = NSSearchPathForDirectoriesInDomains(
                .documentDirectory, .userDomainMask, true
            ).first!
            db = try Connection("\(path)/db.sqlite3")

            createTables()
        } catch {
            print("Unable to initialize database: \(error)")
        }
    }
    
    private func createTables(){
        createUserTable()
        createListTable()
    }

    private func createUserTable() {
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
    
    
//    LIST TABLE STUFF *************************************************************
    private func createListTable(){
        let createTable = listTable.create { table in
            table.column(listID, primaryKey: .autoincrement)
            table.column(listName)
            table.column(uID)
            table.foreignKey(uID, references: usersTable, id, delete: .cascade)
        }
        
        do{
            try db?.run(createTable)
            print("Created list table!")
        }catch {
            print("Unable to create a list table: \(error)")
        }
    }
    
    func addList(userID: Int64, listName: String) -> Bool {
        do{
            let insert = listTable.insert(uID <- userID, self.listName <- listName)
            
            try db?.run(insert)
            print("List added successfully")
            return true
        } catch {
            print("Error adding list: \(error)")
            return false
        }
    }
    
    func getLists(forUserID userID: Int64) -> [String]? {
        var listNames = [String]()
        
        do {
            let query = listTable.filter(uID == userID).select(listName)
            for list in try db!.prepare(query) {
                listNames.append(list[listName])
            }
            return listNames // Return the list names
        } catch {
            print("Failed to get lists: \(error)")
            return nil
        }
    }
    
    
    //    PRODUCT/ITEM LIST TABLE STUFF *************************************************************
    private func createProductTable() {
        let createTable = productTable.create { table in
            table.column(productID, primaryKey: .autoincrement)
            table.column(listID)
            table.column(productName)
            table.column(productCategory)
            table.column(productPrice)
            table.foreignKey(listID, references: listTable, listID, delete: .cascade)
        }
        
        do {
            try db?.run(createTable)
            print("Created product table!")
        } catch {
            print("Unable to create product table: \(error)")
        }
    }

    func addProductToList(listID: Int64, productName: String, productCategory: String, productPrice: Double) -> Bool {
        do {
            let insert = productTable.insert(self.listID <- listID, self.productName <- productName, self.productCategory <- productCategory, self.productPrice <- productPrice)
            try db?.run(insert)
            print("Product added successfully")
            return true
        } catch {
            print("Error adding product: \(error)")
            return false
        }
    }

    // Method to retrieve products for a specific list
    func getProductsForList(listID: Int64) -> [Product]? {
        var products = [Product]()
        
        do {
            let query = productTable.filter(self.listID == listID)
            for productRow in try db!.prepare(query) {
                let product = Product(id: productRow[productID], name: productRow[productName], category: productRow[productCategory], price: productRow[productPrice])
                products.append(product)
            }
            return products
        } catch {
            print("Failed to get products for list: \(error)")
            return nil
        }
    }


}

