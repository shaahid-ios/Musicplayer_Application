
import AVFoundation
import UIKit
var isMix = false

class PlayerViewController: UIViewController  {

    public var position: Int = 0
    var player:AVPlayer?
    var playerItem:AVPlayerItem?
    fileprivate let seekDuration: Float64 = 10
    //var player: AVAudioPlayer?
    
    public var songs: [Homeplaylist] = []
    @IBOutlet var songNameLabel: UILabel!
    @IBOutlet var artistNameLabel: UILabel!
    @IBOutlet var albumNameLabel: UILabel!
    @IBOutlet weak var artistImage: UIImageView!
    @IBOutlet var playButton: UIButton!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var totalTime: UILabel!
    @IBOutlet var slide: UISlider!
   
   
  //  let playPauseButton = UIButton()
    
    @objc func _slider () {
//        if ((player?.rate != 0) && (player?.error == nil)){
//            //player?.stop()
//            //player?.currentTime =  TimeInterval(slide.value)
//            player?.replaceCurrentItem(with: nil)
//           player?.play()
//         //   playButton.setImage(UIImage(named: "play"), for: .normal)
//        }else{
//        //    player?.currentTime = TimeInterval(slide.value)
//
//        }
////        let seconds : Int64 = Int64(slide.value)
////               let targetTime:CMTime = CMTimeMake(value: seconds, timescale: 1)
////
////               player!.seek(to: targetTime)
////
////               if player!.rate == 0
////               {
////                   player?.play()
////               }
        let seconds : Int64 = Int64(slide.value)
        let targetTime:CMTime = CMTimeMake(value: seconds, timescale: 1)
        player!.seek(to: targetTime)
        if player!.rate == 0 {
        player?.play()
         }

    }
    
//    func audioPlayerDidFinishPlaying(_ player: AVPlayer!, successfully flag: Bool) {
//        print("finished audio")
//
//           playButton.setImage(UIImage(named: "play"), for: .normal)
//           if position <= (songs.count) {
//           position = position + 1
//           player.replaceCurrentItem(with: nil)
//           configure()
//     }
//    }
//
//
    @IBOutlet var mixed: UIButton!
  
    
    @objc func _mix ()
      {
       if isMix{
           isMix = false
        mixed.setImage(UIImage(named: "shuffle.png"), for: .normal)
        let alert = UIAlertController(title: "", message: "Shuffle is OFF", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when){
        alert.dismiss(animated: true, completion: nil)
        }
       }
       else{
           isMix = true
        mixed.setImage(UIImage(named: "shuffle_s.png"), for: .normal)
        let alert = UIAlertController(title: "", message: "Shuffle is ON", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when){
          alert.dismiss(animated: true, completion: nil)
        }}
       }
    
