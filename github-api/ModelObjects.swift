//
//  ModelObjects.swift
//  github-api
//
//  Created by Kristoffer Anger on 2023-02-21.
//

import Foundation

/*
 response:
 "id": 174259074,
 "name": "city-bikes-app-ios",
 "owner": {
   "avatar_url": "https://avatars.githubusercontent.com/u/16223241?v=4",
   "url": "https://api.github.com/users/kristofferanger",
 }
 "html_url": "https://github.com/kristofferanger/city-bikes-app-ios",
 "description": "Showing bike stations in Malmö. Written in Objective-C",
 "url": "https://api.github.com/repos/kristofferanger/city-bikes-app-ios",
 "created_at": "2019-03-07T02:46:35Z",
 "language": "Objective-C",
 "visibility": "public",
 */

struct Repo: Codable, Identifiable {
    let id: Int
    let name: String
    let owner: Owner
    let htmlUrl: String
    let description: String
    let url: String
    let createdAt: Date
    let language: String
    let visibility: String
}

struct Owner: Codable {
    let avatarUrl: String
    let url: String
}
