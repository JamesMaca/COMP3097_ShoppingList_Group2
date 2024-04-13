#import <Foundation/Foundation.h>

#if __has_attribute(swift_private)
#define AC_SWIFT_PRIVATE __attribute__((swift_private))
#else
#define AC_SWIFT_PRIVATE
#endif

/// The "logo_image" asset catalog image resource.
static NSString * const ACImageNameLogoImage AC_SWIFT_PRIVATE = @"logo_image";

#undef AC_SWIFT_PRIVATE
