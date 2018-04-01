//
//  AboutAppViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 3/8/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit
import SafariServices
import MessageUI

class AboutAppViewController: ParentViewController , MFMailComposeViewControllerDelegate{

    
    @IBOutlet var tvParagraph : UITextView!
    
    var htmlText = "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\"><HTML>\n<HEAD>\n\t<META HTTP-EQUIV=\"CONTENT-TYPE\"CONTENT=\"text/html; charset=utf-8\">\n\t<TITLE></TITLE>\n\t<META NAME=\"GENERATOR\" CONTENT=\"LibreOffice 4.1.6.2 (Linux)\">\n\t<META NAME=\"AUTHOR\" CONTENT=\"Salah Mahmoud\">\n\t<META NAME=\"CREATED\" CONTENT=\"20180217;115000000000000\">\n\t<META NAME=\"CHANGEDBY\" CONTENT=\"Dell-pc\">\n\t<META NAME=\"CHANGED\" CONTENT=\"20180217;115000000000000\">\n\t<META NAME=\"AppVersion\" CONTENT=\"14.0000\">\n\t<META NAME=\"DocSecurity\" CONTENT=\"0\">\n\t<META NAME=\"HyperlinksChanged\" CONTENT=\"false\">\n\t<META NAME=\"LinksUpToDate\" CONTENT=\"false\">\n\t<META NAME=\"ScaleCrop\" CONTENT=\"false\">\n\t<META NAME=\"ShareDoc\" CONTENT=\"false\">\n\t<STYLE TYPE=\"text/css\">\n\t</STYLE>\n</HEAD>\n<BODY LANG=\"en-US\" DIR=\"LTR\">\n<P ALIGN=JUSTIFY STYLE=\"margin-bottom: 0in; line-height: 100%\"><FONT FACE=\"serif\"><FONT SIZE=6 STYLE=\"font-size: 44pt\"><big>G</big></FONT></FONT><FONT FACE=\"serif\"><FONT SIZE=4>iven\n that “</FONT></FONT><FONT FACE=\"serif\"><FONT SIZE=4><B>A student is\n his own / her own best teacher</B></FONT></FONT><FONT FACE=\"serif\"><FONT SIZE=4>”,\n </FONT></FONT><FONT FACE=\"serif\"><FONT SIZE=4><I><B>Insight</B></I></FONT></FONT><FONT FACE=\"serif\"><FONT SIZE=4>\n adopts a unique innovated approach that enables you to customize</FONT></FONT><FONT COLOR=\"#1d2129\"><FONT FACE=\"serif\"><FONT SIZE=2 STYLE=\"font-size: 10pt\"><SPAN STYLE=\"background: #ffffff\">&nbsp;</SPAN></FONT></FONT></FONT><FONT FACE=\"serif\"><FONT SIZE=4>and\n create your own distinctive learning materials. This pioneering\n approach makes </FONT></FONT><FONT FACE=\"serif\"><FONT SIZE=4><I><B>Insight</B></I></FONT></FONT><FONT FACE=\"serif\"><FONT SIZE=4>\n the first of its kind in the Arab World.</FONT></FONT></P>\n <P ALIGN=JUSTIFY STYLE=\"margin-bottom: 0in; line-height: 100%\"><FONT FACE=\"serif\"><FONT SIZE=6 STYLE=\"font-size: 44pt\"><big>G</big></FONT></FONT><FONT FACE=\"serif\"><FONT SIZE=4>one\n are the days when a student is overwhelmed by a pile of books and\n references; </FONT></FONT><FONT FACE=\"serif\"><FONT SIZE=4><I><B>Insight</B></I></FONT></FONT><FONT FACE=\"serif\"><FONT SIZE=4>\n makes all your books, sources, references and materials immediately\n accessible anywhere and anytime.</FONT></FONT></P>\n <P ALIGN=JUSTIFY STYLE=\"margin-bottom: 0in; line-height: 100%\"><FONT FACE=\"serif\"><FONT SIZE=6 STYLE=\"font-size: 44pt\"><big>U</big></FONT></FONT><FONT FACE=\"serif\"><FONT SIZE=4>sing\n a smart digital environment, </FONT></FONT><FONT FACE=\"serif\"><FONT SIZE=4><I><B>Insight</B></I></FONT></FONT><FONT FACE=\"serif\"><FONT SIZE=4>\n provides a range of exclusive features to help you enhance and enjoy\n your learning process bringing about the best learning outcomes. </FONT></FONT>\n </P>\n <P ALIGN=JUSTIFY STYLE=\"margin-bottom: 0in; line-height: 100%\"><FONT FACE=\"serif\"><FONT SIZE=6 STYLE=\"font-size: 44pt\"><big>F</big></FONT></FONT><FONT FACE=\"serif\"><FONT SIZE=4>ar-fetched\n dreams are now accessible; now you can accomplish your study plan\n effectively with </FONT></FONT><FONT FACE=\"serif\"><FONT SIZE=4><I><B>Insight</B></I></FONT></FONT><FONT FACE=\"serif\"><FONT SIZE=4><I>.</I></FONT></FONT><FONT FACE=\"serif\"><FONT SIZE=4>\n No longer will you forget important questions; with </FONT></FONT><FONT FACE=\"serif\"><FONT SIZE=4><I><B>Insight</B></I></FONT></FONT><FONT FACE=\"serif\"><FONT SIZE=4>\n you can have them visualized with attached pictures.</FONT></FONT></P>\n <P ALIGN=JUSTIFY STYLE=\"margin-bottom: 0in; line-height: 100%\"><FONT FACE=\"serif\"><FONT SIZE=6 STYLE=\"font-size: 44pt\"><big>T</big></FONT></FONT><FONT FACE=\"serif\"><FONT SIZE=4>hrough\n this app, you can use various striking features:</FONT></FONT></P>\n <P ALIGN=JUSTIFY STYLE=\"margin-bottom: 0in; line-height: 100%\"><FONT FACE=\"serif\"><FONT SIZE=4>1.\n Have your important questions </FONT></FONT><FONT FACE=\"serif\"><FONT SIZE=4><I><B>flagged</B></I></FONT></FONT><FONT FACE=\"serif\"><FONT SIZE=4>\n into three categories.</FONT></FONT></P>\n <P ALIGN=JUSTIFY STYLE=\"margin-bottom: 0in; line-height: 100%\"><FONT FACE=\"serif\"><FONT SIZE=4>2.\n </FONT></FONT><FONT FACE=\"serif\"><FONT SIZE=4><I><B>Attach</B></I></FONT></FONT><FONT FACE=\"serif\"><FONT SIZE=4>\n a picture, audio and written notes to your important questions.</FONT></FONT></P>\n <P ALIGN=JUSTIFY STYLE=\"margin-bottom: 0in; line-height: 100%\"><FONT FACE=\"serif\"><FONT SIZE=4>3.\n Do </FONT></FONT><FONT FACE=\"serif\"><FONT SIZE=4><I><B>dictation</B></I></FONT></FONT><FONT FACE=\"serif\"><FONT SIZE=4>\n so that you can easily memorize your vocabulary.</FONT></FONT></P>\n <P ALIGN=JUSTIFY STYLE=\"margin-bottom: 0in; line-height: 100%\"><FONT FACE=\"serif\"><FONT SIZE=4>4.\n </FONT></FONT><FONT FACE=\"serif\"><FONT SIZE=4><I><B>Shuffle</B></I></FONT></FONT><FONT FACE=\"serif\"><FONT SIZE=4>\n the questions (mix the questions into a different order).</FONT></FONT></P>\n <P ALIGN=JUSTIFY STYLE=\"margin-bottom: 0in; line-height: 100%\"><FONT FACE=\"serif\"><FONT SIZE=4>5.\n </FONT></FONT><FONT FACE=\"serif\"><FONT SIZE=4><I><B>Search</B></I></FONT></FONT><FONT FACE=\"serif\"><FONT SIZE=4>\n for a word in a question or in vocabulary.</FONT></FONT></P>\n <P ALIGN=JUSTIFY STYLE=\"margin-bottom: 0in; line-height: 100%\"><FONT FACE=\"serif\"><FONT SIZE=4>6.\n Have a </FONT></FONT><FONT FACE=\"serif\"><FONT SIZE=4><I><B>track\n record</B></I></FONT></FONT><FONT FACE=\"serif\"><FONT SIZE=4> for your\n last three results.</FONT></FONT></P>\n <P ALIGN=JUSTIFY STYLE=\"margin-bottom: 0in; line-height: 100%\"><FONT FACE=\"serif\"><FONT SIZE=4>7.\n Compare your result with the </FONT></FONT><FONT FACE=\"serif\"><FONT SIZE=4><I><B>average\n results</B></I></FONT></FONT><FONT FACE=\"serif\"><FONT SIZE=4> for all\n users.</FONT></FONT></P>\n </P>\n <P ALIGN=JUSTIFY STYLE=\"margin-bottom: 0in; line-height: 100%\"><BR>\n</P>\n </BODY>\n</HTML>"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configuration()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configuration(){
        
        selectedIndex = 6
        self.title = "About App"
        addSideMenuBtn()
        self.tvParagraph.attributedText = htmlText.html2AttributedString
    }

    @IBAction func btnEmailClicked(_ sender: UIButton) {
        
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["info@insight-academy.site"])
            present(mail, animated: true)
        }

    }
 
    @IBAction func btnFbClicked(_ sender: UIButton) {
        
        if let url = URL(string: "https://www.facebook.com/InsightAcademy" ){
            
            let svc = SFSafariViewController(url: url)
            svc.preferredBarTintColor = ColorMainBlue
            svc.preferredControlTintColor = .white
            if #available(iOS 11.0, *) {
                svc.dismissButtonStyle = .close
            }
            self.present(svc, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
