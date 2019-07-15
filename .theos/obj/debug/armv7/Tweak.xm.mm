#line 1 "Tweak.xm"
#import <SafariServices/SafariServices.h>
#import <sys/utsname.h> 

NSMutableDictionary *all_packages;

@interface ZBRepo : NSObject
@property (nonatomic, strong) NSString *baseFileName;
@property (nonatomic, strong) NSString *baseURL;
@end

@interface ZBPackage : NSObject
@property (nonatomic, strong) NSString *section;
@property (nonatomic, strong) NSString *shortDescription;
@property (nonatomic, strong) ZBRepo *repo;
- (BOOL)isPaid;
@end

@interface ZBPackageDepictionViewController : UIViewController {
	NSMutableDictionary *infos;
}
@property ZBPackage *package;
@property (strong, nonatomic) UITableView *tableView;
@property (weak, nonatomic) UILabel *packageName;
- (NSArray *)packageInfoOrder;
@end

@interface ZBPackageInfoView : UIView {
	NSMutableDictionary *infos;
}
@property ZBPackage *package;
@property ZBPackage *depictionPackage;
@property (strong, nonatomic) UITableView *tableView;
@property (weak, nonatomic) UILabel *packageName;
@property UIViewController *parentVC;
+ (NSArray *)packageInfoOrder;
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

@class ZBPackageDepictionViewController; @class ZBTabBarController; @class ZBPackageInfoView; 


#line 38 "Tweak.xm"
static void (*_logos_orig$new$ZBTabBarController$viewDidLoad)(_LOGOS_SELF_TYPE_NORMAL ZBTabBarController* _LOGOS_SELF_CONST, SEL); static void _logos_method$new$ZBTabBarController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL ZBTabBarController* _LOGOS_SELF_CONST, SEL); static NSArray * (*_logos_orig$new$ZBPackageDepictionViewController$packageInfoOrder)(_LOGOS_SELF_TYPE_NORMAL ZBPackageDepictionViewController* _LOGOS_SELF_CONST, SEL); static NSArray * _logos_method$new$ZBPackageDepictionViewController$packageInfoOrder(_LOGOS_SELF_TYPE_NORMAL ZBPackageDepictionViewController* _LOGOS_SELF_CONST, SEL); static UITableViewCell * (*_logos_orig$new$ZBPackageDepictionViewController$tableView$cellForRowAtIndexPath$)(_LOGOS_SELF_TYPE_NORMAL ZBPackageDepictionViewController* _LOGOS_SELF_CONST, SEL, UITableView *, NSIndexPath *); static UITableViewCell * _logos_method$new$ZBPackageDepictionViewController$tableView$cellForRowAtIndexPath$(_LOGOS_SELF_TYPE_NORMAL ZBPackageDepictionViewController* _LOGOS_SELF_CONST, SEL, UITableView *, NSIndexPath *); static void (*_logos_orig$new$ZBPackageDepictionViewController$setPackage)(_LOGOS_SELF_TYPE_NORMAL ZBPackageDepictionViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$new$ZBPackageDepictionViewController$setPackage(_LOGOS_SELF_TYPE_NORMAL ZBPackageDepictionViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$new$ZBPackageDepictionViewController$tappedOnViewReports(_LOGOS_SELF_TYPE_NORMAL ZBPackageDepictionViewController* _LOGOS_SELF_CONST, SEL); static void _logos_method$new$ZBPackageDepictionViewController$tappedOnAddReport(_LOGOS_SELF_TYPE_NORMAL ZBPackageDepictionViewController* _LOGOS_SELF_CONST, SEL); 



static void _logos_method$new$ZBTabBarController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL ZBTabBarController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    if (!all_packages){
        all_packages = [[NSMutableDictionary alloc] init];
        NSURL *url =  [NSURL URLWithString:[NSString stringWithFormat:@"https://jlippold.github.io/tweakCompatible/json/iOS/%@.json", [[UIDevice currentDevice] systemVersion]]];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse* response, NSData* data, NSError* error) {
            if (data) {
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                
                if (!all_packages) {
                    all_packages = [[NSMutableDictionary alloc] init];
                }
                for (id package in json[@"packages"]) {
                    NSString *packageId = [NSString stringWithFormat:@"%@", [package objectForKey:@"id"]];
                    NSData *packageData = [NSJSONSerialization dataWithJSONObject:package options:kNilOptions error:nil];
                    
                    if ( ![[all_packages allKeys] containsObject:packageId] ) {
                        [all_packages setObject:packageData forKey:packageId];
                    }
                }
                [[NSFileManager defaultManager] createDirectoryAtPath:@"/Library/Application Support/tweakcompatible-zebra/" withIntermediateDirectories:TRUE attributes:nil error:nil];
                [all_packages writeToFile:@"/Library/Application Support/tweakcompatible-zebra/packages.plist" atomically:TRUE];
            }
        }];
    }
    _logos_orig$new$ZBTabBarController$viewDidLoad(self, _cmd);
}






static NSArray * _logos_method$new$ZBPackageDepictionViewController$packageInfoOrder(_LOGOS_SELF_TYPE_NORMAL ZBPackageDepictionViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	NSArray *origPkgInfoOrder = _logos_orig$new$ZBPackageDepictionViewController$packageInfoOrder(self, _cmd);
	NSMutableArray *pkgInfoOrder = [NSMutableArray arrayWithArray:origPkgInfoOrder];
	int i = (int)[pkgInfoOrder count];
    [pkgInfoOrder insertObject:@"TweakCompatible" atIndex:i];
	return pkgInfoOrder;
}

