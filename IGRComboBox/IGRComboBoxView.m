//
//  IGRComboBoxView.m
//  IGRComboBox
//
//  Created by Vitalii Parovishnyk on 04.02.2013.
//  Copyright 2013 IGR Software. All rights reserved.
//

#import "IGRComboBoxView.h"
#import "IGRListCell.h"

@interface IGRComboBoxView ()

@property (nonatomic, assign) IBOutlet IGRListCell *igrListCell;

- (void)initVariables;

- (void)show;
- (void)hide;

@end


@implementation IGRComboBoxView

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		[self initVariables];
		[self initCompentWithFrame:frame];
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
    if (self) {
        [self initVariables];
		[self initCompentWithFrame:self.frame];
    }
    return self;
}

#pragma mark -
#pragma mark custom methods

- (void)initVariables
{
	_showComboBox = false;
	_height = 35.f;
	_font = [UIFont systemFontOfSize:14.0f];
	self.backgroundColor = [UIColor clearColor];
}

- (UIImage *)buttonBackgroundForState:(UIControlState)state
{
    NSString *name = @"combox-down";
    if (state == UIControlStateSelected) {
        name = @"combox-up";
    }
    UIImage *image = [UIImage imageNamed:name];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 29.0)];
    return image;
}

- (void)initCompentWithFrame:(CGRect)frame
{
	_pulldownButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[_pulldownButton setFrame:CGRectMake(0, 0, self.frame.size.width, _height)];
	
	[_pulldownButton setBackgroundImage:[self buttonBackgroundForState:UIControlStateNormal]
							   forState:UIControlStateNormal];
	[_pulldownButton setBackgroundImage:[self buttonBackgroundForState:UIControlStateSelected]
							   forState:UIControlStateSelected];
	
	[_pulldownButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[_pulldownButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
	[_pulldownButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
	
	[_pulldownButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
	[_pulldownButton setContentEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
	
	[_pulldownButton addTarget:self
						action:@selector(pulldownButtonWasClicked:)
			  forControlEvents:UIControlEventTouchUpInside];
	
	[self addSubview:_pulldownButton];
	
	self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(1, _height+1, frame.size.width -2, frame.size.height - _height)];
	[self.tableView setDataSource:self];
	[self.tableView setDelegate:self];
	
	self.tableView.backgroundColor = [UIColor whiteColor];
	self.tableView.alpha = 0.f;
	
	[self addSubview:self.tableView];
}

- (void)setContent:(NSString *)content {
	[_pulldownButton setTitle:content forState:UIControlStateNormal];
	[_pulldownButton setTitle:content forState:UIControlStateHighlighted];
	[_pulldownButton setTitle:content forState:UIControlStateSelected];
}

- (void)show {
	self.tableView.alpha = 1.f;
	_showComboBox = true;
	[_pulldownButton setSelected:_showComboBox];
	
	[self setNeedsDisplay];
}

- (void)hide {
	self.tableView.alpha = 0.f;
	_showComboBox = false;
	[_pulldownButton setSelected:_showComboBox];
	
	[self setNeedsDisplay];
}

#pragma mark -
#pragma mark custom event methods

- (void)pulldownButtonWasClicked:(id)sender {
	
	[UIView beginAnimations:@"ShowHideControls" context:nil];
	[UIView setAnimationDuration:0.2];
	
	if (_showComboBox == true) {
		[self hide];
	}else {
		[self show];
	}
	
	[UIView commitAnimations];
}

#pragma mark -
#pragma mark UITableViewDelegate and UITableViewDatasource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	static NSString *cellId = @"IGRListCell";
    IGRListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[IGRListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        [[NSBundle mainBundle] loadNibNamed:cellId owner:self options:nil];
		cell = self.igrListCell;
		self.igrListCell = nil;
    }
	
	cell.textLabel.text = self.dataSource[indexPath.row];
	
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return [IGRListCell height];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 1.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	return 1.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIView* view = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 300, 1)];
    view.backgroundColor = BORDER_COLOR;
	
	return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
	UIView* view = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 300, 1)];
    view.backgroundColor = BORDER_COLOR;
	
	return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	[self hide];
	[self setContent:self.dataSource[indexPath.row]];
	
	if ([self.delegate respondsToSelector:@selector(comboBoxSelectedIndex:)]) {
		[self.delegate comboBoxSelectedIndex:indexPath.row];
	}
}

#pragma mark -
#pragma mark drawRect methods

- (void)drawRect:(CGRect)rect {
	
	[super drawRect:rect];
}


#pragma mark -
#pragma mark dealloc memery methods

- (void)dealloc {
	self.tableView.delegate		= nil;
	self.tableView.dataSource	= nil;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	[super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[super touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	[super touchesCancelled:touches withEvent:event];
}

@end
