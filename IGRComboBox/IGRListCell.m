//
//  IGRListCell.m
//  IGRComboBox
//
//  Created by Vitalii Parovishnyk on 04.02.2013.
//  Copyright (c) 2013 IGR Software. All rights reserved.
//

#import "IGRListCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation IGRListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (CGFloat) height
{
	return 42;
}

- (void)drawRect:(CGRect)rect
{
	float correctSize = 1.0f;
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] == YES && [[UIScreen mainScreen] scale] == 2.00) {
        correctSize /= 2;
    }else{
    }
	
	[self.layer setBorderWidth:correctSize];
	
    [self.layer setBorderColor:BORDER_COLOR.CGColor];
}

@end
