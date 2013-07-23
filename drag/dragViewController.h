//
//  dragViewController.h
//  dragMe
//
//  Created by Foram Mukund Shah on 12/6/12.
//

#import <UIKit/UIKit.h>
#import "FKDrag.h"

@interface dragViewController : FKDrag
{
    NSString *str_scramble;
    UIButton *btnDone;
}

@property (nonatomic, strong) NSMutableArray *data;

@end
