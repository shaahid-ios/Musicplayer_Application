//
//  NewPlayerViewController.swift
//  music_app
//
//  Created by Shaahid on 06/10/21.
//


    import AVFoundation
    import UIKit
    import WebKit
 

    class NewPlayerViewController: UITableViewController,AVAudioPlayerDelegate  {

        
        var isrepeat = false
        
        @IBOutlet weak var webvieww: WKWebView!
        public var position: Int = 0
        public var songs: [Homeplaylist] = []
        public var chordsong: [chord_sheet] = []
        var player:AVPlayer?
        var playerItem:AVPlayerItem?

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

        @IBOutlet weak var repeatbtn: UIButton!
        @IBOutlet var mixed: UIButton!
      
        
 

        override func viewDidLoad() {
            super.viewDidLoad()
            
            isrepeat = false
            isMix = false
            webvieww.isHidden = true
            
            artistImage.clipsToBounds = true
            artistImage.layer.cornerRadius = 10
            artistImage.contentMode = .scaleAspectFill
//            slide.maximumValue = 1000
//            slide.minimumValue = 0
            slide.tintColor = UIColor.black
            slide.addTarget(self, action: #selector(_slider), for: .touchDragInside)
              
            
         //     playButton.setImage(UIImage(named: "play"), for: .normal)
              playButton.addTarget(self, action: #selector(didTapPlayPauseButton), for: .touchUpInside)
            
            backButton.setImage(UIImage(named: "previous"), for: .normal)
     

        //    mixed.setImage(UIImage(named: "mix"), for: .normal)
            mixed.addTarget(self, action: #selector(_mix), for: .touchUpInside)
            
            repeatbtn.addTarget(self, action: #selector(_repeataction), for: .touchUpInside)
            
            nextButton.setImage(UIImage(named: "next"), for: .normal)

           // view.addSubview(artistImage)
            let song = songs[position]
            let url = URL(string: song.music_url)
            let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
            player = AVPlayer(playerItem: playerItem)
            avItems.append(AVPlayerItem(url: url!))
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
            
           if ((position + 1) == songs.count){
                 position = 0
            }

        }
       
    
        @objc func _repeataction() {
            if isrepeat{
                isrepeat = false
                isMix = false

                repeatbtn.setImage(UIImage(named: "repeat.png"), for: .normal)
                mixed.setImage(UIImage(named: "shuffle.png"), for: .normal)
//                NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem, queue: .main) { [weak self] _ in
//                    self?.player?.seek(to: CMTime.zero)
//                    self?.player?.play()
//                }
                let alert = UIAlertController(title: "", message: "Repeat is OFF", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                let when = DispatchTime.now() + 2
                DispatchQueue.main.asyncAfter(deadline: when){
                alert.dismiss(animated: true, completion: nil)
                }
               
                
                
                
            }else {
                isrepeat = true
                isMix = false
                mixed.setImage(UIImage(named: "shuffle.png"), for: .normal)
                repeatbtn.setImage(UIImage(named: "repeat_s.png"), for: .normal)
                
                let alert = UIAlertController(title: "", message: "Repeat is ON", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                let when = DispatchTime.now() + 2
                DispatchQueue.main.asyncAfter(deadline: when){
                alert.dismiss(animated: true, completion: nil)
                }
//                NotificationCenter.default.addObserver(self,
//                                                           selector: #selector(restartaudio),
//                                                           name: .AVPlayerItemDidPlayToEndTime,
//                                                           object: self.player?.currentItem)
          
//                NotificationCenter.default.addObserver(
//                            self,
//                            selector: #selector(loopVideo),
//                            name: .AVPlayerItemDidPlayToEndTime,
//                            object: self.player?.currentItem
//                        )
                
            }
              
        
        }
        
        func playerItemDidReachEnd() {
               player?.seek(to: CMTime.zero)
           }
           
           // add this loop at the end, after viewDidLoad
           @objc func loopVideo() {
               playerItemDidReachEnd()
               player?.play()
           }
        
        @objc func restartaudio() {
            player?.pause()
            player?.currentItem?.seek(to: CMTime.zero, completionHandler: { _ in
                self.player?.play()
            })
        }
            
 
        @IBAction func segmentChanged(_ sender: UISegmentedControl) {
          if sender.selectedSegmentIndex == 0
                  {
                     configure()
                  }
        else if sender.selectedSegmentIndex == 1{
                    karokeconfigure()
            
        }
//        else if sender.selectedSegmentIndex == 2 {
//
//                    configurepdf()
//            player?.replaceCurrentItem(with: nil)
//                  }
          }
        
        @objc func _mix ()
          {
           if isMix{
               isMix = false
                isrepeat = false
            repeatbtn.setImage(UIImage(named: "repeat.png"), for: .normal)
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
            isrepeat = false
            repeatbtn.setImage(UIImage(named: "repeat.png"), for: .normal)
            mixed.setImage(UIImage(named: "shuffle_s.png"), for: .normal)
            let alert = UIAlertController(title: "", message: "Shuffle is ON", preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            let when = DispatchTime.now() + 2
            DispatchQueue.main.asyncAfter(deadline: when){
              alert.dismiss(animated: true, completion: nil)
            }}
           }

        
        @objc func _slider () {
            let seconds : Int64 = Int64(slide.value)
            let targetTime:CMTime = CMTimeMake(value: seconds, timescale: 1)
            player!.seek(to: targetTime)
            if player!.rate == 0 {
            player?.play()
             }
            
        }
        var avItems: [AVPlayerItem] = []
        var myQueuePlayer: AVQueuePlayer?
        var trackId: Int = 0
        
        
        @objc func finishedPlaying( _ myNotification:NSNotification) {
            
            if isrepeat == false{
          
                if position <= (songs.count) {
                    position += 1
                 configure()
                 karokeconfigure()
                  

                }
                   }else if isrepeat == true{
                    
                        player?.seek(to: CMTime.zero)
                        player?.play()
                   }
                if isMix == false{
                player?.seek(to: CMTime.zero)
                player?.play()
                   }else if isMix == true{
                    
                    if position <= (songs.count) {
                      position = position + 2
                     configure()
                    karokeconfigure()
      
                      }
                     }
        
//            if position <= (songs.count) {
//              position = position + 1
//             configure()
//
//                }

                }
        
        func stringFromTimeInterval(interval: TimeInterval) -> String {
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        return String(format: "%02d:%02d", minutes, seconds)
            
        }

        func stringFormatterTimeInterval(interval : TimeInterval) ->NSString {
            let ti = NSInteger(interval)
            let second = ti % 60
            let minutes = ( ti / 60) % 60
            return NSString(format: "%0.2d:%0.2d", minutes,second)
        }

        
        func configure() {
            webvieww.isHidden = true
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
            mixed.addTarget(self, action: #selector(_mix), for: .touchUpInside)
            
            repeatbtn.addTarget(self, action: #selector(_repeataction), for: .touchUpInside)
            
              nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
              backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
            
            NotificationCenter.default.addObserver(self, selector: #selector(self.finishedPlaying(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
            
            

            playButton.setImage(UIImage(named: "pause"), for: .normal)
            slide.minimumValue = 0
            slide.addTarget(self, action: #selector(NewPlayerViewController.playbackSliderValueChanged(_:)), for: .valueChanged)
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
            if ((position + 1) == songs.count){
                  position = 0
             }
            
        }
        
        func configurepdf(){
            webvieww.isHidden = false
            let song = chordsong[position]
            let url = URL(string: song.pdf_url)
            webvieww.load(URLRequest(url: url!))
         
        }
        
        func karokeconfigure() {
            webvieww.isHidden = true
            let song = songs[position]
            let url = URL(string: song.minus_one_track)
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

              nextButton.addTarget(self, action: #selector(kdidTapNextButton), for: .touchUpInside)
              backButton.addTarget(self, action: #selector(kdidTapBackButton), for: .touchUpInside)
            
            NotificationCenter.default.addObserver(self, selector: #selector(self.finishedPlaying(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)

            playButton.setImage(UIImage(named: "pause"), for: .normal)
            slide.minimumValue = 0
            slide.addTarget(self, action: #selector(NewPlayerViewController.playbackSliderValueChanged(_:)), for: .valueChanged)
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
            
            if ((position + 1) == songs.count){
                  position = 0
             }
            
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
                position = position + 2
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
        
        @objc func kdidTapBackButton() {
            if position > 0 {
                position = position - 1
              //  player?.stop()
                karokeconfigure()
            }
        }
        
        @objc func kdidTapNextButton() {
            if position < (songs.count - 1) {
                position = position + 1
         //       player?.stop()
                karokeconfigure()
            }
        }
        
        @objc func didSlideSlider(_ slider: UISlider) {
            let value = slider.value
            player?.volume = value
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
            mixed.setImage(UIImage(named: "shuffle"), for: .normal)
            repeatbtn.setImage(UIImage(named: "repeat.png"), for: .normal)
            
            
           }
        
//
//        private var trackIndex = 0{
//            didSet{
//                self.updateSongDetails?(trackIndex)
//                self.updateControllerIndex?(trackIndex)
//    //            self.updateTrackIndexToAppdelegate?(trackIndex)
//            }
//        }
//
//        var updateControllerIndex: ((_ index: Int) -> ())?
//        private var indexs = [Int]()
//        var updateSongDetails: ((_ index: Int) -> ())?
//        open var isShuffle = false
//
//        private func shuffleIndex(){
//            if isShuffle == true{
//                indexs.shuffle()
//                if let i = indexs.firstIndex(where: {$0 == trackIndex }) {
//                    indexs.remove(at: i)
//                    indexs.insert(trackIndex, at: 0)
//                }
//            }else{
//                indexs = [Int]()
//                for i in 0..<songs.count{
//                    indexs.append(i)
//                }
//            }
//            print(indexs)
//        }
        
        
        
           }


