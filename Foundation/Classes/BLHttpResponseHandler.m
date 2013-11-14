//
//  BLHttpResponseHandler.m
//  BowerLabsFoundation
//
//  Created by Jeremy Bower on 2013-10-10.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import "BLHttpResponseHandler.h"

#import "BLError.h"

@interface BLHttpResponseHandler ()

@property (nonatomic, strong) NSMutableDictionary* handlers;
@property (nonatomic, copy) void(^failureBlock)(NSError*);

@end

@implementation BLHttpResponseHandler

+ (instancetype)expectStatusCode:(NSInteger)statusCode
                         success:(void(^)(NSHTTPURLResponse* response, id responseObject))successBlock
                         failure:(void(^)(NSError* error))failureBlock
{
    BLHttpResponseHandler* handler = [BLHttpResponseHandler new];
    [handler expectStatusCode:statusCode block:successBlock];
    handler.failureBlock = failureBlock;
    return handler;
}

- (id)init
{
    self = [super init];
    if (!self) { return nil; }
    
    self.handlers = [NSMutableDictionary dictionary];
    
    return self;
}

- (void)expectStatusCode:(NSInteger)statusCode
                   block:(void(^)(NSHTTPURLResponse* response, id responseObject))block
{
    self.handlers[@(statusCode)] = [block copy];
}

- (void)handleResponse:(NSHTTPURLResponse*)response
        responseObject:(id)responseObject
                 error:(NSError*)error
{
    if (error) {
        if (self.failureBlock) {
            self.failureBlock(error);
        }
    }
    else if (response) {
        void(^unexpectedBlock)() = ^{
            if (self.failureBlock) {
                // Not handled.
                NSDictionary* userInfo = @{ NSLocalizedDescriptionKey: NSLocalizedString(@"Unexpected response from server.", nil),
                                            BLErrorHttpStatusCodeKey: [NSNumber numberWithInteger:response.statusCode] };
                NSError* error = [NSError errorWithDomain:BLErrorDomain code:BLErrorCodeUnexpectedResponse userInfo:userInfo];
                self.failureBlock(error);
            }
        };
        
        void(^expectedBlock)(NSHTTPURLResponse* response, id responseObject) = self.handlers[@(response.statusCode)];
        if (expectedBlock) {
            // Handled by provided block.
            expectedBlock(response, responseObject);
        }
        else if ([self.delegate respondsToSelector:@selector(responseHandler:didReceiveUnexpectedResponse:completion:)]) {
            // Handled by delegate.
            [self.delegate responseHandler:self didReceiveUnexpectedResponse:response responseObject:responseObject completion:^(NSError* error) {
                if (error) {
                    if (self.failureBlock) {
                        self.failureBlock(error);
                    }
                }
                else {
                    unexpectedBlock();
                }
            }];
        }
        else {
            unexpectedBlock();
        }
    }
}

@end
