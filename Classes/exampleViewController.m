//
//  exampleViewController.m
//  IGRComboBox
//
//  Created by Vitalii Parovishnyk on 04.02.2013.
//  Copyright 2013 IGR Software. All rights reserved.
//

#import "exampleViewController.h"

@implementation exampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	NSArray *dataSource = @[@"I", @"Like", @"To", @"Provide", @"Shit", @"Combobox", @"for", @"iOS"];
	m_IGRComboBoxView = [[IGRComboBoxView alloc] initWithFrame:CGRectMake(20, 20, 280, 280)];
	[m_IGRComboBoxView setDataSource:dataSource];
	[m_IGRComboBoxView setContent:dataSource[0]];
	[m_IGRComboBoxView setDelegate:self];
	
	[self.view addSubview:m_IGRComboBoxView];
	
	//[self.igrComboBoxView setDataSource:dataSource];
	//[self.igrComboBoxView setContent:dataSource[1]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) comboBoxSelectedIndex:(int)index
{
	NSLog(@"Selected: %d", index);
}

@end
