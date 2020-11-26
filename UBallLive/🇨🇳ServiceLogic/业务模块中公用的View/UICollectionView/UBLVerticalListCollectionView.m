//
//  VerticalListCollectionView.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/10/10.
//  Copyright © 2018 jiaxin. All rights reserved.
//

#import "UBLVerticalListCollectionView.h"

@implementation UBLVerticalListCollectionView

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.layoutSubviewsCallback) {
        self.layoutSubviewsCallback();
    }
}

@end
