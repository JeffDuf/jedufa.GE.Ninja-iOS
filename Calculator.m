//
//  Calculator.m
//  test5
//
//  Created by JF Dufour on 4/21/13.
//  Copyright (c) 2013 JF Dufour. All rights reserved.
//

#import "Calculator.h"

@implementation Calculator


BOOL	SC = false;
BOOL	LC = false;
BOOL	LF = false;
BOOL    HF = false;
BOOL	CR = false;
BOOL	BS = false;
BOOL    COL = false;
BOOL	REC = false;
BOOL	SPY = false;
BOOL    BB = false;
BOOL    DS = false;
BOOL    RIP = false;
BOOL    BC = false;
BOOL    use_general = false; 			//1
double		event_factor; 			//2
NSInteger    	Hyperspace_drive_level;
NSInteger		Impulse_drive_level;
NSInteger       Combustion_drive_level; //8
NSInteger orig_gal;
NSInteger orig_sys;
NSInteger orig_pla;
NSInteger targ_gal;
NSInteger targ_sys;
NSInteger targ_pla;
double ship_speed_factor_hyp;
double ship_speed_factor_imp;
double ship_speed_factor_com;
NSDate* departureTime;
NSInteger remainingSecondsBeforeRecall;


// Constants
NSInteger ship_speed_SC_low_impulse5 = 5000;		//1
NSInteger ship_speed_SC_high_impulse5 = 10000;		//-
NSInteger ship_speed_LC = 7500;				//2
NSInteger ship_speed_LF = 12500;			//3
NSInteger ship_speed_HF = 10000;			//4
NSInteger ship_speed_CR = 15000;			//5
NSInteger ship_speed_BS = 10000;			//6
NSInteger ship_speed_COL = 2500;			//7
NSInteger ship_speed_REC = 2000;			//8
NSInteger ship_speed_SPY = 100000000;		//9
NSInteger ship_speed_BB_low_hyper8 = 4000;	//10
NSInteger ship_speed_BB_high_hyper8 = 5000;	//-
NSInteger ship_speed_DS = 5000;				//11
NSInteger ship_speed_RIP = 100;				//12
NSInteger ship_speed_BC = 10000;			//13

NSInteger universe_speed = 2;

double	Hyperspace_drive_level_bonus 		= 0.3;
double	Impusle_drive_level_bonus 			= 0.2;
double	Combustion_drive_level_bonus 	    = 0.1;



- (void)Initialise:(BOOL)sc
largecargo:(BOOL)lc
lightfighter:(BOOL) lf
heavyfighter:(BOOL) hf
cruiser:(BOOL) cr
battelship:(BOOL)bs
colony:(BOOL)cs
recycler:(BOOL) rc
bomber:(BOOL) bb
destroyer:(BOOL)ds
deathstar:(BOOL) rip
battlecruiser:(BOOL) bc
general:(BOOL) gen
eventFactor:(double) event
hyper:(NSInteger)hyp
impulsion:(NSInteger)imp
combustion:(NSInteger)com
departureTime:(NSDate*) departure_time
remainingTime:(NSInteger) remaining_SecondsBeforeRecall
origA:(NSInteger)origgal
origB:(NSInteger)origsys
origC:(NSInteger)origpla
destA:(NSInteger)destgal
destB:(NSInteger)destsys
destC:(NSInteger)destpla
{
    SC = sc;
    LC = lc;
    LF = lf;
    HF = hf;
    CR = cr;
    BS = bs;
    COL = cs;
    REC = rc;
    BB = bb;
    DS = ds;
    RIP = rip;
    BC = bc;
    use_general = gen;
    event_factor = event;
    Hyperspace_drive_level = hyp;
    Impulse_drive_level = imp;
    Combustion_drive_level = com;
    departureTime = departure_time;
    remainingSecondsBeforeRecall = remaining_SecondsBeforeRecall;
    orig_gal = origgal;
    orig_pla = origpla;
    orig_sys = origsys;
    targ_gal = destgal;
    targ_pla = destpla;
    targ_sys = destsys;
    
    ship_speed_factor_hyp = (1 + (double)Hyperspace_drive_level * Hyperspace_drive_level_bonus);
    ship_speed_factor_imp = (1 + (double)Impulse_drive_level    * Impusle_drive_level_bonus);
    ship_speed_factor_com = (1 + (double)Combustion_drive_level * Combustion_drive_level_bonus);
    
    _output = @"";
    _outputArrival = @"";
}



