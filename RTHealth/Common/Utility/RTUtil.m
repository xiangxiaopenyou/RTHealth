//
//  RTUtil.m
//  RTHealth
//
//  Created by cheng on 14/10/22.
//  Copyright (c) 2014年 realtech. All rights reserved.
//

#import "RTUtil.h"

@implementation RTUtil

+ (BOOL)matchtelphone:(NSString*)string
{
    NSString *regexString = @"^[0-9]{11}$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexString];
    return [emailTest evaluateWithObject:string];
}

+ (BOOL) isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:mobile];
}

+ (BOOL)matchpassword:(NSString*)string
{
    NSString *regexString = @"^[0-9a-zA-Z]{6,16}$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexString];
    return [emailTest evaluateWithObject:string];
}

+ (BOOL)isEmpty:(id)sender
{
    if (sender == nil || [sender isEqual:@""] || sender == [NSNull null] ||[sender isEqual:[NSNull null]]) {
        return YES;
    }
    return NO;
}

//判断字符串是否为空
+ (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

+ (BOOL)isLogin
{
    if (![RTUtil isEmpty:[[NSUserDefaults standardUserDefaults] objectForKey:@"userid"]]) {
        return YES;
    }
    return NO;
}

+ (NSString*)urlPhoto:(NSString*)key
{
    if ([self isEmpty:key]) {
        return [NSString stringWithFormat:@"%@%@",URL_FOCUSMAP,@"1.png?imageView/5/w/320/h/480"];
    }else{
        NSArray *urlComps = [key componentsSeparatedByString:@"://"];
        if([urlComps count] && ( [[urlComps objectAtIndex:0] isEqualToString:@"http"]||[[urlComps objectAtIndex:0] isEqualToString:@"https"] ))
        {
            return key;
        }
        return [NSString stringWithFormat:@"%@%@",URL_FOCUSMAP,key];
    }
}

+ (NSString*)urlZoomPhoto:(NSString*)key{
    if ([self isEmpty:key]) {
        return [NSString stringWithFormat:@"%@%@",URL_FOCUSMAP,@"1.png?imageView/5/w/160/h/160"];
    }else{
        
        NSArray *urlComps = [key componentsSeparatedByString:@"://"];
        if([urlComps count] && ([[urlComps objectAtIndex:0] isEqualToString:@"http"]||[[urlComps objectAtIndex:0] isEqualToString:@"https"]))
        {
            return [NSString stringWithFormat:@"%@?imageView/5/w/160/h/160", key];
        }
        return [NSString stringWithFormat:@"%@%@?imageView/5/w/160/h/160",URL_FOCUSMAP,key];
    }
}
+ (NSString*)urlWeixinPhoto:(NSString *)key{
    if ([self isEmpty:key]) {
        return [NSString stringWithFormat:@"%@%@",URL_FOCUSMAP,@"1.png?imageView/3/w/40/h/40"];
    }else{
        
        NSArray *urlComps = [key componentsSeparatedByString:@"://"];
        if([urlComps count] && ([[urlComps objectAtIndex:0] isEqualToString:@"http"]||[[urlComps objectAtIndex:0] isEqualToString:@"https"]))
        {
            return [NSString stringWithFormat:@"%@?imageView/3/w/40/h/40", key];
        }
        return [NSString stringWithFormat:@"%@%@?imageView/3/w/40/h/40",URL_FOCUSMAP,key];
    }
}

+ (void)notificationRegister{
    
    RTUserInfo *userData = [RTUserInfo getInstance];
    UserInfo *userinfo = userData.userData;
    [[UIApplication sharedApplication]cancelAllLocalNotifications];
    if ([RTUtil isEmpty:userinfo.healthplan]) {
        return;
    }else{
        HealthPlan *plan = userinfo.healthplan;
        for (SmallHealthPlan *smallPlan in plan.smallhealthplan) {
            UILocalNotification *localNotification = [[UILocalNotification alloc]init];
            if (localNotification == nil) {
                return;
            }
            NSString *dateString = [NSString stringWithFormat:@"%@ %@",[CustomDate getBirthDayString:plan.planbegindate],smallPlan.smallplanbegintime];
            @try{
                NSDate *date = [CustomDate getDateTime:dateString];
                NSCalendar *calendar = [NSCalendar currentCalendar];
                NSDateComponents *comps;
                comps = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:date];
                NSInteger days = [smallPlan.smallplansequence intValue];
                NSInteger cycle = [smallPlan.smallplancycle intValue];
                NSInteger round = [plan.plancycleday intValue];
                [comps setHour:+(24*(days-1 + (cycle-1)*round))]; //+24表示获取下一天的date，-24表示获取前一天的date；
                [comps setMinute:0];
                [comps setSecond:0];
                NSDate *nowDate = [calendar dateByAddingComponents:comps toDate:date options:0];
                if ([nowDate compare:[NSDate date]] != NSOrderedAscending) {
                    
                NSLog(@"now Date %@",nowDate);
                localNotification.fireDate = nowDate;
                localNotification.timeZone = [NSTimeZone defaultTimeZone];
                NSString *content =[NSString stringWithFormat:@"%@: %ld分钟",[sports objectAtIndex:[smallPlan.smallplantype intValue]],(long)[CustomDate getTimeDistance:smallPlan.smallplanbegintime toTime:smallPlan.smallplanendtime]];
                localNotification.alertBody = [NSString stringWithFormat:@"亲，您在健身坊的今日任务 %@,%@ 可以开始了喔。",smallPlan.smallplanbegintime,content];//smallPlan.smallplanmark;
                localNotification.alertAction = @"查看";
                localNotification.soundName = UILocalNotificationDefaultSoundName;
                NSDictionary *infoDic = [NSDictionary dictionaryWithObjectsAndKeys:smallPlan.smallplanid,@"id",nil];
                localNotification.userInfo = infoDic;
                
                [[UIApplication sharedApplication]scheduleLocalNotification:localNotification];
                }
            }
            @catch (NSException *exception){
            }
        }
    }
}


@end
