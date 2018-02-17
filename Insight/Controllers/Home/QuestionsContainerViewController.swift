//
//  QuestionsContainerViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/2/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

protocol CorrectedQuestion: class {
    
    func submitAnswers()
}

class QuestionsContainerViewController: UIViewController {

    @IBOutlet var lblTimer: UILabel!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var containerViewQuestion: UIView!
    @IBOutlet var btnNextOrSubmit: UIButton!
    @IBOutlet var btnPrevious: UIButton!
    
    var subsubCategory : SubSubCategory?
    var currentQuestionIndex = 0
    var isNext = true
    weak var delegate : CorrectedQuestion?
    var questionTimer = Timer()
    var timerCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if subsubCategory != nil {
            
            presentQuestions(currentQuestion: currentQuestionIndex)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    @objc func nextQuestion() {
        
        if currentQuestionIndex < subsubCategory!.questions.count - 1{
            isNext = true
            currentQuestionIndex += 1
            presentQuestions(currentQuestion: currentQuestionIndex)
        }
        
    }
    
    @objc func submitQuestion(){
        
        if delegate != nil{
            
            delegate!.submitAnswers()
            
            btnNextOrSubmit.setTitle("Next", for: .normal)
            
            btnNextOrSubmit.removeTarget(nil, action: #selector(self.submitQuestion), for: .touchUpInside)
            
            btnNextOrSubmit.addTarget(nil, action: #selector(self.nextQuestion), for: .touchUpInside)
            
        }else {
            
            nextQuestion()
        }
        
        
    }
    
    @IBAction func btnPreviousClicked(_ sender: UIButton) {
        
        if currentQuestionIndex > 0{
            isNext = false
            currentQuestionIndex -= 1
            presentQuestions(currentQuestion: currentQuestionIndex)
            
        }else{
            
            self.navigationController?.popViewController(animated: true)
        }
        
        
    }
    
    func presentQuestions(currentQuestion : Int){
        
        if subsubCategory!.questions != nil && subsubCategory!.questions!.count > currentQuestion{
            
            switch subsubCategory?.questions[currentQuestion].type {
                
            case QuestionTypes.Antonym.rawValue?:
                self.lblTitle.text = subsubCategory?.questions[currentQuestion].title
                initAntonymQuestionView()
                break
                
            case QuestionTypes.Complete.rawValue?:
                self.lblTitle.text = subsubCategory?.questions[currentQuestion].title
                initCompleteQuestionsView()
                
                break
                
            case QuestionTypes.Dictation.rawValue?:
                self.lblTitle.text = subsubCategory?.questions[currentQuestion].title
                initDictationQuestionView()
                break
                
//            case QuestionTypes.Listening.rawValue?:
//                self.lblTitle.text = subsubCategory?.questions[currentQuestion].title
//                initListeningQuestionView()
//                break
                
            case QuestionTypes.Match.rawValue?://presentation
                self.lblTitle.text = subsubCategory?.questions[currentQuestion].title
                initMatchQuestionView()
                break
                
            case QuestionTypes.MCQ.rawValue?://presentation
                self.lblTitle.text = subsubCategory?.questions[currentQuestion].title
                initMCQQuestionView()
                break
                
            case QuestionTypes.MiniDialog.rawValue?://presentation  
                self.lblTitle.text = subsubCategory?.questions[currentQuestion].title
                initMiniDialogQuestionView()
                break
                
            case QuestionTypes.Mistakes.rawValue?://presentation
                self.lblTitle.text = subsubCategory?.questions[currentQuestion].title
                initMistakesQuestionView()
                break
                
            case QuestionTypes.Rewrite.rawValue?://presentation
                self.lblTitle.text = subsubCategory?.questions[currentQuestion].title
                initGeneralQuestionView()
                break
                
            case QuestionTypes.Situations.rawValue?://presentation
                self.lblTitle.text = subsubCategory?.questions[currentQuestion].title
                initGeneralQuestionView()
                break
                
            case QuestionTypes.Translation.rawValue?://presentation
                self.lblTitle.text = subsubCategory?.questions[currentQuestion].title
                initGeneralQuestionView()
                break
                
            case QuestionTypes.Writing.rawValue?://presentation
                self.lblTitle.text = subsubCategory?.questions[currentQuestion].title
                initWritingQuestionView()
                break
                
            case QuestionTypes.Prereading.rawValue?:
                self.lblTitle.text = subsubCategory?.questions[currentQuestion].title
                initGeneralQuestionView()
                break
                
            case QuestionTypes.Quotations.rawValue?://presentation
                self.lblTitle.text = subsubCategory?.questions[currentQuestion].title
                initQuotationsQuestionView()
                break
                
            case QuestionTypes.TrueFalse.rawValue?:
                self.lblTitle.text = subsubCategory?.questions[currentQuestion].title
                initTrueFalseQuestionView()
                break
                
            default:
                showAlert(title: "Warning", message: "Unexpected question type!", vc: self, closure: {
                    if self.isNext {
                        
                        self.nextQuestion()
                    }else{
                        
                        self.btnPreviousClicked(self.btnPrevious)
                    }
                })
                break
                
            }
        }
        
    }
    
    func initCompleteQuestionsView(){
        
        lblTimer.isHidden = true
        // to reload data without adding posts view over each other
        for view in containerViewQuestion.subviews{
            view.removeFromSuperview()
        }
        
        let storyboard = UIStoryboard.init(name: "Home", bundle: Bundle.main)
        if let vc  = storyboard.instantiateViewController(withIdentifier: "QuestionCompleteVC") as? QuestionCompleteViewController {
            
            vc.questions = subsubCategory!.questions[currentQuestionIndex].data
            self.delegate = vc
            vc.view.translatesAutoresizingMaskIntoConstraints = false
            vc.willMove(toParentViewController: self)
            self.containerViewQuestion.addSubview(vc.view)
            vc.view.leadingAnchor.constraint(equalTo: self.containerViewQuestion.leadingAnchor).isActive = true
            vc.view.trailingAnchor.constraint(equalTo: self.containerViewQuestion.trailingAnchor).isActive = true
            vc.view.topAnchor.constraint(equalTo: self.containerViewQuestion.topAnchor).isActive = true
            vc.view.bottomAnchor.constraint(equalTo: self.containerViewQuestion.bottomAnchor).isActive = true
            self.addChildViewController(vc)
            vc.didMove(toParentViewController: self)
            
            btnNextOrSubmit.setTitle("Submit", for: .normal)
            btnNextOrSubmit.removeTarget(nil, action: #selector(self.nextQuestion), for: .touchUpInside)
            btnNextOrSubmit.addTarget(nil, action: #selector(self.submitQuestion), for: .touchUpInside)
        }
    }
    
    func initAntonymQuestionView(){
        
        lblTimer.isHidden = true
        // to reload data without adding posts view over each other
        for view in containerViewQuestion.subviews{
            view.removeFromSuperview()
        }
        
        let storyboard = UIStoryboard.init(name: "Home", bundle: Bundle.main)
        if let vc  = storyboard.instantiateViewController(withIdentifier: "QuestionAntonymVC") as? AntonymQViewController {
            
            vc.questions = subsubCategory!.questions[currentQuestionIndex].data
            self.delegate = vc
            vc.view.translatesAutoresizingMaskIntoConstraints = false
            vc.willMove(toParentViewController: self)
            self.containerViewQuestion.addSubview(vc.view)
            vc.view.leadingAnchor.constraint(equalTo: self.containerViewQuestion.leadingAnchor).isActive = true
            vc.view.trailingAnchor.constraint(equalTo: self.containerViewQuestion.trailingAnchor).isActive = true
            vc.view.topAnchor.constraint(equalTo: self.containerViewQuestion.topAnchor).isActive = true
            vc.view.bottomAnchor.constraint(equalTo: self.containerViewQuestion.bottomAnchor).isActive = true
            self.addChildViewController(vc)
            vc.didMove(toParentViewController: self)
            
            btnNextOrSubmit.setTitle("Submit", for: .normal)
            btnNextOrSubmit.removeTarget(nil, action: #selector(self.nextQuestion), for: .touchUpInside)
            btnNextOrSubmit.addTarget(nil, action: #selector(self.submitQuestion), for: .touchUpInside)
        }
    }
    
    
    
    func initDictationQuestionView(){
        
        // to reload data without adding posts view over each other
        for view in containerViewQuestion.subviews{
            view.removeFromSuperview()
        }
        
        let storyboard = UIStoryboard.init(name: "Home", bundle: Bundle.main)
        if let vc  = storyboard.instantiateViewController(withIdentifier: "QuestionDictationVC") as? QuestionDictationViewController {
            
            vc.questions = subsubCategory!.questions[currentQuestionIndex].data
            self.delegate = vc
            vc.view.translatesAutoresizingMaskIntoConstraints = false
            vc.willMove(toParentViewController: self)
            self.containerViewQuestion.addSubview(vc.view)
            vc.view.leadingAnchor.constraint(equalTo: self.containerViewQuestion.leadingAnchor).isActive = true
            vc.view.trailingAnchor.constraint(equalTo: self.containerViewQuestion.trailingAnchor).isActive = true
            vc.view.topAnchor.constraint(equalTo: self.containerViewQuestion.topAnchor).isActive = true
            vc.view.bottomAnchor.constraint(equalTo: self.containerViewQuestion.bottomAnchor).isActive = true
            self.addChildViewController(vc)
            vc.didMove(toParentViewController: self)
            
            startTimer(numberOfQuestions: subsubCategory!.questions[currentQuestionIndex].data.count)
            btnNextOrSubmit.setTitle("Submit", for: .normal)
            btnNextOrSubmit.removeTarget(nil, action: #selector(self.nextQuestion), for: .touchUpInside)
            btnNextOrSubmit.addTarget(nil, action: #selector(self.submitQuestion), for: .touchUpInside)
        }
    }
    func initListeningQuestionView(){
        
        // to reload data without adding posts view over each other
        for view in containerViewQuestion.subviews{
            view.removeFromSuperview()
        }
        
        let storyboard = UIStoryboard.init(name: "Home", bundle: Bundle.main)
        if let vc  = storyboard.instantiateViewController(withIdentifier: "QuestionListeningVC") as? QuestionListeningViewController {
            
            vc.questions = subsubCategory!.questions[currentQuestionIndex].data
            vc.view.translatesAutoresizingMaskIntoConstraints = false
            vc.willMove(toParentViewController: self)
            self.containerViewQuestion.addSubview(vc.view)
            vc.view.leadingAnchor.constraint(equalTo: self.containerViewQuestion.leadingAnchor).isActive = true
            vc.view.trailingAnchor.constraint(equalTo: self.containerViewQuestion.trailingAnchor).isActive = true
            vc.view.topAnchor.constraint(equalTo: self.containerViewQuestion.topAnchor).isActive = true
            vc.view.bottomAnchor.constraint(equalTo: self.containerViewQuestion.bottomAnchor).isActive = true
            self.addChildViewController(vc)
            vc.didMove(toParentViewController: self)
        }
    }
    func initMatchQuestionView(){
        
        // to reload data without adding posts view over each other
        for view in containerViewQuestion.subviews{
            view.removeFromSuperview()
        }
        
        let storyboard = UIStoryboard.init(name: "Home", bundle: Bundle.main)
        if let vc  = storyboard.instantiateViewController(withIdentifier: "QuestionMatchVC") as? QuestionMatchViewController {
            
            vc.questions = subsubCategory!.questions[currentQuestionIndex].data
            vc.view.translatesAutoresizingMaskIntoConstraints = false
            vc.willMove(toParentViewController: self)
            self.containerViewQuestion.addSubview(vc.view)
            vc.view.leadingAnchor.constraint(equalTo: self.containerViewQuestion.leadingAnchor).isActive = true
            vc.view.trailingAnchor.constraint(equalTo: self.containerViewQuestion.trailingAnchor).isActive = true
            vc.view.topAnchor.constraint(equalTo: self.containerViewQuestion.topAnchor).isActive = true
            vc.view.bottomAnchor.constraint(equalTo: self.containerViewQuestion.bottomAnchor).isActive = true
            self.addChildViewController(vc)
            vc.didMove(toParentViewController: self)
            
            btnNextOrSubmit.setTitle("Submit", for: .normal)
            btnNextOrSubmit.removeTarget(nil, action: #selector(self.nextQuestion), for: .touchUpInside)
            btnNextOrSubmit.addTarget(nil, action: #selector(self.submitQuestion), for: .touchUpInside)
        }
    }
    func initMCQQuestionView(){
        
        // to reload data without adding posts view over each other
        for view in containerViewQuestion.subviews{
            view.removeFromSuperview()
        }
        
        let storyboard = UIStoryboard.init(name: "Home", bundle: Bundle.main)
        if let vc  = storyboard.instantiateViewController(withIdentifier: "QuestionMCQVC") as? QuestionMcqViewController {
            
            vc.questions = subsubCategory!.questions[currentQuestionIndex].data
            vc.view.translatesAutoresizingMaskIntoConstraints = false
            vc.willMove(toParentViewController: self)
            self.containerViewQuestion.addSubview(vc.view)
            vc.view.leadingAnchor.constraint(equalTo: self.containerViewQuestion.leadingAnchor).isActive = true
            vc.view.trailingAnchor.constraint(equalTo: self.containerViewQuestion.trailingAnchor).isActive = true
            vc.view.topAnchor.constraint(equalTo: self.containerViewQuestion.topAnchor).isActive = true
            vc.view.bottomAnchor.constraint(equalTo: self.containerViewQuestion.bottomAnchor).isActive = true
            self.addChildViewController(vc)
            vc.didMove(toParentViewController: self)
            
            btnNextOrSubmit.setTitle("Submit", for: .normal)
            btnNextOrSubmit.removeTarget(nil, action: #selector(self.nextQuestion), for: .touchUpInside)
            btnNextOrSubmit.addTarget(nil, action: #selector(self.submitQuestion), for: .touchUpInside)
        }
    }
    func initMiniDialogQuestionView(){
        
        // to reload data without adding posts view over each other
        for view in containerViewQuestion.subviews{
            view.removeFromSuperview()
        }
        
        let storyboard = UIStoryboard.init(name: "Home", bundle: Bundle.main)
        if let vc  = storyboard.instantiateViewController(withIdentifier: "QuestionMiniDialogVC") as? MiniDialogViewController {
            
            vc.questions = subsubCategory!.questions[currentQuestionIndex].data
            vc.view.translatesAutoresizingMaskIntoConstraints = false
            vc.willMove(toParentViewController: self)
            self.containerViewQuestion.addSubview(vc.view)
            vc.view.leadingAnchor.constraint(equalTo: self.containerViewQuestion.leadingAnchor).isActive = true
            vc.view.trailingAnchor.constraint(equalTo: self.containerViewQuestion.trailingAnchor).isActive = true
            vc.view.topAnchor.constraint(equalTo: self.containerViewQuestion.topAnchor).isActive = true
            vc.view.bottomAnchor.constraint(equalTo: self.containerViewQuestion.bottomAnchor).isActive = true
            self.addChildViewController(vc)
            vc.didMove(toParentViewController: self)
            
            btnNextOrSubmit.setTitle("Next", for: .normal)
            btnNextOrSubmit.removeTarget(nil, action: #selector(self.submitQuestion), for: .touchUpInside)
            btnNextOrSubmit.addTarget(nil, action: #selector(self.nextQuestion), for: .touchUpInside)
        }
    }
    func initMistakesQuestionView(){
        
        // to reload data without adding posts view over each other
        for view in containerViewQuestion.subviews{
            view.removeFromSuperview()
        }
        
        let storyboard = UIStoryboard.init(name: "Home", bundle: Bundle.main)
        if let vc  = storyboard.instantiateViewController(withIdentifier: "QuestionMistakesVC") as? MistakesViewController {
            
            vc.questions = subsubCategory!.questions[currentQuestionIndex].data
            vc.view.translatesAutoresizingMaskIntoConstraints = false
            vc.willMove(toParentViewController: self)
            self.containerViewQuestion.addSubview(vc.view)
            vc.view.leadingAnchor.constraint(equalTo: self.containerViewQuestion.leadingAnchor).isActive = true
            vc.view.trailingAnchor.constraint(equalTo: self.containerViewQuestion.trailingAnchor).isActive = true
            vc.view.topAnchor.constraint(equalTo: self.containerViewQuestion.topAnchor).isActive = true
            vc.view.bottomAnchor.constraint(equalTo: self.containerViewQuestion.bottomAnchor).isActive = true
            self.addChildViewController(vc)
            vc.didMove(toParentViewController: self)
            
            btnNextOrSubmit.setTitle("Submit", for: .normal)
            btnNextOrSubmit.removeTarget(nil, action: #selector(self.nextQuestion), for: .touchUpInside)
            btnNextOrSubmit.addTarget(nil, action: #selector(self.submitQuestion), for: .touchUpInside)
        }
    }
    
    func initGeneralQuestionView(){
        
        // to reload data without adding posts view over each other
        for view in containerViewQuestion.subviews{
            view.removeFromSuperview()
        }
        
        let storyboard = UIStoryboard.init(name: "Home", bundle: Bundle.main)
        if let vc  = storyboard.instantiateViewController(withIdentifier: "GeneralQuestionVC") as? GeneralQuestionViewController {
            
            vc.questions = subsubCategory!.questions[currentQuestionIndex].data
            vc.view.translatesAutoresizingMaskIntoConstraints = false
            vc.willMove(toParentViewController: self)
            self.containerViewQuestion.addSubview(vc.view)
            vc.view.leadingAnchor.constraint(equalTo: self.containerViewQuestion.leadingAnchor).isActive = true
            vc.view.trailingAnchor.constraint(equalTo: self.containerViewQuestion.trailingAnchor).isActive = true
            vc.view.topAnchor.constraint(equalTo: self.containerViewQuestion.topAnchor).isActive = true
            vc.view.bottomAnchor.constraint(equalTo: self.containerViewQuestion.bottomAnchor).isActive = true
            self.addChildViewController(vc)
            vc.didMove(toParentViewController: self)
            
            btnNextOrSubmit.setTitle("Next", for: .normal)
            btnNextOrSubmit.removeTarget(nil, action: #selector(self.submitQuestion), for: .touchUpInside)
            btnNextOrSubmit.addTarget(nil, action: #selector(self.nextQuestion), for: .touchUpInside)
        }
    }
    func initWritingQuestionView(){
        
        // to reload data without adding posts view over each other
        for view in containerViewQuestion.subviews{
            view.removeFromSuperview()
        }
        
        let storyboard = UIStoryboard.init(name: "Home", bundle: Bundle.main)
        if let vc  = storyboard.instantiateViewController(withIdentifier: "QuestionWritingVC") as? WritingViewController {
            
            vc.questions = subsubCategory!.questions[currentQuestionIndex].data
            vc.view.translatesAutoresizingMaskIntoConstraints = false
            vc.willMove(toParentViewController: self)
            self.containerViewQuestion.addSubview(vc.view)
            vc.view.leadingAnchor.constraint(equalTo: self.containerViewQuestion.leadingAnchor).isActive = true
            vc.view.trailingAnchor.constraint(equalTo: self.containerViewQuestion.trailingAnchor).isActive = true
            vc.view.topAnchor.constraint(equalTo: self.containerViewQuestion.topAnchor).isActive = true
            vc.view.bottomAnchor.constraint(equalTo: self.containerViewQuestion.bottomAnchor).isActive = true
            self.addChildViewController(vc)
            vc.didMove(toParentViewController: self)
            
            btnNextOrSubmit.setTitle("Next", for: .normal)
            btnNextOrSubmit.removeTarget(nil, action: #selector(self.submitQuestion), for: .touchUpInside)
            btnNextOrSubmit.addTarget(nil, action: #selector(self.nextQuestion), for: .touchUpInside)
        }
    }
    func initQuotationsQuestionView(){
        
        // to reload data without adding posts view over each other
        for view in containerViewQuestion.subviews{
            view.removeFromSuperview()
        }
        
        let storyboard = UIStoryboard.init(name: "Home", bundle: Bundle.main)
        if let vc  = storyboard.instantiateViewController(withIdentifier: "QuestionQuotationVC") as? QuotationViewController {
            
            vc.questions = subsubCategory!.questions[currentQuestionIndex].data
            vc.view.translatesAutoresizingMaskIntoConstraints = false
            vc.willMove(toParentViewController: self)
            self.containerViewQuestion.addSubview(vc.view)
            vc.view.leadingAnchor.constraint(equalTo: self.containerViewQuestion.leadingAnchor).isActive = true
            vc.view.trailingAnchor.constraint(equalTo: self.containerViewQuestion.trailingAnchor).isActive = true
            vc.view.topAnchor.constraint(equalTo: self.containerViewQuestion.topAnchor).isActive = true
            vc.view.bottomAnchor.constraint(equalTo: self.containerViewQuestion.bottomAnchor).isActive = true
            self.addChildViewController(vc)
            vc.didMove(toParentViewController: self)
            
            btnNextOrSubmit.setTitle("Next", for: .normal)
            btnNextOrSubmit.removeTarget(nil, action: #selector(self.submitQuestion), for: .touchUpInside)
            btnNextOrSubmit.addTarget(nil, action: #selector(self.nextQuestion), for: .touchUpInside)
        }
    }
    func initTrueFalseQuestionView(){
        
        // to reload data without adding posts view over each other
        for view in containerViewQuestion.subviews{
            view.removeFromSuperview()
        }
        
        let storyboard = UIStoryboard.init(name: "Home", bundle: Bundle.main)
        if let vc  = storyboard.instantiateViewController(withIdentifier: "QuestionTrueFalseVC") as? TrueFalseViewController {
            
            vc.questions = subsubCategory!.questions[currentQuestionIndex].data
            vc.view.translatesAutoresizingMaskIntoConstraints = false
            vc.willMove(toParentViewController: self)
            self.containerViewQuestion.addSubview(vc.view)
            vc.view.leadingAnchor.constraint(equalTo: self.containerViewQuestion.leadingAnchor).isActive = true
            vc.view.trailingAnchor.constraint(equalTo: self.containerViewQuestion.trailingAnchor).isActive = true
            vc.view.topAnchor.constraint(equalTo: self.containerViewQuestion.topAnchor).isActive = true
            vc.view.bottomAnchor.constraint(equalTo: self.containerViewQuestion.bottomAnchor).isActive = true
            self.addChildViewController(vc)
            vc.didMove(toParentViewController: self)
            
            btnNextOrSubmit.setTitle("Submit", for: .normal)
            btnNextOrSubmit.removeTarget(nil, action: #selector(self.nextQuestion), for: .touchUpInside)
            btnNextOrSubmit.addTarget(nil, action: #selector(self.submitQuestion), for: .touchUpInside)
        }
    }
    
    func startTimer(numberOfQuestions: Int){

        
        timerCounter = questionTimerUnit * numberOfQuestions
        lblTimer.text = timeString(time: TimeInterval.init(questionTimerUnit * numberOfQuestions))
        lblTimer.isHidden = false
        questionTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        
        if timerCounter == 0{
            
            questionTimer.invalidate()
            self.submitQuestion()
            
        }else{
            timerCounter -= 1
            lblTimer.text = timeString(time: TimeInterval.init(timerCounter))
        }
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String.init(format: "%02i:%02i:%02i", arguments: [hours,minutes,seconds])
    }
    
}
