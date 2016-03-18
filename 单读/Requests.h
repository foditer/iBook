//
//  Requests.h
//  单读
//
//  Created by mac on 16/2/5.
//  Copyright © 2016年 mac. All rights reserved.
//

#ifndef Requests_h
#define Requests_h

#define kRequestHomeArticle @"http://static.owspace.com/index.php?m=Home&c=Api&a=getList&p=1&client=iphone&page_id=0&create_time=0&iOS_version=1.0.0"

#define kRequestHomePageArticle(page,page_id,create_time) [NSString stringWithFormat:@"http://static.owspace.com/index.php?m=Home&c=Api&a=getList&p=%d&client=iphone&page_id=%d&create_time=%d&iOS_version=1.0.0",page,page_id,create_time]

#define kRequestMoreCalendar(page,page_id,create_time) [NSString stringWithFormat:@"http://static.owspace.com/index.php?m=Home&c=Api&a=getList&model=4&p=%d&client=iphone&page_id=%d&create_time=%d&iOS_version=1.0.0",page,page_id,create_time]

#define kRequestCalendar @"http://static.owspace.com/index.php?m=Home&c=Api&a=getList&model=4&p=1&client=iphone&page_id=0&create_time=0&device_id=D51EEE61-5FA5-40AC-861D-99AFAFD1CB51&iOS_version=1.0.0"

#define kRequestTable(model,page,page_id,create_time) [NSString stringWithFormat:@"http://static.owspace.com/index.php?m=Home&c=Api&a=getList&model=%ld&p=%d&client=iphone&page_id=%d&create_time=%d&iOS_version=1.0.0",model,page,page_id,create_time]

#define kRequestHotKeys @"http://static.owspace.com/index.php?m=Home&c=Api&a=getHotKeys&client=iphone&iOS_version=1.0.0"

#define kRequestResult @"http://static.owspace.com/?index.php?m=Home&c=Api&a=search&page_id=0&create_time=0"

#endif /* Requests_h */
