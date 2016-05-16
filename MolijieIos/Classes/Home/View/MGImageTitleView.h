//
//  MGPhotoView.h
//  
//
//  Created by yexifeng on 15/11/19.
//
//

#import <UIKit/UIKit.h>
#import "IndexBlock.h"

@interface MGImageTitleView : UIImageView
@property(nonatomic,strong)UILabel* nameLabel;

-(void)setTitle:(NSString*)title;
-(void)setImageId:(NSString*)url;
@end
