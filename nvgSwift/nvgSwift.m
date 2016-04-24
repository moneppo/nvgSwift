//
//  nvgSwift.m
//  nvgSwift
//
//  Created by Michael Oneppo on 4/23/16.
//  Copyright © 2016 moneppo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "nvgSwift.h"

#if defined NANOVG_GL2
NVGcontext* nvgCreateGL2(int flags)
#elif defined NANOVG_GL3
NVGcontext* nvgCreateGL3(int flags)
#elif defined NANOVG_GLES2
NVGcontext* nvgCreateGLES2(int flags)
#elif defined NANOVG_GLES3
NVGcontext* nvgCreateGLES3(int flags)
#endif
{
    NVGparams params;
    NVGcontext* ctx = NULL;
    GLNVGcontext* gl = (GLNVGcontext*)malloc(sizeof(GLNVGcontext));
    if (gl == NULL) goto error;
    memset(gl, 0, sizeof(GLNVGcontext));
    
    memset(&params, 0, sizeof(params));
    params.renderCreate = glnvg__renderCreate;
    params.renderCreateTexture = glnvg__renderCreateTexture;
    params.renderDeleteTexture = glnvg__renderDeleteTexture;
    params.renderUpdateTexture = glnvg__renderUpdateTexture;
    params.renderGetTextureSize = glnvg__renderGetTextureSize;
    params.renderViewport = glnvg__renderViewport;
    params.renderCancel = glnvg__renderCancel;
    params.renderFlush = glnvg__renderFlush;
    params.renderFill = glnvg__renderFill;
    params.renderStroke = glnvg__renderStroke;
    params.renderTriangles = glnvg__renderTriangles;
    params.renderDelete = glnvg__renderDelete;
    params.userPtr = gl;
    params.edgeAntiAlias = flags & NVG_ANTIALIAS ? 1 : 0;
    
    gl->flags = flags;
    
    ctx = nvgCreateInternal(&params);
    if (ctx == NULL) goto error;
    
    return ctx;
    
error:
    // 'gl' is freed by nvgDeleteInternal.
    if (ctx != NULL) nvgDeleteInternal(ctx);
    return NULL;
}

#if defined NANOVG_GL2
void nvgDeleteGL2(NVGcontext* ctx)
#elif defined NANOVG_GL3
void nvgDeleteGL3(NVGcontext* ctx)
#elif defined NANOVG_GLES2
void nvgDeleteGLES2(NVGcontext* ctx)
#elif defined NANOVG_GLES3
void nvgDeleteGLES3(NVGcontext* ctx)
#endif
{
    nvgDeleteInternal(ctx);
}

#if defined NANOVG_GL2
int nvglCreateImageFromHandleGL2(NVGcontext* ctx, GLuint textureId, int w, int h, int imageFlags)
#elif defined NANOVG_GL3
int nvglCreateImageFromHandleGL3(NVGcontext* ctx, GLuint textureId, int w, int h, int imageFlags)
#elif defined NANOVG_GLES2
int nvglCreateImageFromHandleGLES2(NVGcontext* ctx, GLuint textureId, int w, int h, int imageFlags)
#elif defined NANOVG_GLES3
int nvglCreateImageFromHandleGLES3(NVGcontext* ctx, GLuint textureId, int w, int h, int imageFlags)
#endif
{
    GLNVGcontext* gl = (GLNVGcontext*)nvgInternalParams(ctx)->userPtr;
    GLNVGtexture* tex = glnvg__allocTexture(gl);
    
    if (tex == NULL) return 0;
    
    tex->type = NVG_TEXTURE_RGBA;
    tex->tex = textureId;
    tex->flags = imageFlags;
    tex->width = w;
    tex->height = h;
    
    return tex->id;
}

#if defined NANOVG_GL2
GLuint nvglImageHandleGL2(NVGcontext* ctx, int image)
#elif defined NANOVG_GL3
GLuint nvglImageHandleGL3(NVGcontext* ctx, int image)
#elif defined NANOVG_GLES2
GLuint nvglImageHandleGLES2(NVGcontext* ctx, int image)
#elif defined NANOVG_GLES3
GLuint nvglImageHandleGLES3(NVGcontext* ctx, int image)
#endif
{
    GLNVGcontext* gl = (GLNVGcontext*)nvgInternalParams(ctx)->userPtr;
    GLNVGtexture* tex = glnvg__findTexture(gl, image);
    return tex->tex;
}
