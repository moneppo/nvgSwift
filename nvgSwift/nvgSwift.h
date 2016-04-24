//
//  nvgSwift.h
//  nvgSwift
//
//  Created by Michael Oneppo on 4/22/16.
//  Copyright © 2016 moneppo. All rights reserved.
//

#import <Cocoa/Cocoa.h>

//! Project version number for nvgSwift.
FOUNDATION_EXPORT double nvgSwiftVersionNumber;

//! Project version string for nvgSwift.
FOUNDATION_EXPORT const unsigned char nvgSwiftVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <nvgSwift/PublicHeader.h>

#include "nanovg.h"
#include <OpenGL/gl.h>

#define NANOVG_GL2_IMPLEMENTATION   // Use GL2 implementation.
#include "nanovg_gl.h"

