//
//  MusicListCollection.swift
//  music_app
//
//  Created by Shaahid on 06/10/21.
//

import UIKit
import SDWebImage

class MusicListCollection: UITableViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
   // var songslist = [Song]()
    @IBOutlet weak var collectionView: UICollectionView!
    
    var mymusicArray = [mymusictopics]()

    var recommendedlistArray = [Homeplaylist]()
    
    var chord = [chord_sheet]()
    
    
    var screenSize: CGRect!
       var screenWidth: CGFloat!
       var screenHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getmymusicDatas()
       // configureSongs()
        collectionView.delegate = self
        collectionView.dataSource = self
//        screenSize = UIScreen.main.bounds
//               screenWidth = screenSize.width
//               screenHeight = screenSize.height
        
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return recommendedlistArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "musiccollectioncell", for: indexPath) as! MusicCollCell
        let song = recommendedlistArray[indexPath.row]
        cell.collsonglab.text = song.name
        let img1 = song.image
        let imgname = img1.setImageURL()
        cell.collImage.sd_setImage(with: URL(string:  imgname), placeholderImage: UIImage(named: "default_icon"))
        
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("item selected")
        let position = indexPath.row
        guard let vc = storyboard?.instantiateViewController(identifier: "player1") as? NewPlayerViewController else {
            return
        }
        vc.songs = recommendedlistArray
        vc.chordsong = chord
        vc.position = position
        vc.modalPresentationStyle = .fullScreen
       self.navigationController?.pushViewController(vc, animated: true)
        
    }
    func getmymusicDatas(){
      let user_id = UserDefaults.standard.object(forKey: "user_id") as? String
      let url:URL = URL(string: "https://godmusic.app/god_music/iOS/version19.0/mymusicdatas.php")!
      var request = URLRequest(url: url)
      request.httpMethod = "POST"
      request.httpBody = Data("user_id=\(user_id ?? "0")".utf8)
      let pinnedSession = URLSession(configuration: URLSessionConfiguration.ephemeral, delegate: URLSessionPinningDelegate(), delegateQueue: nil)
      pinnedSession.dataTask(with: request) { (data, response, error) in
          if error == nil,let data = data{
          do{
            let json = try JSONDecoder().decode(mymusic.self, from: data)
            self.mymusicArray = json.mymusictopics
            print("my musicarray\(self.mymusicArray)")
            self.recommendedlistArray = json.mymusictopics[0].homeplaylist
            print("The recomm list is \(self.recommendedlistArray)")
            self.chord = json.mymusictopics[0].homeplaylist[0].chord
            print("The chord is:\(self.chord)")
            DispatchQueue.main.async(execute: { () -> Void in
             // self.isLoaded = true
              self.tableView.reloadData()
                self.collectionView.reloadData()
             
            })
          }catch let jsonerr{
            print("error parsing",jsonerr)
          }
        }
      }.resume()
    }

}
struct mymusic: Codable {
    let mymusictopics: [mymusictopics]
 //   let tabdatas: [[Tabdatum]]
}

// MARK: - Mymusictopic
struct mymusictopics: Codable  {
    let name, circle: String
    let homeplaylist: [Homeplaylist]
}

// MARK: - Homeplaylist
struct Homeplaylist: Codable {
    let name, artist, image: String
    let music_url: String
    let minus_one_track: String
    let chord: [chord_sheet]
  //  let type: TypeEnum
//    let albumName, albumID, bgImage: String
//    let minusOneTrack: String
    
    enum CodingKeys: String, CodingKey {
           case name = "name"
           case artist = "artist"
           case image = "image"
           case music_url = "music_url"
           case minus_one_track = "minus_one_track"
           case chord = "chord_sheet"
          
       }
//    let chordSheet: [ChordSheet]
}


struct chord_sheet: Codable{
    
    let title: String
    let pdf_url: String
    
    enum CodingKeys: String, CodingKey {
           case title = "title"
           case pdf_url = "pdf_url"
    }
    
    
    
}
