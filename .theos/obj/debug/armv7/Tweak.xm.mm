#line 1 "Tweak.xm"
#import <SafariServices/SafariServices.h>

NSMutableDictionary *all_packages;

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

@class ZBPackageDepictionViewController; @class ZBPackageInfoView; 
static void (*_logos_orig$_ungrouped$ZBPackageDepictionViewController$viewDidLoad)(_LOGOS_SELF_TYPE_NORMAL ZBPackageDepictionViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$ZBPackageDepictionViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL ZBPackageDepictionViewController* _LOGOS_SELF_CONST, SEL); static NSArray * (*_logos_meta_orig$_ungrouped$ZBPackageInfoView$packageInfoOrder)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static NSArray * _logos_meta_method$_ungrouped$ZBPackageInfoView$packageInfoOrder(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static UITableViewCell * (*_logos_orig$_ungrouped$ZBPackageInfoView$tableView$cellForRowAtIndexPath$)(_LOGOS_SELF_TYPE_NORMAL ZBPackageInfoView* _LOGOS_SELF_CONST, SEL, UITableView *, NSIndexPath *); static UITableViewCell * _logos_method$_ungrouped$ZBPackageInfoView$tableView$cellForRowAtIndexPath$(_LOGOS_SELF_TYPE_NORMAL ZBPackageInfoView* _LOGOS_SELF_CONST, SEL, UITableView *, NSIndexPath *); static void (*_logos_orig$_ungrouped$ZBPackageInfoView$setPackage$)(_LOGOS_SELF_TYPE_NORMAL ZBPackageInfoView* _LOGOS_SELF_CONST, SEL, ZBPackage *); static void _logos_method$_ungrouped$ZBPackageInfoView$setPackage$(_LOGOS_SELF_TYPE_NORMAL ZBPackageInfoView* _LOGOS_SELF_CONST, SEL, ZBPackage *); static void _logos_method$_ungrouped$ZBPackageInfoView$tappedOnViewReports(_LOGOS_SELF_TYPE_NORMAL ZBPackageInfoView* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$ZBPackageInfoView$tappedOnAddReport(_LOGOS_SELF_TYPE_NORMAL ZBPackageInfoView* _LOGOS_SELF_CONST, SEL); 

#line 16 "Tweak.xm"


static void _logos_method$_ungrouped$ZBPackageDepictionViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL ZBPackageDepictionViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
   	NSString *basePath = [paths.firstObject stringByAppendingPathComponent:@"TweakCompatible.plist"];
	all_packages = [NSMutableDictionary dictionaryWithDictionary:[NSDictionary dictionaryWithContentsOfFile:basePath]];
	_logos_orig$_ungrouped$ZBPackageDepictionViewController$viewDidLoad(self, _cmd);
}





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
        NSMutableDictionary *infoDict = MSHookIvar<NSMutableDictionary *>(self, "infos");
        NSString *packageID = [infoDict objectForKey:@"packageID"];
        if ([[all_packages allKeys] containsObject:packageID] ) {
            NSDictionary *compatibilityInfo = [NSJSONSerialization JSONObjectWithData:[all_packages objectForKey:packageID] options:0 error:NULL];
            NSArray *allVersions = [compatibilityInfo objectForKey:@"versions"];
			NSDictionary *outcomeDict;
            for (NSDictionary *versionInfo in allVersions){
                if ([[versionInfo objectForKey:@"tweakVersion"] isEqualToString:[compatibilityInfo objectForKey:@"latest"]]) {
                    if (sizeof(void*) == 4) {
                        outcomeDict = [NSDictionary dictionaryWithDictionary:[[versionInfo objectForKey:@"outcome"] objectForKey:@"arch32"]];
                    } else  {
                        outcomeDict = [NSDictionary dictionaryWithDictionary:[versionInfo objectForKey:@"outcome"]];
                    }
                }
            }
			if ([[outcomeDict objectForKey:@"calculatedStatus"] isEqualToString:@"Working"]){
                        [[cell textLabel] setText:@"Works with your device"];
                        [[cell textLabel] setTextColor:[UIColor colorWithRed:.224 green:.792 blue:.459 alpha:1.0]];
                        [[cell detailTextLabel] setText:@"Provided by TweakCompatible"];
						return cell;
                    } else if ([[outcomeDict objectForKey:@"calculatedStatus"] isEqualToString:@"Likely working"]) {
                        [[cell textLabel] setText:@"Probably works with your device (not 100% sure!)"];
                        [[cell textLabel] setTextColor:[UIColor colorWithRed:.941 green:.765 blue:.188 alpha:1.0]];
                        [[cell detailTextLabel] setText:@"Provided by TweakCompatible"];
						return cell;
                    } else if ([[outcomeDict objectForKey:@"calculatedStatus"] isEqualToString:@"Not working"]){
                        [[cell textLabel] setText:@"Does not work with your device"];
                        [[cell textLabel] setTextColor:[UIColor colorWithRed:.894 green:.302 blue:.259 alpha:1.0]];
                        [[cell detailTextLabel] setText:@"Provided by TweakCompatible"];
						return cell;
                    } else {
						[[cell textLabel] setText:@"Unknown compatibility/No reports"];
            			[[cell detailTextLabel] setText:@"Provided by TweakCompatible"];
						return cell;
					}
        } else {
            [[cell textLabel] setText:@"Unknown compatibility/No reports"];
            [[cell detailTextLabel] setText:@"Provided by TweakCompatible"];
			return cell;
        }
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
	if ([versionString containsString:@"(Installed Version"]){
		NSArray *versionArray = [versionString componentsSeparatedByString:@"(Installed Version"];
		versionString = [[versionArray objectAtIndex:0] stringByReplacingOccurrencesOfString:@" " withString:@""];
	}
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://jlippold.github.io/tweakCompatible/package.html#!/%@/details/%@", [packageInfo objectForKey:@"packageID"], versionString]];
	SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:url];
	[[self parentVC] presentViewController:safariVC animated:TRUE completion:nil];
}


