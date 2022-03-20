//
//  SearchViewModel.swift
//  LastFM
//
//  Created by Babu on 19/03/2021.
//

import Foundation

class SearchViewModel {

    var selectedScope = 0
    
    private let networkManager: NetworkManager!
    
    public init (){
        //takes default session as we are not passing anything
        networkManager  = NetworkManager()
    }
    
    func updateScopeId(scope:String)
    {
        switch scope {
        case "Artist":
            selectedScope = 0
        case "Album":
            selectedScope = 1
        case "Track":
            selectedScope = 2
        default:
            selectedScope = 0
        }
    }
}

//URL Related
extension SearchViewModel {
    
    func fetchImage(imageUrl : URL, completionHandler: @escaping (_ reponseItems:Data?)->())
    {
        self.networkManager.fetchData(url: imageUrl, completionHandler: {data in
            completionHandler(data)
        })
    }
    
    func computeCurrentScope(parseUrl: String, completionHandler: @escaping (_ reponseItems:[playItems])->())
    {
        guard let url = URL(string: parseUrl) else {
            print(Constants.Errors.kAPIUrlError)
            return;
        }
        
        self.networkManager.fetchData(url: url, completionHandler: {data in
            completionHandler(self.parseResponse(data: data))
        })
    }
    
    func parseResponse(data:Data) -> [playItems]
    {
        var playItemArr = [playItems]()
        do{

            switch selectedScope {
            case 0:
                let model = try JSONDecoder().decode(ArtistModel.self, from: data )
                let artistArr = model.results.artistmatches.artist
                for artist in artistArr
                {
                    playItemArr.append(playItems(artistInfo: artist))
                }
            case 1:
                let model = try JSONDecoder().decode(AlbumModel.self, from: data )
                let albumArr = model.results.albummatches.album
                for album in albumArr
                {
                    playItemArr.append(playItems(albumInfo: album))
                }
            case 2:
                let model = try JSONDecoder().decode(TrackModel.self, from: data )
                let trackArr = model.results.trackmatches.track
                for track in trackArr
                {
                    playItemArr.append(playItems(trackInfo: track))
                }
            default:
                print(Constants.CommonStrings.kDefault)
            }
        }
        catch{
        }
        return playItemArr
    }
    
    func parseUrl(searchKey: String) -> String
    {
        var urlToCall = Constants.CommonStrings.kEmptyString
        switch selectedScope {
        case 0:
            urlToCall = Constants.APIUrls.artistURL
        case 1:
            urlToCall = Constants.APIUrls.albumURL
        case 2:
            urlToCall = Constants.APIUrls.trackURL
        default:
            urlToCall = Constants.APIUrls.artistURL
        }
        urlToCall = urlToCall.replacingOccurrences(of: "<SEARCHKEY>", with: searchKey)
        urlToCall = urlToCall.replacingOccurrences(of: "<API_KEY>", with: Constants.APIKeys.kSearchAPIKey)
        return urlToCall
    }
}
