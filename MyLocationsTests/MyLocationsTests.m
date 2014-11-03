//
//  MyLocationsTests.m
//  MyLocationsTests
//
//  Created by Iino Daisuke on 2014/02/15.
//  Copyright (c) 2014年 Iino Daisuke. All rights reserved.
//


#import "Kiwi.h"

SPEC_BEGIN(MathSpec)

describe(@"Math", ^{
    it(@"is correctly answered", ^{
        NSUInteger a = 16;
        NSUInteger b = 26;
        [[theValue(a + b) should] equal:theValue(42)];
    });
});

describe(@"Math", ^{
    it(@"is wonglyy answered", ^{
        NSUInteger a = 20;
        NSUInteger b = 10;
        [[theValue(a - b) should] equal:theValue(10)];
    });
});

SPEC_END