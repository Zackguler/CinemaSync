//
//  Environment.swift
//  CinemaSync
//
//  Created by Semih Güler on 30.07.2024.
//

var Current = Environment()

public class Environment {
    public var client: ServiceType
    
    // MARK: - Intialisers
    init() {
         let service = NetworkService()
         self.client = service
    }
}
