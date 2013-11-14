//
//  BLHttpResponseHandler.h
//  BowerLabsFoundation
//
//  Created by Jeremy Bower on 2013-10-10.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BLHttpResponseHandler;

@protocol BLHttpResponseHandlerDelegate <NSObject>

@optional

- (void)responseHandler:(BLHttpResponseHandler*)handler didReceiveUnexpectedResponse:(NSHTTPURLResponse*)response responseObject:(id)responseObject completion:(void(^)(NSError* error))completionBlock;

@end

@interface BLHttpResponseHandler : NSObject

@property (nonatomic, weak) id<BLHttpResponseHandlerDelegate> delegate;

+ (instancetype)expectStatusCode:(NSInteger)statusCode
                         success:(void(^)(NSHTTPURLResponse* response, id responseObject))successBlock
                         failure:(void(^)(NSError* error))failureBlock;

- (void)expectStatusCode:(NSInteger)statusCode
                   block:(void(^)(NSHTTPURLResponse* response, id responseObject))block;

- (void)handleResponse:(NSHTTPURLResponse*)response
        responseObject:(id)responseObject
                 error:(NSError*)error;

@end