- (NSInteger) Calculate
{
   
    _output = @"";
    _outputArrival = @"";
    NSInteger slowest_ship_speed = [self Calculate_Slowest_Ship_Speed];
    if (slowest_ship_speed == 0)
    {
        _output = @"Enter your inputs \n\n\n\n\n\n\n\n";
        return 200;
    }
    double distance = [self Calculate_Distance];
    
    NSInteger flight_time100 = [self Calculate_Flight_Time:100 slowestSpeed:slowest_ship_speed dist:distance ];
    NSInteger flight_time90  = [self Calculate_Flight_Time:90  slowestSpeed:slowest_ship_speed dist:distance ];
    NSInteger flight_time80  = [self Calculate_Flight_Time:80  slowestSpeed:slowest_ship_speed dist:distance ];
    NSInteger flight_time70  = [self Calculate_Flight_Time:70  slowestSpeed:slowest_ship_speed dist:distance ];
    NSInteger flight_time60  = [self Calculate_Flight_Time:60  slowestSpeed:slowest_ship_speed dist:distance ];
    NSInteger flight_time50  = [self Calculate_Flight_Time:50  slowestSpeed:slowest_ship_speed dist:distance ];
    NSInteger flight_time40  = [self Calculate_Flight_Time:40  slowestSpeed:slowest_ship_speed dist:distance ];
    NSInteger flight_time30  = [self Calculate_Flight_Time:30  slowestSpeed:slowest_ship_speed dist:distance ];
    NSInteger flight_time20  = [self Calculate_Flight_Time:20  slowestSpeed:slowest_ship_speed dist:distance ];
    NSInteger flight_time10  = [self Calculate_Flight_Time:10  slowestSpeed:slowest_ship_speed dist:distance ];
    
    
    
    NSInteger flight_time_hours = [self Convert_TotalSeconds_To_Hours:flight_time100];
    NSInteger flight_time_minutes = [self Convert_TotalSeconds_To_Minutes:flight_time100 hours:flight_time_hours];
    NSInteger flight_time_seconds = [self Convert_TotalSeconds_To_Seconds:flight_time100 hours:flight_time_hours mins:flight_time_minutes];
    NSString* outputText = [NSString stringWithFormat:@"%@%@",
                            @"100%:",[self GetStringFromRemainingTimeAtRecall:flight_time_hours minutes:flight_time_minutes seconds:flight_time_seconds isReturnDuration:true]];
    NSString* outputTextArrival = [self GetStringFromRemainingTimeAtRecall:flight_time_hours minutes:flight_time_minutes seconds:flight_time_seconds isReturnDuration:false];
    
    
    flight_time_hours = [self Convert_TotalSeconds_To_Hours:flight_time90];
    flight_time_minutes = [self Convert_TotalSeconds_To_Minutes:flight_time90 hours:flight_time_hours];
    flight_time_seconds = [self Convert_TotalSeconds_To_Seconds:flight_time90 hours:flight_time_hours mins:flight_time_minutes];
    outputText = [NSString stringWithFormat:@"%@%@%@",outputText,
                @"\n90%:",[self GetStringFromRemainingTimeAtRecall:flight_time_hours minutes:flight_time_minutes seconds:flight_time_seconds isReturnDuration:true]];
    outputTextArrival = [NSString stringWithFormat:@"%@%@", outputTextArrival, [self GetStringFromRemainingTimeAtRecall:flight_time_hours minutes:flight_time_minutes seconds:flight_time_seconds isReturnDuration:false]];
    
    
    
    
    flight_time_hours = [self Convert_TotalSeconds_To_Hours:flight_time80];
    flight_time_minutes = [self Convert_TotalSeconds_To_Minutes:flight_time80 hours:flight_time_hours];
    flight_time_seconds = [self Convert_TotalSeconds_To_Seconds:flight_time80 hours:flight_time_hours mins:flight_time_minutes];
    outputText = [NSString stringWithFormat:@"%@%@%@",outputText,
                  @"\n80%:",[self GetStringFromRemainingTimeAtRecall:flight_time_hours minutes:flight_time_minutes seconds:flight_time_seconds isReturnDuration:true]];
    outputTextArrival = [NSString stringWithFormat:@"%@%@", outputTextArrival, [self GetStringFromRemainingTimeAtRecall:flight_time_hours minutes:flight_time_minutes seconds:flight_time_seconds isReturnDuration:false]];
    
    
    
    
    flight_time_hours = [self Convert_TotalSeconds_To_Hours:flight_time70];
    flight_time_minutes = [self Convert_TotalSeconds_To_Minutes:flight_time70 hours:flight_time_hours];
    flight_time_seconds = [self Convert_TotalSeconds_To_Seconds:flight_time70 hours:flight_time_hours mins:flight_time_minutes];
    outputText = [NSString stringWithFormat:@"%@%@%@",outputText,
                  @"\n70%:",[self GetStringFromRemainingTimeAtRecall:flight_time_hours minutes:flight_time_minutes seconds:flight_time_seconds isReturnDuration:true]];
    outputTextArrival = [NSString stringWithFormat:@"%@%@", outputTextArrival, [self GetStringFromRemainingTimeAtRecall:flight_time_hours minutes:flight_time_minutes seconds:flight_time_seconds isReturnDuration:false]];
    
    
    
    
    
    flight_time_hours = [self Convert_TotalSeconds_To_Hours:flight_time60];
    flight_time_minutes = [self Convert_TotalSeconds_To_Minutes:flight_time60 hours:flight_time_hours];
    flight_time_seconds = [self Convert_TotalSeconds_To_Seconds:flight_time60 hours:flight_time_hours mins:flight_time_minutes];
    outputText = [NSString stringWithFormat:@"%@%@%@",outputText,
                  @"\n60%:",[self GetStringFromRemainingTimeAtRecall:flight_time_hours minutes:flight_time_minutes seconds:flight_time_seconds isReturnDuration:true]];
    outputTextArrival = [NSString stringWithFormat:@"%@%@", outputTextArrival, [self GetStringFromRemainingTimeAtRecall:flight_time_hours minutes:flight_time_minutes seconds:flight_time_seconds isReturnDuration:false]];
    
    
    
    
    
    
    
    flight_time_hours = [self Convert_TotalSeconds_To_Hours:flight_time50];
    flight_time_minutes = [self Convert_TotalSeconds_To_Minutes:flight_time50 hours:flight_time_hours];
    flight_time_seconds = [self Convert_TotalSeconds_To_Seconds:flight_time50 hours:flight_time_hours mins:flight_time_minutes];
    outputText = [NSString stringWithFormat:@"%@%@%@",outputText,
                  @"\n50%:",[self GetStringFromRemainingTimeAtRecall:flight_time_hours minutes:flight_time_minutes seconds:flight_time_seconds isReturnDuration:true]];
    outputTextArrival = [NSString stringWithFormat:@"%@%@", outputTextArrival, [self GetStringFromRemainingTimeAtRecall:flight_time_hours minutes:flight_time_minutes seconds:flight_time_seconds isReturnDuration:false]];
    
    
    
    
    
    
    
    
    flight_time_hours = [self Convert_TotalSeconds_To_Hours:flight_time40];
    flight_time_minutes = [self Convert_TotalSeconds_To_Minutes:flight_time40 hours:flight_time_hours];
    flight_time_seconds = [self Convert_TotalSeconds_To_Seconds:flight_time40 hours:flight_time_hours mins:flight_time_minutes];
    outputText = [NSString stringWithFormat:@"%@%@%@",outputText,
                  @"\n40%:",[self GetStringFromRemainingTimeAtRecall:flight_time_hours minutes:flight_time_minutes seconds:flight_time_seconds isReturnDuration:true]];
    outputTextArrival = [NSString stringWithFormat:@"%@%@", outputTextArrival, [self GetStringFromRemainingTimeAtRecall:flight_time_hours minutes:flight_time_minutes seconds:flight_time_seconds isReturnDuration:false]];
    
    
    
    
    
    
    
    flight_time_hours = [self Convert_TotalSeconds_To_Hours:flight_time30];
    flight_time_minutes = [self Convert_TotalSeconds_To_Minutes:flight_time30 hours:flight_time_hours];
    flight_time_seconds = [self Convert_TotalSeconds_To_Seconds:flight_time30 hours:flight_time_hours mins:flight_time_minutes];
    outputText = [NSString stringWithFormat:@"%@%@%@",outputText,
                  @"\n30%:",[self GetStringFromRemainingTimeAtRecall:flight_time_hours minutes:flight_time_minutes seconds:flight_time_seconds isReturnDuration:true]];
    outputTextArrival = [NSString stringWithFormat:@"%@%@", outputTextArrival, [self GetStringFromRemainingTimeAtRecall:flight_time_hours minutes:flight_time_minutes seconds:flight_time_seconds isReturnDuration:false]];
    
    
    
    
    
    
    
    
    
    flight_time_hours = [self Convert_TotalSeconds_To_Hours:flight_time20];
    flight_time_minutes = [self Convert_TotalSeconds_To_Minutes:flight_time20 hours:flight_time_hours];
    flight_time_seconds = [self Convert_TotalSeconds_To_Seconds:flight_time20 hours:flight_time_hours mins:flight_time_minutes];
    outputText = [NSString stringWithFormat:@"%@%@%@",outputText,
                 @"\n20%:",[self GetStringFromRemainingTimeAtRecall:flight_time_hours minutes:flight_time_minutes seconds:flight_time_seconds isReturnDuration:true]];
    outputTextArrival = [NSString stringWithFormat:@"%@%@", outputTextArrival, [self GetStringFromRemainingTimeAtRecall:flight_time_hours minutes:flight_time_minutes seconds:flight_time_seconds isReturnDuration:false]];
    
    
    
    
    
    
    flight_time_hours = [self Convert_TotalSeconds_To_Hours:flight_time10];
    flight_time_minutes = [self Convert_TotalSeconds_To_Minutes:flight_time10 hours:flight_time_hours];
    flight_time_seconds = [self Convert_TotalSeconds_To_Seconds:flight_time10 hours:flight_time_hours mins:flight_time_minutes];
    outputText = [NSString stringWithFormat:@"%@%@%@",outputText,
                  @"\n10%:",[self GetStringFromRemainingTimeAtRecall:flight_time_hours minutes:flight_time_minutes seconds:flight_time_seconds isReturnDuration:true]];
    outputTextArrival = [NSString stringWithFormat:@"%@%@", outputTextArrival, [self GetStringFromRemainingTimeAtRecall:flight_time_hours minutes:flight_time_minutes seconds:flight_time_seconds isReturnDuration:false]];
    
    
    
    _output = outputText;
    _outputArrival = outputTextArrival;
    return 0;
}