    @objc func _back ()
       {
//           if isMix {
//               if rondomInt < songList.count - 1 {
//                   rondomInt -= 1
//                   if rondomInt < 0  {
//                       rondomInt = 0
//                       return
//                   }
//                   activeSong = rondomInt
//                   playThisSong(activeSong: songList[rondomInt])
//                   time.text = ""
//                   totalTime.text = ""
//                   updateTime()
//                   getArtistInfo()
//                   audioPlayer.play()
//                   playBtn.setImage(UIImage(named: "pause"), for: .normal)
//               }
//               else{
//                   rondomInt = 0
//                   activeSong = 0
//                   playThisSong(activeSong: songList[activeSong])
//                   time.text = ""
//                   totalTime.text = ""
//                    updateTime()
//                    getArtistInfo()
//                     audioPlayer.play()
//                   playBtn.setImage(UIImage(named: "pause"), for: .normal)
//               }
//           }else{
//
//               if activeSong < songList.count - 1 {
//                   activeSong -= 1
//                   if activeSong < 0 {
//                       activeSong = 0
//                       return
//                   }
//                   playThisSong(activeSong: songList[activeSong])
//                   time.text = ""
//                    totalTime.text = ""
//                  updateTime()
//                  getArtistInfo()
//                  audioPlayer.play()
//                   playBtn.setImage(UIImage(named: "pause"), for: .normal)
//               }
//               else {
//                   activeSong = 0
//                   playThisSong(activeSong: songList[activeSong])
//                   time.text = ""
//                   totalTime.text = ""
//                    updateTime()
//                   getArtistInfo()
//                  audioPlayer.play()
//                 playBtn.setImage(UIImage(named: "pause"), for: .normal)
//               }
//
//          }
//
       }
       @objc func _next ()
       {
//           if isMix {
//               if rondomInt < songList.count - 1 {
//                   rondomInt += 1
//                   activeSong = rondomInt
//                      playThisSong(activeSong: songList[activeSong])
//                               time.text = ""
//                               totalTime.text = ""
//                                updateTime()
//                               getArtistInfo()
//                              audioPlayer.play()
//                             playBtn.setImage(UIImage(named: "pause"), for: .normal)
//
//               }else{
//                   rondomInt = 0
//                   activeSong = 0
//                   playThisSong(activeSong: songList[activeSong])
//                                   time.text = ""
//                                   totalTime.text = ""
//                                    updateTime()
//                                   getArtistInfo()
//                                  audioPlayer.play()
//                                 playBtn.setImage(UIImage(named: "pause"), for: .normal)
//               }
//
//           }else{
//               if activeSong < songList.count - 1 {
//                   activeSong += 1
        
//                   if activeSong > songList.count {
//                       activeSong = 0
//                       return
//                   }
//                   playThisSong(activeSong: songList[activeSong])
//                    time.text = ""
//                   totalTime.text = ""
//                    updateTime()
//                    getArtistInfo()
//                   getCoverImage()
//                     audioPlayer.play()
//                 playBtn.setImage(UIImage(named: "pause"), for: .normal)
//               }else{
//                   activeSong = 0
//                   playThisSong(activeSong: songList[activeSong])
//                                                             time.text = ""
//                                                             totalTime.text = ""
//                                                              updateTime()
//                                                             getArtistInfo()
//                                                            audioPlayer.play()
//                                                           playBtn.setImage(UIImage(named: "pause"), for: .normal)
//               }
//           }
           
        }
    
//    @objc func update (_timer : Timer ) {
// //       slide.value = Float(player!.currentTime)
//
//           time.text =  stringFormatterTimeInterval(interval: TimeInterval(slide.value)) as String
//       }
    
//    func updateTime() {
//        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
//     // slide.maximumValue = Float(player!.duration)
//    //    totalTime.text = stringFormatterTimeInterval(interval: player!.duration) as String
//    }
//    func stringFormatterTimeInterval(interval : TimeInterval) ->NSString {
//        let ti = NSInteger(interval)
//        let second = ti % 60
//        let minutes = ( ti / 60) % 60
//        return NSString(format: "%0.2d:%0.2d", minutes,second)
//    }
//

    func stringFromTimeInterval(interval: TimeInterval) -> String {
    let interval = Int(interval)
    let seconds = interval % 60
    let minutes = (interval / 60) % 60
    let hours = (interval / 3600)
    return String(format: "%02d:%02d", minutes, seconds)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        let duration : CMTime = playerItem!.asset.duration
        let seconds : Float64 = CMTimeGetSeconds(duration)
        totalTime.text = self.stringFromTimeInterval(interval: seconds)
  
        
        let currentDuration : CMTime = playerItem!.currentTime()
        let currentSeconds : Float64 = CMTimeGetSeconds(currentDuration)
        
        time.text = self.stringFromTimeInterval(interval: currentSeconds)
        
        
        player!.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: DispatchQueue.main) { (CMTime) -> Void in
        if self.player!.currentItem?.status == .readyToPlay {
        let time : Float64 = CMTimeGetSeconds(self.player!.currentTime());
        self.slide.value = Float ( time );
        self.time.text = self.stringFromTimeInterval(interval: time)
        }
        }
        
        
//
//        totalTime.text = "-:--"
//        totalTime.font = UIFont.systemFont(ofSize : 12)
//        totalTime.textColor = .black
//
//
//        time.text = "-:--"
//        time.font = UIFont.systemFont(ofSize : 12)
//        time.textColor = .black
//
        artistImage.clipsToBounds = true
        artistImage.layer.cornerRadius = 10
        artistImage.contentMode = .scaleAspectFill
        
