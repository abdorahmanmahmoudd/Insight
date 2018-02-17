//
//  QuestionListeningTableViewCell.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/4/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit
import AVFoundation

class QuestionListeningTableViewCell: UITableViewCell {
    
    @IBOutlet var slider: UISlider!
    @IBOutlet var lblContent: UILabel!
    @IBOutlet var btnPlay: UIButton!
    
    var isPlaying = false
    var player = AVAudioPlayer()
    var timer = Timer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setStyle()
    }

    func setStyle(){
        
        btnPlay.clipsToBounds = true
        btnPlay.layer.cornerRadius = 6
        btnPlay.layer.borderWidth = 2
        btnPlay.layer.borderColor = UIColor.white.cgColor
        
        slider.setValue(0.0, animated: false)
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnPlayClicked(_ sender: UIButton) {
        
        if isPlaying{
            
            btnPlay.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            isPlaying = !isPlaying
            
            player.pause()
            
        }else {
            
            btnPlay.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
            isPlaying = !isPlaying
            
            player.play()
        }
    }

    
    func fillData(question : QuestionData){
        
        lblContent.text = question.content.html2String
        
        if let url = URL.init(string: question.sound ?? ""){
            
            do  {
                
                let data = try Data.init(contentsOf: url)
                
                player = try AVAudioPlayer(data: data, fileTypeHint: AVFileType.mp3.rawValue)
                
                isPlaying = false
                
                btnPlay.setImage(#imageLiteral(resourceName: "play"), for: .normal)
                
                btnPlay.isEnabled = true
                
                player.currentTime = 0
                
                player.prepareToPlay()
                
                slider.maximumValue = Float(player.duration)
                
                timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateSlider), userInfo: nil, repeats: true)
                
            }catch let err {
                
                btnPlay.isEnabled = false
                slider.isEnabled = false
                print("sound corrupted url : " , err.localizedDescription)
            }
        }
        
    }
    
    @objc func updateSlider (){
    
        slider.value = Float(player.currentTime)
    }
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        
        player.currentTime = TimeInterval.init(slider.value)
    }
}