- (NSString*) formatValue:(int) value forDigits:(int)zeros
{
    NSString* format = [NSString stringWithFormat:@"%%0%dd", zeros];
    return [NSString stringWithFormat:format, value];
}

///////////////////////////////////////////////////
// Lowest Speed
///////////////////////////////////////////////////

- (NSInteger) Calculate_Slowest_Ship_Speed
{
    double actual_ship_speed_SC = 0;  //comb-imp
    double actual_ship_speed_LC = 0;  //comb
    double actual_ship_speed_LF = 0;  //comb
    double actual_ship_speed_HF = 0;  //imp
    double actual_ship_speed_CR = 0;  //imp
    double actual_ship_speed_BS = 0;  //hyp
    double actual_ship_speed_COL = 0; //imp
    double actual_ship_speed_REC = 0; //comb
    double actual_ship_speed_SPY = 0; //comb
    double actual_ship_speed_BB = 0;  //imp-hyp
    double actual_ship_speed_DS = 0;  //hyp
    double actual_ship_speed_RIP = 0; //hyp
    double actual_ship_speed_BC = 0;  //hyp
    
    NSInteger slowest_ship = 0;
    double slowest_ship_speed = 100000000; 	// 390
    
    if (SC)
    {
        if (Impulse_drive_level >= 5) 	// Impulse drive used
        {
            actual_ship_speed_SC = ship_speed_SC_high_impulse5 * ship_speed_factor_imp ;
            actual_ship_speed_SC = actual_ship_speed_SC + (use_general?1.0:0.0) * 0.2 * ship_speed_SC_high_impulse5;
        }
        else				 // Combustion drive used
        {
            actual_ship_speed_SC = ship_speed_SC_low_impulse5 * ship_speed_factor_com ;
            actual_ship_speed_SC = actual_ship_speed_SC  + (use_general?1.0:0.0) * 0.2 * ship_speed_SC_low_impulse5;
        }
        slowest_ship_speed = actual_ship_speed_SC;
        slowest_ship = 1;
    }
    
    if (LC)
    {
        actual_ship_speed_LC = ship_speed_LC * ship_speed_factor_com;
        actual_ship_speed_LC = actual_ship_speed_LC  + (use_general?1.0:0.0) * 0.2 * ship_speed_LC;
        if (actual_ship_speed_LC < slowest_ship_speed)
        {
            slowest_ship_speed = actual_ship_speed_LC;
            slowest_ship = 2;
        }
        
    }
    
    if (LF)
    {
        actual_ship_speed_LF = ship_speed_LF * ship_speed_factor_com;
        actual_ship_speed_LF = actual_ship_speed_LF  + (use_general?1.0:0.0) * 0.2* ship_speed_LF;
        if (actual_ship_speed_LF < slowest_ship_speed)
        {
            slowest_ship_speed = actual_ship_speed_LF;
            slowest_ship = 3;
        }
        
    }
    if (HF)
    {
        actual_ship_speed_HF = ship_speed_HF * ship_speed_factor_imp;
        actual_ship_speed_HF = actual_ship_speed_HF  + (use_general?1.0:0.0) * 0.2 * ship_speed_HF;
        if (actual_ship_speed_HF < slowest_ship_speed)
        {
            slowest_ship_speed = actual_ship_speed_HF;
            slowest_ship = 4;
        }
    }
    if (CR)
    {
        actual_ship_speed_CR = ship_speed_CR * ship_speed_factor_imp;
        actual_ship_speed_CR = actual_ship_speed_CR  + (use_general?1.0:0.0) * 0.2 * ship_speed_CR;
        if (actual_ship_speed_CR < slowest_ship_speed)
        {
            slowest_ship_speed = actual_ship_speed_CR;
            slowest_ship = 5;
        }
    }
    if (BS)
    {
        actual_ship_speed_BS = ship_speed_BS * ship_speed_factor_hyp;
        actual_ship_speed_BS = actual_ship_speed_BS  + (use_general?1.0:0.0) * 0.2 * ship_speed_BS;
        if (actual_ship_speed_BS < slowest_ship_speed)
        {
            slowest_ship_speed = actual_ship_speed_BS;
            slowest_ship = 6;
        }
    }
    if (COL)
    {
        actual_ship_speed_COL = ship_speed_COL * ship_speed_factor_imp;
        actual_ship_speed_COL = actual_ship_speed_COL  + (use_general?1.0:0.0) * 0.2 * ship_speed_COL;
        if (actual_ship_speed_COL < slowest_ship_speed)
        {
            slowest_ship_speed = actual_ship_speed_COL;
            slowest_ship = 7;
        }
    }
    if (REC)
    {
        actual_ship_speed_REC = ship_speed_REC * ship_speed_factor_com;
        actual_ship_speed_REC = actual_ship_speed_REC  + (use_general?1.0:0.0) * 0.2 * ship_speed_REC;
        if (actual_ship_speed_REC < slowest_ship_speed)
        {
            slowest_ship_speed = actual_ship_speed_REC;
            slowest_ship = 8;
        }
    }
    if (SPY)
    {
        actual_ship_speed_SPY = ship_speed_SPY * ship_speed_factor_com;
        actual_ship_speed_SPY = actual_ship_speed_SPY  + (use_general?1.0:0.0) * 0.2 * ship_speed_SPY;
        if (actual_ship_speed_SPY < slowest_ship_speed)
        {
            slowest_ship_speed = actual_ship_speed_SPY ;
            slowest_ship = 9;
        }
    }
    if (BB)
    {
        if (Hyperspace_drive_level >= 5) // Hyperspace drive used
        {
            actual_ship_speed_BB = ship_speed_BB_high_hyper8 * ship_speed_factor_hyp;
            actual_ship_speed_BB = actual_ship_speed_BB  + (use_general?1.0:0.0) * 0.2 * ship_speed_BB_high_hyper8;
        }
        else				 // Impulse drive used
        {
            actual_ship_speed_BB = ship_speed_BB_low_hyper8 * ship_speed_factor_imp;
            actual_ship_speed_BB = actual_ship_speed_BB  + (use_general?1.0:0.0) * 0.2 * ship_speed_BB_low_hyper8;
        }
        if (actual_ship_speed_BB < slowest_ship_speed)
        {
            slowest_ship_speed = actual_ship_speed_BB ;
            slowest_ship = 10;
        }
        
    }
    if (DS)
    {
        actual_ship_speed_DS = ship_speed_DS * ship_speed_factor_hyp;
        actual_ship_speed_DS = actual_ship_speed_DS  + (use_general?1.0:0.0) * 0.2 * ship_speed_DS;
        if (actual_ship_speed_DS < slowest_ship_speed)
        {
            slowest_ship_speed = actual_ship_speed_DS ;
            slowest_ship = 11;
        }
    }
    if (RIP)
    {
        actual_ship_speed_RIP = ship_speed_RIP * ship_speed_factor_hyp;
        actual_ship_speed_RIP = actual_ship_speed_RIP  + (use_general?1.0:0.0) * 0.2 * ship_speed_RIP;
        if (actual_ship_speed_RIP < slowest_ship_speed)
        {
            slowest_ship_speed = actual_ship_speed_RIP ;
            slowest_ship = 12;
        }
    }
    if (BC)
    {
        actual_ship_speed_BC = ship_speed_BC * ship_speed_factor_hyp;
        actual_ship_speed_BC = actual_ship_speed_BC  + (use_general?1.0:0.0) * 0.2 * ship_speed_BC;
        if (actual_ship_speed_BC < slowest_ship_speed)
        {
            slowest_ship_speed = actual_ship_speed_BC ;
            slowest_ship = 13;
        }
    }
    
    if (slowest_ship == 0)
        return 0;
    return (NSInteger)round(slowest_ship_speed);
}

