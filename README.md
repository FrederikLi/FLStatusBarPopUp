FLStatusBarPopUp
================

Status Bar Messages for iOS like Mailbox App

This is my first git if you have any tipps or suggestions please let me know. 
I'm pretty new to this stuff, don't no my way around yet. So anyway.

FLStatusBarPopUp is a simple singelton class that you can use to show messages in place of the status bar like the mailbox app does.

You just need to load the singleton:
FLStatusBarPopUp *statusBarPopUpInstance = [FLStatusBarPopUp sharedFLStatusBarPopUp];
Then the message can be displayed with
[statusBarPopUpInstance showPopUpWithMessage:@"Whatup Mailbox" forDuration:3 stayInfinite:NO withActivityIndicator:YES];
If you choose stayInfinite:YES the duration value will be ignored and you can dismiss the PopUp with
[statusBarPopUpInstance dismissPopUp];

That's pretty much it. I put some more comments in the class itself.

![FLStatusBarPopUp](fredderli.github.com/FLStatusBarPopUp/FLStatusBarPopUp.png)