static void _logos_method$_ungrouped$ZBPackageInfoView$tappedOnAddReport(_LOGOS_SELF_TYPE_NORMAL ZBPackageInfoView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
	
}


static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$ZBPackageDepictionViewController = objc_getClass("ZBPackageDepictionViewController"); MSHookMessageEx(_logos_class$_ungrouped$ZBPackageDepictionViewController, @selector(viewDidLoad), (IMP)&_logos_method$_ungrouped$ZBPackageDepictionViewController$viewDidLoad, (IMP*)&_logos_orig$_ungrouped$ZBPackageDepictionViewController$viewDidLoad);Class _logos_class$_ungrouped$ZBPackageInfoView = objc_getClass("ZBPackageInfoView"); Class _logos_metaclass$_ungrouped$ZBPackageInfoView = object_getClass(_logos_class$_ungrouped$ZBPackageInfoView); MSHookMessageEx(_logos_metaclass$_ungrouped$ZBPackageInfoView, @selector(packageInfoOrder), (IMP)&_logos_meta_method$_ungrouped$ZBPackageInfoView$packageInfoOrder, (IMP*)&_logos_meta_orig$_ungrouped$ZBPackageInfoView$packageInfoOrder);MSHookMessageEx(_logos_class$_ungrouped$ZBPackageInfoView, @selector(tableView:cellForRowAtIndexPath:), (IMP)&_logos_method$_ungrouped$ZBPackageInfoView$tableView$cellForRowAtIndexPath$, (IMP*)&_logos_orig$_ungrouped$ZBPackageInfoView$tableView$cellForRowAtIndexPath$);MSHookMessageEx(_logos_class$_ungrouped$ZBPackageInfoView, @selector(setPackage:), (IMP)&_logos_method$_ungrouped$ZBPackageInfoView$setPackage$, (IMP*)&_logos_orig$_ungrouped$ZBPackageInfoView$setPackage$);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$ZBPackageInfoView, @selector(tappedOnViewReports), (IMP)&_logos_method$_ungrouped$ZBPackageInfoView$tappedOnViewReports, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$ZBPackageInfoView, @selector(tappedOnAddReport), (IMP)&_logos_method$_ungrouped$ZBPackageInfoView$tappedOnAddReport, _typeEncoding); }} }
#line 112 "Tweak.xm"
