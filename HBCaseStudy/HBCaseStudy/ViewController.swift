//
//  ViewController.swift
//  HBCaseStudy
//
//  Created by Saide Cekic on 27.10.2021.
//

import UIKit

class StoreItemListTableViewController: UITableViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var filterSegmentedControl: UISegmentedControl!
    
    var items = [StoreItem]()
    
    let queryOptions = ["movie", "music", "software", "ebook"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func fetchItems(term: String, media: String, lang: String, limit: Int) {
        
        let url = URL(string: "https://itunes.apple.com/search?term=\(term)&media=\(media)&lang=\(lang)&limit=\(limit)")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if let _ = error {
                
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let searchResponse = try decoder.decode(SearchResponse.self, from: data)
                    self.items = searchResponse.results
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    
    func fetchMatchingItems() {
        
        self.items = []
        self.tableView.reloadData()
        
        let searchTerm = searchBar.text ?? ""
        let mediaType = queryOptions[filterSegmentedControl.selectedSegmentIndex]
        
        if !searchTerm.isEmpty {
            
            // use the item controller to fetch items
            
            fetchItems(term: searchTerm, media: mediaType, lang: "en_us", limit: 20)
        }
    }
    
    func configure(cell: ItemCell, forItemAt indexPath: IndexPath) {
    
        let item = items[indexPath.row]
        
        // set cell.titleLabel to the item's name
        cell.titleLabel.text = item.name
        
        // set cell.detailLabel to the item's artist
        cell.detailLabel.text = item.artist
        
        // set cell.itemImageView to the system image "photo"
        cell.itemImageView?.image = UIImage(systemName: "photo")//?.applyingSymbolConfiguration(.init(scale: .large))
        
        // initialize a network task to fetch the item's artwork
        
        let task = URLSession.shared.dataTask(with: item.artworkURL) { (data, response, error) in
            if let data = data,
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    cell.itemImageView.image = image
                }
            }
        }
        task.resume()
        
        
    }
    
    @IBAction func filterOptionUpdated(_ sender: UISegmentedControl) {
        
        fetchMatchingItems()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath) as! ItemCell
        configure(cell: cell, forItemAt: indexPath)
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension StoreItemListTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        fetchMatchingItems()
        searchBar.resignFirstResponder()
        
        
    }
}