///////////////////////////////////////////////////
// Distance calculation
///////////////////////////////////////////////////

- (double) Calculate_Distance
{
    double distance = 0;
    if (targ_gal != orig_gal)
    {
        distance = 20000 * abs(targ_gal - orig_gal);
    }
    else
    {
        if (targ_sys != orig_sys)
        {
            distance = 2700 + (95 * abs(targ_sys - orig_sys));
        }
        else
        {
            if (targ_pla != orig_pla)
            {
                distance = 1000 + (5 * abs(targ_pla - orig_pla));
            }
            else
            {
                distance = 5;
            }
        }
    }
    return distance;
}
///////////////////////////////////////////////////
// Flight time
///////////////////////////////////////////////////
- (NSInteger) Calculate_Flight_Time: (NSInteger) fleet_Speed_Fraction
                        slowestSpeed:(NSInteger) slowest_ship_speed
                                dist:(double) distance
{
    double flight_time = 0;
    flight_time = (35000 / fleet_Speed_Fraction * pow(distance * 1000 / slowest_ship_speed, 0.5) + 10) / universe_speed / event_factor;
    
    return  (NSInteger) round(flight_time);// in seconds
}

- (NSInteger) Convert_TotalSeconds_To_Hours:(NSInteger) totalseconds
{
    return (NSInteger)floor ((double)(totalseconds / 3600));
}