static UITableViewCell * _logos_method$new$ZBPackageDepictionViewController$tableView$cellForRowAtIndexPath$(_LOGOS_SELF_TYPE_NORMAL ZBPackageDepictionViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UITableView * arg1, NSIndexPath * arg2) {
    if ([arg2 row] == [[self packageInfoOrder] indexOfObject:@"TweakCompatible"]) {
        UITableViewCell *cell = _logos_orig$new$ZBPackageDepictionViewController$tableView$cellForRowAtIndexPath$(self, _cmd, arg1, arg2);
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
				UIButton *viewReportsButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
	    		[viewReportsButton addTarget:self action:@selector(tappedOnViewReports) forControlEvents:UIControlEventTouchUpInside];
				UIButton *addReportButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
				[addReportButton addTarget:self action:@selector(tappedOnAddReport) forControlEvents:UIControlEventTouchUpInside];
		    	UIStackView *buttonsStackView = [[UIStackView alloc] initWithFrame:CGRectMake(0, 0, 65, 25)];
				[buttonsStackView setAxis:UILayoutConstraintAxisHorizontal];
		   	 	[buttonsStackView setDistribution:UIStackViewDistributionEqualSpacing];
				[buttonsStackView setAlignment:UIStackViewAlignmentLeading];
				[buttonsStackView setBackgroundColor:[UIColor yellowColor]];
		    	[buttonsStackView addArrangedSubview:viewReportsButton];
				[buttonsStackView addArrangedSubview:addReportButton];
				[cell setAccessoryView:buttonsStackView];
				return cell;
            } else if ([[outcomeDict objectForKey:@"calculatedStatus"] isEqualToString:@"Likely working"]) {
                [[cell textLabel] setText:@"**Probably** works with your device"];
                [[cell textLabel] setTextColor:[UIColor colorWithRed:.941 green:.765 blue:.188 alpha:1.0]];
                [[cell detailTextLabel] setText:@"Provided by TweakCompatible"];
				UIButton *viewReportsButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
	    		[viewReportsButton addTarget:self action:@selector(tappedOnViewReports) forControlEvents:UIControlEventTouchUpInside];
				UIButton *addReportButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
				[addReportButton addTarget:self action:@selector(tappedOnAddReport) forControlEvents:UIControlEventTouchUpInside];
		    	UIStackView *buttonsStackView = [[UIStackView alloc] initWithFrame:CGRectMake(0, 0, 65, 25)];
				[buttonsStackView setAxis:UILayoutConstraintAxisHorizontal];
	    		[buttonsStackView setDistribution:UIStackViewDistributionEqualSpacing];
	    		[buttonsStackView setAlignment:UIStackViewAlignmentLeading];
				[buttonsStackView setBackgroundColor:[UIColor yellowColor]];
	    		[buttonsStackView addArrangedSubview:viewReportsButton];
				[buttonsStackView addArrangedSubview:addReportButton];
				[cell setAccessoryView:buttonsStackView];
				return cell;
            } else if ([[outcomeDict objectForKey:@"calculatedStatus"] isEqualToString:@"Not working"]){
                [[cell textLabel] setText:@"Does not work with your device"];
                [[cell textLabel] setTextColor:[UIColor colorWithRed:.894 green:.302 blue:.259 alpha:1.0]];
                [[cell detailTextLabel] setText:@"Provided by TweakCompatible"];
				UIButton *viewReportsButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
		    	[viewReportsButton addTarget:self action:@selector(tappedOnViewReports) forControlEvents:UIControlEventTouchUpInside];
				UIButton *addReportButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
				[addReportButton addTarget:self action:@selector(tappedOnAddReport) forControlEvents:UIControlEventTouchUpInside];
	    		UIStackView *buttonsStackView = [[UIStackView alloc] initWithFrame:CGRectMake(0, 0, 65, 25)];
				[buttonsStackView setAxis:UILayoutConstraintAxisHorizontal];
		    	[buttonsStackView setDistribution:UIStackViewDistributionEqualSpacing];
	    		[buttonsStackView setAlignment:UIStackViewAlignmentLeading];
				[buttonsStackView setBackgroundColor:[UIColor yellowColor]];
		    	[buttonsStackView addArrangedSubview:viewReportsButton];
				[buttonsStackView addArrangedSubview:addReportButton];
				[cell setAccessoryView:buttonsStackView];
				return cell;
            } else {
				[[cell textLabel] setText:@"Unknown compatibility/No reports"];
				[[cell detailTextLabel] setText:@"Provided by TweakCompatible"];
				UIButton *viewReportsButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
	    		[viewReportsButton addTarget:self action:@selector(tappedOnViewReports) forControlEvents:UIControlEventTouchUpInside];
				UIButton *addReportButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
				[addReportButton addTarget:self action:@selector(tappedOnAddReport) forControlEvents:UIControlEventTouchUpInside];
	    		UIStackView *buttonsStackView = [[UIStackView alloc] initWithFrame:CGRectMake(0, 0, 65, 25)];
				[buttonsStackView setAxis:UILayoutConstraintAxisHorizontal];
		    	[buttonsStackView setDistribution:UIStackViewDistributionEqualSpacing];
	   		 	[buttonsStackView setAlignment:UIStackViewAlignmentLeading];
				[buttonsStackView setBackgroundColor:[UIColor yellowColor]];
		    	[buttonsStackView addArrangedSubview:viewReportsButton];
				[buttonsStackView addArrangedSubview:addReportButton];
				[cell setAccessoryView:buttonsStackView];
				return cell;
			}
        } else {
            [[cell textLabel] setText:@"Unknown compatibility/No reports"];
            [[cell detailTextLabel] setText:@"Provided by TweakCompatible"];
			UIButton *viewReportsButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
	    	[viewReportsButton addTarget:self action:@selector(tappedOnViewReports) forControlEvents:UIControlEventTouchUpInside];
			UIButton *addReportButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
			[addReportButton addTarget:self action:@selector(tappedOnAddReport) forControlEvents:UIControlEventTouchUpInside];
	    	UIStackView *buttonsStackView = [[UIStackView alloc] initWithFrame:CGRectMake(0, 0, 65, 25)];
			[buttonsStackView setAxis:UILayoutConstraintAxisHorizontal];
	    	[buttonsStackView setDistribution:UIStackViewDistributionEqualSpacing];
	    	[buttonsStackView setAlignment:UIStackViewAlignmentLeading];
			[buttonsStackView setBackgroundColor:[UIColor yellowColor]];
	    	[buttonsStackView addArrangedSubview:viewReportsButton];
			[buttonsStackView addArrangedSubview:addReportButton];
	
			[cell setAccessoryView:buttonsStackView];
			return cell;
        }
    } else {
		return _logos_orig$new$ZBPackageDepictionViewController$tableView$cellForRowAtIndexPath$(self, _cmd, arg1, arg2);
	}
}

static void _logos_method$new$ZBPackageDepictionViewController$setPackage(_LOGOS_SELF_TYPE_NORMAL ZBPackageDepictionViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
	_logos_orig$new$ZBPackageDepictionViewController$setPackage(self, _cmd);
	NSMutableDictionary *infoDict = MSHookIvar<NSMutableDictionary *>(self, "infos");
	[infoDict setObject:@"TweakCompatible" forKey:@"TweakCompatible"];
	MSHookIvar<NSMutableDictionary *>(self, "infos") = infoDict;
}