        slide.maximumValue = 1000
        slide.minimumValue = 0
        slide.tintColor = UIColor.black
        slide.addTarget(self, action: #selector(_slider), for: .touchDragInside)
          
        
          playButton.setImage(UIImage(named: "play"), for: .normal)
          playButton.addTarget(self, action: #selector(didTapPlayPauseButton), for: .touchUpInside)
        
        backButton.setImage(UIImage(named: "previous"), for: .normal)
 

    //    mixed.setImage(UIImage(named: "mix"), for: .normal)
        mixed.addTarget(self, action: #selector(_mix), for: .touchUpInside)
        
        nextButton.setImage(UIImage(named: "next"), for: .normal)

        view.addSubview(artistImage)
        let song = songs[position]

               // let urlString = Bundle.main.path(forResource: song.music_url, ofType: "mp3")

                do {
    
                    try AVAudioSession.sharedInstance().setMode(.default)
                    try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)

//                    guard let urlString = urlString else {
//                        print("urlstring is nil")
//                        return
//                    }

                    let urlString = URL(string: song.music_url)
                    
                            let playerItem:AVPlayerItem = AVPlayerItem(url: urlString!)
                    
                            player = AVPlayer(playerItem: playerItem)
                    
                 //   player = try AVAudioPlayer(contentsOf: URL(string: urlString)!)

                    //player?.delegate = self
                    
                    guard let player = player else {
                        print("player is nil")
                        return
                    }
                    player.volume = 0.5

                    player.play()
                }
                catch {
                    print("error occurred")
                }

        songNameLabel.text = song.name
        albumNameLabel.text = song.artist
        artistNameLabel.text = song.artist
          let img1 = song.image
          let imgname = img1.setImageURL()
          artistImage.sd_setImage(with: URL(string: imgname), placeholderImage: UIImage(named: "default_icon"))

        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)

  */
        let song = songs[position]
        let url = URL(string: song.music_url)
        let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        player?.play()
        player?.volume = 0.6
        artistImage.image = UIImage(named: "\(song.image)")
        songNameLabel.text = song.name
        albumNameLabel.text = song.artist
        artistNameLabel.text = song.artist
          let img1 = song.image
          let imgname = img1.setImageURL()
          artistImage.sd_setImage(with: URL(string: imgname), placeholderImage: UIImage(named: "default_icon"))

          nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
          backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)

