//
//  exampleViewController.h
//  IGRComboBox
//
//  Created by Vitalii Parovishnyk on 04.02.2013.
//  Copyright 2013 IGR Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IGRComboBoxView.h"

@interface exampleViewController : UIViewController <IGRComboBoxDelegate> {
	
	IGRComboBoxView		*m_IGRComboBoxView;
}
//@property (strong, nonatomic) IBOutlet IGRComboBoxView *igrComboBoxView;

@end