static void _logos_method$new$ZBPackageDepictionViewController$tappedOnViewReports(_LOGOS_SELF_TYPE_NORMAL ZBPackageDepictionViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
	NSMutableDictionary *infoDict = MSHookIvar<NSMutableDictionary *>(self, "infos");
    NSString *packageID = [infoDict objectForKey:@"packageID"];
	NSString *versionString = [infoDict objectForKey:@"Version"];
	NSString *summary = [[NSString alloc] init];
	if ([versionString containsString:@"(Installed Version"]){
		NSArray *versionArray = [versionString componentsSeparatedByString:@"(Installed Version"];
		versionString = [[versionArray objectAtIndex:0] stringByReplacingOccurrencesOfString:@" " withString:@""];
	}
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
		if ([[outcomeDict objectForKey:@"calculatedStatus"] isEqualToString:@"Working"] || [[outcomeDict objectForKey:@"calculatedStatus"] isEqualToString:@"Likely working"] || [[outcomeDict objectForKey:@"calculatedStatus"] isEqualToString:@"Not working"]){
            summary = [NSString stringWithFormat:@"%@ version %@ is marked as %@ on iOS %@\n\n(%@ reports, %@ working and %@ non-working)", [infoDict objectForKey:@"packageID"], versionString, [outcomeDict objectForKey:@"calculatedStatus"], [[UIDevice currentDevice] systemVersion], [outcomeDict objectForKey:@"total"], [outcomeDict objectForKey:@"good"], [outcomeDict objectForKey:@"bad"]];
        } else {
			summary = [NSString stringWithFormat:@"%@ version %@ has unknown compatibility with iOS %@", [infoDict objectForKey:@"packageID"], versionString, [[UIDevice currentDevice] systemVersion]];
		}
    } else {
		summary = [NSString stringWithFormat:@"%@ version %@ has unknown compatibility with iOS %@", [infoDict objectForKey:@"packageID"], versionString, [[UIDevice currentDevice] systemVersion]];
    }
	UIAlertController *compatibilityAlert = [UIAlertController alertControllerWithTitle:@"Compatibility Report" message:summary preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *viewAllReportsAction = [UIAlertAction actionWithTitle:@"View all reports" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://jlippold.github.io/tweakCompatible/package.html#!/%@/details/%@", [infoDict objectForKey:@"packageID"], versionString]];
		SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:url];
		[self presentViewController:safariVC animated:TRUE completion:nil];
    }];
    [compatibilityAlert addAction:viewAllReportsAction];
    [compatibilityAlert addAction:dismissAction];
    [self presentViewController:compatibilityAlert animated:TRUE completion:nil];
}


