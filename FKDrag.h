//
//  FKDrag.h
//  drag
//
//  Created by Foram Mukund Shah on 12/6/12.
//

#import <UIKit/UIKit.h>
#import "GMGridView.h"
#import "GMGridViewLayoutStrategies.h"
#import <QuartzCore/QuartzCore.h>

// identify device
#define INTERFACE_IS_PAD     ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define INTERFACE_IS_PHONE   ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)

// identify orientation
#define deviceOrientation [UIDevice currentDevice].orientation

@interface FKDrag : UIViewController <GMGridViewDataSource, GMGridViewSortingDelegate>
{
    GMGridView *gridView;
}
// an array which will hold final result 
@property (nonatomic, strong) NSMutableArray *currentData;

- (void)computeViewFrames;

@end
