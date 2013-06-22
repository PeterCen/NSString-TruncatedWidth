//
//  NSString+NSString_TruncateWidth.m
//  OohLaLa 3.0
//
//  Created by Peter Cen on 13-03-29.
//
//

#import "NSString+TruncateWidth.h"

@implementation NSString (TruncateWidth)

- (NSInteger) indexForTruncatedStringWithWidth:(CGFloat) targetWidth forFont:(UIFont *)font {
    
    //Modified from http://stackoverflow.com/questions/10690701/nsstring-constrainedtosize-method
    
    
    NSInteger imin = 0;
    NSInteger stringWidth = [self sizeWithFont:font].width;
    NSLog(@"stringWidth %d", stringWidth);
    NSInteger imax = self.length-1;
    NSLog(@"imax: %d", imax);
    if (stringWidth <= targetWidth) {
        return -1;
    }
    
    while (imax > imin)
    {
        /* calculate the midpoint for roughly equal partition */
        int imid = (imin + imax) / 2;
        
        // determine which subarray to search
        float width = [[self substringToIndex:imid] sizeWithFont:font].width;
        if      (width < targetWidth)
            // change min index to search upper subarray
            imin = imid + 1;
        else if (width > targetWidth )
            // change max index to search lower subarray
            imax = imid - 1;
        else
            // exact match found at index imid
            return imid;
    }
    // Normally, this is the "not found" case, but we're just looking for
    // the best fit, so we return something here.
    return imin;
}

- (NSArray *) componentsSeparatedByWidth:(CGFloat)width forFont:(UIFont *)font maxStrings:(int)maxStrings {
    NSLog(@"string %@", self);
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSInteger stringWidth = [self sizeWithFont:font].width;
    NSInteger stringCount = maxStrings;
    if (stringWidth <= width) {
        return [NSArray arrayWithObject:self];
    }
    NSMutableString *string = [self mutableCopy];
    NSInteger stringIndex = self.length-1;
    while (stringIndex > 0 && maxStrings > 0) {
        stringIndex = [string indexForTruncatedStringWithWidth:width forFont:font];
        
        if (stringIndex <= 0) {
            if (string.length > 0) {
                [array addObject:string];
            }
            break;
        }
        if (maxStrings != 0) {
            stringCount--;
            if (stringCount == 0) {
                [array addObject:string];
                break;
            }
        }
        
        //Find first space infront of cut
        BOOL foundSpace = NO;
        for(int i=stringIndex;i>=0;i--) {
            NSLog(@"index %d", i);
            NSLog(@"char %c", [string characterAtIndex:i]);
            if(' ' == [string characterAtIndex:i]) {
                [array addObject:[string substringToIndex:i]];
                [string setString:[string substringFromIndex:i+1]];
                foundSpace = YES;
                break;
            }
        }
        if (!foundSpace) {
            [array addObject:string];
            break;
        }
    }
    for (NSString *string in array) {
        NSLog(@"seperated component %@", string);
    }
    return [NSArray arrayWithArray:array];
}

@end
