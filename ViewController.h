//
//  ViewController.h
//  test5
//
//  Created by JF Dufour on 4/19/13.
//  Copyright (c) 2013 JF Dufour. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
<UIPickerViewDataSource, UIPickerViewDelegate>


@property (strong, nonatomic) IBOutlet UIImageView *characterimage;
@property (strong, nonatomic) IBOutlet UIPickerView *comboPicker;


@property (strong, nonatomic) IBOutlet UILabel *label_hyperspace;
@property (strong, nonatomic) IBOutlet UILabel *label_impulsion;
@property (strong, nonatomic) IBOutlet UILabel *label_combustion;
@property (strong, nonatomic) IBOutlet UILabel *label_origins_a;
@property (strong, nonatomic) IBOutlet UILabel *label_origins_b;
@property (strong, nonatomic) IBOutlet UILabel *label_origins_c;
@property (strong, nonatomic) IBOutlet UILabel *label_destination_a;
@property (strong, nonatomic) IBOutlet UILabel *label_destination_b;
@property (strong, nonatomic) IBOutlet UILabel *label_destination_c;
@property (strong, nonatomic) IBOutlet UILabel *label_departureTime_a;
@property (strong, nonatomic) IBOutlet UILabel *label_departureTime_b;
@property (strong, nonatomic) IBOutlet UILabel *label_departureTime_c;
@property (strong, nonatomic) IBOutlet UILabel *label_durationD;
@property (strong, nonatomic) IBOutlet UILabel *label_durationH;
@property (strong, nonatomic) IBOutlet UILabel *label_durationM;
@property (strong, nonatomic) IBOutlet UILabel *label_durationS;




@property (strong, nonatomic) IBOutlet UISegmentedControl *eventFactor;
@property (strong, nonatomic) IBOutlet UISwitch *general;
@property (strong, nonatomic) IBOutlet UISwitch *SC;
@property (strong, nonatomic) IBOutlet UISwitch *LC;
@property (strong, nonatomic) IBOutlet UISwitch *LF;
@property (strong, nonatomic) IBOutlet UISwitch *HF;
@property (strong, nonatomic) IBOutlet UISwitch *CR;
@property (strong, nonatomic) IBOutlet UISwitch *BS;
@property (strong, nonatomic) IBOutlet UISwitch *CS;
@property (strong, nonatomic) IBOutlet UISwitch *REC;
@property (strong, nonatomic) IBOutlet UISwitch *BB;
@property (strong, nonatomic) IBOutlet UISwitch *RIP;
@property (strong, nonatomic) IBOutlet UISwitch *BC;
@property (strong, nonatomic) IBOutlet UISwitch *DS;
@property (strong, nonatomic) IBOutlet UISegmentedControl *eventUI;


@property (strong, nonatomic) IBOutlet UILabel *label_FlightArrival;



- (IBAction)hideButton:(id)sender;

- (IBAction)buttonHyperspace:(id)sender;
- (IBAction)buttonImpulsion:(id)sender;
- (IBAction)buttonCombustion:(id)sender;
- (IBAction)buttonOrigins:(id)sender;
- (IBAction)buttonDestination:(id)sender;
- (IBAction)buttonDepartureTime:(id)sender;
- (IBAction)buttonDurationAtRecall:(id)sender;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *viewContainerPicker;

- (IBAction)switchSC:(id)sender;
- (IBAction)switchLC:(id)sender;
- (IBAction)switchLF:(id)sender;
- (IBAction)switchHF:(id)sender;
- (IBAction)switchCR:(id)sender;
- (IBAction)switchBS:(id)sender;
- (IBAction)switchCS:(id)sender;
- (IBAction)switchREC:(id)sender;
- (IBAction)switchBB:(id)sender;
- (IBAction)switchDS:(id)sender;
- (IBAction)switchRIP:(id)sender;
- (IBAction)switchBC:(id)sender;
- (IBAction)eventChange:(id)sender;
- (IBAction)switchGeneral:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *label_FlightDuration;

//populate the picker
//@property (strong, nonatomic) NSArray * arrayOneTwentytwo;
@property (strong, nonatomic) NSMutableArray * arrayOneTwentytwo;
@property (strong, nonatomic) NSMutableArray * arrayOneSeven;
@property (strong, nonatomic) NSMutableArray * arrayOneFivehundread;
@property (strong, nonatomic) NSMutableArray * arrayOneFifteen;
@property (strong, nonatomic) NSMutableArray * arrayZeroFifteen;
@property (strong, nonatomic) NSMutableArray * arrayZeroTwentyfour;
@property (strong, nonatomic) NSMutableArray * arrayZeroSixty;


@end
