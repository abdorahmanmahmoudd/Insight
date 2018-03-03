//
//  AddVoiceNoteViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/25/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit
import AVFoundation

class AddVoiceNoteViewController: ParentViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {

    @IBOutlet var btnDeleteExistingRecord: UIButton!
    @IBOutlet var slider: UISlider!
    @IBOutlet var btnPlayExistingRecord: UIButton!
    @IBOutlet var viewPlaying: UIView!
    
    @IBOutlet var btnTestPlay: UIButton!
    @IBOutlet var btnRecord: UIButton!
    @IBOutlet var lblTimer: UILabel!
    @IBOutlet var viewRecording: UIView!
    
    var audioPlayer : AVAudioPlayer?
    var recordingSession : AVAudioSession!
    var audioRecorder : AVAudioRecorder!
    var settings = [String:Int]()
    var timer = Timer()
    var timerCounter = 0
    
    var mediaSaved = true
    var questionId = String()
    var VoiceFile: String {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path
    }
    var isRecordExits = false
    var deleteRecord = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configuration()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print(flag)
        btnTestPlay.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        btnPlayExistingRecord.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        
    }
    
    func  configuration(){
        
        self.title = "Recorder"
        btnRecord.layer.cornerRadius = (btnRecord.frame.width + 1) / 2
        // load voice note if exists
        getQuestionVoiceNoteIfExists()
        configureBackBtn()
        
    }
    
    func configureBackBtn(){
        
        let btn = UIButton.init(type: .custom)
        btn.setImage(#imageLiteral(resourceName: "back-NoShadow"), for: .normal)
        btn.addTarget(self, action: #selector(self.backBtnClicked), for: .touchUpInside)
        let barBtn = UIBarButtonItem.init(customView: btn)
        self.navigationItem.leftBarButtonItem = barBtn
    }
    
    @objc func backBtnClicked(){
        
        if mediaSaved{
            self.navigationController?.popViewController(animated: true)
        }else{
            showYesNoAlert(title: "Attention", message: "Unsaved changes will be discarded.", vc: self, firstBtnTitle: "Discard", secondBtnTitle: "Cancel", closure: { (exit) in
                if exit{
                    
                    self.navigationController?.popViewController(animated: true)
                }
            })
        }
    }
    
    func getQuestionVoiceNoteIfExists(){
        
        do {
            
            showLoaderFor(view: self.view)
            
            let predicateQuery = NSPredicate.init(format: "Id == %@", questionId)
            
            if let question = realm?.objects(FlaggedQuestion.self).filter(predicateQuery).first{
                
                if let voiceNoteName = question.voiceNotePath{
                    
                    if let voiceNoteURL = self.voicePathFromName(voiceNoteName){
                        
                        self.audioPlayer = try AVAudioPlayer.init(contentsOf: voiceNoteURL)
                        self.audioPlayer?.prepareToPlay()
                        self.audioPlayer?.delegate = self
                        self.isRecordExits = true
                        self.slider.setValue( 0.0, animated: false)
                        self.slider.maximumValue = Float(audioPlayer!.duration)
                        
                    }else{
                        
                        self.isRecordExits = false
                    }
                }else{
                    
                    self.isRecordExits = false
                }
                self.presentCorrectView()
            }
            hideLoaderFor(view: self.view)
            
        }catch let err{
            
            hideLoaderFor(view: self.view)
            
            showAlert(title: "Error", message: err.localizedDescription, vc: self, closure: nil)
        }
    }
    
    func voicePathFromName(_ voiceNoteName: String) -> URL? {
        
        guard  voiceNoteName.characters.count > 0 else {
            print("ERROR: No voice note name")
            return nil
        }
        
        let voicePath = VoiceFile + "/" + voiceNoteName
        let url = URL.init(fileURLWithPath: voicePath)
        return url
        
    }
    
    func presentCorrectView(){
        
        if isRecordExits{
            
            self.viewPlaying.isHidden = false
            self.viewRecording.isHidden = true
            
        }else{
            
            self.viewRecording.isHidden = false
            self.viewPlaying.isHidden = true
            recordingSession = AVAudioSession.sharedInstance()
            
            do {
                try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
                try recordingSession.setActive(true)
                
                recordingSession.requestRecordPermission() { [unowned self] allowed in
                    
                    DispatchQueue.main.async {
                        
                        if allowed {
                            
                            self.btnRecord.isEnabled = true
                            print("Allow")
                            
                        } else {
                            
                            self.btnRecord.isEnabled = false
                            print("Dont Allow")
                        }
                    }
                }
                
            } catch let err {
                
                self.btnRecord.isEnabled = false
                showAlert(title: "Error", message: err.localizedDescription, vc: self, closure: nil)
            }
        }
    }
    
    @IBAction func btnRecordClicked(_ sender: UIButton) {
        
        mediaSaved = false
        
        if audioRecorder == nil {
            self.btnRecord.setImage(#imageLiteral(resourceName: "Home"), for: .normal)
            self.startRecording()
            
        } else {
            
            audioRecorder.stop()
            audioRecorder = nil
            self.btnRecord.setImage(#imageLiteral(resourceName: "mice"), for: .normal)
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            audioRecorder.stop()
            audioRecorder = nil
            self.btnRecord.setImage(#imageLiteral(resourceName: "mice"), for: .normal)
        }
    }
    
    @IBAction func btnSaveRecordClicked(_ sender: UIButton) {
        
        mediaSaved = true
        
        if isRecordExits{
            
            if deleteRecord{
                
                do {
                    
                    let predicateQuery = NSPredicate.init(format: "Id == %@", questionId)
                    
                    if let fq = realm?.objects(FlaggedQuestion.self).filter(predicateQuery).first{
                        
                        try realm?.write {
                            fq.voiceNotePath = nil
                        }
                        
                        let recordName = "\(questionId).m4a"
                        audioPlayer?.stop()
                        audioPlayer = nil
                        
                        if let recordUrl = self.voicePathFromName(recordName){
                            
                            try FileManager.default.removeItem(at: recordUrl)
                            
                        }
                        
                        self.navigationController?.popViewController(animated: true)
                    }
                    
                }catch let err{
                    showAlert(title: "Error", message: err.localizedDescription, vc: self, closure: nil)
                }
            }
        }else{
            
            do {
                
                let predicateQuery = NSPredicate.init(format: "Id == %@", questionId)
                
                if let fq = realm?.objects(FlaggedQuestion.self).filter(predicateQuery).first{
                    
                    let url = NSURL.init(fileURLWithPath: VoiceFile)
                    
                    if let filePath = url.appendingPathComponent("\(questionId).m4a"){
                        
                        if FileManager.default.fileExists(atPath: filePath.path) {
                            
                            try realm?.write {
                                fq.voiceNotePath = "\(questionId).m4a"
                            }
                            
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                }
                
            }catch let err{
                showAlert(title: "Error", message: err.localizedDescription, vc: self, closure: nil)
            }
        }
    }
    
    @IBAction func btnsDeleteClicked(_ sender: UIButton) {
        
        mediaSaved = false
        
        if isRecordExits{
            
            deleteRecord = true
            audioPlayer?.stop()
            btnPlayExistingRecord.isHidden = true
            slider.isHidden = true
            btnDeleteExistingRecord.isHidden = true
            
        }else{
            
            let recordName = "\(questionId).m4a"
            
            audioPlayer?.stop()
            
            audioPlayer = nil
            
            timer.invalidate()
            
            do {
                
                if let recordUrl = self.voicePathFromName(recordName){
                    
                    try FileManager.default.removeItem(at: recordUrl)
                    
                    timerCounter = 0
                    
                    self.lblTimer.text = self.timeString(time: TimeInterval.init(self.timerCounter))
                }
                
            }catch let err {
                
                print(err.localizedDescription)
            }
            
            
        }
    }
    
    func startRecording() {
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        do {
            
            let url = URL.init(fileURLWithPath: VoiceFile).appendingPathComponent("\(questionId).m4a")
            audioRecorder = try AVAudioRecorder(url: url, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.prepareToRecord()
            audioRecorder.record()
            
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
            
        } catch let err{
            
            showAlert(title: "Error", message: err.localizedDescription, vc: self, closure: nil)
        }
    }
    
    @objc func updateTimer(){
        
        if audioRecorder == nil {
            
            timer.invalidate()
            timerCounter = 0
            
        }else {
            
            self.timerCounter += 1
            self.lblTimer.text = self.timeString(time: TimeInterval.init(self.timerCounter))
        }
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String.init(format: "%02i:%02i:%02i", arguments: [hours,minutes,seconds])
    }

    @IBAction func btnCancelClicked(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnPlayClicked(_ sender: UIButton) {
        
        if isRecordExits && audioPlayer != nil{
            
            if audioPlayer!.isPlaying{
                
                btnPlayExistingRecord.setImage(#imageLiteral(resourceName: "play"), for: .normal)
                audioPlayer?.pause()
                
            }else{
                
                btnPlayExistingRecord.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
                audioPlayer?.play()
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateSlider), userInfo: nil, repeats: true)
            }
        }else{
            
            if audioPlayer != nil{
                
                if audioPlayer!.isPlaying{
                    
                    btnTestPlay.setImage(#imageLiteral(resourceName: "play"), for: .normal)
                    audioPlayer?.pause()
                    
                }else{
                    
                    btnTestPlay.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
                    audioPlayer?.play()

                }
                
            }else {
                
                let recordName = "\(questionId).m4a"
                
                if let recordUrl = self.voicePathFromName(recordName){
                    
                    if let ap = try? AVAudioPlayer.init(contentsOf: recordUrl){
                        
                        self.audioPlayer = ap
                        self.audioPlayer?.prepareToPlay()
                        self.audioPlayer?.delegate = self
                        btnTestPlay.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
                        self.audioPlayer?.play()
                    }
                }
                
            }

        }
    }
    
    @objc func updateSlider (){
        if audioPlayer != nil{
            slider.value = Float(audioPlayer!.currentTime)
        }
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        
        if audioPlayer != nil{
            audioPlayer!.currentTime = TimeInterval.init(slider.value)
        }
    }
}
