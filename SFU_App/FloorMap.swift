//
//  FloorMap.swift
//  SFU_App
//
//  Created by Daniel Russell on 2015-04-12.
//  Copyright (c) 2015 Hugo Cheng. All rights reserved.
//

import Foundation
import UIKit

class FloorMap: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var scrollView: UIScrollView!
    var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // if floors are available but floor plans are not tell user
        if (building == "AQ" || building == "ASB" ){
            let alertController = UIAlertController(title: "Error", message: "Floor plans under construction", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            self.presentViewController(alertController, animated: true, completion: nil)
            return;
        }
        let image = UIImage(named: "\(building)_\(level).png")!
        imageView = UIImageView(image: image)
        /*var newSize = image.size
        newSize.height = newSize.height*2
        newSize.width = newSize.width*2*/
        imageView.frame = CGRectMake(0.0, 0.0, image.size.width, image.size.height)
        
        // set up scroll view dimensions
        scrollView.addSubview(imageView)
        scrollView.contentSize = image.size
        
        // recognize double tap
        var doubleTapRecognizer = UITapGestureRecognizer(target: self, action: "scrollViewDoubleTapped:")
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.numberOfTouchesRequired = 1
        scrollView.addGestureRecognizer(doubleTapRecognizer)
        
        // start zoom set up
        let scrollViewFrame = scrollView.frame
        let scaleWidth = scrollViewFrame.size.width / scrollView.contentSize.width
        let scaleHeight = scrollViewFrame.size.height / scrollView.contentSize.height
        let minScale = max(scaleWidth, scaleHeight);
        scrollView.minimumZoomScale = minScale;
        
        // make zoom work
        scrollView.maximumZoomScale = 1.0
        scrollView.zoomScale = minScale;
        
        // centre the image
        centerScrollViewContents()
        
    }
    
    // centre the image
    func centerScrollViewContents() {
        let boundsSize = scrollView.bounds.size
        var contentsFrame = imageView.frame
        
        if contentsFrame.size.width < boundsSize.width {
            contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0
        } else {
            contentsFrame.origin.x = 0.0
        }
        
        if contentsFrame.size.height < boundsSize.height {
            contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0
        } else {
            contentsFrame.origin.y = 0.0
        }
        
        imageView.frame = contentsFrame
        
    }
    
    func scrollViewDoubleTapped(recognizer: UITapGestureRecognizer) {
        // set up image view
        let pointInView = recognizer.locationInView(imageView)
        
        // set up zoom scale
        var newZoomScale = scrollView.zoomScale * 1.5
        newZoomScale = min(newZoomScale, scrollView.maximumZoomScale)
        
        // set scroll view bounds
        let scrollViewSize = scrollView.bounds.size
        let w = scrollViewSize.width / newZoomScale
        let h = scrollViewSize.height / newZoomScale
        let x = pointInView.x - (w / 2.0)
        let y = pointInView.y - (h / 2.0)
        
        let rectToZoomTo = CGRectMake(x, y, w, h);
        
        // set up scroll animations
        scrollView.zoomToRect(rectToZoomTo, animated: true)
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView!) -> UIView! {
        return imageView
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView!) {
        centerScrollViewContents()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
