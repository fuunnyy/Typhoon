////////////////////////////////////////////////////////////////////////////////
//
//  TYPHOON FRAMEWORK
//  Copyright 2016, Typhoon Framework Contributors
//  All Rights Reserved.
//
//  NOTICE: The authors permit you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////


#import "TyphoonDefinitionBase.h"
#import "TyphoonDefinitionBase+Infrastructure.h"
#import "TyphoonRuntimeArguments.h"

static NSString *TyphoonScopeToString(TyphoonScope scope)
{
    switch (scope) {
        case TyphoonScopeObjectGraph:
            return @"ObjectGraph";
        case TyphoonScopePrototype:
            return @"Prototype";
        case TyphoonScopeSingleton:
            return @"Singleton";
        case TyphoonScopeWeakSingleton:
            return @"WeakSingleton";
        default:
            return @"Unknown";
    }
}


@implementation TyphoonDefinitionBase

//-------------------------------------------------------------------------------------------
#pragma mark: - Initialization
//-------------------------------------------------------------------------------------------

- (instancetype)init
{
    return [self initWithClass:Nil key:nil];
}

- (instancetype)initWithClass:(Class)clazz key:(NSString *)key
{
    if (clazz == nil) {
        [NSException raise:NSInvalidArgumentException format:@"Property 'clazz' is required."];
    }
    
    self = [super init];
    if (self) {
        _type = clazz;
        _key = key;
        _scope = TyphoonScopeObjectGraph;
        _autoInjectionVisibility = TyphoonAutoInjectVisibilityDefault;
    }
    return self;    
}

//-------------------------------------------------------------------------------------------
#pragma mark - Properties
//-------------------------------------------------------------------------------------------

- (void)setScope:(TyphoonScope)scope
{
    _scope = scope;
    _scopeSetByUser = YES;
}

//-------------------------------------------------------------------------------------------
#pragma mark - Utility Methods
//-------------------------------------------------------------------------------------------

- (id)copyWithZone:(NSZone *)zone
{
    TyphoonDefinitionBase *copy = [[[self class] allocWithZone:zone] initWithClass:_type key:[_key copy]];
    copy->_scope = _scope;
    copy->_scopeSetByUser = _scopeSetByUser;
    copy->_autoInjectionVisibility = _autoInjectionVisibility;
    copy->_processed = _processed;
    copy->_currentRuntimeArguments = [_currentRuntimeArguments copy];
    return copy;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@: class='%@', key='%@', scope='%@'", NSStringFromClass([self class]),
            NSStringFromClass(_type), _key, TyphoonScopeToString(_scope)];
}

@end
