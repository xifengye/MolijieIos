//
//  MGPhotoView.m
//  
//
//  Created by yexifeng on 15/11/19.
//
//

#import "MGImageTitleView.h"
#import "UIImageView+WebCache.h"
#import "AppDataTool.h"

@implementation MGImageTitleView

-(instancetype)init{
    if(self = [super init]){
        UILabel* nameLabel = [[UILabel alloc] init];
        [nameLabel setTextColor:[UIColor whiteColor]];
        [nameLabel setFont:[UIFont systemFontOfSize:11.0f]];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        [nameLabel setBackgroundColor:[UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:0.4f]];
        self.nameLabel = nameLabel;
        [self addSubview:nameLabel];
        
    }
    return self;
}


-(void)setTitle:(NSString*)title{
    if(title==nil || title.length<=0){
        self.nameLabel.hidden = YES;
    }else{
        self.nameLabel.hidden = NO;
        [self.nameLabel setText:title];
    }
    
}


-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat height = 25;
    CGRect r = CGRectMake(0, self.frame.size.height-height, self.frame.size.width, height);
    self.nameLabel.frame =r;
}


@end
