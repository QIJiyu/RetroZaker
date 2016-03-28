//
//  ZakerDebugHeader.h
//  RetroZaker
//
//  Created by 祁继宇 on 16/3/28.
//  Copyright © 2016年 Qi Jy/Hu Yr. All rights reserved.
//

#ifndef ZakerDebugHeader_h

#define ZAKER_Log(fmt, ...) NSLog((@"%s," "[lineNum:%d]" fmt) , __FUNCTION__, __LINE__, ##__VA_ARGS__); //带函数名和行数
#define YL_Log(fmt, ...) NSLog((@"===[lineNum:%d]" fmt), __LINE__, ##__VA_ARGS__);  //带行数
#define YC_Log(fmt, ...) NSLog((fmt), ##__VA_ARGS__); //不带函数名和行数

#define ZakerDebugHeader_h

//#define ORBYUN_Log(fmt, ...);
//#define YL_Log(fmt, ...);
//#define YC_Log(fmt, ...);

#endif /* ZakerDebugHeader_h */