- (NSInteger) Convert_TotalSeconds_To_Minutes:(NSInteger) totalseconds
                                        hours:(NSInteger) flight_time_hours
{
    return (NSInteger)floor ((double)(totalseconds / 60 - flight_time_hours * 60));
}
- (NSInteger) Convert_TotalSeconds_To_Seconds: (NSInteger) totalseconds
                                        hours: (NSInteger) flight_time_hours
                                         mins: (NSInteger) flight_time_minutes
{
    return (NSInteger) floor ((double)(totalseconds - 60*flight_time_minutes - 3600*flight_time_hours));
}

- (NSString*)GetStringFromDepartureTime:(NSInteger) flight_time_days
                                  hours:(NSInteger) flight_time_hours
                                minutes:(NSInteger) flight_time_minutes
                                seconds:(NSInteger) flight_time_seconds
{
    NSDateComponents* compCurrentDate = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:departureTime];
    
    NSTimeInterval secondsToAdd = flight_time_seconds
    + flight_time_minutes*60
    + flight_time_hours * 3600
    + flight_time_days * 86400;
    NSDate *arrivalDate = [departureTime dateByAddingTimeInterval:secondsToAdd];
    
    NSDateComponents* compArrival = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:arrivalDate];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    NSString* text = [NSString stringWithFormat:@"\t\t\t%@ (+%d)\n",
            [formatter stringFromDate:arrivalDate],
            compArrival.day - compCurrentDate.day];
    
    return text;
}

