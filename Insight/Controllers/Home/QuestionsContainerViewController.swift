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

class QuestionsContainerViewController: ParentViewController {

    @IBOutlet var lblTimer: UILabel!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var containerViewQuestion: UIView!
    @IBOutlet var btnNextOrSubmit: UIButton!
    @IBOutlet var btnPrevious: UIButton!
    
    var isKeyboard = false
    var subsubCategory : SubSubCategory?
    var currentQuestionIndex = 0
    var isNext = true
    weak var delegate : CorrectedQuestion?
    var questionTimer = Timer()
    var timerCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configuration()
        if subsubCategory != nil {
            
            self.presentQuestions(currentQuestion: self.currentQuestionIndex)
            
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
    
    func configuration(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if !isKeyboard {
                self.view.frame.size.height -= keyboardSize.height
                isKeyboard = !isKeyboard
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if isKeyboard{
                self.view.frame.size.height += keyboardSize.height
                isKeyboard = !isKeyboard
            }
        }
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func nextQuestion() {
        
        if currentQuestionIndex < subsubCategory!.questions.count - 1{
            isNext = true
            currentQuestionIndex += 1
            lblTimer.isHidden = true
            hideLoading()
            btnPrevious.isEnabled = false
            btnNextOrSubmit.isEnabled = false
            presentQuestions(currentQuestion: currentQuestionIndex)
        }
        
    }
    
    @objc func submitQuestion(){
        
        if delegate != nil{
            
            questionTimer.invalidate()
                        
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
            
            btnPrevious.isEnabled = false
            btnNextOrSubmit.isEnabled = false
            isNext = false
            currentQuestionIndex -= 1
            presentQuestions(currentQuestion: currentQuestionIndex)
            
        }else{
            
            self.navigationController?.popViewController(animated: true)
        }
        
        
    }
    
    func presentQuestions(currentQuestion : Int){
        
        showLoaderFor(view: self.view)
        
        if subsubCategory!.questions != nil && subsubCategory!.questions!.count > currentQuestion{
            self.lblTitle.text = self.subsubCategory?.questions[currentQuestion].title
            
            // to reload data without adding posts view over each other
            for view in self.containerViewQuestion.subviews{
                view.removeFromSuperview()
            }
            
            DispatchQueue.global(qos: .userInitiated).async {
            
                //
                print("This is run on the background queue")
                
                switch self.subsubCategory?.questions[currentQuestion].type {
                    
                case QuestionTypes.Antonym.rawValue?:
                    self.initAntonymQuestionView()
                    break
                    
                case QuestionTypes.Complete.rawValue?:
                    self.initCompleteQuestionsView()
                    break
                    
                case QuestionTypes.Dictation.rawValue?:
                    self.initDictationQuestionView()
                    break
                    
                case QuestionTypes.Match.rawValue?:
                    self.initMatchQuestionView()
                    break
                    
                case QuestionTypes.MCQ.rawValue?:
                    self.initMCQQuestionView()
                    break
                    
                case QuestionTypes.MiniDialog.rawValue?:
                    self.initMiniDialogQuestionView()
                    break
                    
                case QuestionTypes.Mistakes.rawValue?:
                    self.initMistakesQuestionView()
                    break
                    
                case QuestionTypes.Rewrite.rawValue?:
                    self.initGeneralQuestionView()
                    break
                    
                case QuestionTypes.Situations.rawValue?:
                    self.initGeneralQuestionView()
                    break
                    
                case QuestionTypes.Translation.rawValue?:
                    self.initGeneralQuestionView()
                    break
                    
                case QuestionTypes.Writing.rawValue?:
                    self.initWritingQuestionView()
                    break
                    
                case QuestionTypes.Prereading.rawValue?:
                    self.initGeneralQuestionView()
                    break
                    
                case QuestionTypes.Quotations.rawValue?:
                    self.initQuotationsQuestionView()
                    break
                    
                case QuestionTypes.TrueFalse.rawValue?:
                    self.initTrueFalseQuestionView()
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
                //
            }
        
        }
        
    }
    
    func initCompleteQuestionsView(){
        
        DispatchQueue.main.async {
            self.lblTimer.isHidden = true
        }
        
        let storyboard = UIStoryboard.init(name: "Home", bundle: Bundle.main)
        if let vc  = storyboard.instantiateViewController(withIdentifier: "QuestionCompleteVC") as? QuestionCompleteViewController {
            
            vc.questions = subsubCategory!.questions[currentQuestionIndex].data
            self.delegate = vc
            vc.willMove(toParentViewController: self)
            
            DispatchQueue.main.async {
                vc.view.translatesAutoresizingMaskIntoConstraints = false

                self.containerViewQuestion.addSubview(vc.view)
                vc.view.leadingAnchor.constraint(equalTo: self.containerViewQuestion.leadingAnchor).isActive = true
                vc.view.trailingAnchor.constraint(equalTo: self.containerViewQuestion.trailingAnchor).isActive = true
                vc.view.topAnchor.constraint(equalTo: self.containerViewQuestion.topAnchor).isActive = true
                vc.view.bottomAnchor.constraint(equalTo: self.containerViewQuestion.bottomAnchor).isActive = true
                self.btnNextOrSubmit.setTitle("Submit", for: .normal)
                self.btnNextOrSubmit.removeTarget(nil, action: #selector(self.nextQuestion), for: .touchUpInside)
                self.btnNextOrSubmit.addTarget(nil, action: #selector(self.submitQuestion), for: .touchUpInside)
                hideLoaderFor(view: self.view)
                self.btnPrevious.isEnabled = true
                self.btnNextOrSubmit.isEnabled = true
            }
            
            self.addChildViewController(vc)
            vc.didMove(toParentViewController: self)
            
            
        }
    }
    
    func initAntonymQuestionView(){
        
        DispatchQueue.main.async {
            self.lblTimer.isHidden = true
        }
        
        let storyboard = UIStoryboard.init(name: "Home", bundle: Bundle.main)
        if let vc  = storyboard.instantiateViewController(withIdentifier: "QuestionAntonymVC") as? AntonymQViewController {
            
            vc.questions = subsubCategory!.questions[currentQuestionIndex].data
            self.delegate = vc
            vc.willMove(toParentViewController: self)
            
            DispatchQueue.main.async{
                vc.view.translatesAutoresizingMaskIntoConstraints = false

                self.containerViewQuestion.addSubview(vc.view)
                vc.view.leadingAnchor.constraint(equalTo: self.containerViewQuestion.leadingAnchor).isActive = true
                vc.view.trailingAnchor.constraint(equalTo: self.containerViewQuestion.trailingAnchor).isActive = true
                vc.view.topAnchor.constraint(equalTo: self.containerViewQuestion.topAnchor).isActive = true
                vc.view.bottomAnchor.constraint(equalTo: self.containerViewQuestion.bottomAnchor).isActive = true
                self.btnNextOrSubmit.setTitle("Submit", for: .normal)
                self.btnNextOrSubmit.removeTarget(nil, action: #selector(self.nextQuestion), for: .touchUpInside)
                self.btnNextOrSubmit.addTarget(nil, action: #selector(self.submitQuestion), for: .touchUpInside)
                
                hideLoaderFor(view: self.view)
                self.btnPrevious.isEnabled = true
                self.btnNextOrSubmit.isEnabled = true
            }
            
            self.addChildViewController(vc)
            vc.didMove(toParentViewController: self)
            
            
        }
    }
    
    
    
    func initDictationQuestionView(){
        
        
        let storyboard = UIStoryboard.init(name: "Home", bundle: Bundle.main)
        if let vc  = storyboard.instantiateViewController(withIdentifier: "QuestionDictationVC") as? QuestionDictationViewController {
            
            vc.questions = subsubCategory!.questions[currentQuestionIndex].data
            self.delegate = vc
            vc.willMove(toParentViewController: self)
            
            DispatchQueue.main.async{
                vc.view.translatesAutoresizingMaskIntoConstraints = false

                self.containerViewQuestion.addSubview(vc.view)
                vc.view.leadingAnchor.constraint(equalTo: self.containerViewQuestion.leadingAnchor).isActive = true
                vc.view.trailingAnchor.constraint(equalTo: self.containerViewQuestion.trailingAnchor).isActive = true
                vc.view.topAnchor.constraint(equalTo: self.containerViewQuestion.topAnchor).isActive = true
                vc.view.bottomAnchor.constraint(equalTo: self.containerViewQuestion.bottomAnchor).isActive = true
                
                self.startTimer(numberOfQuestions: self.subsubCategory!.questions[self.currentQuestionIndex].data.count)
                self.btnNextOrSubmit.setTitle("Submit", for: .normal)
                self.btnNextOrSubmit.removeTarget(nil, action: #selector(self.nextQuestion), for: .touchUpInside)
                self.btnNextOrSubmit.addTarget(nil, action: #selector(self.submitQuestion), for: .touchUpInside)
                
                hideLoaderFor(view: self.view)
                self.btnPrevious.isEnabled = true
                self.btnNextOrSubmit.isEnabled = true
            }
    
            self.addChildViewController(vc)
            vc.didMove(toParentViewController: self)
            
            
        }
    }

    func initMatchQuestionView(){
        
        let storyboard = UIStoryboard.init(name: "Home", bundle: Bundle.main)
        if let vc  = storyboard.instantiateViewController(withIdentifier: "QuestionMatchVC") as? QuestionMatchViewController {
            
            vc.questions = subsubCategory!.questions[currentQuestionIndex].data
            self.delegate = vc
            vc.willMove(toParentViewController: self)
            
            DispatchQueue.main.async{
                vc.view.translatesAutoresizingMaskIntoConstraints = false

                self.containerViewQuestion.addSubview(vc.view)
                vc.view.leadingAnchor.constraint(equalTo: self.containerViewQuestion.leadingAnchor).isActive = true
                vc.view.trailingAnchor.constraint(equalTo: self.containerViewQuestion.trailingAnchor).isActive = true
                vc.view.topAnchor.constraint(equalTo: self.containerViewQuestion.topAnchor).isActive = true
                vc.view.bottomAnchor.constraint(equalTo: self.containerViewQuestion.bottomAnchor).isActive = true
                
                self.btnNextOrSubmit.setTitle("Submit", for: .normal)
                self.btnNextOrSubmit.removeTarget(nil, action: #selector(self.nextQuestion), for: .touchUpInside)
                self.btnNextOrSubmit.addTarget(nil, action: #selector(self.submitQuestion), for: .touchUpInside)
                
                hideLoaderFor(view: self.view)
                self.btnPrevious.isEnabled = true
                self.btnNextOrSubmit.isEnabled = true
            }
            
            self.addChildViewController(vc)
            vc.didMove(toParentViewController: self)
            
            
        }
    }
    func initMCQQuestionView(){
    
        
        let storyboard = UIStoryboard.init(name: "Home", bundle: Bundle.main)
        if let vc  = storyboard.instantiateViewController(withIdentifier: "QuestionMCQVC") as? QuestionMcqViewController {
            
            vc.questions = subsubCategory!.questions[currentQuestionIndex].data
            self.delegate = vc
            vc.containerDelegate = self
            vc.willMove(toParentViewController: self)
            
            var mcqCounter = 0
            for question in 0..<subsubCategory!.questions[currentQuestionIndex].data.count{
                for _ in 0..<subsubCategory!.questions[currentQuestionIndex].data[question].choices.count{
                    
                    mcqCounter += 1
                }
            }
            
            DispatchQueue.main.async {
                vc.view.translatesAutoresizingMaskIntoConstraints = false
            
                self.containerViewQuestion.addSubview(vc.view)
                
                vc.view.leadingAnchor.constraint(equalTo: self.containerViewQuestion.leadingAnchor).isActive = true
                vc.view.trailingAnchor.constraint(equalTo: self.containerViewQuestion.trailingAnchor).isActive = true
                vc.view.topAnchor.constraint(equalTo: self.containerViewQuestion.topAnchor).isActive = true
                vc.view.bottomAnchor.constraint(equalTo: self.containerViewQuestion.bottomAnchor).isActive = true
                
                self.startTimer(numberOfQuestions: mcqCounter)
                self.btnNextOrSubmit.setTitle("Submit", for: .normal)
                self.btnNextOrSubmit.removeTarget(nil, action: #selector(self.nextQuestion), for: .touchUpInside)
                self.btnNextOrSubmit.addTarget(nil, action: #selector(self.submitQuestion), for: .touchUpInside)
                
                hideLoaderFor(view: self.view)
                self.btnPrevious.isEnabled = true
                self.btnNextOrSubmit.isEnabled = true
            }
            
            self.addChildViewController(vc)
            vc.didMove(toParentViewController: self)
            
            
        }
    }
    func initMiniDialogQuestionView(){
        
        let storyboard = UIStoryboard.init(name: "Home", bundle: Bundle.main)
        if let vc  = storyboard.instantiateViewController(withIdentifier: "QuestionMiniDialogVC") as? MiniDialogViewController {
            
            vc.questions = subsubCategory!.questions[currentQuestionIndex].data
            vc.willMove(toParentViewController: self)
            
            DispatchQueue.main.async {
                vc.view.translatesAutoresizingMaskIntoConstraints = false

                self.containerViewQuestion.addSubview(vc.view)
                vc.view.leadingAnchor.constraint(equalTo: self.containerViewQuestion.leadingAnchor).isActive = true
                vc.view.trailingAnchor.constraint(equalTo: self.containerViewQuestion.trailingAnchor).isActive = true
                vc.view.topAnchor.constraint(equalTo: self.containerViewQuestion.topAnchor).isActive = true
                vc.view.bottomAnchor.constraint(equalTo: self.containerViewQuestion.bottomAnchor).isActive = true
                self.btnNextOrSubmit.setTitle("Next", for: .normal)
                self.btnNextOrSubmit.removeTarget(nil, action: #selector(self.submitQuestion), for: .touchUpInside)
                self.btnNextOrSubmit.addTarget(nil, action: #selector(self.nextQuestion), for: .touchUpInside)
                
                hideLoaderFor(view: self.view)
                self.btnPrevious.isEnabled = true
                self.btnNextOrSubmit.isEnabled = true
            }
        
            self.addChildViewController(vc)
            vc.didMove(toParentViewController: self)
            
            
        }
    }
    func initMistakesQuestionView(){
        
        let storyboard = UIStoryboard.init(name: "Home", bundle: Bundle.main)
        if let vc  = storyboard.instantiateViewController(withIdentifier: "QuestionMistakesVC") as? MistakesViewController {
            
            vc.questions = subsubCategory!.questions[currentQuestionIndex].data
            self.delegate = vc
            vc.willMove(toParentViewController: self)
            
            var mistakesCounter = 0
            for question in 0..<subsubCategory!.questions[currentQuestionIndex].data.count{
                for _ in 0..<subsubCategory!.questions[currentQuestionIndex].data[question].mistakes.count{
                    
                    mistakesCounter += 1
                }
            }
            
            DispatchQueue.main.async{
                vc.view.translatesAutoresizingMaskIntoConstraints = false

                self.containerViewQuestion.addSubview(vc.view)
                vc.view.leadingAnchor.constraint(equalTo: self.containerViewQuestion.leadingAnchor).isActive = true
                vc.view.trailingAnchor.constraint(equalTo: self.containerViewQuestion.trailingAnchor).isActive = true
                vc.view.topAnchor.constraint(equalTo: self.containerViewQuestion.topAnchor).isActive = true
                vc.view.bottomAnchor.constraint(equalTo: self.containerViewQuestion.bottomAnchor).isActive = true
                
                self.startTimer(numberOfQuestions: mistakesCounter)
                self.btnNextOrSubmit.setTitle("Submit", for: .normal)
                self.btnNextOrSubmit.removeTarget(nil, action: #selector(self.nextQuestion), for: .touchUpInside)
                self.btnNextOrSubmit.addTarget(nil, action: #selector(self.submitQuestion), for: .touchUpInside)
                
                hideLoaderFor(view: self.view)
                self.btnPrevious.isEnabled = true
                self.btnNextOrSubmit.isEnabled = true
                
            }
    
            self.addChildViewController(vc)
            vc.didMove(toParentViewController: self)
            
        }
    }
    
    func initGeneralQuestionView(){
        

        let storyboard = UIStoryboard.init(name: "Home", bundle: Bundle.main)
        if let vc  = storyboard.instantiateViewController(withIdentifier: "GeneralQuestionVC") as? GeneralQuestionViewController {
            
            vc.questions = subsubCategory!.questions[currentQuestionIndex].data
            vc.willMove(toParentViewController: self)
            
            DispatchQueue.main.async{
                vc.view.translatesAutoresizingMaskIntoConstraints = false
                self.containerViewQuestion.addSubview(vc.view)
                vc.view.leadingAnchor.constraint(equalTo: self.containerViewQuestion.leadingAnchor).isActive = true
                vc.view.trailingAnchor.constraint(equalTo: self.containerViewQuestion.trailingAnchor).isActive = true
                vc.view.topAnchor.constraint(equalTo: self.containerViewQuestion.topAnchor).isActive = true
                vc.view.bottomAnchor.constraint(equalTo: self.containerViewQuestion.bottomAnchor).isActive = true
             
                self.btnNextOrSubmit.setTitle("Next", for: .normal)
                self.btnNextOrSubmit.removeTarget(nil, action: #selector(self.submitQuestion), for: .touchUpInside)
                self.btnNextOrSubmit.addTarget(nil, action: #selector(self.nextQuestion), for: .touchUpInside)
                
                hideLoaderFor(view: self.view)
                self.btnPrevious.isEnabled = true
                self.btnNextOrSubmit.isEnabled = true
            }
            
            self.addChildViewController(vc)
            vc.didMove(toParentViewController: self)
            
            
        }
    }
    func initWritingQuestionView(){
        
        
        let storyboard = UIStoryboard.init(name: "Home", bundle: Bundle.main)
        if let vc  = storyboard.instantiateViewController(withIdentifier: "QuestionWritingVC") as? WritingViewController {
            
            vc.questions = subsubCategory!.questions[currentQuestionIndex].data
            vc.willMove(toParentViewController: self)
            
            DispatchQueue.main.async{
                vc.view.translatesAutoresizingMaskIntoConstraints = false

                self.containerViewQuestion.addSubview(vc.view)
                vc.view.leadingAnchor.constraint(equalTo: self.containerViewQuestion.leadingAnchor).isActive = true
                vc.view.trailingAnchor.constraint(equalTo: self.containerViewQuestion.trailingAnchor).isActive = true
                vc.view.topAnchor.constraint(equalTo: self.containerViewQuestion.topAnchor).isActive = true
                vc.view.bottomAnchor.constraint(equalTo: self.containerViewQuestion.bottomAnchor).isActive = true
                
                self.btnNextOrSubmit.setTitle("Next", for: .normal)
                self.btnNextOrSubmit.removeTarget(nil, action: #selector(self.submitQuestion), for: .touchUpInside)
                self.btnNextOrSubmit.addTarget(nil, action: #selector(self.nextQuestion), for: .touchUpInside)
                
                hideLoaderFor(view: self.view)
                self.btnPrevious.isEnabled = true
                self.btnNextOrSubmit.isEnabled = true
                
            }
            
            self.addChildViewController(vc)
            vc.didMove(toParentViewController: self)
            
            
        }
    }
    func initQuotationsQuestionView(){
        
        
        let storyboard = UIStoryboard.init(name: "Home", bundle: Bundle.main)
        if let vc  = storyboard.instantiateViewController(withIdentifier: "QuestionQuotationVC") as? QuotationViewController {
            
            vc.questions = subsubCategory!.questions[currentQuestionIndex].data
            vc.willMove(toParentViewController: self)
            
            DispatchQueue.main.async{
                vc.view.translatesAutoresizingMaskIntoConstraints = false

                self.containerViewQuestion.addSubview(vc.view)
                vc.view.leadingAnchor.constraint(equalTo: self.containerViewQuestion.leadingAnchor).isActive = true
                vc.view.trailingAnchor.constraint(equalTo: self.containerViewQuestion.trailingAnchor).isActive = true
                vc.view.topAnchor.constraint(equalTo: self.containerViewQuestion.topAnchor).isActive = true
                vc.view.bottomAnchor.constraint(equalTo: self.containerViewQuestion.bottomAnchor).isActive = true
                
                self.btnNextOrSubmit.setTitle("Next", for: .normal)
                self.btnNextOrSubmit.removeTarget(nil, action: #selector(self.submitQuestion), for: .touchUpInside)
                self.btnNextOrSubmit.addTarget(nil, action: #selector(self.nextQuestion), for: .touchUpInside)
                
                hideLoaderFor(view: self.view)
                self.btnPrevious.isEnabled = true
                self.btnNextOrSubmit.isEnabled = true
            }
            
            self.addChildViewController(vc)
            vc.didMove(toParentViewController: self)
            
        }
    }
    func initTrueFalseQuestionView(){
        
        
        let storyboard = UIStoryboard.init(name: "Home", bundle: Bundle.main)
        if let vc  = storyboard.instantiateViewController(withIdentifier: "QuestionTrueFalseVC") as? TrueFalseViewController {
            
            vc.questions = subsubCategory!.questions[currentQuestionIndex].data
            self.delegate = vc
            vc.willMove(toParentViewController: self)
            
            DispatchQueue.main.async{
                vc.view.translatesAutoresizingMaskIntoConstraints = false

                self.containerViewQuestion.addSubview(vc.view)
                vc.view.leadingAnchor.constraint(equalTo: self.containerViewQuestion.leadingAnchor).isActive = true
                vc.view.trailingAnchor.constraint(equalTo: self.containerViewQuestion.trailingAnchor).isActive = true
                vc.view.topAnchor.constraint(equalTo: self.containerViewQuestion.topAnchor).isActive = true
                vc.view.bottomAnchor.constraint(equalTo: self.containerViewQuestion.bottomAnchor).isActive = true
                
                self.btnNextOrSubmit.setTitle("Submit", for: .normal)
                self.btnNextOrSubmit.removeTarget(nil, action: #selector(self.nextQuestion), for: .touchUpInside)
                self.btnNextOrSubmit.addTarget(nil, action: #selector(self.submitQuestion), for: .touchUpInside)
                
                hideLoaderFor(view: self.view)
                self.btnPrevious.isEnabled = true
                self.btnNextOrSubmit.isEnabled = true
            }
            
            self.addChildViewController(vc)
            vc.didMove(toParentViewController: self)
            
            
        }
    }
    
    func startTimer(numberOfQuestions: Int){

        timerCounter = questionTimerUnit * numberOfQuestions
        lblTimer.text = timeString(time: TimeInterval.init(questionTimerUnit * numberOfQuestions))
        lblTimer.isHidden = false
        self.questionTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)


    }
    
    @objc func updateTimer(){
        
        if timerCounter == 0{
            
            questionTimer.invalidate()
            self.submitQuestion()
            
        }else{
            
            self.timerCounter -= 1
            self.lblTimer.text = self.timeString(time: TimeInterval.init(self.timerCounter))
        }
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String.init(format: "%02i:%02i:%02i", arguments: [hours,minutes,seconds])
    }
    
}
