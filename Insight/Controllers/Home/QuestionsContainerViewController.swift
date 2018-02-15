//
//  QuestionsContainerViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/2/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class QuestionsContainerViewController: UIViewController {

    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var containerViewQuestion: UIView!
    @IBOutlet var btnNextOrSubmit: UIButton!
    @IBOutlet var btnPrevious: UIButton!
    
    var subsubCategory : SubSubCategory?
    var currentQuestionIndex = 0
    var isNext = true
    
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
    
    @IBAction func btnNextSubmitClicked(_ sender: UIButton) {
        
        if currentQuestionIndex < subsubCategory!.questions.count - 1{
            isNext = true
            currentQuestionIndex += 1
            presentQuestions(currentQuestion: currentQuestionIndex)
        }
        
    }
    @IBAction func btnPreviousClicked(_ sender: UIButton) {
        
        if currentQuestionIndex > 0{
            isNext = false
            currentQuestionIndex -= 1
            presentQuestions(currentQuestion: currentQuestionIndex)
            
        }else{
            
            self.dismiss(animated: true, completion: nil)
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
                
            case QuestionTypes.Listening.rawValue?:
                //push
                break
                
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
                
            case QuestionTypes.Rewrite.rawValue?:
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
                        
                        self.btnNextSubmitClicked(self.btnNextOrSubmit)
                    }else{
                        
                        self.btnPreviousClicked(self.btnPrevious)
                    }
                })
                break
                
            }
        }
        
    }
    
    func initCompleteQuestionsView(){
        
        // to reload data without adding posts view over each other
        for view in containerViewQuestion.subviews{
            view.removeFromSuperview()
        }
        
        let storyboard = UIStoryboard.init(name: "Home", bundle: Bundle.main)
        if let vc  = storyboard.instantiateViewController(withIdentifier: "QuestionCompleteVC") as? QuestionCompleteViewController {
            
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
    
    func initAntonymQuestionView(){
        
        // to reload data without adding posts view over each other
        for view in containerViewQuestion.subviews{
            view.removeFromSuperview()
        }
        
        let storyboard = UIStoryboard.init(name: "Home", bundle: Bundle.main)
        if let vc  = storyboard.instantiateViewController(withIdentifier: "QuestionAntonymVC") as? AntonymQViewController {
            
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
    func initDictationQuestionView(){
        
        // to reload data without adding posts view over each other
        for view in containerViewQuestion.subviews{
            view.removeFromSuperview()
        }
        
        let storyboard = UIStoryboard.init(name: "Home", bundle: Bundle.main)
        if let vc  = storyboard.instantiateViewController(withIdentifier: "QuestionDictationVC") as? QuestionDictationViewController {
            
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
        }
    }
    func initQuotationsQuestionView(){
        
        // to reload data without adding posts view over each other
        for view in containerViewQuestion.subviews{
            view.removeFromSuperview()
        }
        
        let storyboard = UIStoryboard.init(name: "Home", bundle: Bundle.main)
        if let vc  = storyboard.instantiateViewController(withIdentifier: "QuestionQuotationVC") as? QuotationViewController {
            
//            vc.questions = subsubCategory!.questions[currentQuestion].data
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
    func initTrueFalseQuestionView(){
        
        // to reload data without adding posts view over each other
        for view in containerViewQuestion.subviews{
            view.removeFromSuperview()
        }
        
        let storyboard = UIStoryboard.init(name: "Home", bundle: Bundle.main)
        if let vc  = storyboard.instantiateViewController(withIdentifier: "QuestionTrueFalseVC") as? TrueFalseViewController {
            
//            vc.questions = subsubCategory!.questions[currentQuestion].data
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
    
}