static void _logos_method$new$ZBPackageDepictionViewController$tappedOnAddReport(_LOGOS_SELF_TYPE_NORMAL ZBPackageDepictionViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
	NSMutableDictionary *infoDict = MSHookIvar<NSMutableDictionary *>(self, "infos");
    NSString *packageID = [infoDict objectForKey:@"packageID"];
	NSString *packageStatusExplanation = [[NSString alloc] init];
	NSString *archDescription = [[NSString alloc] init];
	NSDictionary *outcomeDict;
	BOOL packageExists;
	BOOL versionExists;
	NSString *versionString = [infoDict objectForKey:@"Version"];
	if ([versionString containsString:@" (Installed Version: "]){
		NSArray *versionArray = [versionString componentsSeparatedByString:@" (Installed Version: "];
		versionString = [[versionArray objectAtIndex:0] stringByReplacingOccurrencesOfString:@" " withString:@""];
	}
    if ([[all_packages allKeys] containsObject:packageID] ) {
        NSDictionary *compatibilityInfo = [NSJSONSerialization JSONObjectWithData:[all_packages objectForKey:packageID] options:0 error:NULL];
        NSArray *allVersions = [compatibilityInfo objectForKey:@"versions"];
        for (NSDictionary *versionInfo in allVersions){
            if ([[versionInfo objectForKey:@"tweakVersion"] isEqualToString:[compatibilityInfo objectForKey:@"latest"]]) {
                if (sizeof(void*) == 4) {
					archDescription = @"32bit";
                    outcomeDict = [NSDictionary dictionaryWithDictionary:[[versionInfo objectForKey:@"outcome"] objectForKey:@"arch32"]];
                } else  {
                    outcomeDict = [NSDictionary dictionaryWithDictionary:[versionInfo objectForKey:@"outcome"]];
                }
            }
        }
		if ([[outcomeDict objectForKey:@"calculatedStatus"] isEqualToString:@"Working"] || [[outcomeDict objectForKey:@"calculatedStatus"] isEqualToString:@"Likely working"] || [[outcomeDict objectForKey:@"calculatedStatus"] isEqualToString:@"Not working"]){
            packageExists = TRUE;
			versionExists = TRUE;
			packageStatusExplanation = [NSString stringWithFormat:@"This%@ package version has been marked as %@ based on feedback from users in the community. ""The current positive rating is %@%% with %@ working reports.", archDescription, [outcomeDict objectForKey:@"calculatedStatus"], [outcomeDict objectForKey:@"percentage"], [outcomeDict objectForKey:@"good"]];
        } else {
			packageExists = TRUE;
			versionExists = FALSE;
			packageStatusExplanation = @"A matching version of this tweak for this iOS version could not be found. ""Please submit a review if you choose to install.";
		}
    } else {
		packageExists = FALSE;
		versionExists = FALSE;
		packageStatusExplanation = @"This tweak has not been reviewed. Please submit a review if you choose to install.";
    }
	NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
	struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceId = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
	[userInfo setObject:deviceId forKey:@"deviceId"];
	NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
	[userInfo setObject:systemVersion forKey:@"iOSVersion"];
	NSString *myVersion = [[NSString alloc] init];
    NSString *dpkgStatus = [NSString stringWithContentsOfFile:@"/Library/dpkg/status" encoding:NSUTF8StringEncoding error:nil];
    NSArray *dpkgStatusArray = [dpkgStatus componentsSeparatedByString:@"Package: "];
    for (NSString *dpkgPackageStatus in dpkgStatusArray) {
        if ([dpkgPackageStatus containsString:@"com.samgisaninja.tweakcompatible-zebra"]) {
            NSArray *statusLines = [dpkgPackageStatus componentsSeparatedByString:[NSString stringWithFormat:@"\n"]];
            for (NSString *line in statusLines) {
                if ([line hasPrefix:@"Version: "]) {
                    myVersion = [NSString stringWithFormat:@"tweakcompatible-zebra-%@", [line stringByReplacingOccurrencesOfString:@"Version: " withString:@""]];
                }
            }
        }
    }
	BOOL isInstalled;
	NSString *installedVersionString = [[NSString alloc] init];
	if ([dpkgStatus containsString:[infoDict objectForKey:@"packageID"]]){
		isInstalled = TRUE;
		for (NSString *dpkgPackageStatus in dpkgStatusArray) {
        	if ([dpkgPackageStatus containsString:[infoDict objectForKey:@"packageID"]]) {
            	NSArray *statusLines = [dpkgPackageStatus componentsSeparatedByString:[NSString stringWithFormat:@"\n"]];
            	for (NSString *line in statusLines) {
                	if ([line hasPrefix:@"Version: "]) {
                	    installedVersionString = [NSString stringWithFormat:@"tweakcompatible-zebra-%@", [line stringByReplacingOccurrencesOfString:@"Version: " withString:@""]];
                	}
            	}
        	}
    	}
	} else {
		isInstalled = FALSE;
	}
	[userInfo setObject:myVersion forKey:@"tweakCompatVersion"];
	[userInfo setObject:@(packageExists) forKey:@"packageIndexed"];
	[userInfo setObject:@(versionExists) forKey:@"packageVersionIndexed"];
	if ([packageStatusExplanation containsString:@"package version has been marked as"]) {
		[userInfo setObject:[outcomeDict objectForKey:@"calculatedStatus"] forKey:@"packageStatus"];
	} else {
		[userInfo setObject:@"Unknown" forKey:@"packageStatus"];
	}
	[userInfo setObject:packageStatusExplanation forKey:@"packageStatusExplaination"];
	[userInfo setObject:[infoDict objectForKey:@"packageID"] forKey:@"packageId"];
	[userInfo setObject:[infoDict objectForKey:@"packageID"] forKey:@"id"];
	[userInfo setObject:[[self packageName] text] forKey:@"name"];
	[userInfo setObject:[[self packageName] text] forKey:@"packageName"];
	[userInfo setObject:versionString forKey:@"latest"];
	[userInfo setObject:installedVersionString forKey:@"installed"];
	BOOL isPaidPkg = [[self package] isPaid];
	[userInfo setObject:@(isPaidPkg) forKey:@"commercial"];
	[userInfo setObject:[[self package] section] forKey:@"category"];
	[userInfo setObject:[[self package] shortDescription] forKey:@"shortDescription"];
	[userInfo setObject:@(isInstalled) forKey:@"packageInstalled"];
	BOOL isArmv7;
	if ([archDescription isEqualToString:@"32bit"]){
		isArmv7 = TRUE;
	} else {
		isArmv7 = FALSE;
	}
	[userInfo setObject:@(isArmv7) forKey:@"arch32"];
	[userInfo setObject:[infoDict objectForKey:@"Repo"] forKey:@"repository"];
	[userInfo setObject:[infoDict objectForKey:@"Author"] forKey:@"author"];
	[userInfo setObject:[NSString stringWithFormat:@"http://cydia.saurik.com/package/%@/", [infoDict objectForKey:@"packageID"]] forKey:@"url"];
	NSData *jsonData = [NSJSONSerialization dataWithJSONObject:userInfo options:kNilOptions error:nil];
	NSString *userInfoBase64 = [jsonData base64EncodedStringWithOptions:0];
	NSString *workingURLString = [NSString stringWithFormat:@"https://jlippold.github.io/tweakCompatible/submit.html#!/%@/working/%@", [infoDict objectForKey:@"packageID"], userInfoBase64];
	NSString *notWorkingURLString = [NSString stringWithFormat:@"https://jlippold.github.io/tweakCompatible/submit.html#!/%@/notworking/%@", [infoDict objectForKey:@"packageID"], userInfoBase64];
	UIAlertController *markPackageAlert;
	NSString *message = [[NSString alloc] init];
	if (isInstalled) {
		message = [NSString stringWithFormat:@"Log in to Github in safari BEFORE attempting to add a report"];
	} else {
		message = [NSString stringWithFormat:@"Log in to Github in safari BEFORE attempting to add a report\nYou cannot file a 'working' report unless you have the package installed"];
	}
    if ([[[UIDevice currentDevice] model] isEqualToString:@"iPad"]) {
        markPackageAlert = [UIAlertController alertControllerWithTitle:@"Create report" message:message preferredStyle:UIAlertControllerStyleAlert];
    } else {
        markPackageAlert = [UIAlertController alertControllerWithTitle:@"Create report" message:message preferredStyle:UIAlertControllerStyleActionSheet];
    }
    UIAlertAction *markAsWorkingAction = [UIAlertAction actionWithTitle:@"Package is working" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *url = [NSURL URLWithString:workingURLString];
		SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:url];
		[self presentViewController:safariVC animated:TRUE completion:nil];
    }];
    UIAlertAction *markAsNotWorkingAction = [UIAlertAction actionWithTitle:@"Package is not working" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSURL *url = [NSURL URLWithString:notWorkingURLString];
		SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:url];
		[self presentViewController:safariVC animated:TRUE completion:nil];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    if (isInstalled){
		[markPackageAlert addAction:markAsWorkingAction];
	}
    [markPackageAlert addAction:markAsNotWorkingAction];
    [markPackageAlert addAction:cancelAction];
    [self presentViewController:markPackageAlert animated:TRUE completion:nil];
}







static void (*_logos_orig$old$ZBTabBarController$viewDidLoad)(_LOGOS_SELF_TYPE_NORMAL ZBTabBarController* _LOGOS_SELF_CONST, SEL); static void _logos_method$old$ZBTabBarController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL ZBTabBarController* _LOGOS_SELF_CONST, SEL); static NSArray * (*_logos_meta_orig$old$ZBPackageInfoView$packageInfoOrder)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static NSArray * _logos_meta_method$old$ZBPackageInfoView$packageInfoOrder(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static UITableViewCell * (*_logos_orig$old$ZBPackageInfoView$tableView$cellForRowAtIndexPath$)(_LOGOS_SELF_TYPE_NORMAL ZBPackageInfoView* _LOGOS_SELF_CONST, SEL, UITableView *, NSIndexPath *); static UITableViewCell * _logos_method$old$ZBPackageInfoView$tableView$cellForRowAtIndexPath$(_LOGOS_SELF_TYPE_NORMAL ZBPackageInfoView* _LOGOS_SELF_CONST, SEL, UITableView *, NSIndexPath *); static void (*_logos_orig$old$ZBPackageInfoView$setPackage$)(_LOGOS_SELF_TYPE_NORMAL ZBPackageInfoView* _LOGOS_SELF_CONST, SEL, ZBPackage *); static void _logos_method$old$ZBPackageInfoView$setPackage$(_LOGOS_SELF_TYPE_NORMAL ZBPackageInfoView* _LOGOS_SELF_CONST, SEL, ZBPackage *); static void _logos_method$old$ZBPackageInfoView$tappedOnViewReports(_LOGOS_SELF_TYPE_NORMAL ZBPackageInfoView* _LOGOS_SELF_CONST, SEL); static void _logos_method$old$ZBPackageInfoView$tappedOnAddReport(_LOGOS_SELF_TYPE_NORMAL ZBPackageInfoView* _LOGOS_SELF_CONST, SEL); 



static void _logos_method$old$ZBTabBarController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL ZBTabBarController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    if (!all_packages){
        all_packages = [[NSMutableDictionary alloc] init];
        NSURL *url =  [NSURL URLWithString:[NSString stringWithFormat:@"https://jlippold.github.io/tweakCompatible/json/iOS/%@.json", [[UIDevice currentDevice] systemVersion]]];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse* response, NSData* data, NSError* error) {
            if (data) {
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                
                if (!all_packages) {
                    all_packages = [[NSMutableDictionary alloc] init];
                }
                for (id package in json[@"packages"]) {
                    NSString *packageId = [NSString stringWithFormat:@"%@", [package objectForKey:@"id"]];
                    NSData *packageData = [NSJSONSerialization dataWithJSONObject:package options:kNilOptions error:nil];
                    
                    if ( ![[all_packages allKeys] containsObject:packageId] ) {
                        [all_packages setObject:packageData forKey:packageId];
                    }
                }
                [[NSFileManager defaultManager] createDirectoryAtPath:@"/Library/Application Support/tweakcompatible-zebra/" withIntermediateDirectories:TRUE attributes:nil error:nil];
                [all_packages writeToFile:@"/Library/Application Support/tweakcompatible-zebra/packages.plist" atomically:TRUE];
            }
        }];
    }
    _logos_orig$old$ZBTabBarController$viewDidLoad(self, _cmd);
}






