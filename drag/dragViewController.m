//
//  dragViewController.m
//  dragMe
//
//  Created by Foram Mukund Shah on 12/6/12.
//

#import "dragViewController.h"

@interface dragViewController ()

@end

@implementation dragViewController
@synthesize data;

#pragma mark
#pragma mark view life cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"view");

    // customize your stuff as you want in YOUR VIEW
    
    // create Done button
    btnDone = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnDone addTarget:nil action:@selector(Done) forControlEvents:UIControlEventTouchUpInside];
    [btnDone setTitle:@"Done" forState:UIControlStateNormal];
    [self.view addSubview:btnDone];
}

- (id)init
{
    if ((self =[super init]))
    {
        // customize your stuff as you want in GRID VIEW

        str_scramble =@"ORTGNS";
        self.data = [[NSMutableArray alloc] init];
        for (int i = 0; i < 6; i ++)
        {
            char letter= [str_scramble characterAtIndex:i];
            [self.data addObject:[NSString stringWithFormat:@"%c", letter]];
        }
        self.currentData = self.data;
    }
    
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark invoked functions

-(void)Done
{
  NSLog(@"Final Result >> %@",self.currentData);
}

#pragma mark
#pragma mark orientation management

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // custom stuff
    
    // set frame for Done Button
    if (INTERFACE_IS_PHONE)
    {
        if (deviceOrientation == UIInterfaceOrientationLandscapeLeft || deviceOrientation == UIInterfaceOrientationLandscapeRight)
            [btnDone setFrame:CGRectMake(410, 170, 50, 30)];
        else
            [btnDone setFrame:CGRectMake(250, 330, 50, 30)];
    }
    else
    {
        if (deviceOrientation == UIInterfaceOrientationLandscapeLeft || deviceOrientation == UIInterfaceOrientationLandscapeRight)
            [btnDone setFrame:CGRectMake(800, 470, 150, 50)];
        else
            [btnDone setFrame:CGRectMake(550, 730, 150, 60)];
    }
    // compute frame for each item in gridview
    [self computeViewFrames];
    
    return YES;
}

#pragma mark ------------ios6 orientation-------

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    // custom stuff
    
    // set frame for Done Button
    if (INTERFACE_IS_PHONE)
    {
        if (deviceOrientation == UIInterfaceOrientationLandscapeLeft || deviceOrientation == UIInterfaceOrientationLandscapeRight)
            [btnDone setFrame:CGRectMake(410, 170, 50, 30)];
        else
            [btnDone setFrame:CGRectMake(250, 330, 50, 30)];
    }
    else
    {
        if (deviceOrientation == UIInterfaceOrientationLandscapeLeft || deviceOrientation == UIInterfaceOrientationLandscapeRight)
            [btnDone setFrame:CGRectMake(800, 470, 150, 50)];
        else
            [btnDone setFrame:CGRectMake(550, 730, 150, 60)];
    }
    // compute frame for each item in gridview
    [self computeViewFrames];

    return UIInterfaceOrientationMaskAllButUpsideDown;
}

@end
