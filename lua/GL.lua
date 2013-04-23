local lib
if FFI.os == "Windows" then
	lib = FFI.load ("OpenGL32.dll", "GLEW32.dll")
elseif FFI.os == "OSX" then
	lib = FFI.load ("OpenGL.framework/OpenGL")
else
	lib = FFI.load ("GL")
end

local function index (t, k)
	local cached = rawget (t, k)
	if cached then return cached end

	local function trylib (k) return lib[k] end
	local ok, value = pcall (trylib, "gl" .. k)
	if ok then
		t[k] = value
		return value
	end

	if FFI.os == "Windows" then
		local ptr = lib.wglGetProcAddress ("gl" .. k)
		local ctype = FFI.typeof ("PFNGL" .. k:upper () .. "PROC") -- wow
		local result = FFI.cast (ctype, ptr)
		t[k] = result
		return result
	end
end

-- constants have been taken from GLES2 headers
local cache = {
	 DEPTH_BUFFER_BIT               = 0x00000100,
	 STENCIL_BUFFER_BIT             = 0x00000400,
	 COLOR_BUFFER_BIT               = 0x00004000,

	 FALSE                          = 0,
	 TRUE                           = 1,

	 POINTS                         = 0x0000,
	 LINES                          = 0x0001,
	 LINE_LOOP                      = 0x0002,
	 LINE_STRIP                     = 0x0003,
	 TRIANGLES                      = 0x0004,
	 TRIANGLE_STRIP                 = 0x0005,
	 TRIANGLE_FAN                   = 0x0006,

	 ZERO                           = 0,
	 ONE                            = 1,
	 SRC_COLOR                      = 0x0300,
	 ONE_MINUS_SRC_COLOR            = 0x0301,
	 SRC_ALPHA                      = 0x0302,
	 ONE_MINUS_SRC_ALPHA            = 0x0303,
	 DST_ALPHA                      = 0x0304,
	 ONE_MINUS_DST_ALPHA            = 0x0305,
	 DST_COLOR                      = 0x0306,
	 ONE_MINUS_DST_COLOR            = 0x0307,
	 SRC_ALPHA_SATURATE             = 0x0308,

	 FUNC_ADD                       = 0x8006,
	 BLEND_EQUATION                 = 0x8009,
	 BLEND_EQUATION_RGB             = 0x8009,
	 BLEND_EQUATION_ALPHA           = 0x883D,

	 FUNC_SUBTRACT                  = 0x800A,
	 FUNC_REVERSE_SUBTRACT          = 0x800B,

	 BLEND_DST_RGB                  = 0x80C8,
	 BLEND_SRC_RGB                  = 0x80C9,
	 BLEND_DST_ALPHA                = 0x80CA,
	 BLEND_SRC_ALPHA                = 0x80CB,
	 CONSTANT_COLOR                 = 0x8001,
	 ONE_MINUS_CONSTANT_COLOR       = 0x8002,
	 CONSTANT_ALPHA                 = 0x8003,
	 ONE_MINUS_CONSTANT_ALPHA       = 0x8004,
	 BLEND_COLOR                    = 0x8005,

	 ARRAY_BUFFER                   = 0x8892,
	 ELEMENT_ARRAY_BUFFER           = 0x8893,
	 ARRAY_BUFFER_BINDING           = 0x8894,
	 ELEMENT_ARRAY_BUFFER_BINDING   = 0x8895,

	 STREAM_DRAW                    = 0x88E0,
	 STATIC_DRAW                    = 0x88E4,
	 DYNAMIC_DRAW                   = 0x88E8,

	 BUFFER_SIZE                    = 0x8764,
	 BUFFER_USAGE                   = 0x8765,

	 CURRENT_VERTEX_ATTRIB          = 0x8626,

	 FRONT                          = 0x0404,
	 BACK                           = 0x0405,
	 FRONT_AND_BACK                 = 0x0408,

	 TEXTURE_2D                     = 0x0DE1,
	 CULL_FACE                      = 0x0B44,
	 BLEND                          = 0x0BE2,
	 DITHER                         = 0x0BD0,
	 STENCIL_TEST                   = 0x0B90,
	 DEPTH_TEST                     = 0x0B71,
	 SCISSOR_TEST                   = 0x0C11,
	 POLYGON_OFFSET_FILL            = 0x8037,
	 SAMPLE_ALPHA_TO_COVERAGE       = 0x809E,
	 SAMPLE_COVERAGE                = 0x80A0,

	 NO_ERROR                       = 0,
	 INVALID_ENUM                   = 0x0500,
	 INVALID_VALUE                  = 0x0501,
	 INVALID_OPERATION              = 0x0502,
	 OUT_OF_MEMORY                  = 0x0505,
	 
	 CW                             = 0x0900,
	 CCW                            = 0x0901,
	 
	 LINE_WIDTH                     = 0x0B21,
	 ALIASED_POINT_SIZE_RANGE       = 0x846D,
	 ALIASED_LINE_WIDTH_RANGE       = 0x846E,
	 CULL_FACE_MODE                 = 0x0B45,
	 FRONT_FACE                     = 0x0B46,
	 DEPTH_RANGE                    = 0x0B70,
	 DEPTH_WRITEMASK                = 0x0B72,
	 DEPTH_CLEAR_VALUE              = 0x0B73,
	 DEPTH_FUNC                     = 0x0B74,
	 STENCIL_CLEAR_VALUE            = 0x0B91,
	 STENCIL_FUNC                   = 0x0B92,
	 STENCIL_FAIL                   = 0x0B94,
	 STENCIL_PASS_DEPTH_FAIL        = 0x0B95,
	 STENCIL_PASS_DEPTH_PASS        = 0x0B96,
	 STENCIL_REF                    = 0x0B97,
	 STENCIL_VALUE_MASK             = 0x0B93,
	 STENCIL_WRITEMASK              = 0x0B98,
	 STENCIL_BACK_FUNC              = 0x8800,
	 STENCIL_BACK_FAIL              = 0x8801,
	 STENCIL_BACK_PASS_DEPTH_FAIL   = 0x8802,
	 STENCIL_BACK_PASS_DEPTH_PASS   = 0x8803,
	 STENCIL_BACK_REF               = 0x8CA3,
	 STENCIL_BACK_VALUE_MASK        = 0x8CA4,
	 STENCIL_BACK_WRITEMASK         = 0x8CA5,
	 VIEWPORT                       = 0x0BA2,
	 SCISSOR_BOX                    = 0x0C10,
	 COLOR_CLEAR_VALUE              = 0x0C22,
	 COLOR_WRITEMASK                = 0x0C23,
	 UNPACK_ALIGNMENT               = 0x0CF5,
	 PACK_ALIGNMENT                 = 0x0D05,
	 MAX_TEXTURE_SIZE               = 0x0D33,
	 MAX_VIEWPORT_DIMS              = 0x0D3A,
	 SUBPIXEL_BITS                  = 0x0D50,
	 RED_BITS                       = 0x0D52,
	 GREEN_BITS                     = 0x0D53,
	 BLUE_BITS                      = 0x0D54,
	 ALPHA_BITS                     = 0x0D55,
	 DEPTH_BITS                     = 0x0D56,
	 STENCIL_BITS                   = 0x0D57,
	 POLYGON_OFFSET_UNITS           = 0x2A00,
	 POLYGON_OFFSET_FACTOR          = 0x8038,
	 TEXTURE_BINDING_2D             = 0x8069,
	 SAMPLE_BUFFERS                 = 0x80A8,
	 SAMPLES                        = 0x80A9,
	 SAMPLE_COVERAGE_VALUE          = 0x80AA,
	 SAMPLE_COVERAGE_INVERT         = 0x80AB,
	 
	 NUM_COMPRESSED_TEXTURE_FORMATS = 0x86A2,
	 COMPRESSED_TEXTURE_FORMATS     = 0x86A3,
	 
	 DONT_CARE                      = 0x1100,
	 FASTEST                        = 0x1101,
	 NICEST                         = 0x1102,
	 
	 GENERATE_MIPMAP_HINT            = 0x8192,
	 
	 BYTE                           = 0x1400,
	 UNSIGNED_BYTE                  = 0x1401,
	 SHORT                          = 0x1402,
	 UNSIGNED_SHORT                 = 0x1403,
	 INT                            = 0x1404,
	 UNSIGNED_INT                   = 0x1405,
	 FLOAT                          = 0x1406,
	 FIXED                          = 0x140C,

	 DEPTH_COMPONENT                = 0x1902,
	 ALPHA                          = 0x1906,
	 RGB                            = 0x1907,
	 RGBA                           = 0x1908,
	 LUMINANCE                      = 0x1909,
	 LUMINANCE_ALPHA                = 0x190A,
	 
	 UNSIGNED_SHORT_4_4_4_4         = 0x8033,
	 UNSIGNED_SHORT_5_5_5_1         = 0x8034,
	 UNSIGNED_SHORT_5_6_5           = 0x8363,
	 
	 FRAGMENT_SHADER                  = 0x8B30,
	 VERTEX_SHADER                    = 0x8B31,
	 MAX_VERTEX_ATTRIBS               = 0x8869,
	 MAX_VERTEX_UNIFORM_VECTORS       = 0x8DFB,
	 MAX_VARYING_VECTORS              = 0x8DFC,
	 MAX_COMBINED_TEXTURE_IMAGE_UNITS = 0x8B4D,
	 MAX_VERTEX_TEXTURE_IMAGE_UNITS   = 0x8B4C,
	 MAX_TEXTURE_IMAGE_UNITS          = 0x8872,
	 MAX_FRAGMENT_UNIFORM_VECTORS     = 0x8DFD,
	 SHADER_TYPE                      = 0x8B4F,
	 DELETE_STATUS                    = 0x8B80,
	 LINK_STATUS                      = 0x8B82,
	 VALIDATE_STATUS                  = 0x8B83,
	 ATTACHED_SHADERS                 = 0x8B85,
	 ACTIVE_UNIFORMS                  = 0x8B86,
	 ACTIVE_UNIFORM_MAX_LENGTH        = 0x8B87,
	 ACTIVE_ATTRIBUTES                = 0x8B89,
	 ACTIVE_ATTRIBUTE_MAX_LENGTH      = 0x8B8A,
	 SHADING_LANGUAGE_VERSION         = 0x8B8C,
	 CURRENT_PROGRAM                  = 0x8B8D, 
	 
	 NEVER                          = 0x0200,
	 LESS                           = 0x0201,
	 EQUAL                          = 0x0202,
	 LEQUAL                         = 0x0203,
	 GREATER                        = 0x0204,
	 NOTEQUAL                       = 0x0205,
	 GEQUAL                         = 0x0206,
	 ALWAYS                         = 0x0207,
	 
	 KEEP                           = 0x1E00,
	 REPLACE                        = 0x1E01,
	 INCR                           = 0x1E02,
	 DECR                           = 0x1E03,
	 INVERT                         = 0x150A,
	 INCR_WRAP                      = 0x8507,
	 DECR_WRAP                      = 0x8508,
	 
	 VENDOR                         = 0x1F00,
	 RENDERER                       = 0x1F01,
	 VERSION                        = 0x1F02,
	 EXTENSIONS                     = 0x1F03,
	 
	 NEAREST                        = 0x2600,
	 LINEAR                         = 0x2601,
	 
	 NEAREST_MIPMAP_NEAREST         = 0x2700,
	 LINEAR_MIPMAP_NEAREST          = 0x2701,
	 NEAREST_MIPMAP_LINEAR          = 0x2702,
	 LINEAR_MIPMAP_LINEAR           = 0x2703,
	 
	 TEXTURE_MAG_FILTER             = 0x2800,
	 TEXTURE_MIN_FILTER             = 0x2801,
	 TEXTURE_WRAP_S                 = 0x2802,
	 TEXTURE_WRAP_T                 = 0x2803,
	 
	 TEXTURE                        = 0x1702,
	 
	 TEXTURE_CUBE_MAP               = 0x8513,
	 TEXTURE_BINDING_CUBE_MAP       = 0x8514,
	 TEXTURE_CUBE_MAP_POSITIVE_X    = 0x8515,
	 TEXTURE_CUBE_MAP_NEGATIVE_X    = 0x8516,
	 TEXTURE_CUBE_MAP_POSITIVE_Y    = 0x8517,
	 TEXTURE_CUBE_MAP_NEGATIVE_Y    = 0x8518,
	 TEXTURE_CUBE_MAP_POSITIVE_Z    = 0x8519,
	 TEXTURE_CUBE_MAP_NEGATIVE_Z    = 0x851A,
	 MAX_CUBE_MAP_TEXTURE_SIZE      = 0x851C,
	 
	 TEXTURE0                       = 0x84C0,
	 TEXTURE1                       = 0x84C1,
	 TEXTURE2                       = 0x84C2,
	 TEXTURE3                       = 0x84C3,
	 TEXTURE4                       = 0x84C4,
	 TEXTURE5                       = 0x84C5,
	 TEXTURE6                       = 0x84C6,
	 TEXTURE7                       = 0x84C7,
	 TEXTURE8                       = 0x84C8,
	 TEXTURE9                       = 0x84C9,
	 TEXTURE10                      = 0x84CA,
	 TEXTURE11                      = 0x84CB,
	 TEXTURE12                      = 0x84CC,
	 TEXTURE13                      = 0x84CD,
	 TEXTURE14                      = 0x84CE,
	 TEXTURE15                      = 0x84CF,
	 TEXTURE16                      = 0x84D0,
	 TEXTURE17                      = 0x84D1,
	 TEXTURE18                      = 0x84D2,
	 TEXTURE19                      = 0x84D3,
	 TEXTURE20                      = 0x84D4,
	 TEXTURE21                      = 0x84D5,
	 TEXTURE22                      = 0x84D6,
	 TEXTURE23                      = 0x84D7,
	 TEXTURE24                      = 0x84D8,
	 TEXTURE25                      = 0x84D9,
	 TEXTURE26                      = 0x84DA,
	 TEXTURE27                      = 0x84DB,
	 TEXTURE28                      = 0x84DC,
	 TEXTURE29                      = 0x84DD,
	 TEXTURE30                      = 0x84DE,
	 TEXTURE31                      = 0x84DF,
	 ACTIVE_TEXTURE                 = 0x84E0,
	 
	 REPEAT                         = 0x2901,
	 CLAMP_TO_EDGE                  = 0x812F,
	 MIRRORED_REPEAT                = 0x8370,
	 
	 FLOAT_VEC2                     = 0x8B50,
	 FLOAT_VEC3                     = 0x8B51,
	 FLOAT_VEC4                     = 0x8B52,
	 INT_VEC2                       = 0x8B53,
	 INT_VEC3                       = 0x8B54,
	 INT_VEC4                       = 0x8B55,
	 BOOL                           = 0x8B56,
	 BOOL_VEC2                      = 0x8B57,
	 BOOL_VEC3                      = 0x8B58,
	 BOOL_VEC4                      = 0x8B59,
	 FLOAT_MAT2                     = 0x8B5A,
	 FLOAT_MAT3                     = 0x8B5B,
	 FLOAT_MAT4                     = 0x8B5C,
	 SAMPLER_2D                     = 0x8B5E,
	 SAMPLER_CUBE                   = 0x8B60,
	 
	 VERTEX_ATTRIB_ARRAY_ENABLED        = 0x8622,
	 VERTEX_ATTRIB_ARRAY_SIZE           = 0x8623,
	 VERTEX_ATTRIB_ARRAY_STRIDE         = 0x8624,
	 VERTEX_ATTRIB_ARRAY_TYPE           = 0x8625,
	 VERTEX_ATTRIB_ARRAY_NORMALIZED     = 0x886A,
	 VERTEX_ATTRIB_ARRAY_POINTER        = 0x8645,
	 VERTEX_ATTRIB_ARRAY_BUFFER_BINDING = 0x889F,
	 
	 IMPLEMENTATION_COLOR_READ_TYPE   = 0x8B9A,
	 IMPLEMENTATION_COLOR_READ_FORMAT = 0x8B9B,
	 
	 COMPILE_STATUS                 = 0x8B81,
	 INFO_LOG_LENGTH                = 0x8B84,
	 SHADER_SOURCE_LENGTH           = 0x8B88,
	 SHADER_COMPILER                = 0x8DFA,
	 
	 SHADER_BINARY_FORMATS          = 0x8DF8,
	 NUM_SHADER_BINARY_FORMATS      = 0x8DF9,
	 
	 LOW_FLOAT                      = 0x8DF0,
	 MEDIUM_FLOAT                   = 0x8DF1,
	 HIGH_FLOAT                     = 0x8DF2,
	 LOW_INT                        = 0x8DF3,
	 MEDIUM_INT                     = 0x8DF4,
	 HIGH_INT                       = 0x8DF5,
	 
	 FRAMEBUFFER                    = 0x8D40,
	 RENDERBUFFER                   = 0x8D41,
	 
	 RGBA4                          = 0x8056,
	 RGB5_A1                        = 0x8057,
	 RGB565                         = 0x8D62,
	 DEPTH_COMPONENT16              = 0x81A5,
	 STENCIL_INDEX                  = 0x1901,
	 STENCIL_INDEX8                 = 0x8D48,
	 
	 RENDERBUFFER_WIDTH             = 0x8D42,
	 RENDERBUFFER_HEIGHT            = 0x8D43,
	 RENDERBUFFER_INTERNAL_FORMAT   = 0x8D44,
	 RENDERBUFFER_RED_SIZE          = 0x8D50,
	 RENDERBUFFER_GREEN_SIZE        = 0x8D51,
	 RENDERBUFFER_BLUE_SIZE         = 0x8D52,
	 RENDERBUFFER_ALPHA_SIZE        = 0x8D53,
	 RENDERBUFFER_DEPTH_SIZE        = 0x8D54,
	 RENDERBUFFER_STENCIL_SIZE      = 0x8D55,
	 
	 FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE           = 0x8CD0,
	 FRAMEBUFFER_ATTACHMENT_OBJECT_NAME           = 0x8CD1,
	 FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL         = 0x8CD2,
	 FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE = 0x8CD3,
	 
	 COLOR_ATTACHMENT0              = 0x8CE0,
	 DEPTH_ATTACHMENT               = 0x8D00,
	 STENCIL_ATTACHMENT             = 0x8D20,
	 
	 NONE                           = 0,

	 FRAMEBUFFER_COMPLETE                      = 0x8CD5,
	 FRAMEBUFFER_INCOMPLETE_ATTACHMENT         = 0x8CD6,
	 FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT = 0x8CD7,
	 FRAMEBUFFER_INCOMPLETE_DIMENSIONS         = 0x8CD9,
	 FRAMEBUFFER_UNSUPPORTED                   = 0x8CDD,
	 
	 FRAMEBUFFER_BINDING            = 0x8CA6,
	 RENDERBUFFER_BINDING           = 0x8CA7,
	 MAX_RENDERBUFFER_SIZE          = 0x84E8,
	 
	 INVALID_FRAMEBUFFER_OPERATION  = 0x0506,
}

