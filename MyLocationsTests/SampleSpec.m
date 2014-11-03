//
//  SampleSpec.m
//  MyLocations
//
//  Created by Iino Daisuke on 2014/11/03.
//  Copyright (c) 2014年 Iino Daisuke. All rights reserved.
//
#import "Kiwi.h"


SPEC_BEGIN(MathSpec2)

describe(@"Math", ^{
    it(@"is wonglyy answered", ^{
        NSUInteger a = 20;
        NSUInteger b = 10;
        [[theValue(a - b) should] equal:theValue(9)];
    });
});

SPEC_END