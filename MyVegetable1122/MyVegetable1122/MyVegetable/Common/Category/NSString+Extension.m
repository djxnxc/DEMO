

#import "NSString+Extension.h"

@implementation NSString (Extension)
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
+ (NSString *)moneyString:(NSString *)str{
    
//    self
    if (str) {
        if (str.length>4) {
            NSRange range = [str rangeOfString:@"."];
            NSString *s1 = [str substringToIndex:range.location];
            NSString *s2 = [str substringFromIndex:range.location];
            NSInteger l = s1.length;
            if (l>3) {
                
                
            }else{
                return str;
            }
        }else{
            return str;
        }
        
        
        
    }
    return str;
}

+(NSString *)countNumAndChangeformat:(NSString *)num
{
   
    /*int count = 0;
    long long int a = num.longLongValue;
    while (a != 0)
    {
        count++;
        a /= 10;
    }
    NSMutableString *string = [NSMutableString stringWithString:num];
    NSMutableString *newstring = [NSMutableString string];
    while (count > 3) {
        count -= 3;
        NSRange rang = NSMakeRange(string.length - 3, 3);
        NSString *str = [string substringWithRange:rang];
        [newstring insertString:str atIndex:0];
        [newstring insertString:@"," atIndex:0];
        [string deleteCharactersInRange:rang];
    }
    [newstring insertString:string atIndex:0];*/
    NSNumberFormatter* numberFormatter=[[NSNumberFormatter alloc]init];
    //[numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [numberFormatter setPositiveFormat:@"###,##0.00"];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
   // NSString* mon=[NSString stringWithFormat:@"%.2f",[num floatValue]];
    NSString* number=[numberFormatter stringFromNumber:[NSNumber numberWithDouble:[num doubleValue]]];
    return number;
}

//char *int2str_withcommas(long number){
//    char *result_str = (char *)malloc(sizeof(char)*20);
//    
//    int iNumCount = 0,iComma = 0,iStrlen = 0,iHead = 0;
//    //iNumCount是数字个数，iComma是逗号个数，iStrlen是字符串长度，不包括结尾空格，iHead是结头位置
//   
//    long fabsNumber = fabs(number);
//    //取绝对值便于处理。
//    long tmp = fabsNumber;
//    
//    //计算数字的个数
//    while (tmp > 0) {
//        tmp /= 10;
//        iNumCount ++;
//    }
//    
//    //计算需要多少个逗号
//    iComma= iNumCount/3;
//    
//    //计算字符串长度
//    if (number < 0) {
//        iStrlen = iNumCount + 1 + iComma;
//        result_str[0] = '-';
//    }else iStrlen = iNumCount + iComma;
//    
//    //每三位为一块，iHead是每块头位置的字符位置(倒序）
//    //并且在字符串后边补上'\0'
//    iHead = iStrlen;
//    result_str[iStrlen] = '\0';
//    
//    //关键部分
//    while (iStrlen >= 1&&fabsNumber >0) {
//        if ((iHead-iStrlen) ==3) {
//            result_str[iStrlen-1] = ',';
//            iStrlen--;
//            iHead -=4;
//        }
//        result_str[iStrlen-1] = fabsNumber%10 + '0';
//        fabsNumber /= 10;
//        iStrlen --;
//    }
//    return result_str;
//}


//判断字符串是否是整型
- (BOOL)isPureInt:(NSString*)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    
    int val;
    
    return[scan scanInt:&val] && [scan isAtEnd];
    
}
//判断是否为浮点形：
- (BOOL)isPureFloat:(NSString*)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    
    float val;
    
    return[scan scanFloat:&val] && [scan isAtEnd];
    
}
//textfield
+(BOOL)textfieldHaveText:(UITextField *)textfield {
    if ([textfield isKindOfClass:[NSNull class]]|[textfield.text isKindOfClass:[NSNull class]]) {
        return NO;
    }
    else if(textfield.text == nil|textfield == nil){
        return NO;
    }
    else if (textfield.text.length==0) {
        return NO;
    }
    else {
        NSString *str = textfield.text;
        if ([[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
            return NO;
        }
        else{
            return YES;
        }
    }
    return NO;
}
+ (NSString *)resetNSString:(NSString *)str {
    NSArray *arr = [str componentsSeparatedByString:str];
    NSMutableArray *marr = [NSMutableArray arrayWithArray:arr];
    NSMutableArray *a = [NSMutableArray array];
    for (int i=0; i<marr.count; i++) {
        if (i+1%4) {
            [a addObject:marr[i]];
            [a addObject:@" "];
        }else{
            [a addObject:marr[i]];
        }
    }
    
    return [a componentsJoinedByString:@""];
}
+(NSString *)SubWhiteSpaceString:(NSString *)str {
    NSString *strUrl = [str  stringByReplacingOccurrencesOfString:@" " withString:@""];
    return strUrl;
}
@end
