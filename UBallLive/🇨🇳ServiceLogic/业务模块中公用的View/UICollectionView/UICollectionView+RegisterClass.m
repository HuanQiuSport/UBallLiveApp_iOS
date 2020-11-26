//
//  UICollectionView+RegisterClass.m
//  UBallLive
//
//  Created by Jobs on 2020/10/31.
//

#import "UICollectionView+RegisterClass.h"

@implementation UICollectionView (RegisterClass)

-(void)RegisterClass{
    
    [self registerClass:UBLSearchCollectionReusableView.class
        forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
               withReuseIdentifier:@"UBLSearchCollectionReusableView"];
    [self registerClass:UBLHotCollectionReusableView.class
        forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
               withReuseIdentifier:@"UBLHotCollectionReusableView"];
    [self registerClass:UBLAllCollectionReusableView.class
        forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
               withReuseIdentifier:@"UBLAllCollectionReusableView"];
    [self registerClass:UBLVerticalSectionHeaderView.class
    forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
               withReuseIdentifier:@"UBLVerticalSectionHeaderView"];
    [self registerClass:UBLVerticalSectionCategoryHeaderView.class
        forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
               withReuseIdentifier:@"UBLVerticalSectionCategoryHeaderView"];
    [self registerClass:UBLMatchIndexCollectionReusableView.class
        forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
               withReuseIdentifier:@"UBLMatchIndexCollectionReusableView"];
    [self registerClass:UBLTimeCollectionReusableView.class
        forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
               withReuseIdentifier:@"UBLTimeCollectionReusableView"];
    
    [self registerClass:UBLVideoCollectionViewCell_Style1.class
        forCellWithReuseIdentifier:@"UBLVideoCollectionViewCell_Style1"];
    [self registerClass:UBLVideoCollectionViewCell_Style2.class
        forCellWithReuseIdentifier:@"UBLVideoCollectionViewCell_Style2"];
    [self registerClass:UBLVideoCollectionViewCell_Style3.class
        forCellWithReuseIdentifier:@"UBLVideoCollectionViewCell_Style3"];
    [self registerClass:UBLVideoCollectionViewCell_Style4.class
        forCellWithReuseIdentifier:@"UBLVideoCollectionViewCell_Style4"];
    [self registerClass:UBLVideoCollectionViewCell_Style5.class
        forCellWithReuseIdentifier:@"UBLVideoCollectionViewCell_Style5"];
    [self registerClass:UBLVideoCollectionViewCell_Style6.class
        forCellWithReuseIdentifier:@"UBLVideoCollectionViewCell_Style6"];
    [self registerClass:UBLVideoCollectionViewCell_Style7.class
        forCellWithReuseIdentifier:@"UBLVideoCollectionViewCell_Style7"];
    [self registerClass:UBLVideoCollectionViewCell_Style8.class
        forCellWithReuseIdentifier:@"UBLVideoCollectionViewCell_Style8"];
    [self registerClass:UBLVideoCollectionViewCell_Style9.class
        forCellWithReuseIdentifier:@"UBLVideoCollectionViewCell_Style9"];
    [self registerClass:UBLVideoCollectionViewCell_Style10.class
        forCellWithReuseIdentifier:@"UBLVideoCollectionViewCell_Style10"];
    [self registerClass:UBLVideoCollectionViewCell_Style11.class
        forCellWithReuseIdentifier:@"UBLVideoCollectionViewCell_Style11"];
    [self registerClass:UBLVideoCollectionViewCell_Style12.class
        forCellWithReuseIdentifier:@"UBLVideoCollectionViewCell_Style12"];
    [self registerClass:UBLVideoCollectionViewCell_Style13.class
        forCellWithReuseIdentifier:@"UBLVideoCollectionViewCell_Style13"];
    [self registerClass:UBLVideoCollectionViewCell_Style14.class
        forCellWithReuseIdentifier:@"UBLVideoCollectionViewCell_Style14"];
    [self registerClass:UBLVideoCollectionViewCell_Style15.class
        forCellWithReuseIdentifier:@"UBLVideoCollectionViewCell_Style15"];
    [self registerClass:UBLVideoCollectionViewCell_Style16.class
        forCellWithReuseIdentifier:@"UBLVideoCollectionViewCell_Style16"];
    [self registerClass:UBLVideoCollectionViewCell_Style17.class
        forCellWithReuseIdentifier:@"UBLVideoCollectionViewCell_Style17"];
    [self registerClass:UBLVideoCollectionViewCell_Style18.class
        forCellWithReuseIdentifier:@"UBLVideoCollectionViewCell_Style18"];
}

@end
