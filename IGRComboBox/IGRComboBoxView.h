//
//  IGRComboBoxView.h
//  IGRComboBox
//
//  Created by Vitalii Parovishnyk on 04.02.2013.
//  Copyright 2013 IGR Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IGRComboBoxDelegate <NSObject>

@required
- (void) comboBoxSelectedIndex:(int)index;

@end

@interface IGRComboBoxView : UIView < UITableViewDelegate, UITableViewDataSource > {

	bool			_showComboBox;
	float			_height;
	UIFont			*_font;
}

@property (nonatomic, strong) NSArray		*dataSource;
@property (nonatomic, strong) UIButton		*pulldownButton;
@property (nonatomic, strong) UITableView	*tableView;

@property (nonatomic, weak) id<IGRComboBoxDelegate> delegate;

- (void)initCompentWithFrame:(CGRect)frame;
- (void)setContent:(NSString *)content;

@end
