//
//  FKDrag.m
//  drag
//
//  Created by Foram Mukund Shah on 12/6/12.
//

#import "FKDrag.h"

@interface FKDrag ()

@end


@implementation FKDrag
@synthesize currentData;

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
	// Do any additional setup after loading the view.
    
    // declare delegates for gridview
    gridView.sortingDelegate   = self;
    gridView.dataSource = self;
    gridView.mainSuperView = self.view;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)loadView
{
    [super loadView];
    
    gridView = [[GMGridView alloc] initWithFrame:self.view.bounds];
    // set horizontal layout
    gridView.layoutStrategy = [GMGridViewLayoutStrategyFactory strategyFromType:GMGridViewLayoutHorizontal];
    
    [self.view addSubview:gridView];

    // compute frame for each item in gridview
    [self computeViewFrames];
}

#pragma mark 
#pragma mark invoked functions

- (void)computeViewFrames
{
    CGSize itemSize = [self GMGridView:gridView sizeForItemsInInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
    
    CGSize minSize  = CGSizeMake(itemSize.width  + gridView.minEdgeInsets.right + gridView.minEdgeInsets.left,
                                 itemSize.height + gridView.minEdgeInsets.top   + gridView.minEdgeInsets.bottom);
    
    CGRect frame1 = CGRectMake(10, 0, minSize.width, self.view.bounds.size.height - minSize.height - 30);
    CGRect frame2 = CGRectMake(10, frame1.size.height + 20, self.view.bounds.size.width - 20 , minSize.height);

    gridView.frame = frame2;
}

#pragma mark
#pragma mark GridView DataSource

- (NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    return [self.currentData count];
}

- (CGSize)GMGridView:(GMGridView *)gridView sizeForItemsInInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    // set size of buttons
    if (INTERFACE_IS_PHONE)
    {
        if (UIInterfaceOrientationIsLandscape(orientation))
            return CGSizeMake(70, 70);
        else
            return CGSizeMake(70, 70);
    }
    else
    {
        if (UIInterfaceOrientationIsLandscape(orientation))
            return CGSizeMake(285, 205);
        else
            return CGSizeMake(230, 175);
    }
}

- (GMGridViewCell *)GMGridView:(GMGridView *)gridView1 cellForItemAtIndex:(NSInteger)index
{
    // set size based on orientation
    CGSize size = [self GMGridView:gridView sizeForItemsInInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
    
    GMGridViewCell *cell = [gridView dequeueReusableCell];
    
    if (!cell)
    {
        // allocate view
        cell = [[GMGridViewCell alloc] init];

        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        view.backgroundColor = [UIColor grayColor];
        view.layer.masksToBounds = NO;
        view.layer.cornerRadius = 8;
        cell.contentView = view;
    }
    
    [[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // allocate label 
    UILabel *label = [[UILabel alloc] initWithFrame:cell.contentView.bounds];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    label.text = (NSString *)[self.currentData objectAtIndex:index];
    label.textAlignment = UITextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
    label.highlightedTextColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:20];
    [cell.contentView addSubview:label];
    
    return cell;
}

#pragma mark
#pragma mark GridView Sorting Delegate

// change color at long press gesture
- (void)GMGridView:(GMGridView *)gridView didStartMovingCell:(GMGridViewCell *)cell
{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         cell.contentView.backgroundColor = [UIColor orangeColor];
                         cell.contentView.layer.shadowOpacity = 0.7;
                     }
                     completion:nil
     ];
}

// change color after releasing button
- (void)GMGridView:(GMGridView *)gridView didEndMovingCell:(GMGridViewCell *)cell
{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         cell.contentView.backgroundColor = [UIColor redColor];
                         cell.contentView.layer.shadowOpacity = 0;
                     }
                     completion:nil
     ];
}

// Allow Shaking Behavior When Moving Cell
- (BOOL)GMGridView:(GMGridView *)gridView shouldAllowShakingBehaviorWhenMovingCell:(GMGridViewCell *)cell atIndex:(NSInteger)index
{
    return YES;
}

// move item
- (void)GMGridView:(GMGridView *)gridView moveItemAtIndex:(NSInteger)oldIndex toIndex:(NSInteger)newIndex
{
    NSObject *object = [self.currentData objectAtIndex:oldIndex];
    [self.currentData removeObject:object];
    [self.currentData insertObject:object atIndex:newIndex];
}

// exchange item
- (void)GMGridView:(GMGridView *)gridView exchangeItemAtIndex:(NSInteger)index1 withItemAtIndex:(NSInteger)index2
{
    [self.currentData exchangeObjectAtIndex:index1 withObjectAtIndex:index2];
}

#pragma mark
#pragma mark optional methods

// Example: adding object at the last position
- (void)addMoreItem
{
    NSString *newItem = [NSString stringWithFormat:@"%d", (int)(arc4random() % 1000)];
    
    [self.currentData addObject:newItem];
    [gridView insertObjectAtIndex:[self.currentData count] - 1 withAnimation:GMGridViewItemAnimationFade | GMGridViewItemAnimationScroll];
}

// Example: removing last item
- (void)removeItem
{
    if ([self.currentData count] > 0)
    {
        NSInteger index = [self.currentData count] - 1;
        
        [gridView removeObjectAtIndex:index withAnimation:GMGridViewItemAnimationFade | GMGridViewItemAnimationScroll];
        [self.currentData removeObjectAtIndex:index];
    }
}

// Example: reloading last item
- (void)refreshItem
{
    if ([self.currentData count] > 0)
    {
        int index = [self.currentData count] - 1;
        
        NSString *newMessage = [NSString stringWithFormat:@"%d", (arc4random() % 1000)];
        
        [self.currentData replaceObjectAtIndex:index withObject:newMessage];
        [gridView reloadObjectAtIndex:index withAnimation:GMGridViewItemAnimationFade | GMGridViewItemAnimationScroll];
    }
}

@end