          playButton.setImage(UIImage(named: "pause"), for: .normal)
        NotificationCenter.default.addObserver(self, selector: #selector(self.finishedPlaying(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
        
        // Add playback slider
        slide.minimumValue = 0
        
        slide.addTarget(self, action: #selector(PlayerViewController.playbackSliderValueChanged(_:)), for: .valueChanged)
        
        let duration : CMTime = playerItem.asset.duration
        let seconds : Float64 = CMTimeGetSeconds(duration)
        totalTime.text = self.stringFromTimeInterval(interval: seconds)
        
        let duration1 : CMTime = playerItem.currentTime()
        let seconds1 : Float64 = CMTimeGetSeconds(duration1)
        time.text = self.stringFromTimeInterval(interval: seconds1)
        
        slide.maximumValue = Float(seconds)
        slide.isContinuous = true
        slide.tintColor = UIColor(red: 0.93, green: 0.74, blue: 0.00, alpha: 1.00)
        
        player!.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: DispatchQueue.main) { (CMTime) -> Void in
            if self.player!.currentItem?.status == .readyToPlay {
                let time : Float64 = CMTimeGetSeconds(self.player!.currentTime());
                self.slide.value = Float ( time );
                
                self.time.text = self.stringFromTimeInterval(interval: time)
            }
            
            let playbackLikelyToKeepUp = self.player?.currentItem?.isPlaybackLikelyToKeepUp
            if playbackLikelyToKeepUp == false{
                print("IsBuffering")
                self.playButton.isHidden = true
           //     self.loadingView.isHidden = false
            } else {
                //stop the activity indicator
                print("Buffering completed")
                self.playButton.isHidden = false
               // self.loadingView.isHidden = true
            }
            
        }
        playButton.setImage(UIImage(named: "play"), for: .normal)
        playButton.addTarget(self, action: #selector(didTapPlayPauseButton), for: .touchUpInside)
      
      backButton.setImage(UIImage(named: "previous"), for: .normal)


    mixed.setImage(UIImage(named: "mix"), for: .normal)
      mixed.addTarget(self, action: #selector(_mix), for: .touchUpInside)
      
      nextButton.setImage(UIImage(named: "next"), for: .normal)


        
    }
    
    @objc func finishedPlaying( _ myNotification:NSNotification) {
        playButton.setImage(UIImage(named: "play"), for: .normal)
           if position <= (songs.count) {
           position = position + 1
         //  player?.replaceCurrentItem(with: nil)
            
           configure()
    }
    }
    
    @objc func playbackSliderValueChanged(_ slide:UISlider)
    {
        let seconds : Int64 = Int64(slide.value)
        let targetTime:CMTime = CMTimeMake(value: seconds, timescale: 1)
        
        player!.seek(to: targetTime)
        
        if player!.rate == 0
        {
            player?.play()
        }
    }

    func configure() {
        let song = songs[position]
        let url = URL(string: song.music_url)
        let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        player?.play()
        player?.volume = 0.6
        artistImage.image = UIImage(named: "\(song.image)")
        songNameLabel.text = song.name
        albumNameLabel.text = song.artist
        artistNameLabel.text = song.artist
          let img1 = song.image
          let imgname = img1.setImageURL()
          artistImage.sd_setImage(with: URL(string: imgname), placeholderImage: UIImage(named: "default_icon"))

          nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
          backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)

        playButton.setImage(UIImage(named: "pause"), for: .normal)
        slide.minimumValue = 0
        
        slide.addTarget(self, action: #selector(PlayerViewController.playbackSliderValueChanged(_:)), for: .valueChanged)
        
        let duration : CMTime = playerItem.asset.duration
        let seconds : Float64 = CMTimeGetSeconds(duration)
        totalTime.text = self.stringFromTimeInterval(interval: seconds)
        
        let duration1 : CMTime = playerItem.currentTime()
        let seconds1 : Float64 = CMTimeGetSeconds(duration1)
        time.text = self.stringFromTimeInterval(interval: seconds1)
        
        slide.maximumValue = Float(seconds)
        slide.isContinuous = true
        slide.tintColor = UIColor(red: 0.93, green: 0.74, blue: 0.00, alpha: 1.00)
        
        player!.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: DispatchQueue.main) { (CMTime) -> Void in
            if self.player!.currentItem?.status == .readyToPlay {
                let time : Float64 = CMTimeGetSeconds(self.player!.currentTime());
                self.slide.value = Float ( time );
                
                self.time.text = self.stringFromTimeInterval(interval: time)
            }
            
            let playbackLikelyToKeepUp = self.player?.currentItem?.isPlaybackLikelyToKeepUp
            if playbackLikelyToKeepUp == false{
                print("IsBuffering")
                self.playButton.isHidden = true
           //     self.loadingView.isHidden = false
            } else {
                //stop the activity indicator
                print("Buffering completed")
                self.playButton.isHidden = false
               // self.loadingView.isHidden = true
            }
            
        }
//        // set up player
//        let song = songs[position]
//
//        //let urlString = Bundle.main.path(forResource: song.music_url, ofType: "mp3")
//
//
//        do {
//            try AVAudioSession.sharedInstance().setMode(.default)
//            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
//
////            guard let urlString = urlString else {
////                print("urlstring is nil")
////                return
////            }
//            let urlString = URL(string: song.music_url)
//                    let playerItem:AVPlayerItem = AVPlayerItem(url: urlString!)
//                    player = AVPlayer(playerItem: playerItem)
//
//         //   player = try AVAudioPlayer(contentsOf: URL(string: urlString)!)
//
//            guard let player = player else {
//                print("player is nil")
//                return
//            }
//            player.volume = 0.5
//
//            player.play()
//        }
//        catch {
//            print("error occurred")
//        }
//
//      artistImage.image = UIImage(named: "\(song.image)")
//      songNameLabel.text = song.name
//      albumNameLabel.text = song.artist
//      artistNameLabel.text = song.artist
//        let img1 = song.image
//        let imgname = img1.setImageURL()
//        artistImage.sd_setImage(with: URL(string: imgname), placeholderImage: UIImage(named: "default_icon"))
//
//        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
//        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
//
//    playButton.setImage(UIImage(named: "pause"), for: .normal)

    }

    @objc func didTapBackButton() {
        if position > 0 {
            position = position - 1
          //  player?.stop()
            configure()
        }
    }
    @IBOutlet var holder: UIView!
    
    @objc func didTapNextButton() {
        if position < (songs.count - 1) {
            position = position + 1
     //       player?.stop()
            configure()
        }
    }

    @objc func didTapPlayPauseButton() {
        if player!.rate == 0 {
            player?.play()
            playButton.setImage(UIImage(named: "pause"), for: .normal)
          //  updateTime()
        }else{
            player?.pause()
            playButton.setImage(UIImage(named: "play"), for: .normal)
           // updateTime()

        }
    }

  

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let player = player {
         //   player.stop()
            player.replaceCurrentItem(with: nil)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        if (player?.rate != 0 && player?.error == nil) {
              // getArtistInfo()
           //    updateTime()
               playButton.setImage(UIImage(named: "pause"), for: .normal)
           }
       }

}
extension UIView{
    func anchor(top : NSLayoutYAxisAnchor?
                ,left : NSLayoutXAxisAnchor?,
                 bottom : NSLayoutYAxisAnchor? ,
                 rigth: NSLayoutXAxisAnchor?,
                 marginTop : CGFloat ,
                 marginLeft : CGFloat ,
                marginBottom: CGFloat
                ,marginRigth : CGFloat ,
                 width : CGFloat ,
                 heigth : CGFloat
    
    )  {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: marginTop).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: marginLeft).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -marginBottom).isActive = true
        }
        if let rigth = rigth {
            self.rightAnchor.constraint(equalTo: rigth, constant: -marginRigth).isActive = true
        }
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if heigth != 0{
            heightAnchor.constraint(equalToConstant: heigth).isActive = true
        }
    }
    
    

}


