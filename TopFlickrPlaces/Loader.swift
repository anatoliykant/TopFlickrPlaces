import UIKit
import MBProgressHUD

class Loader: NSObject {
    
    func Show(message: String = "Processing...",delegate: UIViewController, time: Float){
        var load : MBProgressHUD = MBProgressHUD()
        load = MBProgressHUD.showHUDAddedTo(delegate.view, animated: true)
        load.mode = MBProgressHUDMode.Indeterminate
        if(message != "")
        {
            load.labelText = message;
            load.minShowTime = time
            //let spiningActivity = MBProgressHUD.showHUDAddedTo(view, animated: animated)
            //spiningActivity.activityIndicatorColor = UIColor.blueColor()
            //            spiningActivity.labelText = "Загрузка..."
            //            spiningActivity.minShowTime = 2

        }
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true        
    }
    
     func Hide(delegate:UIViewController){
        MBProgressHUD.hideHUDForView(delegate.view, animated: true)
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
}