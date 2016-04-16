/*
 * AppController.j
 * NewApplication
 *
 * Created by You on April 1, 2016.
 * Copyright 2016, Your Company All rights reserved.
 */

@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@implementation AppController : CPObject
{
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    var div = document.createElement("div");
    div.style.opacity = 1;
    div.style.background = "#FFF";
    div.style.width = "100%";
    div.style.height = "100%";
    div.style.zIndex = 10000;
    div.style.top="0px"
    div.style.left="0px"
    div.style.position="fixed";
    div.classList.add("cpdontremove");
    $(document.body).append(div);
    $(div).fadeTo(2000, 0, function(){
       $(div).remove();
    })

    var theWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero() styleMask:CPBorderlessBridgeWindowMask],
        contentView = [theWindow contentView];

    var label = [[CPTextField alloc] initWithFrame:CGRectMakeZero()];

    [label setStringValue:@"Hello World!"];
    [label setFont:[CPFont boldSystemFontOfSize:24.0]];

    [label sizeToFit];

    [label setAutoresizingMask:CPViewMinXMargin | CPViewMaxXMargin | CPViewMinYMargin | CPViewMaxYMargin];
    [label setCenter:[contentView center]];

    [contentView addSubview:label];

    [theWindow orderFront:self];
}

@end
