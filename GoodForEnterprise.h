@interface JailbreakEnhacement : NSObject {
}
+(BOOL)partitionsModified;
+(BOOL)servicesModified;
+(BOOL)checkFileSystemWithPath:(id)path forPermissions:(id)permissions;
+(BOOL)canUseFork;
+(BOOL)kernelStateModified;
+(BOOL)devReadPermissionModified:(id)modified;
+(BOOL)filePermission:(id)permission;
@end