static NSArray * _logos_meta_method$old$ZBPackageInfoView$packageInfoOrder(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	NSArray *origPkgInfoOrder = _logos_meta_orig$old$ZBPackageInfoView$packageInfoOrder(self, _cmd);
	NSMutableArray *pkgInfoOrder = [NSMutableArray arrayWithArray:origPkgInfoOrder];
	int i = (int)[pkgInfoOrder count];
    [pkgInfoOrder insertObject:@"TweakCompatible" atIndex:i];
	return pkgInfoOrder;
}

static UITableViewCell * _logos_method$old$ZBPackageInfoView$tableView$cellForRowAtIndexPath$(_LOGOS_SELF_TYPE_NORMAL ZBPackageInfoView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UITableView * arg1, NSIndexPath * arg2) {
    if ([arg2 row] == [[[self class] packageInfoOrder] indexOfObject:@"TweakCompatible"]) {
        UITableViewCell *cell = _logos_orig$old$ZBPackageInfoView$tableView$cellForRowAtIndexPath$(self, _cmd, arg1, arg2);
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
				UIButton *viewReportsButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
	    		[viewReportsButton addTarget:self action:@selector(tappedOnViewReports) forControlEvents:UIControlEventTouchUpInside];
				UIButton *addReportButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
				[addReportButton addTarget:self action:@selector(tappedOnAddReport) forControlEvents:UIControlEventTouchUpInside];
		    	UIStackView *buttonsStackView = [[UIStackView alloc] initWithFrame:CGRectMake(0, 0, 65, 25)];
				[buttonsStackView setAxis:UILayoutConstraintAxisHorizontal];
		   	 	[buttonsStackView setDistribution:UIStackViewDistributionEqualSpacing];
				[buttonsStackView setAlignment:UIStackViewAlignmentLeading];
				[buttonsStackView setBackgroundColor:[UIColor yellowColor]];
		    	[buttonsStackView addArrangedSubview:viewReportsButton];
				[buttonsStackView addArrangedSubview:addReportButton];
				[cell setAccessoryView:buttonsStackView];
				return cell;
            } else if ([[outcomeDict objectForKey:@"calculatedStatus"] isEqualToString:@"Likely working"]) {
                [[cell textLabel] setText:@"**Probably** works with your device"];
                [[cell textLabel] setTextColor:[UIColor colorWithRed:.941 green:.765 blue:.188 alpha:1.0]];
                [[cell detailTextLabel] setText:@"Provided by TweakCompatible"];
				UIButton *viewReportsButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
	    		[viewReportsButton addTarget:self action:@selector(tappedOnViewReports) forControlEvents:UIControlEventTouchUpInside];
				UIButton *addReportButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
				[addReportButton addTarget:self action:@selector(tappedOnAddReport) forControlEvents:UIControlEventTouchUpInside];
		    	UIStackView *buttonsStackView = [[UIStackView alloc] initWithFrame:CGRectMake(0, 0, 65, 25)];
				[buttonsStackView setAxis:UILayoutConstraintAxisHorizontal];
	    		[buttonsStackView setDistribution:UIStackViewDistributionEqualSpacing];
	    		[buttonsStackView setAlignment:UIStackViewAlignmentLeading];
				[buttonsStackView setBackgroundColor:[UIColor yellowColor]];
	    		[buttonsStackView addArrangedSubview:viewReportsButton];
				[buttonsStackView addArrangedSubview:addReportButton];
				[cell setAccessoryView:buttonsStackView];
				return cell;
            } else if ([[outcomeDict objectForKey:@"calculatedStatus"] isEqualToString:@"Not working"]){
                [[cell textLabel] setText:@"Does not work with your device"];
                [[cell textLabel] setTextColor:[UIColor colorWithRed:.894 green:.302 blue:.259 alpha:1.0]];
                [[cell detailTextLabel] setText:@"Provided by TweakCompatible"];
				UIButton *viewReportsButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
		    	[viewReportsButton addTarget:self action:@selector(tappedOnViewReports) forControlEvents:UIControlEventTouchUpInside];
				UIButton *addReportButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
				[addReportButton addTarget:self action:@selector(tappedOnAddReport) forControlEvents:UIControlEventTouchUpInside];
	    		UIStackView *buttonsStackView = [[UIStackView alloc] initWithFrame:CGRectMake(0, 0, 65, 25)];
				[buttonsStackView setAxis:UILayoutConstraintAxisHorizontal];
		    	[buttonsStackView setDistribution:UIStackViewDistributionEqualSpacing];
	    		[buttonsStackView setAlignment:UIStackViewAlignmentLeading];
				[buttonsStackView setBackgroundColor:[UIColor yellowColor]];
		    	[buttonsStackView addArrangedSubview:viewReportsButton];
				[buttonsStackView addArrangedSubview:addReportButton];
				[cell setAccessoryView:buttonsStackView];
				return cell;
            } else {
				[[cell textLabel] setText:@"Unknown compatibility/No reports"];
				[[cell detailTextLabel] setText:@"Provided by TweakCompatible"];
				UIButton *viewReportsButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
	    		[viewReportsButton addTarget:self action:@selector(tappedOnViewReports) forControlEvents:UIControlEventTouchUpInside];
				UIButton *addReportButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
				[addReportButton addTarget:self action:@selector(tappedOnAddReport) forControlEvents:UIControlEventTouchUpInside];
	    		UIStackView *buttonsStackView = [[UIStackView alloc] initWithFrame:CGRectMake(0, 0, 65, 25)];
				[buttonsStackView setAxis:UILayoutConstraintAxisHorizontal];
		    	[buttonsStackView setDistribution:UIStackViewDistributionEqualSpacing];
	   		 	[buttonsStackView setAlignment:UIStackViewAlignmentLeading];
				[buttonsStackView setBackgroundColor:[UIColor yellowColor]];
		    	[buttonsStackView addArrangedSubview:viewReportsButton];
				[buttonsStackView addArrangedSubview:addReportButton];
				[cell setAccessoryView:buttonsStackView];
				return cell;
			}
        } else {
            [[cell textLabel] setText:@"Unknown compatibility/No reports"];
            [[cell detailTextLabel] setText:@"Provided by TweakCompatible"];
			UIButton *viewReportsButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
	    	[viewReportsButton addTarget:self action:@selector(tappedOnViewReports) forControlEvents:UIControlEventTouchUpInside];
			UIButton *addReportButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
			[addReportButton addTarget:self action:@selector(tappedOnAddReport) forControlEvents:UIControlEventTouchUpInside];
	    	UIStackView *buttonsStackView = [[UIStackView alloc] initWithFrame:CGRectMake(0, 0, 65, 25)];
			[buttonsStackView setAxis:UILayoutConstraintAxisHorizontal];
	    	[buttonsStackView setDistribution:UIStackViewDistributionEqualSpacing];
	    	[buttonsStackView setAlignment:UIStackViewAlignmentLeading];
			[buttonsStackView setBackgroundColor:[UIColor yellowColor]];
	    	[buttonsStackView addArrangedSubview:viewReportsButton];
			[buttonsStackView addArrangedSubview:addReportButton];
	
			[cell setAccessoryView:buttonsStackView];
			return cell;
        }
    } else {
		return _logos_orig$old$ZBPackageInfoView$tableView$cellForRowAtIndexPath$(self, _cmd, arg1, arg2);
	}
}