-- GLES2 typedefs & functions
FFI.cdef [[
typedef void             GLvoid;
typedef char             GLchar;
typedef unsigned int     GLenum;
typedef unsigned char    GLboolean;
typedef unsigned int     GLbitfield;
typedef int8_t           GLbyte;
typedef short            GLshort;
typedef int              GLint;
typedef int              GLsizei;
typedef uint8_t          GLubyte;
typedef unsigned short   GLushort;
typedef unsigned int     GLuint;
typedef float            GLfloat;
typedef float            GLclampf;
typedef int32_t          GLfixed;
typedef intptr_t         GLintptr;
typedef size_t           GLsizeiptr;

void         glActiveTexture (GLenum texture);
void         glAttachShader (GLuint program, GLuint shader);
void         glBindAttribLocation (GLuint program, GLuint index, const GLchar* name);
void         glBindBuffer (GLenum target, GLuint buffer);
void         glBindFramebuffer (GLenum target, GLuint framebuffer);
void         glBindRenderbuffer (GLenum target, GLuint renderbuffer);
void         glBindTexture (GLenum target, GLuint texture);
void         glBlendColor (GLclampf red, GLclampf green, GLclampf blue, GLclampf alpha);
void         glBlendEquation ( GLenum mode );
void         glBlendEquationSeparate (GLenum modeRGB, GLenum modeAlpha);
void         glBlendFunc (GLenum sfactor, GLenum dfactor);
void         glBlendFuncSeparate (GLenum srcRGB, GLenum dstRGB, GLenum srcAlpha, GLenum dstAlpha);
void         glBufferData (GLenum target, GLsizeiptr size, const GLvoid* data, GLenum usage);
void         glBufferSubData (GLenum target, GLintptr offset, GLsizeiptr size, const GLvoid* data);
GLenum       glCheckFramebufferStatus (GLenum target);
void         glClear (GLbitfield mask);
void         glClearColor (GLclampf red, GLclampf green, GLclampf blue, GLclampf alpha);
void         glClearDepthf (GLclampf depth);
void         glClearStencil (GLint s);
void         glColorMask (GLboolean red, GLboolean green, GLboolean blue, GLboolean alpha);
void         glCompileShader (GLuint shader);
void         glCompressedTexImage2D (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLint border, GLsizei imageSize, const GLvoid* data);
void         glCompressedTexSubImage2D (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLsizei imageSize, const GLvoid* data);
void         glCopyTexImage2D (GLenum target, GLint level, GLenum internalformat, GLint x, GLint y, GLsizei width, GLsizei height, GLint border);
void         glCopyTexSubImage2D (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint x, GLint y, GLsizei width, GLsizei height);
GLuint       glCreateProgram (void);
GLuint       glCreateShader (GLenum type);
void         glCullFace (GLenum mode);
void         glDeleteBuffers (GLsizei n, const GLuint* buffers);
void         glDeleteFramebuffers (GLsizei n, const GLuint* framebuffers);
void         glDeleteProgram (GLuint program);
void         glDeleteRenderbuffers (GLsizei n, const GLuint* renderbuffers);
void         glDeleteShader (GLuint shader);
void         glDeleteTextures (GLsizei n, const GLuint* textures);
void         glDepthFunc (GLenum func);
void         glDepthMask (GLboolean flag);
void         glDepthRangef (GLclampf zNear, GLclampf zFar);
void         glDetachShader (GLuint program, GLuint shader);
void         glDisable (GLenum cap);
void         glDisableVertexAttribArray (GLuint index);
void         glDrawArrays (GLenum mode, GLint first, GLsizei count);
void         glDrawElements (GLenum mode, GLsizei count, GLenum type, const GLvoid* indices);
void         glEnable (GLenum cap);
void         glEnableVertexAttribArray (GLuint index);
void         glFinish (void);
void         glFlush (void);
void         glFramebufferRenderbuffer (GLenum target, GLenum attachment, GLenum renderbuffertarget, GLuint renderbuffer);
void         glFramebufferTexture2D (GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level);
void         glFrontFace (GLenum mode);
void         glGenBuffers (GLsizei n, GLuint* buffers);
void         glGenerateMipmap (GLenum target);
void         glGenFramebuffers (GLsizei n, GLuint* framebuffers);
void         glGenRenderbuffers (GLsizei n, GLuint* renderbuffers);
void         glGenTextures (GLsizei n, GLuint* textures);
void         glGetActiveAttrib (GLuint program, GLuint index, GLsizei bufsize, GLsizei* length, GLint* size, GLenum* type, GLchar* name);
void         glGetActiveUniform (GLuint program, GLuint index, GLsizei bufsize, GLsizei* length, GLint* size, GLenum* type, GLchar* name);
void         glGetAttachedShaders (GLuint program, GLsizei maxcount, GLsizei* count, GLuint* shaders);
int          glGetAttribLocation (GLuint program, const GLchar* name);
void         glGetBooleanv (GLenum pname, GLboolean* params);
void         glGetBufferParameteriv (GLenum target, GLenum pname, GLint* params);
GLenum       glGetError (void);
void         glGetFloatv (GLenum pname, GLfloat* params);
void         glGetFramebufferAttachmentParameteriv (GLenum target, GLenum attachment, GLenum pname, GLint* params);
void         glGetIntegerv (GLenum pname, GLint* params);
void         glGetProgramiv (GLuint program, GLenum pname, GLint* params);
void         glGetProgramInfoLog (GLuint program, GLsizei bufsize, GLsizei* length, GLchar* infolog);
void         glGetRenderbufferParameteriv (GLenum target, GLenum pname, GLint* params);
void         glGetShaderiv (GLuint shader, GLenum pname, GLint* params);
void         glGetShaderInfoLog (GLuint shader, GLsizei bufsize, GLsizei* length, GLchar* infolog);
void         glGetShaderPrecisionFormat (GLenum shadertype, GLenum precisiontype, GLint* range, GLint* precision);
void         glGetShaderSource (GLuint shader, GLsizei bufsize, GLsizei* length, GLchar* source);
const GLubyte* glGetString (GLenum name);
void         glGetTexParameterfv (GLenum target, GLenum pname, GLfloat* params);
void         glGetTexParameteriv (GLenum target, GLenum pname, GLint* params);
void         glGetUniformfv (GLuint program, GLint location, GLfloat* params);
void         glGetUniformiv (GLuint program, GLint location, GLint* params);
int          glGetUniformLocation (GLuint program, const GLchar* name);
void         glGetVertexAttribfv (GLuint index, GLenum pname, GLfloat* params);
void         glGetVertexAttribiv (GLuint index, GLenum pname, GLint* params);
void         glGetVertexAttribPointerv (GLuint index, GLenum pname, GLvoid** pointer);
void         glHint (GLenum target, GLenum mode);
GLboolean    glIsBuffer (GLuint buffer);
GLboolean    glIsEnabled (GLenum cap);
GLboolean    glIsFramebuffer (GLuint framebuffer);
GLboolean    glIsProgram (GLuint program);
GLboolean    glIsRenderbuffer (GLuint renderbuffer);
GLboolean    glIsShader (GLuint shader);
GLboolean    glIsTexture (GLuint texture);
void         glLineWidth (GLfloat width);
void         glLinkProgram (GLuint program);
void         glPixelStorei (GLenum pname, GLint param);
void         glPolygonOffset (GLfloat factor, GLfloat units);
void         glReadPixels (GLint x, GLint y, GLsizei width, GLsizei height, GLenum format, GLenum type, GLvoid* pixels);
void         glReleaseShaderCompiler (void);
void         glRenderbufferStorage (GLenum target, GLenum internalformat, GLsizei width, GLsizei height);
void         glSampleCoverage (GLclampf value, GLboolean invert);
void         glScissor (GLint x, GLint y, GLsizei width, GLsizei height);
void         glShaderBinary (GLsizei n, const GLuint* shaders, GLenum binaryformat, const GLvoid* binary, GLsizei length);
void         glShaderSource (GLuint shader, GLsizei count, const GLchar** string, const GLint* length);
void         glStencilFunc (GLenum func, GLint ref, GLuint mask);
void         glStencilFuncSeparate (GLenum face, GLenum func, GLint ref, GLuint mask);
void         glStencilMask (GLuint mask);
void         glStencilMaskSeparate (GLenum face, GLuint mask);
void         glStencilOp (GLenum fail, GLenum zfail, GLenum zpass);
void         glStencilOpSeparate (GLenum face, GLenum fail, GLenum zfail, GLenum zpass);
void         glTexImage2D (GLenum target, GLint level, GLint internalformat, GLsizei width, GLsizei height, GLint border, GLenum format, GLenum type, const GLvoid* pixels);
void         glTexParameterf (GLenum target, GLenum pname, GLfloat param);
void         glTexParameterfv (GLenum target, GLenum pname, const GLfloat* params);
void         glTexParameteri (GLenum target, GLenum pname, GLint param);
void         glTexParameteriv (GLenum target, GLenum pname, const GLint* params);
void         glTexSubImage2D (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLenum type, const GLvoid* pixels);
void         glUniform1f (GLint location, GLfloat x);
void         glUniform1fv (GLint location, GLsizei count, const GLfloat* v);
void         glUniform1i (GLint location, GLint x);
void         glUniform1iv (GLint location, GLsizei count, const GLint* v);
void         glUniform2f (GLint location, GLfloat x, GLfloat y);
void         glUniform2fv (GLint location, GLsizei count, const GLfloat* v);
void         glUniform2i (GLint location, GLint x, GLint y);
void         glUniform2iv (GLint location, GLsizei count, const GLint* v);
void         glUniform3f (GLint location, GLfloat x, GLfloat y, GLfloat z);
void         glUniform3fv (GLint location, GLsizei count, const GLfloat* v);
void         glUniform3i (GLint location, GLint x, GLint y, GLint z);
void         glUniform3iv (GLint location, GLsizei count, const GLint* v);
void         glUniform4f (GLint location, GLfloat x, GLfloat y, GLfloat z, GLfloat w);
void         glUniform4fv (GLint location, GLsizei count, const GLfloat* v);
void         glUniform4i (GLint location, GLint x, GLint y, GLint z, GLint w);
void         glUniform4iv (GLint location, GLsizei count, const GLint* v);
void         glUniformMatrix2fv (GLint location, GLsizei count, GLboolean transpose, const GLfloat* value);
void         glUniformMatrix3fv (GLint location, GLsizei count, GLboolean transpose, const GLfloat* value);
void         glUniformMatrix4fv (GLint location, GLsizei count, GLboolean transpose, const GLfloat* value);
void         glUseProgram (GLuint program);
void         glValidateProgram (GLuint program);
void         glVertexAttrib1f (GLuint indx, GLfloat x);
void         glVertexAttrib1fv (GLuint indx, const GLfloat* values);
void         glVertexAttrib2f (GLuint indx, GLfloat x, GLfloat y);
void         glVertexAttrib2fv (GLuint indx, const GLfloat* values);
void         glVertexAttrib3f (GLuint indx, GLfloat x, GLfloat y, GLfloat z);
void         glVertexAttrib3fv (GLuint indx, const GLfloat* values);
void         glVertexAttrib4f (GLuint indx, GLfloat x, GLfloat y, GLfloat z, GLfloat w);
void         glVertexAttrib4fv (GLuint indx, const GLfloat* values);
void         glVertexAttribPointer (GLuint indx, GLint size, GLenum type, GLboolean normalized, GLsizei stride, const GLvoid* ptr);
void         glViewport (GLint x, GLint y, GLsizei width, GLsizei height);
]]

