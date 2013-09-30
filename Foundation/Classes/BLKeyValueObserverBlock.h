//
//  BLKeyValueObserverBlock.h
//  BowerLabsFoundation
//
//  Created by Jeremy Bower on 2013-01-24.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

typedef void(^BLKeyValueObserverBlock)(__weak id weakSelf, id oldValue, id newValue);
typedef void(^BLKeyValueStartupBlock)(__weak id weakSelf, id ref);
