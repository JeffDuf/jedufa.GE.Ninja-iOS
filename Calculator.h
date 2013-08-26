//
//  Calculator.h
//  test5
//
//  Created by JF Dufour on 4/21/13.
//  Copyright (c) 2013 JF Dufour. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Calculator : UIView



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
             destC:(NSInteger)destpla;


- (NSInteger) Calculate;


@property (strong, nonatomic) NSString* output ;
@property (strong, nonatomic) NSString* outputArrival;


@end
