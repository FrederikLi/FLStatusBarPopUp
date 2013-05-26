//
//  FLStatusBarPopUp.h
//  AwesomeMenu
//
//  Created by Frederik Lipfert on 26.05.13.
//
//

#import <UIKit/UIKit.h>

@interface FLStatusBarPopUp : UIView
{
    UIView *labelPlusIndicator;
    UIApplication *app;
}

+(FLStatusBarPopUp *)sharedFLStatusBarPopUp;

@property (nonatomic) BOOL popUpStaysInfinite;

// Only function needed to show StatusBarPopUp. If stayInfinite is set to YES, forDuration is being ignored. Still a valid double needs to be entered.
- (void)showPopUpWithMessage:(NSString *)message forDuration:(double)showtime stayInfinite:(BOOL)stayInfinite withActivityIndicator:(BOOL)activity;

// Call this function to dismiss StatusBarPopUp. Will only dismiss StatusBarPopUp though if stayInfinite was set to yes, because otherwise the StatusBarPopUp will dismiss itself after the defined period forDuration.
-(void)dismissPopUp;

@end
