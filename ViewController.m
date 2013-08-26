//
//  ViewController.m
//  test5
//
//  Created by JF Dufour on 4/19/13.
//  Copyright (c) 2013 JF Dufour. All rights reserved.
//

#import "ViewController.h"

#import "Calculator.h"

@interface ViewController ()

@end

Calculator* myCalculator;

@implementation ViewController
@synthesize arrayOneTwentytwo = _arrayOneTwentytwo;
@synthesize arrayOneSeven = _arrayOneSeven;
@synthesize arrayOneFivehundread = _arrayOneFivehundread;
@synthesize arrayOneFifteen = _arrayOneFifteen;
@synthesize arrayZeroFifteen = _arrayZeroFifteen;
@synthesize arrayZeroSixty = _arrayZeroFiftynine;
@synthesize arrayZeroTwentyfour = _arrayZeroTwentythree;

NSMutableArray * currentPickerArray;

typedef enum Buttons
{
    enum_button_hyperspace,
    enum_button_impulse,
    enum_button_combustion,
    enum_button_origins,
    enum_button_destination,
    enum_button_remainingTimeAtRecall,
    enum_button_fleetDepartureTime
    
} enumButtonClicked;
enumButtonClicked _buttonClicked;

- (void)viewDidAppear:(BOOL)animated
{
    
    [self.scrollView setScrollEnabled:YES];
    [self.scrollView setContentSize:CGSizeMake(320, 565)];
    
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //LOAD ARRAY
    _arrayOneTwentytwo = [[NSMutableArray alloc] initWithCapacity:22];
    _arrayOneSeven = [[NSMutableArray alloc] initWithCapacity:7];
    _arrayOneFivehundread = [[NSMutableArray alloc] initWithCapacity:500];
    _arrayOneFifteen = [[NSMutableArray alloc] initWithCapacity:15];
    _arrayZeroFifteen = [[NSMutableArray alloc] initWithCapacity:15];
    _arrayZeroTwentythree = [[NSMutableArray alloc] initWithCapacity:24];
    _arrayZeroFiftynine = [[NSMutableArray alloc] initWithCapacity:60];
    
    for (int i = 1; i < 23; ++i)
        _arrayOneTwentytwo[i-1] = [NSString stringWithFormat:@"%d",i];
    for (int i = 1; i < 8; ++i)
        _arrayOneSeven[i-1] = [NSString stringWithFormat:@"%d",i];
    for (int i = 1; i < 500; ++i)
        _arrayOneFivehundread[i-1] = [NSString stringWithFormat:@"%d",i];
    for (int i = 1; i < 16; ++i)
        _arrayOneFifteen[i-1] = [NSString stringWithFormat:@"%d",i];
    for (int i = 0; i < 16; ++i)
        _arrayZeroFifteen[i] = [NSString stringWithFormat:@"%d",i];
    for (int i = 0; i < 24; ++i)
        _arrayZeroTwentythree[i] = [NSString stringWithFormat:@"%d",i];
    for (int i = 0; i < 60; ++i)
        _arrayZeroFiftynine[i] = [NSString stringWithFormat:@"%d",i];
    
    currentPickerArray = [[NSMutableArray alloc] initWithArray:_arrayOneTwentytwo copyItems:YES];
    
    self.label_FlightDuration.text = @"Enter your inputs \n\n\n\n\n\n\n\n";
    
    myCalculator = [[Calculator alloc] init];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UIPickerView Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (_buttonClicked == enum_button_origins
        || _buttonClicked == enum_button_destination
        ||_buttonClicked == enum_button_fleetDepartureTime)
        return 3;
    if (_buttonClicked == enum_button_remainingTimeAtRecall)
        return 4;
    
    return 1;// nb of column
    
}



- (NSDate*) GetDepartureDate
{
    NSDateComponents* compCurrentDate = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    
    NSDateComponents* comps = [[NSDateComponents alloc] init];
    [comps setDay:compCurrentDate.day];
    [comps setMonth:compCurrentDate.month];
    [comps setYear:compCurrentDate.year];
    [comps setHour:[self.label_departureTime_a.text intValue]];
    [comps setMinute:[self.label_departureTime_b.text intValue]];
    [comps setSecond:[self.label_departureTime_c.text intValue]];
    NSCalendar* cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *departureDate = [cal dateFromComponents:comps];
    
    return departureDate;
}

