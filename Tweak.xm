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
// Not yet fully compatible, but progress

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
// Should work, but app itself looks broken on iOS 5?

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





// Verizon OnDemand

%hook SecureMediaManager
-(void)checkRegisterNotification:(id)notification
{
	id original = notification;
	NSNotification* newNotif = [NSNotification notificationWithName: [original name] object: [original object] userInfo: [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:1], @"registerComplete", [NSNumber numberWithInt:1], @"registerStatus", nil]];
	%log;
	NSLog(@"about to actually return this fake notification: %@", newNotif);
	%orig(newNotif);
}
%end
%hook mscSingleton
-(void)smInitNotificationHandler:(id)handler
{
	id original = handler;
	NSNotification* newNotif = [NSNotification notificationWithName: [original name] object: [original object] userInfo: [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:1], @"initStatus", nil]];
	%log;
	NSLog(@"about to actually return this fake notification: %@", newNotif);
	%orig(newNotif);
}
%end




// fledgling hack stuff on Nomad, currently crashes app

/*%hook NSObject
-(id)init
{
	id obj = %orig;
	NSLog(@"about to init a(n) %@", NSStringFromClass([obj class]));
	return obj;
}
%end

%hook NSComparisonPredicate
+ (NSPredicate *)predicateWithLeftExpression:(NSExpression *)lhs rightExpression:(NSExpression *)rhs modifier:(NSComparisonPredicateModifier)modifier type:(NSPredicateOperatorType)type options:(NSComparisonPredicateOptions)options { %log; return %orig; }
+ (NSPredicate *)predicateWithLeftExpression:(NSExpression *)lhs rightExpression:(NSExpression *)rhs customSelector:(SEL)selector { %log; return %orig; }
- (id)initWithLeftExpression:(NSExpression *)lhs rightExpression:(NSExpression *)rhs modifier:(NSComparisonPredicateModifier)modifier type:(NSPredicateOperatorType)type options:(NSComparisonPredicateOptions)options { %log; return %orig; }
- (id)initWithLeftExpression:(NSExpression *)lhs rightExpression:(NSExpression *)rhs customSelector:(SEL)selector { %log; return %orig; }
- (NSPredicateOperatorType)predicateOperatorType { %log; return %orig; }
- (NSComparisonPredicateModifier)comparisonPredicateModifier { %log; return %orig; }
- (NSExpression *)leftExpression { %log; return %orig; }
- (NSExpression *)rightExpression { %log; return %orig; }
- (SEL)customSelector { %log; return %orig; }
- (NSComparisonPredicateOptions)options { %log; return %orig; }
%end
%hook NSString
- (NSUInteger)length { %log; return %orig; }
- (unichar)characterAtIndex:(NSUInteger)index { %log; return %orig; }
%end
%hook NSString
- (void)getCharacters:(unichar *)buffer range:(NSRange)aRange { %log; %orig; }
- (NSString *)substringFromIndex:(NSUInteger)from { %log; return %orig; }
- (NSString *)substringToIndex:(NSUInteger)to { %log; return %orig; }
- (NSString *)substringWithRange:(NSRange)range { %log; return %orig; }
- (NSComparisonResult)compare:(NSString *)string { %log; return %orig; }
- (NSComparisonResult)compare:(NSString *)string options:(NSStringCompareOptions)mask { %log; return %orig; }
- (NSComparisonResult)compare:(NSString *)string options:(NSStringCompareOptions)mask range:(NSRange)compareRange { %log; return %orig; }
- (NSComparisonResult)compare:(NSString *)string options:(NSStringCompareOptions)mask range:(NSRange)compareRange locale:(id)locale { %log; return %orig; }
- (NSComparisonResult)caseInsensitiveCompare:(NSString *)string { %log; return %orig; }
- (NSComparisonResult)localizedCompare:(NSString *)string { %log; return %orig; }
- (NSComparisonResult)localizedCaseInsensitiveCompare:(NSString *)string { %log; return %orig; }
//- (NSComparisonResult)localizedStandardCompare:(NSString *)string NS_AVAILABLE(10_6, 4_0) { %log; return %orig; }
- (BOOL)isEqualToString:(NSString *)aString { %log; return %orig; }
- (BOOL)hasPrefix:(NSString *)aString { %log; return %orig; }
- (BOOL)hasSuffix:(NSString *)aString { %log; return %orig; }
- (NSRange)rangeOfString:(NSString *)aString { %log; return %orig; }
- (NSRange)rangeOfString:(NSString *)aString options:(NSStringCompareOptions)mask { %log; return %orig; }
- (NSRange)rangeOfString:(NSString *)aString options:(NSStringCompareOptions)mask range:(NSRange)searchRange { %log; return %orig; }
//- (NSRange)rangeOfString:(NSString *)aString options:(NSStringCompareOptions)mask range:(NSRange)searchRange locale:(NSLocale *)locale NS_AVAILABLE(10_5, 2_0) { %log; return %orig; }
- (NSRange)rangeOfCharacterFromSet:(NSCharacterSet *)aSet { %log; return %orig; }
- (NSRange)rangeOfCharacterFromSet:(NSCharacterSet *)aSet options:(NSStringCompareOptions)mask { %log; return %orig; }
- (NSRange)rangeOfCharacterFromSet:(NSCharacterSet *)aSet options:(NSStringCompareOptions)mask range:(NSRange)searchRange { %log; return %orig; }
- (NSRange)rangeOfComposedCharacterSequenceAtIndex:(NSUInteger)index { %log; return %orig; }
//- (NSRange)rangeOfComposedCharacterSequencesForRange:(NSRange)range NS_AVAILABLE(10_5, 2_0) { %log; return %orig; }
- (NSString *)stringByAppendingString:(NSString *)aString { %log; return %orig; }
//- (NSString *)stringByAppendingFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2) { %log; return %orig; }
- (double)doubleValue { %log; return %orig; }
- (float)floatValue { %log; return %orig; }
- (int)intValue { %log; return %orig; }
- (NSInteger)integerValue NS_AVAILABLE(10_5, 2_0) { %log; return %orig; }
- (long long)longLongValue NS_AVAILABLE(10_5, 2_0) { %log; return %orig; }
- (BOOL)boolValue NS_AVAILABLE(10_5, 2_0) { %log; return %orig; }
- (NSArray *)componentsSeparatedByString:(NSString *)separator { %log; return %orig; }
//- (NSArray *)componentsSeparatedByCharactersInSet:(NSCharacterSet *)separator NS_AVAILABLE(10_5, 2_0) { %log; return %orig; }
- (NSString *)commonPrefixWithString:(NSString *)aString options:(NSStringCompareOptions)mask { %log; return %orig; }
- (NSString *)uppercaseString { %log; return %orig; }
- (NSString *)lowercaseString { %log; return %orig; }
- (NSString *)capitalizedString { %log; return %orig; }
- (NSString *)stringByTrimmingCharactersInSet:(NSCharacterSet *)set { %log; return %orig; }
- (NSString *)stringByPaddingToLength:(NSUInteger)newLength withString:(NSString *)padString startingAtIndex:(NSUInteger)padIndex { %log; return %orig; }
- (void)getLineStart:(NSUInteger *)startPtr end:(NSUInteger *)lineEndPtr contentsEnd:(NSUInteger *)contentsEndPtr forRange:(NSRange)range { %log; %orig; }
- (NSRange)lineRangeForRange:(NSRange)range { %log; return %orig; }
- (void)getParagraphStart:(NSUInteger *)startPtr end:(NSUInteger *)parEndPtr contentsEnd:(NSUInteger *)contentsEndPtr forRange:(NSRange)range { %log; %orig; }
- (NSRange)paragraphRangeForRange:(NSRange)range { %log; return %orig; }
//- (void)enumerateSubstringsInRange:(NSRange)range options:(NSStringEnumerationOptions)opts usingBlock:(void (^)(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop))block NS_AVAILABLE(10_6, 4_0) { %log; %orig; }
//- (void)enumerateLinesUsingBlock:(void (^)(NSString *line, BOOL *stop))block NS_AVAILABLE(10_6, 4_0) { %log; %orig; }
- (NSString *)description { %log; return %orig; }
- (NSUInteger)hash { %log; return %orig; }
- (NSStringEncoding)fastestEncoding { %log; return %orig; }
- (NSStringEncoding)smallestEncoding { %log; return %orig; }
- (NSData *)dataUsingEncoding:(NSStringEncoding)encoding allowLossyConversion:(BOOL)lossy { %log; return %orig; }
- (NSData *)dataUsingEncoding:(NSStringEncoding)encoding { %log; return %orig; }
- (BOOL)canBeConvertedToEncoding:(NSStringEncoding)encoding { %log; return %orig; }
- (__strong const char *)cStringUsingEncoding:(NSStringEncoding)encoding { %log; return %orig; }
- (BOOL)getCString:(char *)buffer maxLength:(NSUInteger)maxBufferCount encoding:(NSStringEncoding)encoding { %log; return %orig; }
- (BOOL)getBytes:(void *)buffer maxLength:(NSUInteger)maxBufferCount usedLength:(NSUInteger *)usedBufferCount encoding:(NSStringEncoding)encoding options:(NSStringEncodingConversionOptions)options range:(NSRange)range remainingRange:(NSRangePointer)leftover { %log; return %orig; }
- (NSUInteger)maximumLengthOfBytesUsingEncoding:(NSStringEncoding)enc { %log; return %orig; }
- (NSUInteger)lengthOfBytesUsingEncoding:(NSStringEncoding)enc { %log; return %orig; }
- (NSString *)decomposedStringWithCanonicalMapping { %log; return %orig; }
- (NSString *)precomposedStringWithCanonicalMapping { %log; return %orig; }
- (NSString *)decomposedStringWithCompatibilityMapping { %log; return %orig; }
- (NSString *)precomposedStringWithCompatibilityMapping { %log; return %orig; }
//- (NSString *)stringByFoldingWithOptions:(NSStringCompareOptions)options locale:(NSLocale *)locale NS_AVAILABLE(10_5, 2_0) { %log; return %orig; }
//- (NSString *)stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange NS_AVAILABLE(10_5, 2_0) { %log; return %orig; }
//- (NSString *)stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement NS_AVAILABLE(10_5, 2_0) { %log; return %orig; }
//- (NSString *)stringByReplacingCharactersInRange:(NSRange)range withString:(NSString *)replacement NS_AVAILABLE(10_5, 2_0) { %log; return %orig; }
- (__strong const char *)UTF8String { %log; return %orig; }
+ (NSStringEncoding)defaultCStringEncoding { %log; return %orig; }
+ (const NSStringEncoding *)availableStringEncodings { %log; return %orig; }
+ (NSString *)localizedNameOfStringEncoding:(NSStringEncoding)encoding { %log; return %orig; }
- (id)init { %log; return %orig; }
- (id)initWithCharactersNoCopy:(unichar *)characters length:(NSUInteger)length freeWhenDone:(BOOL)freeBuffer { %log; return %orig; }
- (id)initWithCharacters:(const unichar *)characters length:(NSUInteger)length { %log; return %orig; }
- (id)initWithUTF8String:(const char *)nullTerminatedCString { %log; return %orig; }
- (id)initWithString:(NSString *)aString { %log; return %orig; }
//- (id)initWithFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2) { %log; return %orig; }
//- (id)initWithFormat:(NSString *)format arguments:(va_list)argList NS_FORMAT_FUNCTION(1,0) { %log; return %orig; }
//- (id)initWithFormat:(NSString *)format locale:(id)locale, ... NS_FORMAT_FUNCTION(1,3) { %log; return %orig; }
//- (id)initWithFormat:(NSString *)format locale:(id)locale arguments:(va_list)argList NS_FORMAT_FUNCTION(1,0) { %log; return %orig; }
//- (id)initWithData:(NSData *)data encoding:(NSStringEncoding)encoding { %log; return %orig; }
//- (id)initWithBytes:(const void *)bytes length:(NSUInteger)len encoding:(NSStringEncoding)encoding { %log; return %orig; }
//- (id)initWithBytesNoCopy:(void *)bytes length:(NSUInteger)len encoding:(NSStringEncoding)encoding freeWhenDone:(BOOL)freeBuffer { %log; return %orig; }
+ (id)string { %log; return %orig; }
+ (id)stringWithString:(NSString *)string { %log; return %orig; }
//+ (id)stringWithCharacters:(const unichar *)characters length:(NSUInteger)length { %log; return %orig; }
+ (id)stringWithUTF8String:(const char *)nullTerminatedCString { %log; return %orig; }
//+ (id)stringWithFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2) { %log; return %orig; }
//+ (id)localizedStringWithFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2) { %log; return %orig; }
- (id)initWithCString:(const char *)nullTerminatedCString encoding:(NSStringEncoding)encoding { %log; return %orig; }
+ (id)stringWithCString:(const char *)cString encoding:(NSStringEncoding)enc { %log; return %orig; }
- (id)initWithContentsOfURL:(NSURL *)url encoding:(NSStringEncoding)enc error:(NSError **)error { %log; return %orig; }
- (id)initWithContentsOfFile:(NSString *)path encoding:(NSStringEncoding)enc error:(NSError **)error { %log; return %orig; }
+ (id)stringWithContentsOfURL:(NSURL *)url encoding:(NSStringEncoding)enc error:(NSError **)error { %log; return %orig; }
+ (id)stringWithContentsOfFile:(NSString *)path encoding:(NSStringEncoding)enc error:(NSError **)error { %log; return %orig; }
- (id)initWithContentsOfURL:(NSURL *)url usedEncoding:(NSStringEncoding *)enc error:(NSError **)error { %log; return %orig; }
- (id)initWithContentsOfFile:(NSString *)path usedEncoding:(NSStringEncoding *)enc error:(NSError **)error { %log; return %orig; }
+ (id)stringWithContentsOfURL:(NSURL *)url usedEncoding:(NSStringEncoding *)enc error:(NSError **)error { %log; return %orig; }
+ (id)stringWithContentsOfFile:(NSString *)path usedEncoding:(NSStringEncoding *)enc error:(NSError **)error { %log; return %orig; }
- (BOOL)writeToURL:(NSURL *)url atomically:(BOOL)useAuxiliaryFile encoding:(NSStringEncoding)enc error:(NSError **)error { %log; return %orig; }
- (BOOL)writeToFile:(NSString *)path atomically:(BOOL)useAuxiliaryFile encoding:(NSStringEncoding)enc error:(NSError **)error { %log; return %orig; }

%end
%hook NSMutableString
- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)aString { %log; %orig; }
%end
%hook NSMutableString
- (void)insertString:(NSString *)aString atIndex:(NSUInteger)loc { %log; %orig; }
- (void)deleteCharactersInRange:(NSRange)range { %log; %orig; }
- (void)appendString:(NSString *)aString { %log; %orig; }
//- (void)appendFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2) { %log; %orig; }
- (void)setString:(NSString *)aString { %log; %orig; }
- (id)initWithCapacity:(NSUInteger)capacity { %log; return %orig; }
+ (id)stringWithCapacity:(NSUInteger)capacity { %log; return %orig; }
- (NSUInteger)replaceOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange { %log; return %orig; }
%end
%hook NSString
- (id)propertyList { %log; return %orig; }
- (NSDictionary *)propertyListFromStringsFileFormat { %log; return %orig; }
%end
%hook NSString
//- (const char *)cString NS_DEPRECATED(10_0, 10_4, 2_0, 2_0) { %log; return %orig; }
//- (const char *)lossyCString NS_DEPRECATED(10_0, 10_4, 2_0, 2_0) { %log; return %orig; }
//- (NSUInteger)cStringLength NS_DEPRECATED(10_0, 10_4, 2_0, 2_0) { %log; return %orig; }
- (void)getCString:(char *)bytes NS_DEPRECATED(10_0, 10_4, 2_0, 2_0) { %log; %orig; }
- (void)getCString:(char *)bytes maxLength:(NSUInteger)maxLength NS_DEPRECATED(10_0, 10_4, 2_0, 2_0) { %log; %orig; }
- (void)getCString:(char *)bytes maxLength:(NSUInteger)maxLength range:(NSRange)aRange remainingRange:(NSRangePointer)leftoverRange NS_DEPRECATED(10_0, 10_4, 2_0, 2_0) { %log; %orig; }
- (BOOL)writeToFile:(NSString *)path atomically:(BOOL)useAuxiliaryFile NS_DEPRECATED(10_0, 10_4, 2_0, 2_0) { %log; return %orig; }
- (BOOL)writeToURL:(NSURL *)url atomically:(BOOL)atomically NS_DEPRECATED(10_0, 10_4, 2_0, 2_0) { %log; return %orig; }
- (id)initWithContentsOfFile:(NSString *)path NS_DEPRECATED(10_0, 10_4, 2_0, 2_0) { %log; return %orig; }
- (id)initWithContentsOfURL:(NSURL *)url NS_DEPRECATED(10_0, 10_4, 2_0, 2_0) { %log; return %orig; }
+ (id)stringWithContentsOfFile:(NSString *)path NS_DEPRECATED(10_0, 10_4, 2_0, 2_0) { %log; return %orig; }
+ (id)stringWithContentsOfURL:(NSURL *)url NS_DEPRECATED(10_0, 10_4, 2_0, 2_0) { %log; return %orig; }
- (id)initWithCStringNoCopy:(char *)bytes length:(NSUInteger)length freeWhenDone:(BOOL)freeBuffer NS_DEPRECATED(10_0, 10_4, 2_0, 2_0) { %log; return %orig; }
- (id)initWithCString:(const char *)bytes length:(NSUInteger)length NS_DEPRECATED(10_0, 10_4, 2_0, 2_0) { %log; return %orig; }
- (id)initWithCString:(const char *)bytes NS_DEPRECATED(10_0, 10_4, 2_0, 2_0) { %log; return %orig; }
+ (id)stringWithCString:(const char *)bytes length:(NSUInteger)length NS_DEPRECATED(10_0, 10_4, 2_0, 2_0) { %log; return %orig; }
+ (id)stringWithCString:(const char *)bytes NS_DEPRECATED(10_0, 10_4, 2_0, 2_0) { %log; return %orig; }
- (void)getCharacters:(unichar *)buffer { %log; %orig; }
%end
%hook NSSimpleCString
%end
%hook NSConstantString
%end*/
