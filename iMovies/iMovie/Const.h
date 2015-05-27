//
//  Const.h
//  iMovie
//
//  Created by qianfeng on 15/5/11.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#ifndef iMovie_Const_h
#define iMovie_Const_h

#import "UIViewExt.h"

//TabBar
#define kMOVIE_TITLE @[@"电影",@"新闻",@"排行榜",@"影院",@"更多"]
#define kMOVIE_TITLE_USA @"北美榜"
#define kMOVIE_IMAGE @[@"movie_home.png",@"msg_new.png",@"start_top250.png",@"icon_cinema.png",@"more_setting.png"]



//Common
#define Identifier  @"cellID"


//屏幕大小
#define kSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define kSCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width

//定制控制器
#define kMOVIE_VC(VIEW,VIEWNAME,TITLE) VIEW *VIEWNAME =[[VIEW alloc] initWithTitle:TITLE]
#define kMOVIE_NAV(VIEW,NAVNAME,VIEWNAME) VIEW *NAVNAME = [[VIEW alloc] initWithRootViewController:VIEWNAME]


// TabBar 图片
#define kMOVIE_TABBAR_BG @"tab_bg_all.png"
#define kMOVIE_TABBAR_SELECT_IMG @"selectTabbar_bg_all1.png"

//默认背景图片
#define kMOVIE_DEFUALT_BG @"page_image_loading.png"

//NavigationBar
#define KMOVIE_NAVIGATION_BG @"nav_bg_all.png"

//USA-按钮-图片
#define kMOVIE_USA_RIGHT_POSTER_IMG @"poster_home.png"
#define kMOVIE_USA_RIGHT_LIST_IMG @"list_home.png"
#define kMOVIE_USA_RIGHT_BG @"exchange_bg_home.png"

//Poster  海报页面
#define kMOVIE_DOWN_HOME_IMG @"down_home.png"
#define kMOVIE_UP_HOME_IMG @"up_home.png"
#define kMOVIE_INDEX_HOME_IMG @"indexBG_home.png"
#define kMOVIE_TITLE_HOME_IMG @"poster_title_home.png"

//tableView  背景图片
#define kMOVIE_TableView_BG @"bg_main.png"

//News 新闻类型(视频和图片)
#define kMOVIE_NEWS_TYPE_1  @"sctpxw.png"
#define kMOVIE_NEWS_TYPE_2  @"scspxw.png"

//影院  日期视图
#define kMOVIE_CINEMA_THEATER_IMG @"theater_coming.png"

//更多
#define kMOVIE_POPVIEW_BG @"moreView_setting_new.png"
#define kMOVIE_SEARCH_IMG @"more_search.png"
#define kMOVIE_FAV_IMG @"more_fav.png"
#define kMOVIE_SET_IMG @"more_set.png"
#define kMOVIE_PHB_IMG @"more_phb.png"
#define kMOVIE_XIAN_IMG @"more_xian.png"
#define kMOVIE_MORE_TITLES @[@"搜索",@"收藏",@"设置",@"关于"]

//电影详情
#define kMOVIEW_USER_DEFAULT_IMG @"msg_new.png"
#define kCommentCellHeight 75
#define kMOVIEW_XK_IMG  @"xk.png"
#define kMOVIEW_PF_IMG  @"ypf.png"
#define kMOVIEW_XK_ON_IMG  @"xk_on.png"
#define kMOVIEW_PF_ON_IMG  @"ypf_on.png"
#define kMovieImageViewWith 100
#define kMovieImageViewHeight 140


//颜色
#define Color(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

//定义属性
#define __string(field) @property (nonatomic,copy) NSString *field
#define __class(class,className) @property (nonatomic,strong) class *className
#define __uiclass(uiClass,uiClassName) @property (nonatomic,copy) uiClass *uiClassName
#define __sysclass(sysClass,sysClassName) @property (nonatomic,copy) sysClass *sysClassName
#define __int(i) @property (nonatomic,assign) int i
#define __NSInteger(i) @property (nonatomic,assign) NSInteger i
#define __float(f) @property (nonatomic,assign) float f
#define __BOOL(b) @property (nonatomic,assign) BOOL b
#define __delegate(delegate,delegateName) @property (nonatomic,assign) id<delegate> delegateName
#define __myblock(block,blockName) @property (nonatomic,copy) block blockName
#define __long(f) @property (nonatomic,assign) long f


#endif
