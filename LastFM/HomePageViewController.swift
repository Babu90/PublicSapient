//
//  HomePageViewController.swift
//  LastFM
//
//  Created by Babu on 19/03/2021.
//

import UIKit

class HomePageViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet private weak var searchBar : UISearchBar!
    @IBOutlet private weak var tableView : UITableView!
    var searchVM : SearchViewModel?
    let scopeBarItems = [Constants.CommonStrings.kArtist, Constants.CommonStrings.kAlbum, Constants.CommonStrings.kTrack]
    var playItem = [playItems]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        // Do any additional setup after loading the view.
    }
    
    func setUpView()
    {
        searchVM = SearchViewModel()
        searchBar.scopeButtonTitles = scopeBarItems
        searchBar.showsScopeBar = true
        searchBar.delegate = self
        searchBar.selectedScopeButtonIndex = 1
        searchVM?.updateScopeId(scope: scopeBarItems[1])
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        searchVM?.updateScopeId(scope: scopeBarItems[selectedScope])
        view.endEditing(true)
        initiateSearch()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        initiateSearch()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        
        if self.playItem.count < 1 {
            // Empty list. So just prompt the user and return it
            self.playItem = []
            let alert = UIAlertController(title:Constants.CommonStrings.kErrorAlertTitle, message:Constants.CommonStrings.kErrorAlertMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: Constants.CommonStrings.kErrorAlertOKButtonTitle, style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    func initiateSearch()
    {
        let parsedUrl = searchVM?.parseUrl(searchKey: searchBar.text ?? Constants.CommonStrings.kEmptyString) ?? Constants.CommonStrings.kEmptyString
        searchVM?.computeCurrentScope(parseUrl: parsedUrl, completionHandler: { response in
            self.playItem = response.filter{($0.name.hasPrefix(self.searchBar.text ?? Constants.CommonStrings.kEmptyString))}
                self.tableView.reloadData()
            })
        }
}

// MARK: - UITableViewDataSource methods
extension HomePageViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.kCellIdentifier, for: indexPath) as? PlayItemCell
        cell?.title.text = playItem[indexPath.row].name
        guard let imageUrl = URL(string: playItem[indexPath.row].imageMedium()) else { return cell!}

        //Fetch the image to display in cell
        searchVM?.fetchImage(imageUrl: imageUrl, completionHandler:{ response in
            cell?.imgView.image = UIImage(data: response ?? Data())
        })
            
        return cell!
    }
}

// MARK: - UITableViewDelegate methods
extension HomePageViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = playItem[indexPath.row]
        let storyboard = UIStoryboard(name: Constants.Segues.kMainStoryboard, bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: Constants.Segues.kDetailViewControllerrSegue) as? DetailViewController
        {
            controller.currentItem = selectedItem
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension HomePageViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

