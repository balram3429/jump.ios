
#import "JRProfiles.h"

@implementation JRProfiles
@synthesize accessCredentials;
@synthesize domain;
@synthesize friends;
@synthesize identifier;
@synthesize profile;
@synthesize provider;
@synthesize remote_key;

- (id)initWithDomain:(NSString *)newDomain andIdentifier:(NSString *)newIdentifier
{
    if (!newDomain || !newIdentifier)
    {
        [self release];
        return nil;
     }

    if ((self = [super init]))
    {
        domain = [newDomain copy];
        identifier = [newIdentifier copy];
    }
    return self;
}

+ (id)profilesWithDomain:(NSString *)domain andIdentifier:(NSString *)identifier
{
    return [[[JRProfiles alloc] initWithDomain:domain andIdentifier:identifier] autorelease];
}

- (id)copyWithZone:(NSZone*)zone
{
    JRProfiles *profilesCopy =
                [[JRProfiles allocWithZone:zone] initWithDomain:self.domain andIdentifier:self.identifier];

    profilesCopy.accessCredentials = self.accessCredentials;
    profilesCopy.friends = self.friends;
    profilesCopy.profile = self.profile;
    profilesCopy.provider = self.provider;
    profilesCopy.remote_key = self.remote_key;

    return profilesCopy;
}

+ (id)profilesObjectFromDictionary:(NSDictionary*)dictionary
{
    JRProfiles *profiles =
        [JRProfiles profilesWithDomain:[dictionary objectForKey:@"domain"] andIdentifier:[dictionary objectForKey:@"identifier"]];

    profiles.accessCredentials = [dictionary objectForKey:@"accessCredentials"];
    profiles.friends = [dictionary objectForKey:@"friends"];
    profiles.profile = [JRProfile profileObjectFromDictionary:(NSDictionary*)[dictionary objectForKey:@"profile"]];
    profiles.provider = [dictionary objectForKey:@"provider"];
    profiles.remote_key = [dictionary objectForKey:@"remote_key"];

    return profiles;
}

- (NSDictionary*)dictionaryFromObject
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:10];

    [dict setObject:domain forKey:@"domain"];
    [dict setObject:identifier forKey:@"identifier"];

    if (accessCredentials)
        [dict setObject:accessCredentials forKey:@"accessCredentials"];

    if (friends)
        [dict setObject:friends forKey:@"friends"];

    if (profile)
        [dict setObject:[profile dictionaryFromObject] forKey:@"profile"];

    if (provider)
        [dict setObject:provider forKey:@"provider"];

    if (remote_key)
        [dict setObject:remote_key forKey:@"remote_key"];

    return dict;
}

- (void)dealloc
{
    [accessCredentials release];
    [domain release];
    [friends release];
    [identifier release];
    [profile release];
    [provider release];
    [remote_key release];

    [super dealloc];
}
@end