static void _logos_method$old$ZBPackageInfoView$setPackage$(_LOGOS_SELF_TYPE_NORMAL ZBPackageInfoView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, ZBPackage * arg1){
	_logos_orig$old$ZBPackageInfoView$setPackage$(self, _cmd, arg1);
	NSMutableDictionary *infoDict = MSHookIvar<NSMutableDictionary *>(self, "infos");
	[infoDict setObject:@"TweakCompatible" forKey:@"TweakCompatible"];
	MSHookIvar<NSMutableDictionary *>(self, "infos") = infoDict;
}



static void _logos_method$old$ZBPackageInfoView$tappedOnViewReports(_LOGOS_SELF_TYPE_NORMAL ZBPackageInfoView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
	NSMutableDictionary *infoDict = MSHookIvar<NSMutableDictionary *>(self, "infos");
    NSString *packageID = [infoDict objectForKey:@"packageID"];
	NSString *versionString = [infoDict objectForKey:@"Version"];
	NSString *summary = [[NSString alloc] init];
	if ([versionString containsString:@"(Installed Version"]){
		NSArray *versionArray = [versionString componentsSeparatedByString:@"(Installed Version"];
		versionString = [[versionArray objectAtIndex:0] stringByReplacingOccurrencesOfString:@" " withString:@""];
	}
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
		if ([[outcomeDict objectForKey:@"calculatedStatus"] isEqualToString:@"Working"] || [[outcomeDict objectForKey:@"calculatedStatus"] isEqualToString:@"Likely working"] || [[outcomeDict objectForKey:@"calculatedStatus"] isEqualToString:@"Not working"]){
            summary = [NSString stringWithFormat:@"%@ version %@ is marked as %@ on iOS %@\n\n(%@ reports, %@ working and %@ non-working)", [infoDict objectForKey:@"packageID"], versionString, [outcomeDict objectForKey:@"calculatedStatus"], [[UIDevice currentDevice] systemVersion], [outcomeDict objectForKey:@"total"], [outcomeDict objectForKey:@"good"], [outcomeDict objectForKey:@"bad"]];
        } else {
			summary = [NSString stringWithFormat:@"%@ version %@ has unknown compatibility with iOS %@", [infoDict objectForKey:@"packageID"], versionString, [[UIDevice currentDevice] systemVersion]];
		}
    } else {
		summary = [NSString stringWithFormat:@"%@ version %@ has unknown compatibility with iOS %@", [infoDict objectForKey:@"packageID"], versionString, [[UIDevice currentDevice] systemVersion]];
    }
	UIAlertController *compatibilityAlert = [UIAlertController alertControllerWithTitle:@"Compatibility Report" message:summary preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *viewAllReportsAction = [UIAlertAction actionWithTitle:@"View all reports" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://jlippold.github.io/tweakCompatible/package.html#!/%@/details/%@", [infoDict objectForKey:@"packageID"], versionString]];
		SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:url];
		[[self parentVC] presentViewController:safariVC animated:TRUE completion:nil];
    }];
    [compatibilityAlert addAction:viewAllReportsAction];
    [compatibilityAlert addAction:dismissAction];
    [[self parentVC] presentViewController:compatibilityAlert animated:TRUE completion:nil];
}


