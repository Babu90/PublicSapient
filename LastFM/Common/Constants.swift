//
//  Constants.swift
//  LastFM
//
//  Created by Babu on 19/03/2021.
//

import Foundation

struct Constants{
    
    //API Urls
    struct APIUrls {
      static let albumURL = "http://ws.audioscrobbler.com/2.0/?method=album.search&album=<SEARCHKEY>&api_key=<API_KEY>&format=json"
      static let artistURL = "http://ws.audioscrobbler.com/2.0/?method=artist.search&artist=<SEARCHKEY>&api_key=<API_KEY>&format=json"
      static let trackURL = "http://ws.audioscrobbler.com/2.0/?method=track.search&track=<SEARCHKEY>&api_key=<API_KEY>&format=json"
    }
    
    //Segues
    struct Segues{
        static let kMainStoryboard = "Main"
        static let kDetailViewControllerrSegue = "detailVC"
    }
    
    //Cell identifiers
    struct CellIdentifiers {
        static let kCellIdentifier = "playItemCell"
    }
    
    //API Keys
    struct APIKeys{
        static let kSearchAPIKey = "8f15761ad4472689164c67202aaf3763"
    }
    
    //Error Strings
    struct Errors{
        static let kAPIUrlError = "Error fetching URL"
    }
    
    //Common Strings
    struct CommonStrings{
        static let kEmptyString = ""
        static let kErrorAlertTitle = "Something Wrong!!"
        static let kErrorAlertMessage = "Please try again with some other query"
        static let kErrorAlertOKButtonTitle = "OK"
        static let kBackgroundColor = "#404372"
        static let kDefault = "Default.Do nothing"
        static let kArtist = "Artist"
        static let kAlbum = "Album"
        static let kTrack = "Track"
        static let kNotApplicable = "NA"
    }
    
}