- (NSInteger) GetRemainingSecondsBeforeRecall
{
    return [self.label_durationD.text intValue]*86400+
    [self.label_durationH.text intValue]*3600+
    [self.label_durationM.text intValue]*60+
    [self.label_durationS.text intValue];
}
- (void)Calculate:(NSString*) tmp
{
    
    NSDate* departureDate = [self GetDepartureDate];
    NSInteger remainingSecondsBeforeRecall = [self GetRemainingSecondsBeforeRecall];
    
    int eventindex = self.eventFactor.selectedSegmentIndex+1;
    double event = 1;
    if (eventindex == 2)  event = 1.5;
    else if (eventindex == 3) event = 2;
    else if (eventindex == 4) event = 2.5;
    else
        event = 3;
    
    
    
    [myCalculator Initialise:self.SC.on
                largecargo:self.LC.on
                lightfighter:self.LF.on
                heavyfighter:self.HF.on
                     cruiser:self.CR.on
                  battelship:self.BS.on
                      colony:self.CS.on
                    recycler:self.REC.on
                      bomber:self.BB.on
                   destroyer:self.DS.on
                   deathstar:self.RIP.on
               battlecruiser:self.BC.on
                     general:self.general.on
                 eventFactor:event
                       hyper:[self.label_hyperspace.text intValue]
                   impulsion:[self.label_impulsion.text intValue]
                  combustion:[self.label_combustion.text intValue]
               departureTime:departureDate
               remainingTime:remainingSecondsBeforeRecall
                       origA:[self.label_origins_a.text intValue]
                       origB:[self.label_origins_b.text intValue]
                       origC:[self.label_origins_c.text intValue]
                       destA:[self.label_destination_a.text intValue]
                       destB:[self.label_destination_b.text intValue]
                       destC:[self.label_destination_c.text intValue]
     ];
    
    [myCalculator Calculate];
    
    
    
    
    
    [self.label_FlightDuration setText: myCalculator.output];
    [self.label_FlightArrival setText: myCalculator.outputArrival];
    
    
}
























































- (IBAction)buttonHyperspace:(id)sender
{
     
    _buttonClicked = enum_button_hyperspace;
    currentPickerArray = _arrayOneTwentytwo;
    [self.comboPicker reloadAllComponents];
    [self.comboPicker selectRow:[self.label_hyperspace.text intValue]-1 inComponent:0 animated:NO];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    _viewContainerPicker.frame = CGRectMake(0,196,320,264);
    
    [UIView setAnimationDuration:0];
    _scrollView.frame = CGRectMake(0,0,320,195);
    CGPoint bottomOffset = CGPointMake(0, self.scrollView.contentSize.height - self.scrollView.bounds.size.height - 70);
    [self.scrollView setContentOffset:bottomOffset animated:YES];
    [UIView commitAnimations];
    
    [self Calculate:@"9"];
}


- (IBAction)buttonImpulsion:(id)sender
{
    _buttonClicked = enum_button_impulse;
    currentPickerArray = _arrayOneTwentytwo;
    [self.comboPicker reloadAllComponents];
    [self.comboPicker selectRow:[self.label_impulsion.text intValue]-1 inComponent:0 animated:NO];
    
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    _viewContainerPicker.frame = CGRectMake(0,196,320,264);
    [UIView setAnimationDuration:0];
    _scrollView.frame = CGRectMake(0,0,320,195);
    CGPoint bottomOffset = CGPointMake(0, self.scrollView.contentSize.height - self.scrollView.bounds.size.height - 50);
    [self.scrollView setContentOffset:bottomOffset animated:YES];
    [UIView commitAnimations];
    
    [self Calculate:@"10"];
}