static void _logos_method$old$ZBPackageInfoView$tappedOnAddReport(_LOGOS_SELF_TYPE_NORMAL ZBPackageInfoView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
	NSMutableDictionary *infoDict = MSHookIvar<NSMutableDictionary *>(self, "infos");
    NSString *packageID = [infoDict objectForKey:@"packageID"];
	NSString *packageStatusExplanation = [[NSString alloc] init];
	NSString *archDescription = [[NSString alloc] init];
	NSDictionary *outcomeDict;
	BOOL packageExists;
	BOOL versionExists;
	NSString *versionString = [infoDict objectForKey:@"Version"];
	if ([versionString containsString:@" (Installed Version: "]){
		NSArray *versionArray = [versionString componentsSeparatedByString:@" (Installed Version: "];
		versionString = [[versionArray objectAtIndex:0] stringByReplacingOccurrencesOfString:@" " withString:@""];
	}
    if ([[all_packages allKeys] containsObject:packageID] ) {
        NSDictionary *compatibilityInfo = [NSJSONSerialization JSONObjectWithData:[all_packages objectForKey:packageID] options:0 error:NULL];
        NSArray *allVersions = [compatibilityInfo objectForKey:@"versions"];
        for (NSDictionary *versionInfo in allVersions){
            if ([[versionInfo objectForKey:@"tweakVersion"] isEqualToString:[compatibilityInfo objectForKey:@"latest"]]) {
                if (sizeof(void*) == 4) {
					archDescription = @"32bit";
                    outcomeDict = [NSDictionary dictionaryWithDictionary:[[versionInfo objectForKey:@"outcome"] objectForKey:@"arch32"]];
                } else  {
                    outcomeDict = [NSDictionary dictionaryWithDictionary:[versionInfo objectForKey:@"outcome"]];
                }
            }
        }
		if ([[outcomeDict objectForKey:@"calculatedStatus"] isEqualToString:@"Working"] || [[outcomeDict objectForKey:@"calculatedStatus"] isEqualToString:@"Likely working"] || [[outcomeDict objectForKey:@"calculatedStatus"] isEqualToString:@"Not working"]){
            packageExists = TRUE;
			versionExists = TRUE;
			packageStatusExplanation = [NSString stringWithFormat:@"This%@ package version has been marked as %@ based on feedback from users in the community. ""The current positive rating is %@%% with %@ working reports.", archDescription, [outcomeDict objectForKey:@"calculatedStatus"], [outcomeDict objectForKey:@"percentage"], [outcomeDict objectForKey:@"good"]];
        } else {
			packageExists = TRUE;
			versionExists = FALSE;
			packageStatusExplanation = @"A matching version of this tweak for this iOS version could not be found. ""Please submit a review if you choose to install.";
		}
    } else {
		packageExists = FALSE;
		versionExists = FALSE;
		packageStatusExplanation = @"This tweak has not been reviewed. Please submit a review if you choose to install.";
    }
	NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
	struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceId = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
	[userInfo setObject:deviceId forKey:@"deviceId"];
	NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
	[userInfo setObject:systemVersion forKey:@"iOSVersion"];
	NSString *myVersion = [[NSString alloc] init];
    NSString *dpkgStatus = [NSString stringWithContentsOfFile:@"/Library/dpkg/status" encoding:NSUTF8StringEncoding error:nil];
    NSArray *dpkgStatusArray = [dpkgStatus componentsSeparatedByString:@"Package: "];
    for (NSString *dpkgPackageStatus in dpkgStatusArray) {
        if ([dpkgPackageStatus containsString:@"com.samgisaninja.tweakcompatible-zebra"]) {
            NSArray *statusLines = [dpkgPackageStatus componentsSeparatedByString:[NSString stringWithFormat:@"\n"]];
            for (NSString *line in statusLines) {
                if ([line hasPrefix:@"Version: "]) {
                    myVersion = [NSString stringWithFormat:@"tweakcompatible-zebra-%@", [line stringByReplacingOccurrencesOfString:@"Version: " withString:@""]];
                }
            }
        }
    }
	BOOL isInstalled;
	NSString *installedVersionString = [[NSString alloc] init];
	if ([dpkgStatus containsString:[infoDict objectForKey:@"packageID"]]){
		isInstalled = TRUE;
		for (NSString *dpkgPackageStatus in dpkgStatusArray) {
        	if ([dpkgPackageStatus containsString:[infoDict objectForKey:@"packageID"]]) {
            	NSArray *statusLines = [dpkgPackageStatus componentsSeparatedByString:[NSString stringWithFormat:@"\n"]];
            	for (NSString *line in statusLines) {
                	if ([line hasPrefix:@"Version: "]) {
                	    installedVersionString = [NSString stringWithFormat:@"tweakcompatible-zebra-%@", [line stringByReplacingOccurrencesOfString:@"Version: " withString:@""]];
                	}
            	}
        	}
    	}
	} else {
		isInstalled = FALSE;
	}
	[userInfo setObject:myVersion forKey:@"tweakCompatVersion"];
	[userInfo setObject:@(packageExists) forKey:@"packageIndexed"];
	[userInfo setObject:@(versionExists) forKey:@"packageVersionIndexed"];
	if ([packageStatusExplanation containsString:@"package version has been marked as"]) {
		[userInfo setObject:[outcomeDict objectForKey:@"calculatedStatus"] forKey:@"packageStatus"];
	} else {
		[userInfo setObject:@"Unknown" forKey:@"packageStatus"];
	}
	[userInfo setObject:packageStatusExplanation forKey:@"packageStatusExplaination"];
	[userInfo setObject:[infoDict objectForKey:@"packageID"] forKey:@"packageId"];
	[userInfo setObject:[infoDict objectForKey:@"packageID"] forKey:@"id"];
	[userInfo setObject:[[self packageName] text] forKey:@"name"];
	[userInfo setObject:[[self packageName] text] forKey:@"packageName"];
	[userInfo setObject:versionString forKey:@"latest"];
	[userInfo setObject:installedVersionString forKey:@"installed"];
	BOOL isPaidPkg = [[self depictionPackage] isPaid];
	[userInfo setObject:@(isPaidPkg) forKey:@"commercial"];
	[userInfo setObject:[[self depictionPackage] section] forKey:@"category"];
	[userInfo setObject:[[self depictionPackage] shortDescription] forKey:@"shortDescription"];
	[userInfo setObject:@(isInstalled) forKey:@"packageInstalled"];
	BOOL isArmv7;
	if ([archDescription isEqualToString:@"32bit"]){
		isArmv7 = TRUE;
	} else {
		isArmv7 = FALSE;
	}
	[userInfo setObject:@(isArmv7) forKey:@"arch32"];
	[userInfo setObject:[infoDict objectForKey:@"Repo"] forKey:@"repository"];
	[userInfo setObject:[infoDict objectForKey:@"Author"] forKey:@"author"];
	[userInfo setObject:[NSString stringWithFormat:@"http://cydia.saurik.com/package/%@/", [infoDict objectForKey:@"packageID"]] forKey:@"url"];
	NSData *jsonData = [NSJSONSerialization dataWithJSONObject:userInfo options:kNilOptions error:nil];
	NSString *userInfoBase64 = [jsonData base64EncodedStringWithOptions:0];
	NSString *workingURLString = [NSString stringWithFormat:@"https://jlippold.github.io/tweakCompatible/submit.html#!/%@/working/%@", [infoDict objectForKey:@"packageID"], userInfoBase64];
	NSString *notWorkingURLString = [NSString stringWithFormat:@"https://jlippold.github.io/tweakCompatible/submit.html#!/%@/notworking/%@", [infoDict objectForKey:@"packageID"], userInfoBase64];
	UIAlertController *markPackageAlert;
	NSString *message = [[NSString alloc] init];
	if (isInstalled) {
		message = [NSString stringWithFormat:@"Log in to Github in safari BEFORE attempting to add a report"];
	} else {
		message = [NSString stringWithFormat:@"Log in to Github in safari BEFORE attempting to add a report\nYou cannot file a 'working' report unless you have the package installed"];
	}
    if ([[[UIDevice currentDevice] model] isEqualToString:@"iPad"]) {
        markPackageAlert = [UIAlertController alertControllerWithTitle:@"Create report" message:message preferredStyle:UIAlertControllerStyleAlert];
    } else {
        markPackageAlert = [UIAlertController alertControllerWithTitle:@"Create report" message:message preferredStyle:UIAlertControllerStyleActionSheet];
    }
    UIAlertAction *markAsWorkingAction = [UIAlertAction actionWithTitle:@"Package is working" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *url = [NSURL URLWithString:workingURLString];
		SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:url];
		[[self parentVC] presentViewController:safariVC animated:TRUE completion:nil];
    }];
    UIAlertAction *markAsNotWorkingAction = [UIAlertAction actionWithTitle:@"Package is not working" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSURL *url = [NSURL URLWithString:notWorkingURLString];
		SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:url];
		[[self parentVC] presentViewController:safariVC animated:TRUE completion:nil];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    if (isInstalled){
		[markPackageAlert addAction:markAsWorkingAction];
	}
    [markPackageAlert addAction:markAsNotWorkingAction];
    [markPackageAlert addAction:cancelAction];
    [[self parentVC] presentViewController:markPackageAlert animated:TRUE completion:nil];
}





