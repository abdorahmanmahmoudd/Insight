
import UIKit


//let contentJsonURL = "http://www.insight-academy.site/insight.json"
let contentJsonURL = "http://www.mtech-ins.com/insightios.json"
let MainIP = "http://www.insight-academy.site/api/v1/"
let SignUpURL = "\(MainIP)auth/signup"
let SignInURL = "\(MainIP)auth/login"
let LogOutURL = "\(MainIP)auth/logout"
let ForgetPassURL = "\(MainIP)auth/password/forget"
let EditProfileURL = "\(MainIP)users"
let ChangePasswordURL = "\(MainIP)password"
let UpdateScoreURL = "\(MainIP)score/create"
let GetScoreURL = "\(MainIP)score"
let GetPackagesURL = "\(MainIP)packages"
let GetUserPackagesURL = "\(MainIP)userspackages"
let ValidateCodeURL = "\(MainIP)promocodes/validate?code="
let CreatePackageURL = "\(MainIP)userspackages"
let FileSizeURL = "\(MainIP)filesize"
let PassConfirmationCodeURL = "\(MainIP)auth/password/confirm"
let UpdatePassURL = "\(MainIP)auth/password/update"
let fawryURL = "\(MainIP)payment/fawry/view"
let RefreshTokenURL = "\(MainIP)auth/refresh"


//MARK: - Colors
let ColorMainBlue = UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1)
let ColorUnlockedSubItemDarkGray = UIColor(red: 103/255, green: 103/255, blue: 103/255, alpha: 1)
let ColorlockedSubItemGray = UIColor(red: 178/255, green: 178/255, blue: 178/255, alpha: 1)
let ColorLightGray = UIColor(red: 142/255, green: 142/255, blue: 147/255, alpha: 1)
let ColorBlack = UIColor(red: 44/255, green: 44/255, blue: 44/255, alpha: 1.0)
let ColorGrayForPlaceHolders = UIColor(red: 44/255, green: 44/255, blue: 44/255, alpha: 0.5)
let Colorwhite50 = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
let ColorGrayBackground = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0)
let ColorGreenForValidationLabels = UIColor(red: 20/255, green: 130/255, blue: 86/255, alpha: 1.0)
let ColorBalckForViewsBorder = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.2)
let ColorGreenForButtons = UIColor(red: 64/255, green: 152/255, blue: 91/255, alpha: 1)

//MARK: - UserDefaults
let UserCredentials = "UserCredentials"


//MARK: - Constants
let appVersion = "1"
let pageSize = 10
let MavenProMedium = "mavenPro-Medium"
let MavenProBold = "mavenPro-Bold"

let jsonContentFileDirectory = "InsightContentFile.json"
let InsightAppNoteKey = "InsightAppNoteKey"
let InsightFileSizeKey = "InsightFileSize"
var firebaseToken = ""

let questionTimerUnit = 30