-- on Windows, not all functions are directly available, see 'index'
-- the probably is != to the GLES2 spec

if FFI.os == "Windows" then
	FFI.cdef [[
void * wglGetProcAddress (char const *);
typedef void (* PFNGLBLENDCOLORPROC) (GLfloat red, GLfloat green, GLfloat blue, GLfloat alpha);
typedef void (* PFNGLBLENDEQUATIONPROC) (GLenum mode);
typedef void (* PFNGLDRAWRANGEELEMENTSPROC) (GLenum mode, GLuint start, GLuint end, GLsizei count, GLenum type, const GLvoid *indices);
typedef void (* PFNGLTEXIMAGE3DPROC) (GLenum target, GLint level, GLint internalformat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLenum format, GLenum type, const GLvoid *pixels);
typedef void (* PFNGLTEXSUBIMAGE3DPROC) (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLenum type, const GLvoid *pixels);
typedef void (* PFNGLCOPYTEXSUBIMAGE3DPROC) (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLint x, GLint y, GLsizei width, GLsizei height);
typedef void (* PFNGLCOLORTABLEPROC) (GLenum target, GLenum internalformat, GLsizei width, GLenum format, GLenum type, const GLvoid *table);
typedef void (* PFNGLCOLORTABLEPARAMETERFVPROC) (GLenum target, GLenum pname, const GLfloat *params);
typedef void (* PFNGLCOLORTABLEPARAMETERIVPROC) (GLenum target, GLenum pname, const GLint *params);
typedef void (* PFNGLCOPYCOLORTABLEPROC) (GLenum target, GLenum internalformat, GLint x, GLint y, GLsizei width);
typedef void (* PFNGLGETCOLORTABLEPROC) (GLenum target, GLenum format, GLenum type, GLvoid *table);
typedef void (* PFNGLGETCOLORTABLEPARAMETERFVPROC) (GLenum target, GLenum pname, GLfloat *params);
typedef void (* PFNGLGETCOLORTABLEPARAMETERIVPROC) (GLenum target, GLenum pname, GLint *params);
typedef void (* PFNGLCOLORSUBTABLEPROC) (GLenum target, GLsizei start, GLsizei count, GLenum format, GLenum type, const GLvoid *data);
typedef void (* PFNGLCOPYCOLORSUBTABLEPROC) (GLenum target, GLsizei start, GLint x, GLint y, GLsizei width);
typedef void (* PFNGLCONVOLUTIONFILTER1DPROC) (GLenum target, GLenum internalformat, GLsizei width, GLenum format, GLenum type, const GLvoid *image);
typedef void (* PFNGLCONVOLUTIONFILTER2DPROC) (GLenum target, GLenum internalformat, GLsizei width, GLsizei height, GLenum format, GLenum type, const GLvoid *image);
typedef void (* PFNGLCONVOLUTIONPARAMETERFPROC) (GLenum target, GLenum pname, GLfloat params);
typedef void (* PFNGLCONVOLUTIONPARAMETERFVPROC) (GLenum target, GLenum pname, const GLfloat *params);
typedef void (* PFNGLCONVOLUTIONPARAMETERIPROC) (GLenum target, GLenum pname, GLint params);
typedef void (* PFNGLCONVOLUTIONPARAMETERIVPROC) (GLenum target, GLenum pname, const GLint *params);
typedef void (* PFNGLCOPYCONVOLUTIONFILTER1DPROC) (GLenum target, GLenum internalformat, GLint x, GLint y, GLsizei width);
typedef void (* PFNGLCOPYCONVOLUTIONFILTER2DPROC) (GLenum target, GLenum internalformat, GLint x, GLint y, GLsizei width, GLsizei height);
typedef void (* PFNGLGETCONVOLUTIONFILTERPROC) (GLenum target, GLenum format, GLenum type, GLvoid *image);
typedef void (* PFNGLGETCONVOLUTIONPARAMETERFVPROC) (GLenum target, GLenum pname, GLfloat *params);
typedef void (* PFNGLGETCONVOLUTIONPARAMETERIVPROC) (GLenum target, GLenum pname, GLint *params);
typedef void (* PFNGLGETSEPARABLEFILTERPROC) (GLenum target, GLenum format, GLenum type, GLvoid *row, GLvoid *column, GLvoid *span);
typedef void (* PFNGLSEPARABLEFILTER2DPROC) (GLenum target, GLenum internalformat, GLsizei width, GLsizei height, GLenum format, GLenum type, const GLvoid *row, const GLvoid *column);
typedef void (* PFNGLGETHISTOGRAMPROC) (GLenum target, GLboolean reset, GLenum format, GLenum type, GLvoid *values);
typedef void (* PFNGLGETHISTOGRAMPARAMETERFVPROC) (GLenum target, GLenum pname, GLfloat *params);
typedef void (* PFNGLGETHISTOGRAMPARAMETERIVPROC) (GLenum target, GLenum pname, GLint *params);
typedef void (* PFNGLGETMINMAXPROC) (GLenum target, GLboolean reset, GLenum format, GLenum type, GLvoid *values);
typedef void (* PFNGLGETMINMAXPARAMETERFVPROC) (GLenum target, GLenum pname, GLfloat *params);
typedef void (* PFNGLGETMINMAXPARAMETERIVPROC) (GLenum target, GLenum pname, GLint *params);
typedef void (* PFNGLHISTOGRAMPROC) (GLenum target, GLsizei width, GLenum internalformat, GLboolean sink);
typedef void (* PFNGLMINMAXPROC) (GLenum target, GLenum internalformat, GLboolean sink);
typedef void (* PFNGLRESETHISTOGRAMPROC) (GLenum target);
typedef void (* PFNGLRESETMINMAXPROC) (GLenum target);
typedef void (* PFNGLACTIVETEXTUREPROC) (GLenum texture);
typedef void (* PFNGLSAMPLECOVERAGEPROC) (GLfloat value, GLboolean invert);
typedef void (* PFNGLCOMPRESSEDTEXIMAGE3DPROC) (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLsizei imageSize, const GLvoid *data);
typedef void (* PFNGLCOMPRESSEDTEXIMAGE2DPROC) (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLint border, GLsizei imageSize, const GLvoid *data);
typedef void (* PFNGLCOMPRESSEDTEXIMAGE1DPROC) (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLint border, GLsizei imageSize, const GLvoid *data);
typedef void (* PFNGLCOMPRESSEDTEXSUBIMAGE3DPROC) (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLsizei imageSize, const GLvoid *data);
typedef void (* PFNGLCOMPRESSEDTEXSUBIMAGE2DPROC) (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLsizei imageSize, const GLvoid *data);
typedef void (* PFNGLCOMPRESSEDTEXSUBIMAGE1DPROC) (GLenum target, GLint level, GLint xoffset, GLsizei width, GLenum format, GLsizei imageSize, const GLvoid *data);
typedef void (* PFNGLGETCOMPRESSEDTEXIMAGEPROC) (GLenum target, GLint level, GLvoid *img);
typedef void (* PFNGLCLIENTACTIVETEXTUREPROC) (GLenum texture);
typedef void (* PFNGLMULTITEXCOORD1FPROC) (GLenum target, GLfloat s);
typedef void (* PFNGLMULTITEXCOORD1FVPROC) (GLenum target, const GLfloat *v);
typedef void (* PFNGLMULTITEXCOORD1IPROC) (GLenum target, GLint s);
typedef void (* PFNGLMULTITEXCOORD1IVPROC) (GLenum target, const GLint *v);
typedef void (* PFNGLMULTITEXCOORD1SPROC) (GLenum target, GLshort s);
typedef void (* PFNGLMULTITEXCOORD1SVPROC) (GLenum target, const GLshort *v);
typedef void (* PFNGLMULTITEXCOORD2FPROC) (GLenum target, GLfloat s, GLfloat t);
typedef void (* PFNGLMULTITEXCOORD2FVPROC) (GLenum target, const GLfloat *v);
typedef void (* PFNGLMULTITEXCOORD2IPROC) (GLenum target, GLint s, GLint t);
typedef void (* PFNGLMULTITEXCOORD2IVPROC) (GLenum target, const GLint *v);
typedef void (* PFNGLMULTITEXCOORD2SPROC) (GLenum target, GLshort s, GLshort t);
typedef void (* PFNGLMULTITEXCOORD2SVPROC) (GLenum target, const GLshort *v);
typedef void (* PFNGLMULTITEXCOORD3FPROC) (GLenum target, GLfloat s, GLfloat t, GLfloat r);
typedef void (* PFNGLMULTITEXCOORD3FVPROC) (GLenum target, const GLfloat *v);
typedef void (* PFNGLMULTITEXCOORD3IPROC) (GLenum target, GLint s, GLint t, GLint r);
typedef void (* PFNGLMULTITEXCOORD3IVPROC) (GLenum target, const GLint *v);
typedef void (* PFNGLMULTITEXCOORD3SPROC) (GLenum target, GLshort s, GLshort t, GLshort r);
typedef void (* PFNGLMULTITEXCOORD3SVPROC) (GLenum target, const GLshort *v);
typedef void (* PFNGLMULTITEXCOORD4FPROC) (GLenum target, GLfloat s, GLfloat t, GLfloat r, GLfloat q);
typedef void (* PFNGLMULTITEXCOORD4FVPROC) (GLenum target, const GLfloat *v);
typedef void (* PFNGLMULTITEXCOORD4IPROC) (GLenum target, GLint s, GLint t, GLint r, GLint q);
typedef void (* PFNGLMULTITEXCOORD4IVPROC) (GLenum target, const GLint *v);
typedef void (* PFNGLMULTITEXCOORD4SPROC) (GLenum target, GLshort s, GLshort t, GLshort r, GLshort q);
typedef void (* PFNGLMULTITEXCOORD4SVPROC) (GLenum target, const GLshort *v);
typedef void (* PFNGLLOADTRANSPOSEMATRIXFPROC) (const GLfloat *m);
typedef void (* PFNGLMULTTRANSPOSEMATRIXFPROC) (const GLfloat *m);
typedef void (* PFNGLBLENDFUNCSEPARATEPROC) (GLenum sfactorRGB, GLenum dfactorRGB, GLenum sfactorAlpha, GLenum dfactorAlpha);
typedef void (* PFNGLMULTIDRAWARRAYSPROC) (GLenum mode, const GLint *first, const GLsizei *count, GLsizei drawcount);
typedef void (* PFNGLMULTIDRAWELEMENTSPROC) (GLenum mode, const GLsizei *count, GLenum type, const GLvoid* const *indices, GLsizei drawcount);
typedef void (* PFNGLPOINTPARAMETERFPROC) (GLenum pname, GLfloat param);
typedef void (* PFNGLPOINTPARAMETERFVPROC) (GLenum pname, const GLfloat *params);
typedef void (* PFNGLPOINTPARAMETERIPROC) (GLenum pname, GLint param);
typedef void (* PFNGLPOINTPARAMETERIVPROC) (GLenum pname, const GLint *params);
typedef void (* PFNGLFOGCOORDFPROC) (GLfloat coord);
typedef void (* PFNGLFOGCOORDFVPROC) (const GLfloat *coord);
typedef void (* PFNGLFOGCOORDPOINTERPROC) (GLenum type, GLsizei stride, const GLvoid *pointer);
typedef void (* PFNGLSECONDARYCOLOR3BPROC) (GLbyte red, GLbyte green, GLbyte blue);
typedef void (* PFNGLSECONDARYCOLOR3BVPROC) (const GLbyte *v);
typedef void (* PFNGLSECONDARYCOLOR3FPROC) (GLfloat red, GLfloat green, GLfloat blue);
typedef void (* PFNGLSECONDARYCOLOR3FVPROC) (const GLfloat *v);
typedef void (* PFNGLSECONDARYCOLOR3IPROC) (GLint red, GLint green, GLint blue);
typedef void (* PFNGLSECONDARYCOLOR3IVPROC) (const GLint *v);
typedef void (* PFNGLSECONDARYCOLOR3SPROC) (GLshort red, GLshort green, GLshort blue);
typedef void (* PFNGLSECONDARYCOLOR3SVPROC) (const GLshort *v);
typedef void (* PFNGLSECONDARYCOLOR3UBPROC) (GLubyte red, GLubyte green, GLubyte blue);
typedef void (* PFNGLSECONDARYCOLOR3UBVPROC) (const GLubyte *v);
typedef void (* PFNGLSECONDARYCOLOR3UIPROC) (GLuint red, GLuint green, GLuint blue);
typedef void (* PFNGLSECONDARYCOLOR3UIVPROC) (const GLuint *v);
typedef void (* PFNGLSECONDARYCOLOR3USPROC) (GLushort red, GLushort green, GLushort blue);
typedef void (* PFNGLSECONDARYCOLOR3USVPROC) (const GLushort *v);
typedef void (* PFNGLSECONDARYCOLORPOINTERPROC) (GLint size, GLenum type, GLsizei stride, const GLvoid *pointer);
typedef void (* PFNGLWINDOWPOS2FPROC) (GLfloat x, GLfloat y);
typedef void (* PFNGLWINDOWPOS2FVPROC) (const GLfloat *v);
typedef void (* PFNGLWINDOWPOS2IPROC) (GLint x, GLint y);
typedef void (* PFNGLWINDOWPOS2IVPROC) (const GLint *v);
typedef void (* PFNGLWINDOWPOS2SPROC) (GLshort x, GLshort y);
typedef void (* PFNGLWINDOWPOS2SVPROC) (const GLshort *v);
typedef void (* PFNGLWINDOWPOS3FPROC) (GLfloat x, GLfloat y, GLfloat z);
typedef void (* PFNGLWINDOWPOS3FVPROC) (const GLfloat *v);
typedef void (* PFNGLWINDOWPOS3IPROC) (GLint x, GLint y, GLint z);
typedef void (* PFNGLWINDOWPOS3IVPROC) (const GLint *v);
typedef void (* PFNGLWINDOWPOS3SPROC) (GLshort x, GLshort y, GLshort z);
typedef void (* PFNGLWINDOWPOS3SVPROC) (const GLshort *v);
typedef void (* PFNGLGENQUERIESPROC) (GLsizei n, GLuint *ids);
typedef void (* PFNGLDELETEQUERIESPROC) (GLsizei n, const GLuint *ids);
typedef GLboolean (* PFNGLISQUERYPROC) (GLuint id);
typedef void (* PFNGLBEGINQUERYPROC) (GLenum target, GLuint id);
typedef void (* PFNGLENDQUERYPROC) (GLenum target);
typedef void (* PFNGLGETQUERYIVPROC) (GLenum target, GLenum pname, GLint *params);
typedef void (* PFNGLGETQUERYOBJECTIVPROC) (GLuint id, GLenum pname, GLint *params);
typedef void (* PFNGLGETQUERYOBJECTUIVPROC) (GLuint id, GLenum pname, GLuint *params);
typedef void (* PFNGLBINDBUFFERPROC) (GLenum target, GLuint buffer);
typedef void (* PFNGLDELETEBUFFERSPROC) (GLsizei n, const GLuint *buffers);
typedef void (* PFNGLGENBUFFERSPROC) (GLsizei n, GLuint *buffers);
typedef GLboolean (* PFNGLISBUFFERPROC) (GLuint buffer);
typedef void (* PFNGLBUFFERDATAPROC) (GLenum target, GLsizeiptr size, const GLvoid *data, GLenum usage);
typedef void (* PFNGLBUFFERSUBDATAPROC) (GLenum target, GLintptr offset, GLsizeiptr size, const GLvoid *data);
typedef void (* PFNGLGETBUFFERSUBDATAPROC) (GLenum target, GLintptr offset, GLsizeiptr size, GLvoid *data);
typedef GLvoid* (* PFNGLMAPBUFFERPROC) (GLenum target, GLenum access);
typedef GLboolean (* PFNGLUNMAPBUFFERPROC) (GLenum target);
typedef void (* PFNGLGETBUFFERPARAMETERIVPROC) (GLenum target, GLenum pname, GLint *params);
typedef void (* PFNGLGETBUFFERPOINTERVPROC) (GLenum target, GLenum pname, GLvoid* *params);
typedef void (* PFNGLBLENDEQUATIONSEPARATEPROC) (GLenum modeRGB, GLenum modeAlpha);
typedef void (* PFNGLDRAWBUFFERSPROC) (GLsizei n, const GLenum *bufs);
typedef void (* PFNGLSTENCILOPSEPARATEPROC) (GLenum face, GLenum sfail, GLenum dpfail, GLenum dppass);
typedef void (* PFNGLSTENCILFUNCSEPARATEPROC) (GLenum face, GLenum func, GLint ref, GLuint mask);
typedef void (* PFNGLSTENCILMASKSEPARATEPROC) (GLenum face, GLuint mask);
typedef void (* PFNGLATTACHSHADERPROC) (GLuint program, GLuint shader);
typedef void (* PFNGLBINDATTRIBLOCATIONPROC) (GLuint program, GLuint index, const GLchar *name);
typedef void (* PFNGLCOMPILESHADERPROC) (GLuint shader);
typedef GLuint (* PFNGLCREATEPROGRAMPROC) (void);
typedef GLuint (* PFNGLCREATESHADERPROC) (GLenum type);
typedef void (* PFNGLDELETEPROGRAMPROC) (GLuint program);
typedef void (* PFNGLDELETESHADERPROC) (GLuint shader);
typedef void (* PFNGLDETACHSHADERPROC) (GLuint program, GLuint shader);
typedef void (* PFNGLDISABLEVERTEXATTRIBARRAYPROC) (GLuint index);
typedef void (* PFNGLENABLEVERTEXATTRIBARRAYPROC) (GLuint index);
typedef void (* PFNGLGETACTIVEATTRIBPROC) (GLuint program, GLuint index, GLsizei bufSize, GLsizei *length, GLint *size, GLenum *type, GLchar *name);
typedef void (* PFNGLGETACTIVEUNIFORMPROC) (GLuint program, GLuint index, GLsizei bufSize, GLsizei *length, GLint *size, GLenum *type, GLchar *name);
typedef void (* PFNGLGETATTACHEDSHADERSPROC) (GLuint program, GLsizei maxCount, GLsizei *count, GLuint *obj);
typedef GLint (* PFNGLGETATTRIBLOCATIONPROC) (GLuint program, const GLchar *name);
typedef void (* PFNGLGETPROGRAMIVPROC) (GLuint program, GLenum pname, GLint *params);
typedef void (* PFNGLGETPROGRAMINFOLOGPROC) (GLuint program, GLsizei bufSize, GLsizei *length, GLchar *infoLog);
typedef void (* PFNGLGETSHADERIVPROC) (GLuint shader, GLenum pname, GLint *params);
typedef void (* PFNGLGETSHADERINFOLOGPROC) (GLuint shader, GLsizei bufSize, GLsizei *length, GLchar *infoLog);
typedef void (* PFNGLGETSHADERSOURCEPROC) (GLuint shader, GLsizei bufSize, GLsizei *length, GLchar *source);
typedef GLint (* PFNGLGETUNIFORMLOCATIONPROC) (GLuint program, const GLchar *name);
typedef void (* PFNGLGETUNIFORMFVPROC) (GLuint program, GLint location, GLfloat *params);
typedef void (* PFNGLGETUNIFORMIVPROC) (GLuint program, GLint location, GLint *params);
typedef void (* PFNGLGETVERTEXATTRIBFVPROC) (GLuint index, GLenum pname, GLfloat *params);
typedef void (* PFNGLGETVERTEXATTRIBIVPROC) (GLuint index, GLenum pname, GLint *params);
typedef void (* PFNGLGETVERTEXATTRIBPOINTERVPROC) (GLuint index, GLenum pname, GLvoid* *pointer);
typedef GLboolean (* PFNGLISPROGRAMPROC) (GLuint program);
typedef GLboolean (* PFNGLISSHADERPROC) (GLuint shader);
typedef void (* PFNGLLINKPROGRAMPROC) (GLuint program);
typedef void (* PFNGLSHADERSOURCEPROC) (GLuint shader, GLsizei count, const GLchar* const *string, const GLint *length);
typedef void (* PFNGLUSEPROGRAMPROC) (GLuint program);
typedef void (* PFNGLUNIFORM1FPROC) (GLint location, GLfloat v0);
typedef void (* PFNGLUNIFORM2FPROC) (GLint location, GLfloat v0, GLfloat v1);
typedef void (* PFNGLUNIFORM3FPROC) (GLint location, GLfloat v0, GLfloat v1, GLfloat v2);
typedef void (* PFNGLUNIFORM4FPROC) (GLint location, GLfloat v0, GLfloat v1, GLfloat v2, GLfloat v3);
typedef void (* PFNGLUNIFORM1IPROC) (GLint location, GLint v0);
typedef void (* PFNGLUNIFORM2IPROC) (GLint location, GLint v0, GLint v1);
typedef void (* PFNGLUNIFORM3IPROC) (GLint location, GLint v0, GLint v1, GLint v2);
typedef void (* PFNGLUNIFORM4IPROC) (GLint location, GLint v0, GLint v1, GLint v2, GLint v3);
typedef void (* PFNGLUNIFORM1FVPROC) (GLint location, GLsizei count, const GLfloat *value);
typedef void (* PFNGLUNIFORM2FVPROC) (GLint location, GLsizei count, const GLfloat *value);
typedef void (* PFNGLUNIFORM3FVPROC) (GLint location, GLsizei count, const GLfloat *value);
typedef void (* PFNGLUNIFORM4FVPROC) (GLint location, GLsizei count, const GLfloat *value);
typedef void (* PFNGLUNIFORM1IVPROC) (GLint location, GLsizei count, const GLint *value);
typedef void (* PFNGLUNIFORM2IVPROC) (GLint location, GLsizei count, const GLint *value);
typedef void (* PFNGLUNIFORM3IVPROC) (GLint location, GLsizei count, const GLint *value);
typedef void (* PFNGLUNIFORM4IVPROC) (GLint location, GLsizei count, const GLint *value);
typedef void (* PFNGLUNIFORMMATRIX2FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void (* PFNGLUNIFORMMATRIX3FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void (* PFNGLUNIFORMMATRIX4FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void (* PFNGLVALIDATEPROGRAMPROC) (GLuint program);
typedef void (* PFNGLVERTEXATTRIB1FPROC) (GLuint index, GLfloat x);
typedef void (* PFNGLVERTEXATTRIB1FVPROC) (GLuint index, const GLfloat *v);
typedef void (* PFNGLVERTEXATTRIB1SPROC) (GLuint index, GLshort x);
typedef void (* PFNGLVERTEXATTRIB1SVPROC) (GLuint index, const GLshort *v);
typedef void (* PFNGLVERTEXATTRIB2FPROC) (GLuint index, GLfloat x, GLfloat y);
typedef void (* PFNGLVERTEXATTRIB2FVPROC) (GLuint index, const GLfloat *v);
typedef void (* PFNGLVERTEXATTRIB2SPROC) (GLuint index, GLshort x, GLshort y);
typedef void (* PFNGLVERTEXATTRIB2SVPROC) (GLuint index, const GLshort *v);
typedef void (* PFNGLVERTEXATTRIB3FPROC) (GLuint index, GLfloat x, GLfloat y, GLfloat z);
typedef void (* PFNGLVERTEXATTRIB3FVPROC) (GLuint index, const GLfloat *v);
typedef void (* PFNGLVERTEXATTRIB3SPROC) (GLuint index, GLshort x, GLshort y, GLshort z);
typedef void (* PFNGLVERTEXATTRIB3SVPROC) (GLuint index, const GLshort *v);
typedef void (* PFNGLVERTEXATTRIB4NBVPROC) (GLuint index, const GLbyte *v);
typedef void (* PFNGLVERTEXATTRIB4NIVPROC) (GLuint index, const GLint *v);
typedef void (* PFNGLVERTEXATTRIB4NSVPROC) (GLuint index, const GLshort *v);
typedef void (* PFNGLVERTEXATTRIB4NUBPROC) (GLuint index, GLubyte x, GLubyte y, GLubyte z, GLubyte w);
typedef void (* PFNGLVERTEXATTRIB4NUBVPROC) (GLuint index, const GLubyte *v);
typedef void (* PFNGLVERTEXATTRIB4NUIVPROC) (GLuint index, const GLuint *v);
typedef void (* PFNGLVERTEXATTRIB4NUSVPROC) (GLuint index, const GLushort *v);
typedef void (* PFNGLVERTEXATTRIB4BVPROC) (GLuint index, const GLbyte *v);
typedef void (* PFNGLVERTEXATTRIB4FPROC) (GLuint index, GLfloat x, GLfloat y, GLfloat z, GLfloat w);
typedef void (* PFNGLVERTEXATTRIB4FVPROC) (GLuint index, const GLfloat *v);
typedef void (* PFNGLVERTEXATTRIB4IVPROC) (GLuint index, const GLint *v);
typedef void (* PFNGLVERTEXATTRIB4SPROC) (GLuint index, GLshort x, GLshort y, GLshort z, GLshort w);
typedef void (* PFNGLVERTEXATTRIB4SVPROC) (GLuint index, const GLshort *v);
typedef void (* PFNGLVERTEXATTRIB4UBVPROC) (GLuint index, const GLubyte *v);
typedef void (* PFNGLVERTEXATTRIB4UIVPROC) (GLuint index, const GLuint *v);
typedef void (* PFNGLVERTEXATTRIB4USVPROC) (GLuint index, const GLushort *v);
typedef void (* PFNGLVERTEXATTRIBPOINTERPROC) (GLuint index, GLint size, GLenum type, GLboolean normalized, GLsizei stride, const GLvoid *pointer);
typedef void (* PFNGLUNIFORMMATRIX2X3FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void (* PFNGLUNIFORMMATRIX3X2FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void (* PFNGLUNIFORMMATRIX2X4FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void (* PFNGLUNIFORMMATRIX4X2FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void (* PFNGLUNIFORMMATRIX3X4FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void (* PFNGLUNIFORMMATRIX4X3FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
/* VAO */
typedef void (* PFNGLBINDVERTEXARRAYPROC) (GLuint array);
typedef void (* PFNGLDELETEVERTEXARRAYSPROC) (GLsizei n, const GLuint *arrays);
typedef void (* PFNGLGENVERTEXARRAYSPROC) (GLsizei n, GLuint *arrays);
typedef GLboolean (* PFNGLISVERTEXARRAYPROC) (GLuint array);
]]
end

return setmetatable (cache, {__index = index})
