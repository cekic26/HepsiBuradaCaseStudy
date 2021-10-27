# HepsiBuradaCaseStudy
## The goal of the project
* Get categorized results with iTunes Search API.
## Search Bar

<img width="474" alt="Ekran Resmi 2021-10-27 13 31 24" src="https://user-images.githubusercontent.com/52139376/139053023-e8fb99cf-02f6-4056-9467-4404465777b7.png">

## URL Companent

`func fetchItems(term: String, media: String, lang: String, limit: Int) {let url = URL(string: "https://itunes.apple.com/search?term=\(term)&media=\(media)&lang=\(lang)&limit=\(limit)")`

## JSON
`struct StoreItem: Codable {
    let name: String
    let artist: String
    var kind: String
    var artworkURL: URL
    
    enum CodingKeys: String, CodingKey {
        case name = "trackName"
        case artist = "artistName"
        case kind
        case artworkURL = "artworkUrl100" }`

## View



https://user-images.githubusercontent.com/52139376/139055121-5a010fa4-52d7-4df4-b2b0-19acf7d6ef98.mov


        





