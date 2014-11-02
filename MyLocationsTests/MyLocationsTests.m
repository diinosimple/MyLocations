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
    it(@"この計算式は合っておる", ^{
        NSUInteger a = 16;
        NSUInteger b = 26;
        [[theValue(a + b) should] equal:theValue(42)];
    });
});

SPEC_END