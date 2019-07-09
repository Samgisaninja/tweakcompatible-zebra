#line 1 "Tweak.xm"
#import <SafariServices/SafariServices.h>

@interface ZBPackageInfoView : UIView {
	NSMutableDictionary *infos;
}
@property (strong, nonatomic) UITableView *tableView;
@property UIViewController *parentVC;
+(NSArray *)packageInfoOrder;
@end

@interface ZBPackage : NSObject
@end


#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class ZBPackageInfoView; 
static NSArray * (*_logos_meta_orig$_ungrouped$ZBPackageInfoView$packageInfoOrder)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static NSArray * _logos_meta_method$_ungrouped$ZBPackageInfoView$packageInfoOrder(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static UITableViewCell * (*_logos_orig$_ungrouped$ZBPackageInfoView$tableView$cellForRowAtIndexPath$)(_LOGOS_SELF_TYPE_NORMAL ZBPackageInfoView* _LOGOS_SELF_CONST, SEL, UITableView *, NSIndexPath *); static UITableViewCell * _logos_method$_ungrouped$ZBPackageInfoView$tableView$cellForRowAtIndexPath$(_LOGOS_SELF_TYPE_NORMAL ZBPackageInfoView* _LOGOS_SELF_CONST, SEL, UITableView *, NSIndexPath *); static void (*_logos_orig$_ungrouped$ZBPackageInfoView$setPackage$)(_LOGOS_SELF_TYPE_NORMAL ZBPackageInfoView* _LOGOS_SELF_CONST, SEL, ZBPackage *); static void _logos_method$_ungrouped$ZBPackageInfoView$setPackage$(_LOGOS_SELF_TYPE_NORMAL ZBPackageInfoView* _LOGOS_SELF_CONST, SEL, ZBPackage *); static void _logos_method$_ungrouped$ZBPackageInfoView$tappedOnViewReports(_LOGOS_SELF_TYPE_NORMAL ZBPackageInfoView* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$ZBPackageInfoView$tappedOnAddReport(_LOGOS_SELF_TYPE_NORMAL ZBPackageInfoView* _LOGOS_SELF_CONST, SEL); 

#line 14 "Tweak.xm"


static NSArray * _logos_meta_method$_ungrouped$ZBPackageInfoView$packageInfoOrder(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	NSArray *origPkgInfoOrder = _logos_meta_orig$_ungrouped$ZBPackageInfoView$packageInfoOrder(self, _cmd);
	NSMutableArray *pkgInfoOrder = [NSMutableArray arrayWithArray:origPkgInfoOrder];
	int i = (int)[pkgInfoOrder count];
    [pkgInfoOrder insertObject:@"TweakCompatible" atIndex:i];
	return pkgInfoOrder;
}

static UITableViewCell * _logos_method$_ungrouped$ZBPackageInfoView$tableView$cellForRowAtIndexPath$(_LOGOS_SELF_TYPE_NORMAL ZBPackageInfoView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UITableView * arg1, NSIndexPath * arg2) {
	if ([arg2 row] == [[[self class] packageInfoOrder] indexOfObject:@"TweakCompatible"]) {
		UITableViewCell *cell = _logos_orig$_ungrouped$ZBPackageInfoView$tableView$cellForRowAtIndexPath$(self, _cmd, arg1, arg2);
		[[cell textLabel] setText:@"Works with your device"];
		[[cell textLabel] setTextColor:[UIColor colorWithRed:.224 green:.792 blue:.459 alpha:1.0]];
		[[cell detailTextLabel] setText:@"TweakCompatible"];

		UIButton *viewReportsButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
    	[viewReportsButton addTarget:self action:@selector(tappedOnViewReports) forControlEvents:UIControlEventTouchUpInside];

		UIButton *addReportButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
		[addReportButton addTarget:self action:@selector(tappedOnAddReport) forControlEvents:UIControlEventTouchUpInside];
		
		
		
    	UIStackView *buttonsStackView = [[UIStackView alloc] initWithFrame:CGRectMake(0, 0, 80, 25)];
		[buttonsStackView setAxis:UILayoutConstraintAxisHorizontal];
    	[buttonsStackView setDistribution:UIStackViewDistributionEqualSpacing];
    	[buttonsStackView setAlignment:UIStackViewAlignmentLeading];
		[buttonsStackView setBackgroundColor:[UIColor yellowColor]];
    	[buttonsStackView addArrangedSubview:viewReportsButton];
		[buttonsStackView addArrangedSubview:addReportButton];

		[cell setAccessoryView:buttonsStackView];
		return cell;
    } else {
		return _logos_orig$_ungrouped$ZBPackageInfoView$tableView$cellForRowAtIndexPath$(self, _cmd, arg1, arg2);
	}
}

static void _logos_method$_ungrouped$ZBPackageInfoView$setPackage$(_LOGOS_SELF_TYPE_NORMAL ZBPackageInfoView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, ZBPackage * arg1){
	_logos_orig$_ungrouped$ZBPackageInfoView$setPackage$(self, _cmd, arg1);
	NSMutableDictionary *infoDict = MSHookIvar<NSMutableDictionary *>(self, "infos");
	[infoDict setObject:@"TweakCompatible" forKey:@"TweakCompatible"];
	MSHookIvar<NSMutableDictionary *>(self, "infos") = infoDict;
}



static void _logos_method$_ungrouped$ZBPackageInfoView$tappedOnViewReports(_LOGOS_SELF_TYPE_NORMAL ZBPackageInfoView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
	NSMutableDictionary *packageInfo = MSHookIvar<NSMutableDictionary *>(self, "infos");
	NSString *versionString = [packageInfo objectForKey:@"Version"];
	NSLog(@"ZEBRACOMPATIBLE orig: %@", versionString);
	if ([versionString containsString:@"(Installed Version"]){
		NSArray *versionArray = [versionString componentsSeparatedByString:@"(Installed Version"];
		versionString = [[versionArray objectAtIndex:0] stringByReplacingOccurrencesOfString:@" " withString:@""];
		NSLog(@"ZEBRACOMPATIBLE new: %@", versionString);
	}
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://jlippold.github.io/tweakCompatible/package.html#!/%@/details/%@", [packageInfo objectForKey:@"packageID"], versionString]];
	SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:url];
	[[self parentVC] presentViewController:safariVC animated:TRUE completion:nil];

}


static void _logos_method$_ungrouped$ZBPackageInfoView$tappedOnAddReport(_LOGOS_SELF_TYPE_NORMAL ZBPackageInfoView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){

}

static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$ZBPackageInfoView = objc_getClass("ZBPackageInfoView"); Class _logos_metaclass$_ungrouped$ZBPackageInfoView = object_getClass(_logos_class$_ungrouped$ZBPackageInfoView); MSHookMessageEx(_logos_metaclass$_ungrouped$ZBPackageInfoView, @selector(packageInfoOrder), (IMP)&_logos_meta_method$_ungrouped$ZBPackageInfoView$packageInfoOrder, (IMP*)&_logos_meta_orig$_ungrouped$ZBPackageInfoView$packageInfoOrder);MSHookMessageEx(_logos_class$_ungrouped$ZBPackageInfoView, @selector(tableView:cellForRowAtIndexPath:), (IMP)&_logos_method$_ungrouped$ZBPackageInfoView$tableView$cellForRowAtIndexPath$, (IMP*)&_logos_orig$_ungrouped$ZBPackageInfoView$tableView$cellForRowAtIndexPath$);MSHookMessageEx(_logos_class$_ungrouped$ZBPackageInfoView, @selector(setPackage:), (IMP)&_logos_method$_ungrouped$ZBPackageInfoView$setPackage$, (IMP*)&_logos_orig$_ungrouped$ZBPackageInfoView$setPackage$);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$ZBPackageInfoView, @selector(tappedOnViewReports), (IMP)&_logos_method$_ungrouped$ZBPackageInfoView$tappedOnViewReports, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$ZBPackageInfoView, @selector(tappedOnAddReport), (IMP)&_logos_method$_ungrouped$ZBPackageInfoView$tappedOnAddReport, _typeEncoding); }} }
#line 83 "Tweak.xm"