- (NSString*)GetStringFromRemainingTimeAtRecall:(NSInteger) flight_time_hours
                                minutes:(NSInteger) flight_time_minutes
                                seconds:(NSInteger) flight_time_seconds
                                isReturnDuration:(Boolean)returnDuration
{
    
    
    NSTimeInterval flightDurationInSeconds = flight_time_seconds + flight_time_minutes*60 + flight_time_hours * 3600;
    
    NSTimeInterval remainingSecondsBeforeReturn = flightDurationInSeconds - remainingSecondsBeforeRecall;
    
    if (remainingSecondsBeforeReturn <= 0 && returnDuration)
        return @"---------";
    else if (remainingSecondsBeforeReturn <= 0 && !returnDuration)
        return @"---------\n";
    
    
    int durD = floor (remainingSecondsBeforeReturn/86400);
    int durH = floor ((remainingSecondsBeforeReturn - durD*86400)/3600);
    int durM = floor ((remainingSecondsBeforeReturn - durD*86400 - durH*3600)/60);
    int durS = round (remainingSecondsBeforeReturn - durD*86400 - durH*3600 - durM*60);
    
    if (returnDuration)
    {
        return [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",
        [self formatValue:durD forDigits:1],@"d",
        [self formatValue:durH forDigits:2],@"h",
        [self formatValue:durM forDigits:2],@"m",
        [self formatValue:durS forDigits:2],@"s"];
    }
    else
    {
        return [self GetStringFromDepartureTime:durD hours:durH minutes:durM seconds:durS];
    }
    /*
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    NSString* text = [NSString stringWithFormat:@"\t\t\t%@ (+%d)\n",
                      [formatter stringFromDate:returnDate],
                      compArrival.day - compCurrentDate.day];
    
    return text;*/
}
















- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
