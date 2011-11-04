#import "DirecTViPad.h"
#import "GoodForEnterprise.h"
#import "Grimm.h"
#import "TWCTV.h"


// DirecTV iPad

%hook DTVApplicationBase
-(BOOL)isDeviceJailbroken
{
	return NO;
}
%end

%hook ApplicationSettings
-(BOOL)optionJailbreakCheckEnabled
{
	return NO;
}
-(void)setOptionJailbreakCheckEnabled:(BOOL)enabled
{
	%orig(NO);
}
%end





// Good For Enterprise

%hook JailbreakEnhacement
-(id)init
{
	NSLog(@"n00neimp0rtant here, let's get busy");
	return %orig;
}

+(BOOL)partitionsModified
{
	NSLog(@"Checking partition modification, giving fake thumbs-up");
	return NO;
}

+(BOOL)servicesModified
{
	NSLog(@"Checking service modification, giving fake thumbs-up");
	return NO;
}

+(BOOL)checkFileSystemWithPath:(id)path forPermissions:(id)permissions
{
	BOOL original = %orig;
	NSLog(@"Checking file system.");
	NSLog(@"path: %@", path);
	NSLog(@"permissions is of class type: %@", NSStringFromClass([permissions class]));
	NSLog(@"permissions: %@", permissions);
	if(original) NSLog(@"giving me a yes...");
	else NSLog(@"giving me a no...");
	NSLog(@"leaving well enough alone for now.");
	return original;
}

+(BOOL)canUseFork
{
	NSLog(@"Checking if can fork processes.");
	BOOL original = %orig;
	if(original) NSLog(@"giving me a yes...");
	else NSLog(@"giving me a no...");
	NSLog(@"giving fake thumbs-up");
	return NO;
}

+(BOOL)kernelStateModified
{
	NSLog(@"Checking if kernel state modified, giving fake thumbs-up");
	return NO;
}

+(BOOL)devReadPermissionModified:(id)modified
{
	NSLog(@"Checking if dev read permissions are modified.");
	NSLog(@"modified is of class type: %@", NSStringFromClass([modified class]));
	NSLog(@"modified: %@", modified);
	BOOL original = %orig;
	if(original) NSLog(@"giving me a yes...");
	else NSLog(@"giving me a no...");
	NSLog(@"might as well give fake thumbs-up");
	return NO;
}
+(BOOL)filePermission:(id)permission
{
	NSLog(@"Checking file permission.");
	NSLog(@"permission is of class type: %@", NSStringFromClass([permission class]));
	NSLog(@"permission: %@", permission);
	BOOL original = %orig;
	if(original) NSLog(@"giving me a yes...");
	else NSLog(@"giving me a no...");
	NSLog(@"leaving well enough alone for now.");
	return original;
}
%end





// Grimm

%hook FlurrySession
-(id)init
{
	NSLog(@"n00neimp0rtant here, we're in");
	return %orig;
}
+(BOOL)deviceIsJailbroken
{
	NSLog(@"App wants to know if it is jailbroken");
	return NO;
}
+(BOOL)appIsCracked
{
	NSLog(@"App wants to know if it is cracked");
	return NO;
}
%end





// TWCTV

%hook XXUnknownSuperclass
-(BOOL)isJailbroken
{
	return NO;
}
%end

%hook TWCCustomMessages
-(void)setJailbroken_device_not_allowed:(NSString*)string
{
	%orig(@"If you're reading this, my jailbreak patch failed. Contact me @n00neimp0rtant so we can get this fixed.");
}

-(NSString*)jailbroken_device_not_allowed
{
	return [NSString stringWithFormat:@"If you're reading this, my jailbreak patch failed. Contact me @n00neimp0rtant so we can get this fixed."];
}
%end

%hook TWCTVAppDelegate
-(void)handleJailbrokenDevice
{
	NSLog(@"n00neimp0rtant here! nooping handleJailbrokenDevice");
}
%end