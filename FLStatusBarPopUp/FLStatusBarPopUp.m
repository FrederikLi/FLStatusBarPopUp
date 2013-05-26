//
//  FLStatusBarPopUp.m
//  AwesomeMenu
//
//  Created by Frederik Lipfert on 26.05.13.
//
//

#import "FLStatusBarPopUp.h"
#import <QuartzCore/QuartzCore.h>

@implementation FLStatusBarPopUp

@synthesize popUpStaysInfinite;

static FLStatusBarPopUp* _sharedFLStatusBarPopUp = nil;

+(FLStatusBarPopUp *)sharedFLStatusBarPopUp
{
	@synchronized([FLStatusBarPopUp class])
	{
		if (!_sharedFLStatusBarPopUp)
			(void)[[self alloc] init];
        
		return _sharedFLStatusBarPopUp;
	}
	return nil;
}

+(id)alloc
{
	@synchronized([FLStatusBarPopUp class])
	{
		NSAssert(_sharedFLStatusBarPopUp == nil, @"Attempted to allocate a second instance of a singleton.");
		_sharedFLStatusBarPopUp = [super alloc];
		return _sharedFLStatusBarPopUp;
	}
	return nil;
}

- (id)init
{
    self = [super initWithFrame:CGRectMake(0, 20, 320, 40)];
    if (self) {
        // Set your background color here
        self.backgroundColor = [UIColor colorWithRed:37.0/255.0 green:170.0/255.0 blue:225.0/255.0 alpha:1.000];
        self.alpha = 1.0f;
        // Set corner Radius here. If you want rounded corners, like in the mailboxapp you need to do the following. The easiest way to do it, is set the view controller background to clearColor and add another UIView to your ViewController with rounded corners and position it below the StatusBar in order to have the rounded corners below the StatusBar. See the example ViewController to see how it is done. 
        self.layer.cornerRadius = 10.0f;
        app = [UIApplication sharedApplication]; 
    }
    return self;
}

- (void)showPopUpWithMessage:(NSString *)message forDuration:(double)showtime stayInfinite:(BOOL)stayInfinite withActivityIndicator:(BOOL)activity;
{
    // Remove container UIView labelPlusIndicator to not stack messages
    [labelPlusIndicator removeFromSuperview];
    
    // Set property to know if popup will disappear by itself. Important for dismiss mechanism
    [self setPopUpStaysInfinite:stayInfinite];
    
    // Create a ContainerView
    labelPlusIndicator = [[UIView alloc] initWithFrame:CGRectMake(0,0, 320, 20)];
    labelPlusIndicator.backgroundColor = [UIColor clearColor];
    
    // Create the label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20,0, 280, 20)];
    // Do the text alignment
    label.textAlignment = NSTextAlignmentCenter;
    // Define the message
    label.text = message;
    // Pick a font
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    // Background color for label should be clear
    label.backgroundColor = [UIColor clearColor];
    // Pick a text color
    label.textColor = [UIColor whiteColor];
    // add the label view to the container UIView labelPlusIndicator
    [labelPlusIndicator addSubview:label] ;
    // Calculate label width to position UIActivityIndicatorView
    CGSize labelSize = [label.text sizeWithFont:label.font];
    
    // If you want to display the activity control, initialize and add to the container UIView labelPlusIndicator
    if (activity) {
        // Create the activity control
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        activityIndicator.alpha = 1.0;
        activityIndicator.hidesWhenStopped = NO;
        // Scale it down a bit to fit StatusBar
        activityIndicator.transform = CGAffineTransformMakeScale(0.75, 0.75);
        
        // Calculate position depending on label width
        CGFloat activityPosition = 160 - labelSize.width/2 - 15;
        if (activityPosition >= 10) {
            activityIndicator.center = CGPointMake(activityPosition, 10);
        } else {activityIndicator.center = CGPointMake(10, 10);}
        
        
        // Add activity indicator to container view
        [labelPlusIndicator addSubview:activityIndicator];
        [activityIndicator startAnimating];
    }
    
    // Add labelPlusIndicator to self which is the FLStatusBarPopUp UIView
    [self addSubview:labelPlusIndicator];
    
    // Now add the FLStatusBarPopUp UIView below every other view in your root view controller from which you called this class
    [[[app delegate] window] insertSubview:self atIndex:0];

    // The appear animation does two things. First it calles to hide the statusbar which takes about 0.4 seconds, which is why the animation duration is set to this value. At the same time it moves up the FLStatusBarPopUp UIView from behind every other view, so it becomes visible where the StatusBar is.
    [UIView animateWithDuration:0.4 animations:
     ^{
         [app setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
         
         CGRect moveToCoordinates = {CGPointZero, self.frame.size};
         self.frame = moveToCoordinates;
     }
                     completion:^(BOOL finished1)
     {
         // If stayInfinite was set to NO this will call the dismiss function after the set time period.
         if (!popUpStaysInfinite)
         {
             [self dismissPopUpAfter:showtime];
         }
         
     }];
}

-(void)dismissPopUpAfter:(double)dismissDuration
{
    // Same thing as before only in reverse. Move down the FLStatusBarPopUp UIView behind everything else. Effectivly making it disappear.
    [UIView animateWithDuration:0.4 delay:dismissDuration options:UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionTransitionNone animations:
     ^{
         CGRect moveBackToCoordinates = {{0, 20}, self.frame.size};
         self.frame = moveBackToCoordinates;
     }
    completion:nil];
    // Bring the StatusBar back down. The Time counts the time from the execution of the function, so the StatusBar comes down as the StatusBarPopUp disappears.
    dispatch_time_t dismissAfter = dispatch_time(DISPATCH_TIME_NOW, dismissDuration * NSEC_PER_SEC);
    dispatch_after(dismissAfter, dispatch_get_main_queue(), ^{ [app setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];});
}

-(void)dismissPopUp
{
    // If popUp stays infinitely this function can dismiss it manually
    if (popUpStaysInfinite)
    {
        [self dismissPopUpAfter:0];
    }
}

@end
