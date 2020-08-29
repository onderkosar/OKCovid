//
//  OKError.swift
//  OKCovid
//
//  Created by Önder Koşar on 22.08.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import Foundation

enum OKError: String, Error {
    case invalidURL             = "Please check your URL"
    case invalidResponse        = "Invalid response from the server. Please try again."
    case invalidData            = "The data received from the server was invalid. Please try again."
    case unableToComplete       = "Unable to complete your request. Please check your internet connection."
    case unableToGetDate = "The date could not be retrieved."
}
