//
//  UnsplashScope.swift
//  Youth
//
//  Created by Cristian Lupu on 4/22/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Foundation

/**
 To write data on behalf of a user or to access their private data, you must request additional permission scopes from them.
 
 Used for Unsplash API.
 */
enum UnsplashPermissionScope: String {
    /// Public
    case `public` = "public"
    
    /// Read User
    case readUser = "read_user"
    
    /// Write User
    case writeUser = "write_user"
    
    /// Read Photos
    case readPhotos = "read_photos"
    
    /// Write Photos
    case writePhotos = "write_photos"
    
    /// Write Likes
    case writeLikes = "write_likes"
    
    /// Write followers
    case writeFollowers = "write_followers"
    
    /// Read collections
    case readCollections = "read_collections"
    
    /// Write collections
    case writeCollections = "write_collections"
}
