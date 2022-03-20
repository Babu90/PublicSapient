//
//  DetailViewController.swift
//  LastFM
//
//  Created by Babu on 19/03/2021.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet private weak var detailImageView: UIImageView!
    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var artist: UILabel!
    @IBOutlet private weak var mbid: UILabel!
    @IBOutlet private weak var closeModalButton: UIButton!
    @IBOutlet private weak var lastFMDesc: UITextView!
    var currentItem: playItems?
    
    var searchVM : SearchViewModel?
    
    override func viewDidLoad() {
        updateDetailsUI()
    }
    
    private func updateDetailsUI()
    {
        if currentItem != nil
        {
            searchVM = SearchViewModel()
            self.detailImageView?.contentMode = .scaleToFill

            guard let imageUrl = URL(string: currentItem?.imageLarge() ?? Constants.CommonStrings.kEmptyString) else { return}
            searchVM?.fetchImage(imageUrl: imageUrl, completionHandler: { response in
                self.detailImageView?.image = UIImage(data: response ?? Data())
            })
            
            name?.text = currentItem?.name
            artist?.text = currentItem?.artist
            mbid?.text = "MBID: " + "\(currentItem?.mbid ?? Constants.CommonStrings.kNotApplicable)"
        }
    }
    
    @IBAction func closeModalAction()
    {
        self.dismiss(animated: true, completion: nil)
    }
    
}