- (IBAction)buttonCombustion:(id)sender
{
    _buttonClicked = enum_button_combustion;
    currentPickerArray = _arrayOneTwentytwo;
    [self.comboPicker reloadAllComponents];
    [self.comboPicker selectRow:[self.label_combustion.text intValue]-1 inComponent:0 animated:NO];
    
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    _viewContainerPicker.frame = CGRectMake(0,196,320,264);
    [UIView setAnimationDuration:0];
    _scrollView.frame = CGRectMake(0,0,320,195);
    CGPoint bottomOffset = CGPointMake(0, self.scrollView.contentSize.height - self.scrollView.bounds.size.height - 30);
    [self.scrollView setContentOffset:bottomOffset animated:YES];
    [UIView commitAnimations];
    
    [self Calculate:@""];
}

- (IBAction)buttonDepartureTime:(id)sender
{
    _buttonClicked = enum_button_fleetDepartureTime;
    currentPickerArray = _arrayZeroTwentythree;
    [self.comboPicker reloadAllComponents];
    [self.comboPicker selectRow:[self.label_departureTime_a.text intValue] inComponent:0 animated:NO];
    [self.comboPicker selectRow:[self.label_departureTime_b.text intValue] inComponent:1 animated:NO];
    [self.comboPicker selectRow:[self.label_departureTime_c.text intValue] inComponent:2 animated:NO];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    _viewContainerPicker.frame = CGRectMake(0,196,320,264);
    [UIView setAnimationDuration:0];
    _scrollView.frame = CGRectMake(0,0,320,195);
    CGPoint bottomOffset = CGPointMake(0, self.scrollView.contentSize.height - self.scrollView.bounds.size.height);
    [self.scrollView setContentOffset:bottomOffset animated:YES];
    [UIView commitAnimations];
    
    [self Calculate:@""];
}

- (IBAction)buttonDurationAtRecall:(id)sender
{
    _buttonClicked = enum_button_remainingTimeAtRecall;
    currentPickerArray = _arrayZeroFifteen;
    [self.comboPicker reloadAllComponents];
    [self.comboPicker selectRow:[self.label_durationD.text intValue] inComponent:0 animated:NO];
    [self.comboPicker selectRow:[self.label_durationH.text intValue] inComponent:1 animated:NO];
    [self.comboPicker selectRow:[self.label_durationM.text intValue] inComponent:2 animated:NO];
    [self.comboPicker selectRow:[self.label_durationS.text intValue] inComponent:3 animated:NO];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    _viewContainerPicker.frame = CGRectMake(0,196,320,264);
    [UIView setAnimationDuration:0];
    _scrollView.frame = CGRectMake(0,0,320,195);
    CGPoint bottomOffset = CGPointMake(0, self.scrollView.contentSize.height - self.scrollView.bounds.size.height);
    [self.scrollView setContentOffset:bottomOffset animated:YES];
    [UIView commitAnimations];
    
    [self Calculate:@""];
}

- (IBAction)buttonOrigins:(id)sender
{
    _buttonClicked = enum_button_origins;
    currentPickerArray = _arrayOneFifteen;
    [self.comboPicker reloadAllComponents];
    [self.comboPicker selectRow:[self.label_origins_a.text intValue]-1 inComponent:0 animated:NO];
    [self.comboPicker selectRow:[self.label_origins_b.text intValue]-1 inComponent:1 animated:NO];
    [self.comboPicker selectRow:[self.label_origins_c.text intValue]-1 inComponent:2 animated:NO];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    _viewContainerPicker.frame = CGRectMake(0,196,320,264);
    [UIView setAnimationDuration:0];
    _scrollView.frame = CGRectMake(0,0,320,195);
    CGPoint bottomOffset = CGPointMake(0, self.scrollView.contentSize.height - self.scrollView.bounds.size.height);
    [self.scrollView setContentOffset:bottomOffset animated:YES];
    [UIView commitAnimations];
    
    [self Calculate:@""];
}


