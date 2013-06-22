//
//  NSString+NSString_TruncateWidth.h
//  OohLaLa 3.0
//
//  Created by Peter Cen on 13-03-29.
//
//

#import <Foundation/Foundation.h>

@interface NSString (TruncateWidth)

- (NSInteger) indexForTruncatedStringWithWidth:(CGFloat) width forFont:(UIFont *)font;
- (NSArray *) componentsSeparatedByWidth:(CGFloat)width forFont:(UIFont *)font maxStrings:(int)maxStrings;
@end