static __attribute__((constructor)) void _logosLocalCtor_b2107b13(int __unused argc, char __unused **argv, char __unused **envp) {
	BOOL useOldMethods;
	NSString *zebraVersion = [[NSString alloc] init];
    NSString *dpkgStatus = [NSString stringWithContentsOfFile:@"/Library/dpkg/status" encoding:NSUTF8StringEncoding error:nil];
    NSArray *dpkgStatusArray = [dpkgStatus componentsSeparatedByString:@"Package: "];
    for (NSString *dpkgPackageStatus in dpkgStatusArray) {
        if ([dpkgPackageStatus hasPrefix:@"xyz.willy.zebra"]) {
            NSArray *statusLines = [dpkgPackageStatus componentsSeparatedByString:[NSString stringWithFormat:@"\n"]];
            for (NSString *line in statusLines) {
                if ([line hasPrefix:@"Version: "]) {
                    zebraVersion = [line stringByReplacingOccurrencesOfString:@"Version: " withString:@""];
                    if ([zebraVersion containsString:@"beta"]) {
                        NSArray *zebraVerArray = [zebraVersion componentsSeparatedByString:@"beta"];
                        if ([[zebraVerArray lastObject] length] >= 2) {
                            int zebraBetaNum = [[[zebraVerArray lastObject] substringToIndex:2] intValue];
                            if (zebraBetaNum > 17) {
								useOldMethods = FALSE;
                            } else {
								useOldMethods = TRUE;
                            }

                        } else {
							useOldMethods = TRUE;
                        }
                    } else {
						useOldMethods = FALSE;
                    }
                }
            }
        }
	}
	if (useOldMethods){
		{Class _logos_class$old$ZBTabBarController = objc_getClass("ZBTabBarController"); MSHookMessageEx(_logos_class$old$ZBTabBarController, @selector(viewDidLoad), (IMP)&_logos_method$old$ZBTabBarController$viewDidLoad, (IMP*)&_logos_orig$old$ZBTabBarController$viewDidLoad);Class _logos_class$old$ZBPackageInfoView = objc_getClass("ZBPackageInfoView"); Class _logos_metaclass$old$ZBPackageInfoView = object_getClass(_logos_class$old$ZBPackageInfoView); MSHookMessageEx(_logos_metaclass$old$ZBPackageInfoView, @selector(packageInfoOrder), (IMP)&_logos_meta_method$old$ZBPackageInfoView$packageInfoOrder, (IMP*)&_logos_meta_orig$old$ZBPackageInfoView$packageInfoOrder);MSHookMessageEx(_logos_class$old$ZBPackageInfoView, @selector(tableView:cellForRowAtIndexPath:), (IMP)&_logos_method$old$ZBPackageInfoView$tableView$cellForRowAtIndexPath$, (IMP*)&_logos_orig$old$ZBPackageInfoView$tableView$cellForRowAtIndexPath$);MSHookMessageEx(_logos_class$old$ZBPackageInfoView, @selector(setPackage:), (IMP)&_logos_method$old$ZBPackageInfoView$setPackage$, (IMP*)&_logos_orig$old$ZBPackageInfoView$setPackage$);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$old$ZBPackageInfoView, @selector(tappedOnViewReports), (IMP)&_logos_method$old$ZBPackageInfoView$tappedOnViewReports, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$old$ZBPackageInfoView, @selector(tappedOnAddReport), (IMP)&_logos_method$old$ZBPackageInfoView$tappedOnAddReport, _typeEncoding); }}
	} else {
		{Class _logos_class$new$ZBTabBarController = objc_getClass("ZBTabBarController"); MSHookMessageEx(_logos_class$new$ZBTabBarController, @selector(viewDidLoad), (IMP)&_logos_method$new$ZBTabBarController$viewDidLoad, (IMP*)&_logos_orig$new$ZBTabBarController$viewDidLoad);Class _logos_class$new$ZBPackageDepictionViewController = objc_getClass("ZBPackageDepictionViewController"); MSHookMessageEx(_logos_class$new$ZBPackageDepictionViewController, @selector(packageInfoOrder), (IMP)&_logos_method$new$ZBPackageDepictionViewController$packageInfoOrder, (IMP*)&_logos_orig$new$ZBPackageDepictionViewController$packageInfoOrder);MSHookMessageEx(_logos_class$new$ZBPackageDepictionViewController, @selector(tableView:cellForRowAtIndexPath:), (IMP)&_logos_method$new$ZBPackageDepictionViewController$tableView$cellForRowAtIndexPath$, (IMP*)&_logos_orig$new$ZBPackageDepictionViewController$tableView$cellForRowAtIndexPath$);MSHookMessageEx(_logos_class$new$ZBPackageDepictionViewController, @selector(setPackage), (IMP)&_logos_method$new$ZBPackageDepictionViewController$setPackage, (IMP*)&_logos_orig$new$ZBPackageDepictionViewController$setPackage);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$new$ZBPackageDepictionViewController, @selector(tappedOnViewReports), (IMP)&_logos_method$new$ZBPackageDepictionViewController$tappedOnViewReports, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$new$ZBPackageDepictionViewController, @selector(tappedOnAddReport), (IMP)&_logos_method$new$ZBPackageDepictionViewController$tappedOnAddReport, _typeEncoding); }}
	}
}