- (IBAction)buttonDestination:(id)sender
{
    _buttonClicked = enum_button_destination;
    currentPickerArray = _arrayOneFifteen;
    [self.comboPicker reloadAllComponents];
    [self.comboPicker selectRow:[self.label_destination_a.text intValue]-1 inComponent:0 animated:NO];
    [self.comboPicker selectRow:[self.label_destination_b.text intValue]-1 inComponent:1 animated:NO];
    [self.comboPicker selectRow:[self.label_destination_c.text intValue]-1 inComponent:2 animated:NO];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    _viewContainerPicker.frame = CGRectMake(0,196,320,264);
    [UIView setAnimationDuration:0];
    _scrollView.frame = CGRectMake(0,0,320,195);
    CGPoint bottomOffset = CGPointMake(0, self.scrollView.contentSize.height - self.scrollView.bounds.size.height);
    [self.scrollView setContentOffset:bottomOffset animated:YES];
    [UIView commitAnimations];
    
    [self Calculate:@""];
}

- (IBAction)hideButton:(id)sender
{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    _viewContainerPicker.frame = CGRectMake(320,196,320,264);
    [UIView setAnimationDuration:0];
    _scrollView.frame = CGRectMake(0,0,320,460);
    [UIView commitAnimations];
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (_buttonClicked == enum_button_origins
        || _buttonClicked == enum_button_destination)
    {
        switch (component) {
            case 0:
                return _arrayOneSeven.count;
                break;
            case 1:
                return _arrayOneFivehundread.count;
                break;
            case 2:
                return _arrayOneFifteen.count;
                break;
            default:
                return _arrayOneSeven.count;
                break;
        }
    }
    else if (_buttonClicked == enum_button_fleetDepartureTime)
    {
        switch (component) {
            case 0:
                return _arrayZeroTwentythree.count;
                break;
            case 1:
                return _arrayZeroFiftynine.count;
                break;
            case 2:
                return _arrayZeroFiftynine.count;
                break;
            default:
                return _arrayZeroTwentythree.count;
                break;
        }
    }
    else if (_buttonClicked == enum_button_remainingTimeAtRecall)
    {
        switch (component) {
            case 0:
                return _arrayZeroFifteen.count;
                break;
            case 1:
                return _arrayZeroTwentythree.count;
                break;
            case 2:
                return _arrayZeroFiftynine.count;
                break;
            case 3:
                return _arrayZeroFiftynine.count;
                break;
            default:
                return _arrayZeroFifteen.count;
                break;
        }
    }
    else
        return currentPickerArray.count;
    
}

//put the array in the picker
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (_buttonClicked == enum_button_origins
        || _buttonClicked == enum_button_destination)
    {
        switch (component) {
            case 0:
                return [_arrayOneSeven objectAtIndex:row];
                break;
            case 1:
                return [_arrayOneFivehundread objectAtIndex:row];
                break;
            case 2:
                return [_arrayOneFifteen objectAtIndex:row];
                break;
            default:
                return [_arrayOneSeven objectAtIndex:row];
                break;
        }
    }
    else if (_buttonClicked == enum_button_fleetDepartureTime)
    {
        switch (component) {
            case 0:
                return [_arrayZeroTwentythree objectAtIndex:row];
                break;
            case 1:
                return [_arrayZeroFiftynine objectAtIndex:row];
                break;
            case 2:
                return [_arrayZeroFiftynine objectAtIndex:row];
                break;
            default:
                return [_arrayZeroTwentythree objectAtIndex:row];
                break;
        }
    }
    else if (_buttonClicked == enum_button_remainingTimeAtRecall)
    {
        switch (component) {
            case 0:
                return [_arrayZeroFifteen objectAtIndex:row];
                break;
            case 1:
                return [_arrayZeroTwentythree objectAtIndex:row];
                break;
            case 2:
                return [_arrayZeroFiftynine objectAtIndex:row];
                break;
            case 3:
                return [_arrayZeroFiftynine objectAtIndex:row];
                break;
            default:
                return [_arrayZeroFifteen objectAtIndex:row];
                break;
        }
    }
    else
        return [currentPickerArray objectAtIndex:row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    
    switch (_buttonClicked) {
        case enum_button_hyperspace:
            [self.label_hyperspace setText: [NSString stringWithFormat:@"%d",(row+1)]];
            break;
        case enum_button_impulse:
            [self.label_impulsion setText: [NSString stringWithFormat:@"%d",(row+1)]];
            break;
        case enum_button_combustion:
            [self.label_combustion setText: [NSString stringWithFormat:@"%d",(row+1)]];
            break;
        case enum_button_origins:
            
            switch (component) {
                case 0:
                    [self.label_origins_a setText: [NSString stringWithFormat:@"%d",(row+1)]];
                    break;
                case 1:
                    [self.label_origins_b setText: [NSString stringWithFormat:@"%d",(row+1)]];
                    break;
                case 2:
                    [self.label_origins_c setText: [NSString stringWithFormat:@"%d",(row+1)]];
                    break;
                default:
                    [self.label_origins_c setText: [NSString stringWithFormat:@"%d",(row+1)]];
                    break;
            }
            break;
        case enum_button_destination:
            
            switch (component) {
                case 0:
                    [self.label_destination_a setText: [NSString stringWithFormat:@"%d",(row+1)]];
                    break;
                case 1:
                    [self.label_destination_b setText: [NSString stringWithFormat:@"%d",(row+1)]];
                    break;
                case 2:
                    [self.label_destination_c setText: [NSString stringWithFormat:@"%d",(row+1)]];
                    break;
                default:
                    [self.label_destination_c setText: [NSString stringWithFormat:@"%d",(row+1)]];
                    break;
            }
            break;
        case enum_button_fleetDepartureTime:
            
            switch (component) {
                case 0:
                    [self.label_departureTime_a setText: [NSString stringWithFormat:@"%d",(row)]];
                    break;
                case 1:
                    [self.label_departureTime_b setText: [NSString stringWithFormat:@"%d",(row)]];
                    break;
                case 2:
                    [self.label_departureTime_c setText: [NSString stringWithFormat:@"%d",(row)]];
                    break;
                default:
                    [self.label_departureTime_c setText: [NSString stringWithFormat:@"%d",(row)]];
                    break;
            }
            break;
        case enum_button_remainingTimeAtRecall:
            
            switch (component) {
                case 0:
                    [self.label_durationD setText: [NSString stringWithFormat:@"%d",(row)]];
                    break;
                case 1:
                    [self.label_durationH setText: [NSString stringWithFormat:@"%d",(row)]];
                    break;
                case 2:
                    [self.label_durationM setText: [NSString stringWithFormat:@"%d",(row)]];
                    break;
                case 3:
                    [self.label_durationS setText: [NSString stringWithFormat:@"%d",(row)]];
                    break;
                default:
                    [self.label_durationD setText: [NSString stringWithFormat:@"%d",(row)]];
                    break;
            }
            break;
            
        default:
            break;
    }
    
    [self Calculate:@"90"];
}

- (IBAction)switchSC:(id)sender {
    
    [self Calculate:@"1"];
}

- (IBAction)switchLC:(id)sender {
    
    [self Calculate:@"2"];
}

- (IBAction)switchLF:(id)sender {
    
    [self Calculate:@"3"];
}

- (IBAction)switchHF:(id)sender {
    
    [self Calculate:@"4"];
}

- (IBAction)switchCR:(id)sender {
    
    [self Calculate:@""];
}

- (IBAction)switchBS:(id)sender {
    
    [self Calculate:@""];
}

- (IBAction)switchCS:(id)sender {
    
    [self Calculate:@""];
}

- (IBAction)switchREC:(id)sender {
    
    [self Calculate:@""];
}

- (IBAction)switchBB:(id)sender {
    
    [self Calculate:@""];
}

- (IBAction)switchDS:(id)sender {
    
    [self Calculate:@""];
}

- (IBAction)switchRIP:(id)sender {
    
    [self Calculate:@""];
}

- (IBAction)switchBC:(id)sender {
    
    [self Calculate:@""];
}

- (IBAction)eventChange:(id)sender {
    
    [self Calculate:@""];
}

- (IBAction)switchGeneral:(id)sender {
    
    [self Calculate:@""];
}
@end
