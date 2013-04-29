local table = {
-- GL_VERSION_1_1
-- AttribMask
DEPTH_BUFFER_BIT =                        0x00000100,
STENCIL_BUFFER_BIT =                      0x00000400,
COLOR_BUFFER_BIT =                        0x00004000,
-- Boolean
FALSE =                                   0,
TRUE =                                    1,
-- BeginMode
POINTS =                                  0x0000,
LINES =                                   0x0001,
LINE_LOOP =                               0x0002,
LINE_STRIP =                              0x0003,
TRIANGLES =                               0x0004,
TRIANGLE_STRIP =                          0x0005,
TRIANGLE_FAN =                            0x0006,
QUADS =                                   0x0007,
-- AlphaFunction
NEVER =                                   0x0200,
LESS =                                    0x0201,
EQUAL =                                   0x0202,
LEQUAL =                                  0x0203,
GREATER =                                 0x0204,
NOTEQUAL =                                0x0205,
GEQUAL =                                  0x0206,
ALWAYS =                                  0x0207,
-- BlendingFactorDest
ZERO =                                    0,
ONE =                                     1,
SRC_COLOR =                               0x0300,
ONE_MINUS_SRC_COLOR =                     0x0301,
SRC_ALPHA =                               0x0302,
ONE_MINUS_SRC_ALPHA =                     0x0303,
DST_ALPHA =                               0x0304,
ONE_MINUS_DST_ALPHA =                     0x0305,
-- BlendingFactorSrc
DST_COLOR =                               0x0306,
ONE_MINUS_DST_COLOR =                     0x0307,
SRC_ALPHA_SATURATE =                      0x0308,
-- DrawBufferMode
NONE =                                    0,
FRONT_LEFT =                              0x0400,
FRONT_RIGHT =                             0x0401,
BACK_LEFT =                               0x0402,
BACK_RIGHT =                              0x0403,
FRONT =                                   0x0404,
BACK =                                    0x0405,
LEFT =                                    0x0406,
RIGHT =                                   0x0407,
FRONT_AND_BACK =                          0x0408,
-- ErrorCode
NO_ERROR =                                0,
INVALID_ENUM =                            0x0500,
INVALID_VALUE =                           0x0501,
INVALID_OPERATION =                       0x0502,
OUT_OF_MEMORY =                           0x0505,
-- FrontFaceDirection
CW =                                      0x0900,
CCW =                                     0x0901,
-- GetPName
POINT_SIZE =                              0x0B11,
POINT_SIZE_RANGE =                        0x0B12,
POINT_SIZE_GRANULARITY =                  0x0B13,
LINE_SMOOTH =                             0x0B20,
LINE_WIDTH =                              0x0B21,
LINE_WIDTH_RANGE =                        0x0B22,
LINE_WIDTH_GRANULARITY =                  0x0B23,
POLYGON_MODE =                            0x0B40,
POLYGON_SMOOTH =                          0x0B41,
CULL_FACE =                               0x0B44,
CULL_FACE_MODE =                          0x0B45,
FRONT_FACE =                              0x0B46,
DEPTH_RANGE =                             0x0B70,
DEPTH_TEST =                              0x0B71,
DEPTH_WRITEMASK =                         0x0B72,
DEPTH_CLEAR_VALUE =                       0x0B73,
DEPTH_FUNC =                              0x0B74,
STENCIL_TEST =                            0x0B90,
STENCIL_CLEAR_VALUE =                     0x0B91,
STENCIL_FUNC =                            0x0B92,
STENCIL_VALUE_MASK =                      0x0B93,
STENCIL_FAIL =                            0x0B94,
STENCIL_PASS_DEPTH_FAIL =                 0x0B95,
STENCIL_PASS_DEPTH_PASS =                 0x0B96,
STENCIL_REF =                             0x0B97,
STENCIL_WRITEMASK =                       0x0B98,
VIEWPORT =                                0x0BA2,
DITHER =                                  0x0BD0,
BLEND_DST =                               0x0BE0,
BLEND_SRC =                               0x0BE1,
BLEND =                                   0x0BE2,
LOGIC_OP_MODE =                           0x0BF0,
COLOR_LOGIC_OP =                          0x0BF2,
DRAW_BUFFER =                             0x0C01,
READ_BUFFER =                             0x0C02,
SCISSOR_BOX =                             0x0C10,
SCISSOR_TEST =                            0x0C11,
COLOR_CLEAR_VALUE =                       0x0C22,
COLOR_WRITEMASK =                         0x0C23,
DOUBLEBUFFER =                            0x0C32,
STEREO =                                  0x0C33,
LINE_SMOOTH_HINT =                        0x0C52,
POLYGON_SMOOTH_HINT =                     0x0C53,
UNPACK_SWAP_BYTES =                       0x0CF0,
UNPACK_LSB_FIRST =                        0x0CF1,
UNPACK_ROW_LENGTH =                       0x0CF2,
UNPACK_SKIP_ROWS =                        0x0CF3,
UNPACK_SKIP_PIXELS =                      0x0CF4,
UNPACK_ALIGNMENT =                        0x0CF5,
PACK_SWAP_BYTES =                         0x0D00,
PACK_LSB_FIRST =                          0x0D01,
PACK_ROW_LENGTH =                         0x0D02,
PACK_SKIP_ROWS =                          0x0D03,
PACK_SKIP_PIXELS =                        0x0D04,
PACK_ALIGNMENT =                          0x0D05,
MAX_TEXTURE_SIZE =                        0x0D33,
MAX_VIEWPORT_DIMS =                       0x0D3A,
SUBPIXEL_BITS =                           0x0D50,
TEXTURE_1D =                              0x0DE0,
TEXTURE_2D =                              0x0DE1,
POLYGON_OFFSET_UNITS =                    0x2A00,
POLYGON_OFFSET_POINT =                    0x2A01,
POLYGON_OFFSET_LINE =                     0x2A02,
POLYGON_OFFSET_FILL =                     0x8037,
POLYGON_OFFSET_FACTOR =                   0x8038,
TEXTURE_BINDING_1D =                      0x8068,
TEXTURE_BINDING_2D =                      0x8069,
-- GetTextureParameter
TEXTURE_WIDTH =                           0x1000,
TEXTURE_HEIGHT =                          0x1001,
TEXTURE_INTERNAL_FORMAT =                 0x1003,
TEXTURE_BORDER_COLOR =                    0x1004,
TEXTURE_RED_SIZE =                        0x805C,
TEXTURE_GREEN_SIZE =                      0x805D,
TEXTURE_BLUE_SIZE =                       0x805E,
TEXTURE_ALPHA_SIZE =                      0x805F,
-- HintMode
DONT_CARE =                               0x1100,
FASTEST =                                 0x1101,
NICEST =                                  0x1102,
-- DataType
BYTE =                                    0x1400,
UNSIGNED_BYTE =                           0x1401,
SHORT =                                   0x1402,
UNSIGNED_SHORT =                          0x1403,
INT =                                     0x1404,
UNSIGNED_INT =                            0x1405,
FLOAT =                                   0x1406,
DOUBLE =                                  0x140A,
-- ErrorCode
STACK_OVERFLOW =                          0x0503,
STACK_UNDERFLOW =                         0x0504,
-- LogicOp
CLEAR =                                   0x1500,
AND =                                     0x1501,
AND_REVERSE =                             0x1502,
COPY =                                    0x1503,
AND_INVERTED =                            0x1504,
NOOP =                                    0x1505,
XOR =                                     0x1506,
OR =                                      0x1507,
NOR =                                     0x1508,
EQUIV =                                   0x1509,
INVERT =                                  0x150A,
OR_REVERSE =                              0x150B,
COPY_INVERTED =                           0x150C,
OR_INVERTED =                             0x150D,
NAND =                                    0x150E,
SET =                                     0x150F,
-- MatrixMode (for gl3.h, FBO attachment type)
TEXTURE =                                 0x1702,
-- PixelCopyType
COLOR =                                   0x1800,
DEPTH =                                   0x1801,
STENCIL =                                 0x1802,
-- PixelFormat
STENCIL_INDEX =                           0x1901,
DEPTH_COMPONENT =                         0x1902,
RED =                                     0x1903,
GREEN =                                   0x1904,
BLUE =                                    0x1905,
ALPHA =                                   0x1906,
RGB =                                     0x1907,
RGBA =                                    0x1908,
-- PolygonMode
POINT =                                   0x1B00,
LINE =                                    0x1B01,
FILL =                                    0x1B02,
-- StencilOp
KEEP =                                    0x1E00,
REPLACE =                                 0x1E01,
INCR =                                    0x1E02,
DECR =                                    0x1E03,
-- StringName
VENDOR =                                  0x1F00,
RENDERER =                                0x1F01,
VERSION =                                 0x1F02,
EXTENSIONS =                              0x1F03,
-- TextureMagFilter
NEAREST =                                 0x2600,
LINEAR =                                  0x2601,
-- TextureMinFilter
NEAREST_MIPMAP_NEAREST =                  0x2700,
LINEAR_MIPMAP_NEAREST =                   0x2701,
NEAREST_MIPMAP_LINEAR =                   0x2702,
LINEAR_MIPMAP_LINEAR =                    0x2703,
-- TextureParameterName
TEXTURE_MAG_FILTER =                      0x2800,
TEXTURE_MIN_FILTER =                      0x2801,
TEXTURE_WRAP_S =                          0x2802,
TEXTURE_WRAP_T =                          0x2803,
-- TextureTarget
PROXY_TEXTURE_1D =                        0x8063,
PROXY_TEXTURE_2D =                        0x8064,
-- TextureWrapMode
REPEAT =                                  0x2901,
-- PixelInternalFormat
R3_G3_B2 =                                0x2A10,
RGB4 =                                    0x804F,
RGB5 =                                    0x8050,
RGB8 =                                    0x8051,
RGB10 =                                   0x8052,
RGB12 =                                   0x8053,
RGB16 =                                   0x8054,
RGBA2 =                                   0x8055,
RGBA4 =                                   0x8056,
RGB5_A1 =                                 0x8057,
RGBA8 =                                   0x8058,
RGB10_A2 =                                0x8059,
RGBA12 =                                  0x805A,
RGBA16 =                                  0x805B,

-- GL_VERSION_1_2
UNSIGNED_BYTE_3_3_2 =                     0x8032,
UNSIGNED_SHORT_4_4_4_4 =                  0x8033,
UNSIGNED_SHORT_5_5_5_1 =                  0x8034,
UNSIGNED_INT_8_8_8_8 =                    0x8035,
UNSIGNED_INT_10_10_10_2 =                 0x8036,
TEXTURE_BINDING_3D =                      0x806A,
PACK_SKIP_IMAGES =                        0x806B,
PACK_IMAGE_HEIGHT =                       0x806C,
UNPACK_SKIP_IMAGES =                      0x806D,
UNPACK_IMAGE_HEIGHT =                     0x806E,
TEXTURE_3D =                              0x806F,
PROXY_TEXTURE_3D =                        0x8070,
TEXTURE_DEPTH =                           0x8071,
TEXTURE_WRAP_R =                          0x8072,
MAX_3D_TEXTURE_SIZE =                     0x8073,
UNSIGNED_BYTE_2_3_3_REV =                 0x8362,
UNSIGNED_SHORT_5_6_5 =                    0x8363,
UNSIGNED_SHORT_5_6_5_REV =                0x8364,
UNSIGNED_SHORT_4_4_4_4_REV =              0x8365,
UNSIGNED_SHORT_1_5_5_5_REV =              0x8366,
UNSIGNED_INT_8_8_8_8_REV =                0x8367,
UNSIGNED_INT_2_10_10_10_REV =             0x8368,
BGR =                                     0x80E0,
BGRA =                                    0x80E1,
MAX_ELEMENTS_VERTICES =                   0x80E8,
MAX_ELEMENTS_INDICES =                    0x80E9,
CLAMP_TO_EDGE =                           0x812F,
TEXTURE_MIN_LOD =                         0x813A,
TEXTURE_MAX_LOD =                         0x813B,
TEXTURE_BASE_LEVEL =                      0x813C,
TEXTURE_MAX_LEVEL =                       0x813D,
SMOOTH_POINT_SIZE_RANGE =                 0x0B12,
SMOOTH_POINT_SIZE_GRANULARITY =           0x0B13,
SMOOTH_LINE_WIDTH_RANGE =                 0x0B22,
SMOOTH_LINE_WIDTH_GRANULARITY =           0x0B23,
ALIASED_LINE_WIDTH_RANGE =                0x846E,

-- GL_ARB_imaging
CONSTANT_COLOR =                          0x8001,
ONE_MINUS_CONSTANT_COLOR =                0x8002,
CONSTANT_ALPHA =                          0x8003,
ONE_MINUS_CONSTANT_ALPHA =                0x8004,
BLEND_COLOR =                             0x8005,
FUNC_ADD =                                0x8006,
MIN =                                     0x8007,
MAX =                                     0x8008,
BLEND_EQUATION =                          0x8009,
FUNC_SUBTRACT =                           0x800A,
FUNC_REVERSE_SUBTRACT =                   0x800B,

-- GL_VERSION_1_3
TEXTURE0 =                                0x84C0,
TEXTURE1 =                                0x84C1,
TEXTURE2 =                                0x84C2,
TEXTURE3 =                                0x84C3,
TEXTURE4 =                                0x84C4,
TEXTURE5 =                                0x84C5,
TEXTURE6 =                                0x84C6,
TEXTURE7 =                                0x84C7,
TEXTURE8 =                                0x84C8,
TEXTURE9 =                                0x84C9,
TEXTURE10 =                               0x84CA,
TEXTURE11 =                               0x84CB,
TEXTURE12 =                               0x84CC,
TEXTURE13 =                               0x84CD,
TEXTURE14 =                               0x84CE,
TEXTURE15 =                               0x84CF,
TEXTURE16 =                               0x84D0,
TEXTURE17 =                               0x84D1,
TEXTURE18 =                               0x84D2,
TEXTURE19 =                               0x84D3,
TEXTURE20 =                               0x84D4,
TEXTURE21 =                               0x84D5,
TEXTURE22 =                               0x84D6,
TEXTURE23 =                               0x84D7,
TEXTURE24 =                               0x84D8,
TEXTURE25 =                               0x84D9,
TEXTURE26 =                               0x84DA,
TEXTURE27 =                               0x84DB,
TEXTURE28 =                               0x84DC,
TEXTURE29 =                               0x84DD,
TEXTURE30 =                               0x84DE,
TEXTURE31 =                               0x84DF,
ACTIVE_TEXTURE =                          0x84E0,
MULTISAMPLE =                             0x809D,
SAMPLE_ALPHA_TO_COVERAGE =                0x809E,
SAMPLE_ALPHA_TO_ONE =                     0x809F,
SAMPLE_COVERAGE =                         0x80A0,
SAMPLE_BUFFERS =                          0x80A8,
SAMPLES =                                 0x80A9,
SAMPLE_COVERAGE_VALUE =                   0x80AA,
SAMPLE_COVERAGE_INVERT =                  0x80AB,
TEXTURE_CUBE_MAP =                        0x8513,
TEXTURE_BINDING_CUBE_MAP =                0x8514,
TEXTURE_CUBE_MAP_POSITIVE_X =             0x8515,
TEXTURE_CUBE_MAP_NEGATIVE_X =             0x8516,
TEXTURE_CUBE_MAP_POSITIVE_Y =             0x8517,
TEXTURE_CUBE_MAP_NEGATIVE_Y =             0x8518,
TEXTURE_CUBE_MAP_POSITIVE_Z =             0x8519,
TEXTURE_CUBE_MAP_NEGATIVE_Z =             0x851A,
PROXY_TEXTURE_CUBE_MAP =                  0x851B,
MAX_CUBE_MAP_TEXTURE_SIZE =               0x851C,
COMPRESSED_RGB =                          0x84ED,
COMPRESSED_RGBA =                         0x84EE,
TEXTURE_COMPRESSION_HINT =                0x84EF,
TEXTURE_COMPRESSED_IMAGE_SIZE =           0x86A0,
TEXTURE_COMPRESSED =                      0x86A1,
NUM_COMPRESSED_TEXTURE_FORMATS =          0x86A2,
COMPRESSED_TEXTURE_FORMATS =              0x86A3,
CLAMP_TO_BORDER =                         0x812D,

-- GL_VERSION_1_4
BLEND_DST_RGB =                           0x80C8,
BLEND_SRC_RGB =                           0x80C9,
BLEND_DST_ALPHA =                         0x80CA,
BLEND_SRC_ALPHA =                         0x80CB,
POINT_FADE_THRESHOLD_SIZE =               0x8128,
DEPTH_COMPONENT16 =                       0x81A5,
DEPTH_COMPONENT24 =                       0x81A6,
DEPTH_COMPONENT32 =                       0x81A7,
MIRRORED_REPEAT =                         0x8370,
MAX_TEXTURE_LOD_BIAS =                    0x84FD,
TEXTURE_LOD_BIAS =                        0x8501,
INCR_WRAP =                               0x8507,
DECR_WRAP =                               0x8508,
TEXTURE_DEPTH_SIZE =                      0x884A,
TEXTURE_COMPARE_MODE =                    0x884C,
TEXTURE_COMPARE_FUNC =                    0x884D,

-- GL_VERSION_1_5
BUFFER_SIZE =                             0x8764,
BUFFER_USAGE =                            0x8765,
QUERY_COUNTER_BITS =                      0x8864,
CURRENT_QUERY =                           0x8865,
QUERY_RESULT =                            0x8866,
QUERY_RESULT_AVAILABLE =                  0x8867,
ARRAY_BUFFER =                            0x8892,
ELEMENT_ARRAY_BUFFER =                    0x8893,
ARRAY_BUFFER_BINDING =                    0x8894,
ELEMENT_ARRAY_BUFFER_BINDING =            0x8895,
VERTEX_ATTRIB_ARRAY_BUFFER_BINDING =      0x889F,
READ_ONLY =                               0x88B8,
WRITE_ONLY =                              0x88B9,
READ_WRITE =                              0x88BA,
BUFFER_ACCESS =                           0x88BB,
BUFFER_MAPPED =                           0x88BC,
BUFFER_MAP_POINTER =                      0x88BD,
STREAM_DRAW =                             0x88E0,
STREAM_READ =                             0x88E1,
STREAM_COPY =                             0x88E2,
STATIC_DRAW =                             0x88E4,
STATIC_READ =                             0x88E5,
STATIC_COPY =                             0x88E6,
DYNAMIC_DRAW =                            0x88E8,
DYNAMIC_READ =                            0x88E9,
DYNAMIC_COPY =                            0x88EA,
SAMPLES_PASSED =                          0x8914,
SRC1_ALPHA =                              0x8589,

-- GL_VERSION_2_0
BLEND_EQUATION_RGB =                      0x8009,
VERTEX_ATTRIB_ARRAY_ENABLED =             0x8622,
VERTEX_ATTRIB_ARRAY_SIZE =                0x8623,
VERTEX_ATTRIB_ARRAY_STRIDE =              0x8624,
VERTEX_ATTRIB_ARRAY_TYPE =                0x8625,
CURRENT_VERTEX_ATTRIB =                   0x8626,
VERTEX_PROGRAM_POINT_SIZE =               0x8642,
VERTEX_ATTRIB_ARRAY_POINTER =             0x8645,
STENCIL_BACK_FUNC =                       0x8800,
STENCIL_BACK_FAIL =                       0x8801,
STENCIL_BACK_PASS_DEPTH_FAIL =            0x8802,
STENCIL_BACK_PASS_DEPTH_PASS =            0x8803,
MAX_DRAW_BUFFERS =                        0x8824,
DRAW_BUFFER0 =                            0x8825,
DRAW_BUFFER1 =                            0x8826,
DRAW_BUFFER2 =                            0x8827,
DRAW_BUFFER3 =                            0x8828,
DRAW_BUFFER4 =                            0x8829,
DRAW_BUFFER5 =                            0x882A,
DRAW_BUFFER6 =                            0x882B,
DRAW_BUFFER7 =                            0x882C,
DRAW_BUFFER8 =                            0x882D,
DRAW_BUFFER9 =                            0x882E,
DRAW_BUFFER10 =                           0x882F,
DRAW_BUFFER11 =                           0x8830,
DRAW_BUFFER12 =                           0x8831,
DRAW_BUFFER13 =                           0x8832,
DRAW_BUFFER14 =                           0x8833,
DRAW_BUFFER15 =                           0x8834,
BLEND_EQUATION_ALPHA =                    0x883D,
MAX_VERTEX_ATTRIBS =                      0x8869,
VERTEX_ATTRIB_ARRAY_NORMALIZED =          0x886A,
MAX_TEXTURE_IMAGE_UNITS =                 0x8872,
FRAGMENT_SHADER =                         0x8B30,
VERTEX_SHADER =                           0x8B31,
MAX_FRAGMENT_UNIFORM_COMPONENTS =         0x8B49,
MAX_VERTEX_UNIFORM_COMPONENTS =           0x8B4A,
MAX_VARYING_FLOATS =                      0x8B4B,
MAX_VERTEX_TEXTURE_IMAGE_UNITS =          0x8B4C,
MAX_COMBINED_TEXTURE_IMAGE_UNITS =        0x8B4D,
SHADER_TYPE =                             0x8B4F,
FLOAT_VEC2 =                              0x8B50,
FLOAT_VEC3 =                              0x8B51,
FLOAT_VEC4 =                              0x8B52,
INT_VEC2 =                                0x8B53,
INT_VEC3 =                                0x8B54,
INT_VEC4 =                                0x8B55,
BOOL =                                    0x8B56,
BOOL_VEC2 =                               0x8B57,
BOOL_VEC3 =                               0x8B58,
BOOL_VEC4 =                               0x8B59,
FLOAT_MAT2 =                              0x8B5A,
FLOAT_MAT3 =                              0x8B5B,
FLOAT_MAT4 =                              0x8B5C,
SAMPLER_1D =                              0x8B5D,
SAMPLER_2D =                              0x8B5E,
SAMPLER_3D =                              0x8B5F,
SAMPLER_CUBE =                            0x8B60,
SAMPLER_1D_SHADOW =                       0x8B61,
SAMPLER_2D_SHADOW =                       0x8B62,
DELETE_STATUS =                           0x8B80,
COMPILE_STATUS =                          0x8B81,
LINK_STATUS =                             0x8B82,
VALIDATE_STATUS =                         0x8B83,
INFO_LOG_LENGTH =                         0x8B84,
ATTACHED_SHADERS =                        0x8B85,
ACTIVE_UNIFORMS =                         0x8B86,
ACTIVE_UNIFORM_MAX_LENGTH =               0x8B87,
SHADER_SOURCE_LENGTH =                    0x8B88,
ACTIVE_ATTRIBUTES =                       0x8B89,
ACTIVE_ATTRIBUTE_MAX_LENGTH =             0x8B8A,
FRAGMENT_SHADER_DERIVATIVE_HINT =         0x8B8B,
SHADING_LANGUAGE_VERSION =                0x8B8C,
CURRENT_PROGRAM =                         0x8B8D,
POINT_SPRITE_COORD_ORIGIN =               0x8CA0,
LOWER_LEFT =                              0x8CA1,
UPPER_LEFT =                              0x8CA2,
STENCIL_BACK_REF =                        0x8CA3,
STENCIL_BACK_VALUE_MASK =                 0x8CA4,
STENCIL_BACK_WRITEMASK =                  0x8CA5,

-- GL_VERSION_2_1
PIXEL_PACK_BUFFER =                       0x88EB,
PIXEL_UNPACK_BUFFER =                     0x88EC,
PIXEL_PACK_BUFFER_BINDING =               0x88ED,
PIXEL_UNPACK_BUFFER_BINDING =             0x88EF,
FLOAT_MAT2x3 =                            0x8B65,
FLOAT_MAT2x4 =                            0x8B66,
FLOAT_MAT3x2 =                            0x8B67,
FLOAT_MAT3x4 =                            0x8B68,
FLOAT_MAT4x2 =                            0x8B69,
FLOAT_MAT4x3 =                            0x8B6A,
SRGB =                                    0x8C40,
SRGB8 =                                   0x8C41,
SRGB_ALPHA =                              0x8C42,
SRGB8_ALPHA8 =                            0x8C43,
COMPRESSED_SRGB =                         0x8C48,
COMPRESSED_SRGB_ALPHA =                   0x8C49,

-- GL_VERSION_3_0
COMPARE_REF_TO_TEXTURE =                  0x884E,
CLIP_DISTANCE0 =                          0x3000,
CLIP_DISTANCE1 =                          0x3001,
CLIP_DISTANCE2 =                          0x3002,
CLIP_DISTANCE3 =                          0x3003,
CLIP_DISTANCE4 =                          0x3004,
CLIP_DISTANCE5 =                          0x3005,
CLIP_DISTANCE6 =                          0x3006,
CLIP_DISTANCE7 =                          0x3007,
MAX_CLIP_DISTANCES =                      0x0D32,
MAJOR_VERSION =                           0x821B,
MINOR_VERSION =                           0x821C,
NUM_EXTENSIONS =                          0x821D,
CONTEXT_FLAGS =                           0x821E,
COMPRESSED_RED =                          0x8225,
COMPRESSED_RG =                           0x8226,
CONTEXT_FLAG_FORWARD_COMPATIBLE_BIT =     0x00000001,
RGBA32F =                                 0x8814,
RGB32F =                                  0x8815,
RGBA16F =                                 0x881A,
RGB16F =                                  0x881B,
VERTEX_ATTRIB_ARRAY_INTEGER =             0x88FD,
MAX_ARRAY_TEXTURE_LAYERS =                0x88FF,
MIN_PROGRAM_TEXEL_OFFSET =                0x8904,
MAX_PROGRAM_TEXEL_OFFSET =                0x8905,
CLAMP_READ_COLOR =                        0x891C,
FIXED_ONLY =                              0x891D,
MAX_VARYING_COMPONENTS =                  0x8B4B,
TEXTURE_1D_ARRAY =                        0x8C18,
PROXY_TEXTURE_1D_ARRAY =                  0x8C19,
TEXTURE_2D_ARRAY =                        0x8C1A,
PROXY_TEXTURE_2D_ARRAY =                  0x8C1B,
TEXTURE_BINDING_1D_ARRAY =                0x8C1C,
TEXTURE_BINDING_2D_ARRAY =                0x8C1D,
R11F_G11F_B10F =                          0x8C3A,
UNSIGNED_INT_10F_11F_11F_REV =            0x8C3B,
RGB9_E5 =                                 0x8C3D,
UNSIGNED_INT_5_9_9_9_REV =                0x8C3E,
TEXTURE_SHARED_SIZE =                     0x8C3F,
TRANSFORM_FEEDBACK_VARYING_MAX_LENGTH =   0x8C76,
TRANSFORM_FEEDBACK_BUFFER_MODE =          0x8C7F,
MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS =
                                          0x8C80,
TRANSFORM_FEEDBACK_VARYINGS =             0x8C83,
TRANSFORM_FEEDBACK_BUFFER_START =         0x8C84,
TRANSFORM_FEEDBACK_BUFFER_SIZE =          0x8C85,
PRIMITIVES_GENERATED =                    0x8C87,
TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN =   0x8C88,
RASTERIZER_DISCARD =                      0x8C89,
MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS = 
                                          0x8C8A,
MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS = 0x8C8B,
INTERLEAVED_ATTRIBS =                     0x8C8C,
SEPARATE_ATTRIBS =                        0x8C8D,
TRANSFORM_FEEDBACK_BUFFER =               0x8C8E,
TRANSFORM_FEEDBACK_BUFFER_BINDING =       0x8C8F,
RGBA32UI =                                0x8D70,
RGB32UI =                                 0x8D71,
RGBA16UI =                                0x8D76,
RGB16UI =                                 0x8D77,
RGBA8UI =                                 0x8D7C,
RGB8UI =                                  0x8D7D,
RGBA32I =                                 0x8D82,
RGB32I =                                  0x8D83,
RGBA16I =                                 0x8D88,
RGB16I =                                  0x8D89,
RGBA8I =                                  0x8D8E,
RGB8I =                                   0x8D8F,
RED_INTEGER =                             0x8D94,
GREEN_INTEGER =                           0x8D95,
BLUE_INTEGER =                            0x8D96,
RGB_INTEGER =                             0x8D98,
RGBA_INTEGER =                            0x8D99,
BGR_INTEGER =                             0x8D9A,
BGRA_INTEGER =                            0x8D9B,
SAMPLER_1D_ARRAY =                        0x8DC0,
SAMPLER_2D_ARRAY =                        0x8DC1,
SAMPLER_1D_ARRAY_SHADOW =                 0x8DC3,
SAMPLER_2D_ARRAY_SHADOW =                 0x8DC4,
SAMPLER_CUBE_SHADOW =                     0x8DC5,
UNSIGNED_INT_VEC2 =                       0x8DC6,
UNSIGNED_INT_VEC3 =                       0x8DC7,
UNSIGNED_INT_VEC4 =                       0x8DC8,
INT_SAMPLER_1D =                          0x8DC9,
INT_SAMPLER_2D =                          0x8DCA,
INT_SAMPLER_3D =                          0x8DCB,
INT_SAMPLER_CUBE =                        0x8DCC,
INT_SAMPLER_1D_ARRAY =                    0x8DCE,
INT_SAMPLER_2D_ARRAY =                    0x8DCF,
UNSIGNED_INT_SAMPLER_1D =                 0x8DD1,
UNSIGNED_INT_SAMPLER_2D =                 0x8DD2,
UNSIGNED_INT_SAMPLER_3D =                 0x8DD3,
UNSIGNED_INT_SAMPLER_CUBE =               0x8DD4,
UNSIGNED_INT_SAMPLER_1D_ARRAY =           0x8DD6,
UNSIGNED_INT_SAMPLER_2D_ARRAY =           0x8DD7,
QUERY_WAIT =                              0x8E13,
QUERY_NO_WAIT =                           0x8E14,
QUERY_BY_REGION_WAIT =                    0x8E15,
QUERY_BY_REGION_NO_WAIT =                 0x8E16,
BUFFER_ACCESS_FLAGS =                     0x911F,
BUFFER_MAP_LENGTH =                       0x9120,
BUFFER_MAP_OFFSET =                       0x9121,
-- Reuse tokens from ARB_depth_buffer_float
-- reuse GL_DEPTH_COMPONENT32F
-- reuse GL_DEPTH32F_STENCIL8
-- reuse GL_FLOAT_32_UNSIGNED_INT_24_8_REV
-- Reuse tokens from ARB_framebuffer_object
-- reuse GL_INVALID_FRAMEBUFFER_OPERATION
-- reuse GL_FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING
-- reuse GL_FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE
-- reuse GL_FRAMEBUFFER_ATTACHMENT_RED_SIZE
-- reuse GL_FRAMEBUFFER_ATTACHMENT_GREEN_SIZE
-- reuse GL_FRAMEBUFFER_ATTACHMENT_BLUE_SIZE
-- reuse GL_FRAMEBUFFER_ATTACHMENT_ALPHA_SIZE
-- reuse GL_FRAMEBUFFER_ATTACHMENT_DEPTH_SIZE
-- reuse GL_FRAMEBUFFER_ATTACHMENT_STENCIL_SIZE
-- reuse GL_FRAMEBUFFER_DEFAULT
-- reuse GL_FRAMEBUFFER_UNDEFINED
-- reuse GL_DEPTH_STENCIL_ATTACHMENT
-- reuse GL_INDEX
-- reuse GL_MAX_RENDERBUFFER_SIZE
-- reuse GL_DEPTH_STENCIL
-- reuse GL_UNSIGNED_INT_24_8
-- reuse GL_DEPTH24_STENCIL8
-- reuse GL_TEXTURE_STENCIL_SIZE
-- reuse GL_TEXTURE_RED_TYPE
-- reuse GL_TEXTURE_GREEN_TYPE
-- reuse GL_TEXTURE_BLUE_TYPE
-- reuse GL_TEXTURE_ALPHA_TYPE
-- reuse GL_TEXTURE_DEPTH_TYPE
-- reuse GL_UNSIGNED_NORMALIZED
-- reuse GL_FRAMEBUFFER_BINDING
-- reuse GL_DRAW_FRAMEBUFFER_BINDING
-- reuse GL_RENDERBUFFER_BINDING
-- reuse GL_READ_FRAMEBUFFER
-- reuse GL_DRAW_FRAMEBUFFER
-- reuse GL_READ_FRAMEBUFFER_BINDING
-- reuse GL_RENDERBUFFER_SAMPLES
-- reuse GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE
-- reuse GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME
-- reuse GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL
-- reuse GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE
-- reuse GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER
-- reuse GL_FRAMEBUFFER_COMPLETE
-- reuse GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT
-- reuse GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT
-- reuse GL_FRAMEBUFFER_INCOMPLETE_DRAW_BUFFER
-- reuse GL_FRAMEBUFFER_INCOMPLETE_READ_BUFFER
-- reuse GL_FRAMEBUFFER_UNSUPPORTED
-- reuse GL_MAX_COLOR_ATTACHMENTS
-- reuse GL_COLOR_ATTACHMENT0
-- reuse GL_COLOR_ATTACHMENT1
-- reuse GL_COLOR_ATTACHMENT2
-- reuse GL_COLOR_ATTACHMENT3
-- reuse GL_COLOR_ATTACHMENT4
-- reuse GL_COLOR_ATTACHMENT5
-- reuse GL_COLOR_ATTACHMENT6
-- reuse GL_COLOR_ATTACHMENT7
-- reuse GL_COLOR_ATTACHMENT8
-- reuse GL_COLOR_ATTACHMENT9
-- reuse GL_COLOR_ATTACHMENT10
-- reuse GL_COLOR_ATTACHMENT11
-- reuse GL_COLOR_ATTACHMENT12
-- reuse GL_COLOR_ATTACHMENT13
-- reuse GL_COLOR_ATTACHMENT14
-- reuse GL_COLOR_ATTACHMENT15
-- reuse GL_DEPTH_ATTACHMENT
-- reuse GL_STENCIL_ATTACHMENT
-- reuse GL_FRAMEBUFFER
-- reuse GL_RENDERBUFFER
-- reuse GL_RENDERBUFFER_WIDTH
-- reuse GL_RENDERBUFFER_HEIGHT
-- reuse GL_RENDERBUFFER_INTERNAL_FORMAT
-- reuse GL_STENCIL_INDEX1
-- reuse GL_STENCIL_INDEX4
-- reuse GL_STENCIL_INDEX8
-- reuse GL_STENCIL_INDEX16
-- reuse GL_RENDERBUFFER_RED_SIZE
-- reuse GL_RENDERBUFFER_GREEN_SIZE
-- reuse GL_RENDERBUFFER_BLUE_SIZE
-- reuse GL_RENDERBUFFER_ALPHA_SIZE
-- reuse GL_RENDERBUFFER_DEPTH_SIZE
-- reuse GL_RENDERBUFFER_STENCIL_SIZE
-- reuse GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE
-- reuse GL_MAX_SAMPLES
-- Reuse tokens from ARB_framebuffer_sRGB
-- reuse GL_FRAMEBUFFER_SRGB
-- Reuse tokens from ARB_half_float_vertex
-- reuse GL_HALF_FLOAT
-- Reuse tokens from ARB_map_buffer_range
-- reuse GL_MAP_READ_BIT
-- reuse GL_MAP_WRITE_BIT
-- reuse GL_MAP_INVALIDATE_RANGE_BIT
-- reuse GL_MAP_INVALIDATE_BUFFER_BIT
-- reuse GL_MAP_FLUSH_EXPLICIT_BIT
-- reuse GL_MAP_UNSYNCHRONIZED_BIT
-- Reuse tokens from ARB_texture_compression_rgtc
-- reuse GL_COMPRESSED_RED_RGTC1
-- reuse GL_COMPRESSED_SIGNED_RED_RGTC1
-- reuse GL_COMPRESSED_RG_RGTC2
-- reuse GL_COMPRESSED_SIGNED_RG_RGTC2
-- Reuse tokens from ARB_texture_rg
-- reuse GL_RG
-- reuse GL_RG_INTEGER
-- reuse GL_R8
-- reuse GL_R16
-- reuse GL_RG8
-- reuse GL_RG16
-- reuse GL_R16F
-- reuse GL_R32F
-- reuse GL_RG16F
-- reuse GL_RG32F
-- reuse GL_R8I
-- reuse GL_R8UI
-- reuse GL_R16I
-- reuse GL_R16UI
-- reuse GL_R32I
-- reuse GL_R32UI
-- reuse GL_RG8I
-- reuse GL_RG8UI
-- reuse GL_RG16I
-- reuse GL_RG16UI
-- reuse GL_RG32I
-- reuse GL_RG32UI
-- Reuse tokens from ARB_vertex_array_object
-- reuse GL_VERTEX_ARRAY_BINDING

-- GL_VERSION_3_1
SAMPLER_2D_RECT =                         0x8B63,
SAMPLER_2D_RECT_SHADOW =                  0x8B64,
SAMPLER_BUFFER =                          0x8DC2,
INT_SAMPLER_2D_RECT =                     0x8DCD,
INT_SAMPLER_BUFFER =                      0x8DD0,
UNSIGNED_INT_SAMPLER_2D_RECT =            0x8DD5,
UNSIGNED_INT_SAMPLER_BUFFER =             0x8DD8,
TEXTURE_BUFFER =                          0x8C2A,
MAX_TEXTURE_BUFFER_SIZE =                 0x8C2B,
TEXTURE_BINDING_BUFFER =                  0x8C2C,
TEXTURE_BUFFER_DATA_STORE_BINDING =       0x8C2D,
TEXTURE_RECTANGLE =                       0x84F5,
TEXTURE_BINDING_RECTANGLE =               0x84F6,
PROXY_TEXTURE_RECTANGLE =                 0x84F7,
MAX_RECTANGLE_TEXTURE_SIZE =              0x84F8,
RED_SNORM =                               0x8F90,
RG_SNORM =                                0x8F91,
RGB_SNORM =                               0x8F92,
RGBA_SNORM =                              0x8F93,
R8_SNORM =                                0x8F94,
RG8_SNORM =                               0x8F95,
RGB8_SNORM =                              0x8F96,
RGBA8_SNORM =                             0x8F97,
R16_SNORM =                               0x8F98,
RG16_SNORM =                              0x8F99,
RGB16_SNORM =                             0x8F9A,
RGBA16_SNORM =                            0x8F9B,
SIGNED_NORMALIZED =                       0x8F9C,
PRIMITIVE_RESTART =                       0x8F9D,
PRIMITIVE_RESTART_INDEX =                 0x8F9E,
-- Reuse tokens from ARB_copy_buffer
-- reuse GL_COPY_READ_BUFFER
-- reuse GL_COPY_WRITE_BUFFER
-- Reuse tokens from ARB_draw_instanced (none)
-- Reuse tokens from ARB_uniform_buffer_object
-- reuse GL_UNIFORM_BUFFER
-- reuse GL_UNIFORM_BUFFER_BINDING
-- reuse GL_UNIFORM_BUFFER_START
-- reuse GL_UNIFORM_BUFFER_SIZE
-- reuse GL_MAX_VERTEX_UNIFORM_BLOCKS
-- reuse GL_MAX_FRAGMENT_UNIFORM_BLOCKS
-- reuse GL_MAX_COMBINED_UNIFORM_BLOCKS
-- reuse GL_MAX_UNIFORM_BUFFER_BINDINGS
-- reuse GL_MAX_UNIFORM_BLOCK_SIZE
-- reuse GL_MAX_COMBINED_VERTEX_UNIFORM_COMPONENTS
-- reuse GL_MAX_COMBINED_FRAGMENT_UNIFORM_COMPONENTS
-- reuse GL_UNIFORM_BUFFER_OFFSET_ALIGNMENT
-- reuse GL_ACTIVE_UNIFORM_BLOCK_MAX_NAME_LENGTH
-- reuse GL_ACTIVE_UNIFORM_BLOCKS
-- reuse GL_UNIFORM_TYPE
-- reuse GL_UNIFORM_SIZE
-- reuse GL_UNIFORM_NAME_LENGTH
-- reuse GL_UNIFORM_BLOCK_INDEX
-- reuse GL_UNIFORM_OFFSET
-- reuse GL_UNIFORM_ARRAY_STRIDE
-- reuse GL_UNIFORM_MATRIX_STRIDE
-- reuse GL_UNIFORM_IS_ROW_MAJOR
-- reuse GL_UNIFORM_BLOCK_BINDING
-- reuse GL_UNIFORM_BLOCK_DATA_SIZE
-- reuse GL_UNIFORM_BLOCK_NAME_LENGTH
-- reuse GL_UNIFORM_BLOCK_ACTIVE_UNIFORMS
-- reuse GL_UNIFORM_BLOCK_ACTIVE_UNIFORM_INDICES
-- reuse GL_UNIFORM_BLOCK_REFERENCED_BY_VERTEX_SHADER
-- reuse GL_UNIFORM_BLOCK_REFERENCED_BY_FRAGMENT_SHADER
-- reuse GL_INVALID_INDEX

-- GL_VERSION_3_2
CONTEXT_CORE_PROFILE_BIT =                0x00000001,
CONTEXT_COMPATIBILITY_PROFILE_BIT =       0x00000002,
LINES_ADJACENCY =                         0x000A,
LINE_STRIP_ADJACENCY =                    0x000B,
TRIANGLES_ADJACENCY =                     0x000C,
TRIANGLE_STRIP_ADJACENCY =                0x000D,
PROGRAM_POINT_SIZE =                      0x8642,
MAX_GEOMETRY_TEXTURE_IMAGE_UNITS =        0x8C29,
FRAMEBUFFER_ATTACHMENT_LAYERED =          0x8DA7,
FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS =    0x8DA8,
GEOMETRY_SHADER =                         0x8DD9,
GEOMETRY_VERTICES_OUT =                   0x8916,
GEOMETRY_INPUT_TYPE =                     0x8917,
GEOMETRY_OUTPUT_TYPE =                    0x8918,
MAX_GEOMETRY_UNIFORM_COMPONENTS =         0x8DDF,
MAX_GEOMETRY_OUTPUT_VERTICES =            0x8DE0,
MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS =    0x8DE1,
MAX_VERTEX_OUTPUT_COMPONENTS =            0x9122,
MAX_GEOMETRY_INPUT_COMPONENTS =           0x9123,
MAX_GEOMETRY_OUTPUT_COMPONENTS =          0x9124,
MAX_FRAGMENT_INPUT_COMPONENTS =           0x9125,
CONTEXT_PROFILE_MASK =                    0x9126,
-- reuse GL_MAX_VARYING_COMPONENTS
-- reuse GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER
-- Reuse tokens from ARB_depth_clamp
-- reuse GL_DEPTH_CLAMP
-- Reuse tokens from ARB_draw_elements_base_vertex (none)
-- Reuse tokens from ARB_fragment_coord_conventions (none)
-- Reuse tokens from ARB_provoking_vertex
-- reuse GL_QUADS_FOLLOW_PROVOKING_VERTEX_CONVENTION
-- reuse GL_FIRST_VERTEX_CONVENTION
-- reuse GL_LAST_VERTEX_CONVENTION
-- reuse GL_PROVOKING_VERTEX
-- Reuse tokens from ARB_seamless_cube_map
-- reuse GL_TEXTURE_CUBE_MAP_SEAMLESS
-- Reuse tokens from ARB_sync
-- reuse GL_MAX_SERVER_WAIT_TIMEOUT
-- reuse GL_OBJECT_TYPE
-- reuse GL_SYNC_CONDITION
-- reuse GL_SYNC_STATUS
-- reuse GL_SYNC_FLAGS
-- reuse GL_SYNC_FENCE
-- reuse GL_SYNC_GPU_COMMANDS_COMPLETE
-- reuse GL_UNSIGNALED
-- reuse GL_SIGNALED
-- reuse GL_ALREADY_SIGNALED
-- reuse GL_TIMEOUT_EXPIRED
-- reuse GL_CONDITION_SATISFIED
-- reuse GL_WAIT_FAILED
-- reuse GL_TIMEOUT_IGNORED
-- reuse GL_SYNC_FLUSH_COMMANDS_BIT
-- reuse GL_TIMEOUT_IGNORED
-- Reuse tokens from ARB_texture_multisample
-- reuse GL_SAMPLE_POSITION
-- reuse GL_SAMPLE_MASK
-- reuse GL_SAMPLE_MASK_VALUE
-- reuse GL_MAX_SAMPLE_MASK_WORDS
-- reuse GL_TEXTURE_2D_MULTISAMPLE
-- reuse GL_PROXY_TEXTURE_2D_MULTISAMPLE
-- reuse GL_TEXTURE_2D_MULTISAMPLE_ARRAY
-- reuse GL_PROXY_TEXTURE_2D_MULTISAMPLE_ARRAY
-- reuse GL_TEXTURE_BINDING_2D_MULTISAMPLE
-- reuse GL_TEXTURE_BINDING_2D_MULTISAMPLE_ARRAY
-- reuse GL_TEXTURE_SAMPLES
-- reuse GL_TEXTURE_FIXED_SAMPLE_LOCATIONS
-- reuse GL_SAMPLER_2D_MULTISAMPLE
-- reuse GL_INT_SAMPLER_2D_MULTISAMPLE
-- reuse GL_UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE
-- reuse GL_SAMPLER_2D_MULTISAMPLE_ARRAY
-- reuse GL_INT_SAMPLER_2D_MULTISAMPLE_ARRAY
-- reuse GL_UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE_ARRAY
-- reuse GL_MAX_COLOR_TEXTURE_SAMPLES
-- reuse GL_MAX_DEPTH_TEXTURE_SAMPLES
-- reuse GL_MAX_INTEGER_SAMPLES
-- Don't need to reuse tokens from ARB_vertex_array_bgra since they're already in 1.2 core

-- GL_VERSION_3_3
VERTEX_ATTRIB_ARRAY_DIVISOR =             0x88FE,
-- Reuse tokens from ARB_blend_func_extended
-- reuse GL_SRC1_COLOR
-- reuse GL_ONE_MINUS_SRC1_COLOR
-- reuse GL_ONE_MINUS_SRC1_ALPHA
-- reuse GL_MAX_DUAL_SOURCE_DRAW_BUFFERS
-- Reuse tokens from ARB_explicit_attrib_location (none)
-- Reuse tokens from ARB_occlusion_query2
-- reuse GL_ANY_SAMPLES_PASSED
-- Reuse tokens from ARB_sampler_objects
-- reuse GL_SAMPLER_BINDING
-- Reuse tokens from ARB_shader_bit_encoding (none)
-- Reuse tokens from ARB_texture_rgb10_a2ui
-- reuse GL_RGB10_A2UI
-- Reuse tokens from ARB_texture_swizzle
-- reuse GL_TEXTURE_SWIZZLE_R
-- reuse GL_TEXTURE_SWIZZLE_G
-- reuse GL_TEXTURE_SWIZZLE_B
-- reuse GL_TEXTURE_SWIZZLE_A
-- reuse GL_TEXTURE_SWIZZLE_RGBA
-- Reuse tokens from ARB_timer_query
-- reuse GL_TIME_ELAPSED
-- reuse GL_TIMESTAMP
-- Reuse tokens from ARB_vertex_type_2_10_10_10_rev
-- reuse GL_INT_2_10_10_10_REV

-- GL_VERSION_4_0
SAMPLE_SHADING =                          0x8C36,
MIN_SAMPLE_SHADING_VALUE =                0x8C37,
MIN_PROGRAM_TEXTURE_GATHER_OFFSET =       0x8E5E,
MAX_PROGRAM_TEXTURE_GATHER_OFFSET =       0x8E5F,
TEXTURE_CUBE_MAP_ARRAY =                  0x9009,
TEXTURE_BINDING_CUBE_MAP_ARRAY =          0x900A,
PROXY_TEXTURE_CUBE_MAP_ARRAY =            0x900B,
SAMPLER_CUBE_MAP_ARRAY =                  0x900C,
SAMPLER_CUBE_MAP_ARRAY_SHADOW =           0x900D,
INT_SAMPLER_CUBE_MAP_ARRAY =              0x900E,
UNSIGNED_INT_SAMPLER_CUBE_MAP_ARRAY =     0x900F,
-- Reuse tokens from ARB_texture_query_lod (none)
-- Reuse tokens from ARB_draw_buffers_blend (none)
-- Reuse tokens from ARB_draw_indirect
-- reuse GL_DRAW_INDIRECT_BUFFER
-- reuse GL_DRAW_INDIRECT_BUFFER_BINDING
-- Reuse tokens from ARB_gpu_shader5
-- reuse GL_GEOMETRY_SHADER_INVOCATIONS
-- reuse GL_MAX_GEOMETRY_SHADER_INVOCATIONS
-- reuse GL_MIN_FRAGMENT_INTERPOLATION_OFFSET
-- reuse GL_MAX_FRAGMENT_INTERPOLATION_OFFSET
-- reuse GL_FRAGMENT_INTERPOLATION_OFFSET_BITS
-- reuse GL_MAX_VERTEX_STREAMS
-- Reuse tokens from ARB_gpu_shader_fp64
-- reuse GL_DOUBLE_VEC2
-- reuse GL_DOUBLE_VEC3
-- reuse GL_DOUBLE_VEC4
-- reuse GL_DOUBLE_MAT2
-- reuse GL_DOUBLE_MAT3
-- reuse GL_DOUBLE_MAT4
-- reuse GL_DOUBLE_MAT2x3
-- reuse GL_DOUBLE_MAT2x4
-- reuse GL_DOUBLE_MAT3x2
-- reuse GL_DOUBLE_MAT3x4
-- reuse GL_DOUBLE_MAT4x2
-- reuse GL_DOUBLE_MAT4x3
-- Reuse tokens from ARB_shader_subroutine
-- reuse GL_ACTIVE_SUBROUTINES
-- reuse GL_ACTIVE_SUBROUTINE_UNIFORMS
-- reuse GL_ACTIVE_SUBROUTINE_UNIFORM_LOCATIONS
-- reuse GL_ACTIVE_SUBROUTINE_MAX_LENGTH
-- reuse GL_ACTIVE_SUBROUTINE_UNIFORM_MAX_LENGTH
-- reuse GL_MAX_SUBROUTINES
-- reuse GL_MAX_SUBROUTINE_UNIFORM_LOCATIONS
-- reuse GL_NUM_COMPATIBLE_SUBROUTINES
-- reuse GL_COMPATIBLE_SUBROUTINES
-- Reuse tokens from ARB_tessellation_shader
-- reuse GL_PATCHES
-- reuse GL_PATCH_VERTICES
-- reuse GL_PATCH_DEFAULT_INNER_LEVEL
-- reuse GL_PATCH_DEFAULT_OUTER_LEVEL
-- reuse GL_TESS_CONTROL_OUTPUT_VERTICES
-- reuse GL_TESS_GEN_MODE
-- reuse GL_TESS_GEN_SPACING
-- reuse GL_TESS_GEN_VERTEX_ORDER
-- reuse GL_TESS_GEN_POINT_MODE
-- reuse GL_ISOLINES
-- reuse GL_FRACTIONAL_ODD
-- reuse GL_FRACTIONAL_EVEN
-- reuse GL_MAX_PATCH_VERTICES
-- reuse GL_MAX_TESS_GEN_LEVEL
-- reuse GL_MAX_TESS_CONTROL_UNIFORM_COMPONENTS
-- reuse GL_MAX_TESS_EVALUATION_UNIFORM_COMPONENTS
-- reuse GL_MAX_TESS_CONTROL_TEXTURE_IMAGE_UNITS
-- reuse GL_MAX_TESS_EVALUATION_TEXTURE_IMAGE_UNITS
-- reuse GL_MAX_TESS_CONTROL_OUTPUT_COMPONENTS
-- reuse GL_MAX_TESS_PATCH_COMPONENTS
-- reuse GL_MAX_TESS_CONTROL_TOTAL_OUTPUT_COMPONENTS
-- reuse GL_MAX_TESS_EVALUATION_OUTPUT_COMPONENTS
-- reuse GL_MAX_TESS_CONTROL_UNIFORM_BLOCKS
-- reuse GL_MAX_TESS_EVALUATION_UNIFORM_BLOCKS
-- reuse GL_MAX_TESS_CONTROL_INPUT_COMPONENTS
-- reuse GL_MAX_TESS_EVALUATION_INPUT_COMPONENTS
-- reuse GL_MAX_COMBINED_TESS_CONTROL_UNIFORM_COMPONENTS
-- reuse GL_MAX_COMBINED_TESS_EVALUATION_UNIFORM_COMPONENTS
-- reuse GL_UNIFORM_BLOCK_REFERENCED_BY_TESS_CONTROL_SHADER
-- reuse GL_UNIFORM_BLOCK_REFERENCED_BY_TESS_EVALUATION_SHADER
-- reuse GL_TESS_EVALUATION_SHADER
-- reuse GL_TESS_CONTROL_SHADER
-- Reuse tokens from ARB_texture_buffer_object_rgb32 (none)
-- Reuse tokens from ARB_transform_feedback2
-- reuse GL_TRANSFORM_FEEDBACK
-- reuse GL_TRANSFORM_FEEDBACK_BUFFER_PAUSED
-- reuse GL_TRANSFORM_FEEDBACK_BUFFER_ACTIVE
-- reuse GL_TRANSFORM_FEEDBACK_BINDING
-- Reuse tokens from ARB_transform_feedback3
-- reuse GL_MAX_TRANSFORM_FEEDBACK_BUFFERS
-- reuse GL_MAX_VERTEX_STREAMS

-- GL_VERSION_4_1
-- Reuse tokens from ARB_ES2_compatibility
-- reuse GL_FIXED
-- reuse GL_IMPLEMENTATION_COLOR_READ_TYPE
-- reuse GL_IMPLEMENTATION_COLOR_READ_FORMAT
-- reuse GL_LOW_FLOAT
-- reuse GL_MEDIUM_FLOAT
-- reuse GL_HIGH_FLOAT
-- reuse GL_LOW_INT
-- reuse GL_MEDIUM_INT
-- reuse GL_HIGH_INT
-- reuse GL_SHADER_COMPILER
-- reuse GL_SHADER_BINARY_FORMATS
-- reuse GL_NUM_SHADER_BINARY_FORMATS
-- reuse GL_MAX_VERTEX_UNIFORM_VECTORS
-- reuse GL_MAX_VARYING_VECTORS
-- reuse GL_MAX_FRAGMENT_UNIFORM_VECTORS
-- reuse GL_RGB565
-- Reuse tokens from ARB_get_program_binary
-- reuse GL_PROGRAM_BINARY_RETRIEVABLE_HINT
-- reuse GL_PROGRAM_BINARY_LENGTH
-- reuse GL_NUM_PROGRAM_BINARY_FORMATS
-- reuse GL_PROGRAM_BINARY_FORMATS
-- Reuse tokens from ARB_separate_shader_objects
-- reuse GL_VERTEX_SHADER_BIT
-- reuse GL_FRAGMENT_SHADER_BIT
-- reuse GL_GEOMETRY_SHADER_BIT
-- reuse GL_TESS_CONTROL_SHADER_BIT
-- reuse GL_TESS_EVALUATION_SHADER_BIT
-- reuse GL_ALL_SHADER_BITS
-- reuse GL_PROGRAM_SEPARABLE
-- reuse GL_ACTIVE_PROGRAM
-- reuse GL_PROGRAM_PIPELINE_BINDING
-- Reuse tokens from ARB_shader_precision (none)
-- Reuse tokens from ARB_vertex_attrib_64bit - all are in GL 3.0 and 4.0 already
-- Reuse tokens from ARB_viewport_array - some are in GL 1.1 and ARB_provoking_vertex already
-- reuse GL_MAX_VIEWPORTS
-- reuse GL_VIEWPORT_SUBPIXEL_BITS
-- reuse GL_VIEWPORT_BOUNDS_RANGE
-- reuse GL_LAYER_PROVOKING_VERTEX
-- reuse GL_VIEWPORT_INDEX_PROVOKING_VERTEX
-- reuse GL_UNDEFINED_VERTEX

-- GL_VERSION_4_2
-- Reuse tokens from ARB_base_instance (none)
-- Reuse tokens from ARB_shading_language_420pack (none)
-- Reuse tokens from ARB_transform_feedback_instanced (none)
-- Reuse tokens from ARB_compressed_texture_pixel_storage
-- reuse GL_UNPACK_COMPRESSED_BLOCK_WIDTH
-- reuse GL_UNPACK_COMPRESSED_BLOCK_HEIGHT
-- reuse GL_UNPACK_COMPRESSED_BLOCK_DEPTH
-- reuse GL_UNPACK_COMPRESSED_BLOCK_SIZE
-- reuse GL_PACK_COMPRESSED_BLOCK_WIDTH
-- reuse GL_PACK_COMPRESSED_BLOCK_HEIGHT
-- reuse GL_PACK_COMPRESSED_BLOCK_DEPTH
-- reuse GL_PACK_COMPRESSED_BLOCK_SIZE
-- Reuse tokens from ARB_conservative_depth (none)
-- Reuse tokens from ARB_internalformat_query
-- reuse GL_NUM_SAMPLE_COUNTS
-- Reuse tokens from ARB_map_buffer_alignment
-- reuse GL_MIN_MAP_BUFFER_ALIGNMENT
-- Reuse tokens from ARB_shader_atomic_counters
-- reuse GL_ATOMIC_COUNTER_BUFFER
-- reuse GL_ATOMIC_COUNTER_BUFFER_BINDING
-- reuse GL_ATOMIC_COUNTER_BUFFER_START
-- reuse GL_ATOMIC_COUNTER_BUFFER_SIZE
-- reuse GL_ATOMIC_COUNTER_BUFFER_DATA_SIZE
-- reuse GL_ATOMIC_COUNTER_BUFFER_ACTIVE_ATOMIC_COUNTERS
-- reuse GL_ATOMIC_COUNTER_BUFFER_ACTIVE_ATOMIC_COUNTER_INDICES
-- reuse GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_VERTEX_SHADER
-- reuse GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_TESS_CONTROL_SHADER
-- reuse GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_TESS_EVALUATION_SHADER
-- reuse GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_GEOMETRY_SHADER
-- reuse GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_FRAGMENT_SHADER
-- reuse GL_MAX_VERTEX_ATOMIC_COUNTER_BUFFERS
-- reuse GL_MAX_TESS_CONTROL_ATOMIC_COUNTER_BUFFERS
-- reuse GL_MAX_TESS_EVALUATION_ATOMIC_COUNTER_BUFFERS
-- reuse GL_MAX_GEOMETRY_ATOMIC_COUNTER_BUFFERS
-- reuse GL_MAX_FRAGMENT_ATOMIC_COUNTER_BUFFERS
-- reuse GL_MAX_COMBINED_ATOMIC_COUNTER_BUFFERS
-- reuse GL_MAX_VERTEX_ATOMIC_COUNTERS
-- reuse GL_MAX_TESS_CONTROL_ATOMIC_COUNTERS
-- reuse GL_MAX_TESS_EVALUATION_ATOMIC_COUNTERS
-- reuse GL_MAX_GEOMETRY_ATOMIC_COUNTERS
-- reuse GL_MAX_FRAGMENT_ATOMIC_COUNTERS
-- reuse GL_MAX_COMBINED_ATOMIC_COUNTERS
-- reuse GL_MAX_ATOMIC_COUNTER_BUFFER_SIZE
-- reuse GL_MAX_ATOMIC_COUNTER_BUFFER_BINDINGS
-- reuse GL_ACTIVE_ATOMIC_COUNTER_BUFFERS
-- reuse GL_UNIFORM_ATOMIC_COUNTER_BUFFER_INDEX
-- reuse GL_UNSIGNED_INT_ATOMIC_COUNTER
-- Reuse tokens from ARB_shader_image_load_store
-- reuse GL_VERTEX_ATTRIB_ARRAY_BARRIER_BIT
-- reuse GL_ELEMENT_ARRAY_BARRIER_BIT
-- reuse GL_UNIFORM_BARRIER_BIT
-- reuse GL_TEXTURE_FETCH_BARRIER_BIT
-- reuse GL_SHADER_IMAGE_ACCESS_BARRIER_BIT
-- reuse GL_COMMAND_BARRIER_BIT
-- reuse GL_PIXEL_BUFFER_BARRIER_BIT
-- reuse GL_TEXTURE_UPDATE_BARRIER_BIT
-- reuse GL_BUFFER_UPDATE_BARRIER_BIT
-- reuse GL_FRAMEBUFFER_BARRIER_BIT
-- reuse GL_TRANSFORM_FEEDBACK_BARRIER_BIT
-- reuse GL_ATOMIC_COUNTER_BARRIER_BIT
-- reuse GL_ALL_BARRIER_BITS
-- reuse GL_MAX_IMAGE_UNITS
-- reuse GL_MAX_COMBINED_IMAGE_UNITS_AND_FRAGMENT_OUTPUTS
-- reuse GL_IMAGE_BINDING_NAME
-- reuse GL_IMAGE_BINDING_LEVEL
-- reuse GL_IMAGE_BINDING_LAYERED
-- reuse GL_IMAGE_BINDING_LAYER
-- reuse GL_IMAGE_BINDING_ACCESS
-- reuse GL_IMAGE_1D
-- reuse GL_IMAGE_2D
-- reuse GL_IMAGE_3D
-- reuse GL_IMAGE_2D_RECT
-- reuse GL_IMAGE_CUBE
-- reuse GL_IMAGE_BUFFER
-- reuse GL_IMAGE_1D_ARRAY
-- reuse GL_IMAGE_2D_ARRAY
-- reuse GL_IMAGE_CUBE_MAP_ARRAY
-- reuse GL_IMAGE_2D_MULTISAMPLE
-- reuse GL_IMAGE_2D_MULTISAMPLE_ARRAY
-- reuse GL_INT_IMAGE_1D
-- reuse GL_INT_IMAGE_2D
-- reuse GL_INT_IMAGE_3D
-- reuse GL_INT_IMAGE_2D_RECT
-- reuse GL_INT_IMAGE_CUBE
-- reuse GL_INT_IMAGE_BUFFER
-- reuse GL_INT_IMAGE_1D_ARRAY
-- reuse GL_INT_IMAGE_2D_ARRAY
-- reuse GL_INT_IMAGE_CUBE_MAP_ARRAY
-- reuse GL_INT_IMAGE_2D_MULTISAMPLE
-- reuse GL_INT_IMAGE_2D_MULTISAMPLE_ARRAY
-- reuse GL_UNSIGNED_INT_IMAGE_1D
-- reuse GL_UNSIGNED_INT_IMAGE_2D
-- reuse GL_UNSIGNED_INT_IMAGE_3D
-- reuse GL_UNSIGNED_INT_IMAGE_2D_RECT
-- reuse GL_UNSIGNED_INT_IMAGE_CUBE
-- reuse GL_UNSIGNED_INT_IMAGE_BUFFER
-- reuse GL_UNSIGNED_INT_IMAGE_1D_ARRAY
-- reuse GL_UNSIGNED_INT_IMAGE_2D_ARRAY
-- reuse GL_UNSIGNED_INT_IMAGE_CUBE_MAP_ARRAY
-- reuse GL_UNSIGNED_INT_IMAGE_2D_MULTISAMPLE
-- reuse GL_UNSIGNED_INT_IMAGE_2D_MULTISAMPLE_ARRAY
-- reuse GL_MAX_IMAGE_SAMPLES
-- reuse GL_IMAGE_BINDING_FORMAT
-- reuse GL_IMAGE_FORMAT_COMPATIBILITY_TYPE
-- reuse GL_IMAGE_FORMAT_COMPATIBILITY_BY_SIZE
-- reuse GL_IMAGE_FORMAT_COMPATIBILITY_BY_CLASS
-- reuse GL_MAX_VERTEX_IMAGE_UNIFORMS
-- reuse GL_MAX_TESS_CONTROL_IMAGE_UNIFORMS
-- reuse GL_MAX_TESS_EVALUATION_IMAGE_UNIFORMS
-- reuse GL_MAX_GEOMETRY_IMAGE_UNIFORMS
-- reuse GL_MAX_FRAGMENT_IMAGE_UNIFORMS
-- reuse GL_MAX_COMBINED_IMAGE_UNIFORMS
-- Reuse tokens from ARB_shading_language_packing (none)
-- Reuse tokens from ARB_texture_storage
-- reuse GL_TEXTURE_IMMUTABLE_FORMAT

-- GL_VERSION_4_3
NUM_SHADING_LANGUAGE_VERSIONS =           0x82E9,
VERTEX_ATTRIB_ARRAY_LONG =                0x874E,
-- Reuse tokens from ARB_arrays_of_arrays (none, GLSL only)
-- Reuse tokens from ARB_fragment_layer_viewport (none, GLSL only)
-- Reuse tokens from ARB_shader_image_size (none, GLSL only)
-- Reuse tokens from ARB_ES3_compatibility
-- reuse GL_COMPRESSED_RGB8_ETC2
-- reuse GL_COMPRESSED_SRGB8_ETC2
-- reuse GL_COMPRESSED_RGB8_PUNCHTHROUGH_ALPHA1_ETC2
-- reuse GL_COMPRESSED_SRGB8_PUNCHTHROUGH_ALPHA1_ETC2
-- reuse GL_COMPRESSED_RGBA8_ETC2_EAC
-- reuse GL_COMPRESSED_SRGB8_ALPHA8_ETC2_EAC
-- reuse GL_COMPRESSED_R11_EAC
-- reuse GL_COMPRESSED_SIGNED_R11_EAC
-- reuse GL_COMPRESSED_RG11_EAC
-- reuse GL_COMPRESSED_SIGNED_RG11_EAC
-- reuse GL_PRIMITIVE_RESTART_FIXED_INDEX
-- reuse GL_ANY_SAMPLES_PASSED_CONSERVATIVE
-- reuse GL_MAX_ELEMENT_INDEX
-- Reuse tokens from ARB_clear_buffer_object (none)
-- Reuse tokens from ARB_compute_shader
-- reuse GL_COMPUTE_SHADER
-- reuse GL_MAX_COMPUTE_UNIFORM_BLOCKS
-- reuse GL_MAX_COMPUTE_TEXTURE_IMAGE_UNITS
-- reuse GL_MAX_COMPUTE_IMAGE_UNIFORMS
-- reuse GL_MAX_COMPUTE_SHARED_MEMORY_SIZE
-- reuse GL_MAX_COMPUTE_UNIFORM_COMPONENTS
-- reuse GL_MAX_COMPUTE_ATOMIC_COUNTER_BUFFERS
-- reuse GL_MAX_COMPUTE_ATOMIC_COUNTERS
-- reuse GL_MAX_COMBINED_COMPUTE_UNIFORM_COMPONENTS
-- reuse GL_MAX_COMPUTE_LOCAL_INVOCATIONS
-- reuse GL_MAX_COMPUTE_WORK_GROUP_COUNT
-- reuse GL_MAX_COMPUTE_WORK_GROUP_SIZE
-- reuse GL_COMPUTE_LOCAL_WORK_SIZE
-- reuse GL_UNIFORM_BLOCK_REFERENCED_BY_COMPUTE_SHADER
-- reuse GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_COMPUTE_SHADER
-- reuse GL_DISPATCH_INDIRECT_BUFFER
-- reuse GL_DISPATCH_INDIRECT_BUFFER_BINDING
-- Reuse tokens from ARB_copy_image (none)
-- Reuse tokens from KHR_debug
-- reuse GL_DEBUG_OUTPUT_SYNCHRONOUS
-- reuse GL_DEBUG_NEXT_LOGGED_MESSAGE_LENGTH
-- reuse GL_DEBUG_CALLBACK_FUNCTION
-- reuse GL_DEBUG_CALLBACK_USER_PARAM
-- reuse GL_DEBUG_SOURCE_API
-- reuse GL_DEBUG_SOURCE_WINDOW_SYSTEM
-- reuse GL_DEBUG_SOURCE_SHADER_COMPILER
-- reuse GL_DEBUG_SOURCE_THIRD_PARTY
-- reuse GL_DEBUG_SOURCE_APPLICATION
-- reuse GL_DEBUG_SOURCE_OTHER
-- reuse GL_DEBUG_TYPE_ERROR
-- reuse GL_DEBUG_TYPE_DEPRECATED_BEHAVIOR
-- reuse GL_DEBUG_TYPE_UNDEFINED_BEHAVIOR
-- reuse GL_DEBUG_TYPE_PORTABILITY
-- reuse GL_DEBUG_TYPE_PERFORMANCE
-- reuse GL_DEBUG_TYPE_OTHER
-- reuse GL_MAX_DEBUG_MESSAGE_LENGTH
-- reuse GL_MAX_DEBUG_LOGGED_MESSAGES
-- reuse GL_DEBUG_LOGGED_MESSAGES
-- reuse GL_DEBUG_SEVERITY_HIGH
-- reuse GL_DEBUG_SEVERITY_MEDIUM
-- reuse GL_DEBUG_SEVERITY_LOW
-- reuse GL_DEBUG_TYPE_MARKER
-- reuse GL_DEBUG_TYPE_PUSH_GROUP
-- reuse GL_DEBUG_TYPE_POP_GROUP
-- reuse GL_DEBUG_SEVERITY_NOTIFICATION
-- reuse GL_MAX_DEBUG_GROUP_STACK_DEPTH
-- reuse GL_DEBUG_GROUP_STACK_DEPTH
-- reuse GL_BUFFER
-- reuse GL_SHADER
-- reuse GL_PROGRAM
-- reuse GL_QUERY
-- reuse GL_PROGRAM_PIPELINE
-- reuse GL_SAMPLER
-- reuse GL_DISPLAY_LIST
-- reuse GL_MAX_LABEL_LENGTH
-- reuse GL_DEBUG_OUTPUT
-- reuse GL_CONTEXT_FLAG_DEBUG_BIT
-- reuse GL_STACK_UNDERFLOW
-- reuse GL_STACK_OVERFLOW
-- Reuse tokens from ARB_explicit_uniform_location
-- reuse GL_MAX_UNIFORM_LOCATIONS
-- Reuse tokens from ARB_framebuffer_no_attachments
-- reuse GL_FRAMEBUFFER_DEFAULT_WIDTH
-- reuse GL_FRAMEBUFFER_DEFAULT_HEIGHT
-- reuse GL_FRAMEBUFFER_DEFAULT_LAYERS
-- reuse GL_FRAMEBUFFER_DEFAULT_SAMPLES
-- reuse GL_FRAMEBUFFER_DEFAULT_FIXED_SAMPLE_LOCATIONS
-- reuse GL_MAX_FRAMEBUFFER_WIDTH
-- reuse GL_MAX_FRAMEBUFFER_HEIGHT
-- reuse GL_MAX_FRAMEBUFFER_LAYERS
-- reuse GL_MAX_FRAMEBUFFER_SAMPLES
-- Reuse tokens from ARB_internalformat_query2
-- reuse GL_INTERNALFORMAT_SUPPORTED
-- reuse GL_INTERNALFORMAT_PREFERRED
-- reuse GL_INTERNALFORMAT_RED_SIZE
-- reuse GL_INTERNALFORMAT_GREEN_SIZE
-- reuse GL_INTERNALFORMAT_BLUE_SIZE
-- reuse GL_INTERNALFORMAT_ALPHA_SIZE
-- reuse GL_INTERNALFORMAT_DEPTH_SIZE
-- reuse GL_INTERNALFORMAT_STENCIL_SIZE
-- reuse GL_INTERNALFORMAT_SHARED_SIZE
-- reuse GL_INTERNALFORMAT_RED_TYPE
-- reuse GL_INTERNALFORMAT_GREEN_TYPE
-- reuse GL_INTERNALFORMAT_BLUE_TYPE
-- reuse GL_INTERNALFORMAT_ALPHA_TYPE
-- reuse GL_INTERNALFORMAT_DEPTH_TYPE
-- reuse GL_INTERNALFORMAT_STENCIL_TYPE
-- reuse GL_MAX_WIDTH
-- reuse GL_MAX_HEIGHT
-- reuse GL_MAX_DEPTH
-- reuse GL_MAX_LAYERS
-- reuse GL_MAX_COMBINED_DIMENSIONS
-- reuse GL_COLOR_COMPONENTS
-- reuse GL_DEPTH_COMPONENTS
-- reuse GL_STENCIL_COMPONENTS
-- reuse GL_COLOR_RENDERABLE
-- reuse GL_DEPTH_RENDERABLE
-- reuse GL_STENCIL_RENDERABLE
-- reuse GL_FRAMEBUFFER_RENDERABLE
-- reuse GL_FRAMEBUFFER_RENDERABLE_LAYERED
-- reuse GL_FRAMEBUFFER_BLEND
-- reuse GL_READ_PIXELS
-- reuse GL_READ_PIXELS_FORMAT
-- reuse GL_READ_PIXELS_TYPE
-- reuse GL_TEXTURE_IMAGE_FORMAT
-- reuse GL_TEXTURE_IMAGE_TYPE
-- reuse GL_GET_TEXTURE_IMAGE_FORMAT
-- reuse GL_GET_TEXTURE_IMAGE_TYPE
-- reuse GL_MIPMAP
-- reuse GL_MANUAL_GENERATE_MIPMAP
-- reuse GL_AUTO_GENERATE_MIPMAP
-- reuse GL_COLOR_ENCODING
-- reuse GL_SRGB_READ
-- reuse GL_SRGB_WRITE
-- reuse GL_FILTER
-- reuse GL_VERTEX_TEXTURE
-- reuse GL_TESS_CONTROL_TEXTURE
-- reuse GL_TESS_EVALUATION_TEXTURE
-- reuse GL_GEOMETRY_TEXTURE
-- reuse GL_FRAGMENT_TEXTURE
-- reuse GL_COMPUTE_TEXTURE
-- reuse GL_TEXTURE_SHADOW
-- reuse GL_TEXTURE_GATHER
-- reuse GL_TEXTURE_GATHER_SHADOW
-- reuse GL_SHADER_IMAGE_LOAD
-- reuse GL_SHADER_IMAGE_STORE
-- reuse GL_SHADER_IMAGE_ATOMIC
-- reuse GL_IMAGE_TEXEL_SIZE
-- reuse GL_IMAGE_COMPATIBILITY_CLASS
-- reuse GL_IMAGE_PIXEL_FORMAT
-- reuse GL_IMAGE_PIXEL_TYPE
-- reuse GL_SIMULTANEOUS_TEXTURE_AND_DEPTH_TEST
-- reuse GL_SIMULTANEOUS_TEXTURE_AND_STENCIL_TEST
-- reuse GL_SIMULTANEOUS_TEXTURE_AND_DEPTH_WRITE
-- reuse GL_SIMULTANEOUS_TEXTURE_AND_STENCIL_WRITE
-- reuse GL_TEXTURE_COMPRESSED_BLOCK_WIDTH
-- reuse GL_TEXTURE_COMPRESSED_BLOCK_HEIGHT
-- reuse GL_TEXTURE_COMPRESSED_BLOCK_SIZE
-- reuse GL_CLEAR_BUFFER
-- reuse GL_TEXTURE_VIEW
-- reuse GL_VIEW_COMPATIBILITY_CLASS
-- reuse GL_FULL_SUPPORT
-- reuse GL_CAVEAT_SUPPORT
-- reuse GL_IMAGE_CLASS_4_X_32
-- reuse GL_IMAGE_CLASS_2_X_32
-- reuse GL_IMAGE_CLASS_1_X_32
-- reuse GL_IMAGE_CLASS_4_X_16
-- reuse GL_IMAGE_CLASS_2_X_16
-- reuse GL_IMAGE_CLASS_1_X_16
-- reuse GL_IMAGE_CLASS_4_X_8
-- reuse GL_IMAGE_CLASS_2_X_8
-- reuse GL_IMAGE_CLASS_1_X_8
-- reuse GL_IMAGE_CLASS_11_11_10
-- reuse GL_IMAGE_CLASS_10_10_10_2
-- reuse GL_VIEW_CLASS_128_BITS
-- reuse GL_VIEW_CLASS_96_BITS
-- reuse GL_VIEW_CLASS_64_BITS
-- reuse GL_VIEW_CLASS_48_BITS
-- reuse GL_VIEW_CLASS_32_BITS
-- reuse GL_VIEW_CLASS_24_BITS
-- reuse GL_VIEW_CLASS_16_BITS
-- reuse GL_VIEW_CLASS_8_BITS
-- reuse GL_VIEW_CLASS_S3TC_DXT1_RGB
-- reuse GL_VIEW_CLASS_S3TC_DXT1_RGBA
-- reuse GL_VIEW_CLASS_S3TC_DXT3_RGBA
-- reuse GL_VIEW_CLASS_S3TC_DXT5_RGBA
-- reuse GL_VIEW_CLASS_RGTC1_RED
-- reuse GL_VIEW_CLASS_RGTC2_RG
-- reuse GL_VIEW_CLASS_BPTC_UNORM
-- reuse GL_VIEW_CLASS_BPTC_FLOAT
-- Reuse tokens from ARB_invalidate_subdata (none)
-- Reuse tokens from ARB_multi_draw_indirect (none)
-- Reuse tokens from ARB_program_interface_query
-- reuse GL_UNIFORM
-- reuse GL_UNIFORM_BLOCK
-- reuse GL_PROGRAM_INPUT
-- reuse GL_PROGRAM_OUTPUT
-- reuse GL_BUFFER_VARIABLE
-- reuse GL_SHADER_STORAGE_BLOCK
-- reuse GL_VERTEX_SUBROUTINE
-- reuse GL_TESS_CONTROL_SUBROUTINE
-- reuse GL_TESS_EVALUATION_SUBROUTINE
-- reuse GL_GEOMETRY_SUBROUTINE
-- reuse GL_FRAGMENT_SUBROUTINE
-- reuse GL_COMPUTE_SUBROUTINE
-- reuse GL_VERTEX_SUBROUTINE_UNIFORM
-- reuse GL_TESS_CONTROL_SUBROUTINE_UNIFORM
-- reuse GL_TESS_EVALUATION_SUBROUTINE_UNIFORM
-- reuse GL_GEOMETRY_SUBROUTINE_UNIFORM
-- reuse GL_FRAGMENT_SUBROUTINE_UNIFORM
-- reuse GL_COMPUTE_SUBROUTINE_UNIFORM
-- reuse GL_TRANSFORM_FEEDBACK_VARYING
-- reuse GL_ACTIVE_RESOURCES
-- reuse GL_MAX_NAME_LENGTH
-- reuse GL_MAX_NUM_ACTIVE_VARIABLES
-- reuse GL_MAX_NUM_COMPATIBLE_SUBROUTINES
-- reuse GL_NAME_LENGTH
-- reuse GL_TYPE
-- reuse GL_ARRAY_SIZE
-- reuse GL_OFFSET
-- reuse GL_BLOCK_INDEX
-- reuse GL_ARRAY_STRIDE
-- reuse GL_MATRIX_STRIDE
-- reuse GL_IS_ROW_MAJOR
-- reuse GL_ATOMIC_COUNTER_BUFFER_INDEX
-- reuse GL_BUFFER_BINDING
-- reuse GL_BUFFER_DATA_SIZE
-- reuse GL_NUM_ACTIVE_VARIABLES
-- reuse GL_ACTIVE_VARIABLES
-- reuse GL_REFERENCED_BY_VERTEX_SHADER
-- reuse GL_REFERENCED_BY_TESS_CONTROL_SHADER
-- reuse GL_REFERENCED_BY_TESS_EVALUATION_SHADER
-- reuse GL_REFERENCED_BY_GEOMETRY_SHADER
-- reuse GL_REFERENCED_BY_FRAGMENT_SHADER
-- reuse GL_REFERENCED_BY_COMPUTE_SHADER
-- reuse GL_TOP_LEVEL_ARRAY_SIZE
-- reuse GL_TOP_LEVEL_ARRAY_STRIDE
-- reuse GL_LOCATION
-- reuse GL_LOCATION_INDEX
-- reuse GL_IS_PER_PATCH
-- Reuse tokens from ARB_robust_buffer_access_behavior (none)
-- Reuse tokens from ARB_shader_storage_buffer_object
-- reuse GL_SHADER_STORAGE_BUFFER
-- reuse GL_SHADER_STORAGE_BUFFER_BINDING
-- reuse GL_SHADER_STORAGE_BUFFER_START
-- reuse GL_SHADER_STORAGE_BUFFER_SIZE
-- reuse GL_MAX_VERTEX_SHADER_STORAGE_BLOCKS
-- reuse GL_MAX_GEOMETRY_SHADER_STORAGE_BLOCKS
-- reuse GL_MAX_TESS_CONTROL_SHADER_STORAGE_BLOCKS
-- reuse GL_MAX_TESS_EVALUATION_SHADER_STORAGE_BLOCKS
-- reuse GL_MAX_FRAGMENT_SHADER_STORAGE_BLOCKS
-- reuse GL_MAX_COMPUTE_SHADER_STORAGE_BLOCKS
-- reuse GL_MAX_COMBINED_SHADER_STORAGE_BLOCKS
-- reuse GL_MAX_SHADER_STORAGE_BUFFER_BINDINGS
-- reuse GL_MAX_SHADER_STORAGE_BLOCK_SIZE
-- reuse GL_SHADER_STORAGE_BUFFER_OFFSET_ALIGNMENT
-- reuse GL_SHADER_STORAGE_BARRIER_BIT
-- reuse GL_MAX_COMBINED_SHADER_OUTPUT_RESOURCES
-- Reuse tokens from ARB_stencil_texturing
-- reuse GL_DEPTH_STENCIL_TEXTURE_MODE
-- Reuse tokens from ARB_texture_buffer_range
-- reuse GL_TEXTURE_BUFFER_OFFSET
-- reuse GL_TEXTURE_BUFFER_SIZE
-- reuse GL_TEXTURE_BUFFER_OFFSET_ALIGNMENT
-- Reuse tokens from ARB_texture_query_levels (none)
-- Reuse tokens from ARB_texture_storage_multisample (none)
-- Reuse tokens from ARB_texture_view
-- reuse GL_TEXTURE_VIEW_MIN_LEVEL
-- reuse GL_TEXTURE_VIEW_NUM_LEVELS
-- reuse GL_TEXTURE_VIEW_MIN_LAYER
-- reuse GL_TEXTURE_VIEW_NUM_LAYERS
-- reuse GL_TEXTURE_IMMUTABLE_LEVELS
-- Reuse tokens from ARB_vertex_attrib_binding
-- reuse GL_VERTEX_ATTRIB_BINDING
-- reuse GL_VERTEX_ATTRIB_RELATIVE_OFFSET
-- reuse GL_VERTEX_BINDING_DIVISOR
-- reuse GL_VERTEX_BINDING_OFFSET
-- reuse GL_VERTEX_BINDING_STRIDE
-- reuse GL_MAX_VERTEX_ATTRIB_RELATIVE_OFFSET
-- reuse GL_MAX_VERTEX_ATTRIB_BINDINGS

-- GL_ARB_depth_buffer_float
DEPTH_COMPONENT32F =                      0x8CAC,
DEPTH32F_STENCIL8 =                       0x8CAD,
FLOAT_32_UNSIGNED_INT_24_8_REV =          0x8DAD,

-- GL_ARB_framebuffer_object
INVALID_FRAMEBUFFER_OPERATION =           0x0506,
FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING =   0x8210,
FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE =   0x8211,
FRAMEBUFFER_ATTACHMENT_RED_SIZE =         0x8212,
FRAMEBUFFER_ATTACHMENT_GREEN_SIZE =       0x8213,
FRAMEBUFFER_ATTACHMENT_BLUE_SIZE =        0x8214,
FRAMEBUFFER_ATTACHMENT_ALPHA_SIZE =       0x8215,
FRAMEBUFFER_ATTACHMENT_DEPTH_SIZE =       0x8216,
FRAMEBUFFER_ATTACHMENT_STENCIL_SIZE =     0x8217,
FRAMEBUFFER_DEFAULT =                     0x8218,
FRAMEBUFFER_UNDEFINED =                   0x8219,
DEPTH_STENCIL_ATTACHMENT =                0x821A,
MAX_RENDERBUFFER_SIZE =                   0x84E8,
DEPTH_STENCIL =                           0x84F9,
UNSIGNED_INT_24_8 =                       0x84FA,
DEPTH24_STENCIL8 =                        0x88F0,
TEXTURE_STENCIL_SIZE =                    0x88F1,
TEXTURE_RED_TYPE =                        0x8C10,
TEXTURE_GREEN_TYPE =                      0x8C11,
TEXTURE_BLUE_TYPE =                       0x8C12,
TEXTURE_ALPHA_TYPE =                      0x8C13,
TEXTURE_DEPTH_TYPE =                      0x8C16,
UNSIGNED_NORMALIZED =                     0x8C17,
FRAMEBUFFER_BINDING =                     0x8CA6,
DRAW_FRAMEBUFFER_BINDING =                0x8CA6,
RENDERBUFFER_BINDING =                    0x8CA7,
READ_FRAMEBUFFER =                        0x8CA8,
DRAW_FRAMEBUFFER =                        0x8CA9,
READ_FRAMEBUFFER_BINDING =                0x8CAA,
RENDERBUFFER_SAMPLES =                    0x8CAB,
FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE =      0x8CD0,
FRAMEBUFFER_ATTACHMENT_OBJECT_NAME =      0x8CD1,
FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL =    0x8CD2,
FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE =
                                          0x8CD3,
FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER =    0x8CD4,
FRAMEBUFFER_COMPLETE =                    0x8CD5,
FRAMEBUFFER_INCOMPLETE_ATTACHMENT =       0x8CD6,
FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT =
                                          0x8CD7,
FRAMEBUFFER_INCOMPLETE_DRAW_BUFFER =      0x8CDB,
FRAMEBUFFER_INCOMPLETE_READ_BUFFER =      0x8CDC,
FRAMEBUFFER_UNSUPPORTED =                 0x8CDD,
MAX_COLOR_ATTACHMENTS =                   0x8CDF,
COLOR_ATTACHMENT0 =                       0x8CE0,
COLOR_ATTACHMENT1 =                       0x8CE1,
COLOR_ATTACHMENT2 =                       0x8CE2,
COLOR_ATTACHMENT3 =                       0x8CE3,
COLOR_ATTACHMENT4 =                       0x8CE4,
COLOR_ATTACHMENT5 =                       0x8CE5,
COLOR_ATTACHMENT6 =                       0x8CE6,
COLOR_ATTACHMENT7 =                       0x8CE7,
COLOR_ATTACHMENT8 =                       0x8CE8,
COLOR_ATTACHMENT9 =                       0x8CE9,
COLOR_ATTACHMENT10 =                      0x8CEA,
COLOR_ATTACHMENT11 =                      0x8CEB,
COLOR_ATTACHMENT12 =                      0x8CEC,
COLOR_ATTACHMENT13 =                      0x8CED,
COLOR_ATTACHMENT14 =                      0x8CEE,
COLOR_ATTACHMENT15 =                      0x8CEF,
DEPTH_ATTACHMENT =                        0x8D00,
STENCIL_ATTACHMENT =                      0x8D20,
FRAMEBUFFER =                             0x8D40,
RENDERBUFFER =                            0x8D41,
RENDERBUFFER_WIDTH =                      0x8D42,
RENDERBUFFER_HEIGHT =                     0x8D43,
RENDERBUFFER_INTERNAL_FORMAT =            0x8D44,
STENCIL_INDEX1 =                          0x8D46,
STENCIL_INDEX4 =                          0x8D47,
STENCIL_INDEX8 =                          0x8D48,
STENCIL_INDEX16 =                         0x8D49,
RENDERBUFFER_RED_SIZE =                   0x8D50,
RENDERBUFFER_GREEN_SIZE =                 0x8D51,
RENDERBUFFER_BLUE_SIZE =                  0x8D52,
RENDERBUFFER_ALPHA_SIZE =                 0x8D53,
RENDERBUFFER_DEPTH_SIZE =                 0x8D54,
RENDERBUFFER_STENCIL_SIZE =               0x8D55,
FRAMEBUFFER_INCOMPLETE_MULTISAMPLE =      0x8D56,
MAX_SAMPLES =                             0x8D57,

-- GL_ARB_framebuffer_sRGB
FRAMEBUFFER_SRGB =                        0x8DB9,

-- GL_ARB_half_float_vertex
HALF_FLOAT =                              0x140B,

-- GL_ARB_map_buffer_range
MAP_READ_BIT =                            0x0001,
MAP_WRITE_BIT =                           0x0002,
MAP_INVALIDATE_RANGE_BIT =                0x0004,
MAP_INVALIDATE_BUFFER_BIT =               0x0008,
MAP_FLUSH_EXPLICIT_BIT =                  0x0010,
MAP_UNSYNCHRONIZED_BIT =                  0x0020,

-- GL_ARB_texture_compression_rgtc
COMPRESSED_RED_RGTC1 =                    0x8DBB,
COMPRESSED_SIGNED_RED_RGTC1 =             0x8DBC,
COMPRESSED_RG_RGTC2 =                     0x8DBD,
COMPRESSED_SIGNED_RG_RGTC2 =              0x8DBE,

-- GL_ARB_texture_rg
RG =                                      0x8227,
RG_INTEGER =                              0x8228,
R8 =                                      0x8229,
R16 =                                     0x822A,
RG8 =                                     0x822B,
RG16 =                                    0x822C,
R16F =                                    0x822D,
R32F =                                    0x822E,
RG16F =                                   0x822F,
RG32F =                                   0x8230,
R8I =                                     0x8231,
R8UI =                                    0x8232,
R16I =                                    0x8233,
R16UI =                                   0x8234,
R32I =                                    0x8235,
R32UI =                                   0x8236,
RG8I =                                    0x8237,
RG8UI =                                   0x8238,
RG16I =                                   0x8239,
RG16UI =                                  0x823A,
RG32I =                                   0x823B,
RG32UI =                                  0x823C,

-- GL_ARB_vertex_array_object
VERTEX_ARRAY_BINDING =                    0x85B5,

-- GL_ARB_uniform_buffer_object
UNIFORM_BUFFER =                          0x8A11,
UNIFORM_BUFFER_BINDING =                  0x8A28,
UNIFORM_BUFFER_START =                    0x8A29,
UNIFORM_BUFFER_SIZE =                     0x8A2A,
MAX_VERTEX_UNIFORM_BLOCKS =               0x8A2B,
MAX_GEOMETRY_UNIFORM_BLOCKS =             0x8A2C,
MAX_FRAGMENT_UNIFORM_BLOCKS =             0x8A2D,
MAX_COMBINED_UNIFORM_BLOCKS =             0x8A2E,
MAX_UNIFORM_BUFFER_BINDINGS =             0x8A2F,
MAX_UNIFORM_BLOCK_SIZE =                  0x8A30,
MAX_COMBINED_VERTEX_UNIFORM_COMPONENTS =  0x8A31,
MAX_COMBINED_GEOMETRY_UNIFORM_COMPONENTS =0x8A32,
MAX_COMBINED_FRAGMENT_UNIFORM_COMPONENTS =0x8A33,
UNIFORM_BUFFER_OFFSET_ALIGNMENT =         0x8A34,
ACTIVE_UNIFORM_BLOCK_MAX_NAME_LENGTH =    0x8A35,
ACTIVE_UNIFORM_BLOCKS =                   0x8A36,
UNIFORM_TYPE =                            0x8A37,
UNIFORM_SIZE =                            0x8A38,
UNIFORM_NAME_LENGTH =                     0x8A39,
UNIFORM_BLOCK_INDEX =                     0x8A3A,
UNIFORM_OFFSET =                          0x8A3B,
UNIFORM_ARRAY_STRIDE =                    0x8A3C,
UNIFORM_MATRIX_STRIDE =                   0x8A3D,
UNIFORM_IS_ROW_MAJOR =                    0x8A3E,
UNIFORM_BLOCK_BINDING =                   0x8A3F,
UNIFORM_BLOCK_DATA_SIZE =                 0x8A40,
UNIFORM_BLOCK_NAME_LENGTH =               0x8A41,
UNIFORM_BLOCK_ACTIVE_UNIFORMS =           0x8A42,
UNIFORM_BLOCK_ACTIVE_UNIFORM_INDICES =    0x8A43,
UNIFORM_BLOCK_REFERENCED_BY_VERTEX_SHADER =
                                          0x8A44,
UNIFORM_BLOCK_REFERENCED_BY_GEOMETRY_SHADER =
                                          0x8A45,
UNIFORM_BLOCK_REFERENCED_BY_FRAGMENT_SHADER =
                                          0x8A46,
INVALID_INDEX =                           0xFFFFFFFF,

-- GL_ARB_copy_buffer
COPY_READ_BUFFER_BINDING =                0x8F36,
COPY_READ_BUFFER =                        0x8F36,
COPY_WRITE_BUFFER_BINDING =               0x8F37,
COPY_WRITE_BUFFER =                       0x8F37,

-- GL_ARB_depth_clamp
DEPTH_CLAMP =                             0x864F,

-- GL_ARB_draw_elements_base_vertex

-- GL_ARB_fragment_coord_conventions

-- GL_ARB_provoking_vertex
QUADS_FOLLOW_PROVOKING_VERTEX_CONVENTION =0x8E4C,
FIRST_VERTEX_CONVENTION =                 0x8E4D,
LAST_VERTEX_CONVENTION =                  0x8E4E,
PROVOKING_VERTEX =                        0x8E4F,

-- GL_ARB_seamless_cube_map
TEXTURE_CUBE_MAP_SEAMLESS =               0x884F,

-- GL_ARB_sync
MAX_SERVER_WAIT_TIMEOUT =                 0x9111,
OBJECT_TYPE =                             0x9112,
SYNC_CONDITION =                          0x9113,
SYNC_STATUS =                             0x9114,
SYNC_FLAGS =                              0x9115,
SYNC_FENCE =                              0x9116,
SYNC_GPU_COMMANDS_COMPLETE =              0x9117,
UNSIGNALED =                              0x9118,
SIGNALED =                                0x9119,
ALREADY_SIGNALED =                        0x911A,
TIMEOUT_EXPIRED =                         0x911B,
CONDITION_SATISFIED =                     0x911C,
WAIT_FAILED =                             0x911D,
SYNC_FLUSH_COMMANDS_BIT =                 0x00000001,
TIMEOUT_IGNORED =                         0xFFFFFFFFFFFFFFFF,

-- GL_ARB_texture_multisample
SAMPLE_POSITION =                         0x8E50,
SAMPLE_MASK =                             0x8E51,
SAMPLE_MASK_VALUE =                       0x8E52,
MAX_SAMPLE_MASK_WORDS =                   0x8E59,
TEXTURE_2D_MULTISAMPLE =                  0x9100,
PROXY_TEXTURE_2D_MULTISAMPLE =            0x9101,
TEXTURE_2D_MULTISAMPLE_ARRAY =            0x9102,
PROXY_TEXTURE_2D_MULTISAMPLE_ARRAY =      0x9103,
TEXTURE_BINDING_2D_MULTISAMPLE =          0x9104,
TEXTURE_BINDING_2D_MULTISAMPLE_ARRAY =    0x9105,
TEXTURE_SAMPLES =                         0x9106,
TEXTURE_FIXED_SAMPLE_LOCATIONS =          0x9107,
SAMPLER_2D_MULTISAMPLE =                  0x9108,
INT_SAMPLER_2D_MULTISAMPLE =              0x9109,
UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE =     0x910A,
SAMPLER_2D_MULTISAMPLE_ARRAY =            0x910B,
INT_SAMPLER_2D_MULTISAMPLE_ARRAY =        0x910C,
UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE_ARRAY =
                                          0x910D,
MAX_COLOR_TEXTURE_SAMPLES =               0x910E,
MAX_DEPTH_TEXTURE_SAMPLES =               0x910F,
MAX_INTEGER_SAMPLES =                     0x9110,

-- GL_ARB_vertex_array_bgra
-- reuse GL_BGRA

-- GL_ARB_draw_buffers_blend

-- GL_ARB_sample_shading
SAMPLE_SHADING_ARB =                      0x8C36,
MIN_SAMPLE_SHADING_VALUE_ARB =            0x8C37,

-- GL_ARB_texture_cube_map_array
TEXTURE_CUBE_MAP_ARRAY_ARB =              0x9009,
TEXTURE_BINDING_CUBE_MAP_ARRAY_ARB =      0x900A,
PROXY_TEXTURE_CUBE_MAP_ARRAY_ARB =        0x900B,
SAMPLER_CUBE_MAP_ARRAY_ARB =              0x900C,
SAMPLER_CUBE_MAP_ARRAY_SHADOW_ARB =       0x900D,
INT_SAMPLER_CUBE_MAP_ARRAY_ARB =          0x900E,
UNSIGNED_INT_SAMPLER_CUBE_MAP_ARRAY_ARB = 0x900F,

-- GL_ARB_texture_gather
MIN_PROGRAM_TEXTURE_GATHER_OFFSET_ARB =   0x8E5E,
MAX_PROGRAM_TEXTURE_GATHER_OFFSET_ARB =   0x8E5F,
MAX_PROGRAM_TEXTURE_GATHER_COMPONENTS_ARB =
                                          0x8F9F,

-- GL_ARB_texture_query_lod

-- GL_ARB_shading_language_include
SHADER_INCLUDE_ARB =                      0x8DAE,
NAMED_STRING_LENGTH_ARB =                 0x8DE9,
NAMED_STRING_TYPE_ARB =                   0x8DEA,

-- GL_ARB_texture_compression_bptc
COMPRESSED_RGBA_BPTC_UNORM_ARB =          0x8E8C,
COMPRESSED_SRGB_ALPHA_BPTC_UNORM_ARB =    0x8E8D,
COMPRESSED_RGB_BPTC_SIGNED_FLOAT_ARB =    0x8E8E,
COMPRESSED_RGB_BPTC_UNSIGNED_FLOAT_ARB =  0x8E8F,

-- GL_ARB_blend_func_extended
SRC1_COLOR =                              0x88F9,
-- reuse GL_SRC1_ALPHA
ONE_MINUS_SRC1_COLOR =                    0x88FA,
ONE_MINUS_SRC1_ALPHA =                    0x88FB,
MAX_DUAL_SOURCE_DRAW_BUFFERS =            0x88FC,

-- GL_ARB_explicit_attrib_location

-- GL_ARB_occlusion_query2
ANY_SAMPLES_PASSED =                      0x8C2F,

-- GL_ARB_sampler_objects
SAMPLER_BINDING =                         0x8919,

-- GL_ARB_shader_bit_encoding

-- GL_ARB_texture_rgb10_a2ui
RGB10_A2UI =                              0x906F,

-- GL_ARB_texture_swizzle
TEXTURE_SWIZZLE_R =                       0x8E42,
TEXTURE_SWIZZLE_G =                       0x8E43,
TEXTURE_SWIZZLE_B =                       0x8E44,
TEXTURE_SWIZZLE_A =                       0x8E45,
TEXTURE_SWIZZLE_RGBA =                    0x8E46,

-- GL_ARB_timer_query
TIME_ELAPSED =                            0x88BF,
TIMESTAMP =                               0x8E28,

-- GL_ARB_vertex_type_2_10_10_10_rev
-- reuse GL_UNSIGNED_INT_2_10_10_10_REV
INT_2_10_10_10_REV =                      0x8D9F,

-- GL_ARB_draw_indirect
DRAW_INDIRECT_BUFFER =                    0x8F3F,
DRAW_INDIRECT_BUFFER_BINDING =            0x8F43,

-- GL_ARB_gpu_shader5
GEOMETRY_SHADER_INVOCATIONS =             0x887F,
MAX_GEOMETRY_SHADER_INVOCATIONS =         0x8E5A,
MIN_FRAGMENT_INTERPOLATION_OFFSET =       0x8E5B,
MAX_FRAGMENT_INTERPOLATION_OFFSET =       0x8E5C,
FRAGMENT_INTERPOLATION_OFFSET_BITS =      0x8E5D,
-- reuse GL_MAX_VERTEX_STREAMS

-- GL_ARB_gpu_shader_fp64
-- reuse GL_DOUBLE
DOUBLE_VEC2 =                             0x8FFC,
DOUBLE_VEC3 =                             0x8FFD,
DOUBLE_VEC4 =                             0x8FFE,
DOUBLE_MAT2 =                             0x8F46,
DOUBLE_MAT3 =                             0x8F47,
DOUBLE_MAT4 =                             0x8F48,
DOUBLE_MAT2x3 =                           0x8F49,
DOUBLE_MAT2x4 =                           0x8F4A,
DOUBLE_MAT3x2 =                           0x8F4B,
DOUBLE_MAT3x4 =                           0x8F4C,
DOUBLE_MAT4x2 =                           0x8F4D,
DOUBLE_MAT4x3 =                           0x8F4E,

-- GL_ARB_shader_subroutine
ACTIVE_SUBROUTINES =                      0x8DE5,
ACTIVE_SUBROUTINE_UNIFORMS =              0x8DE6,
ACTIVE_SUBROUTINE_UNIFORM_LOCATIONS =     0x8E47,
ACTIVE_SUBROUTINE_MAX_LENGTH =            0x8E48,
ACTIVE_SUBROUTINE_UNIFORM_MAX_LENGTH =    0x8E49,
MAX_SUBROUTINES =                         0x8DE7,
MAX_SUBROUTINE_UNIFORM_LOCATIONS =        0x8DE8,
NUM_COMPATIBLE_SUBROUTINES =              0x8E4A,
COMPATIBLE_SUBROUTINES =                  0x8E4B,
-- reuse GL_UNIFORM_SIZE
-- reuse GL_UNIFORM_NAME_LENGTH

-- GL_ARB_tessellation_shader
PATCHES =                                 0x000E,
PATCH_VERTICES =                          0x8E72,
PATCH_DEFAULT_INNER_LEVEL =               0x8E73,
PATCH_DEFAULT_OUTER_LEVEL =               0x8E74,
TESS_CONTROL_OUTPUT_VERTICES =            0x8E75,
TESS_GEN_MODE =                           0x8E76,
TESS_GEN_SPACING =                        0x8E77,
TESS_GEN_VERTEX_ORDER =                   0x8E78,
TESS_GEN_POINT_MODE =                     0x8E79,
-- reuse GL_TRIANGLES
-- reuse GL_QUADS
ISOLINES =                                0x8E7A,
-- reuse GL_EQUAL
FRACTIONAL_ODD =                          0x8E7B,
FRACTIONAL_EVEN =                         0x8E7C,
-- reuse GL_CCW
-- reuse GL_CW
MAX_PATCH_VERTICES =                      0x8E7D,
MAX_TESS_GEN_LEVEL =                      0x8E7E,
MAX_TESS_CONTROL_UNIFORM_COMPONENTS =     0x8E7F,
MAX_TESS_EVALUATION_UNIFORM_COMPONENTS =  0x8E80,
MAX_TESS_CONTROL_TEXTURE_IMAGE_UNITS =    0x8E81,
MAX_TESS_EVALUATION_TEXTURE_IMAGE_UNITS = 0x8E82,
MAX_TESS_CONTROL_OUTPUT_COMPONENTS =      0x8E83,
MAX_TESS_PATCH_COMPONENTS =               0x8E84,
MAX_TESS_CONTROL_TOTAL_OUTPUT_COMPONENTS =0x8E85,
MAX_TESS_EVALUATION_OUTPUT_COMPONENTS =   0x8E86,
MAX_TESS_CONTROL_UNIFORM_BLOCKS =         0x8E89,
MAX_TESS_EVALUATION_UNIFORM_BLOCKS =      0x8E8A,
MAX_TESS_CONTROL_INPUT_COMPONENTS =       0x886C,
MAX_TESS_EVALUATION_INPUT_COMPONENTS =    0x886D,
MAX_COMBINED_TESS_CONTROL_UNIFORM_COMPONENTS =
                                          0x8E1E,
MAX_COMBINED_TESS_EVALUATION_UNIFORM_COMPONENTS =
                                          0x8E1F,
UNIFORM_BLOCK_REFERENCED_BY_TESS_CONTROL_SHADER =
                                          0x84F0,
UNIFORM_BLOCK_REFERENCED_BY_TESS_EVALUATION_SHADER =
                                          0x84F1,
TESS_EVALUATION_SHADER =                  0x8E87,
TESS_CONTROL_SHADER =                     0x8E88,

-- GL_ARB_texture_buffer_object_rgb32
-- reuse GL_RGB32F
-- reuse GL_RGB32UI
-- reuse GL_RGB32I

-- GL_ARB_transform_feedback2
TRANSFORM_FEEDBACK =                      0x8E22,
TRANSFORM_FEEDBACK_PAUSED =               0x8E23,
TRANSFORM_FEEDBACK_BUFFER_PAUSED =        0x8E23,
TRANSFORM_FEEDBACK_ACTIVE =               0x8E24,
TRANSFORM_FEEDBACK_BUFFER_ACTIVE =        0x8E24,
TRANSFORM_FEEDBACK_BINDING =              0x8E25,

-- GL_ARB_transform_feedback3
MAX_TRANSFORM_FEEDBACK_BUFFERS =          0x8E70,
MAX_VERTEX_STREAMS =                      0x8E71,

-- GL_ARB_ES2_compatibility
FIXED =                                   0x140C,
IMPLEMENTATION_COLOR_READ_TYPE =          0x8B9A,
IMPLEMENTATION_COLOR_READ_FORMAT =        0x8B9B,
LOW_FLOAT =                               0x8DF0,
MEDIUM_FLOAT =                            0x8DF1,
HIGH_FLOAT =                              0x8DF2,
LOW_INT =                                 0x8DF3,
MEDIUM_INT =                              0x8DF4,
HIGH_INT =                                0x8DF5,
SHADER_COMPILER =                         0x8DFA,
SHADER_BINARY_FORMATS =                   0x8DF8,
NUM_SHADER_BINARY_FORMATS =               0x8DF9,
MAX_VERTEX_UNIFORM_VECTORS =              0x8DFB,
MAX_VARYING_VECTORS =                     0x8DFC,
MAX_FRAGMENT_UNIFORM_VECTORS =            0x8DFD,
RGB565 =                                  0x8D62,

-- GL_ARB_get_program_binary
PROGRAM_BINARY_RETRIEVABLE_HINT =         0x8257,
PROGRAM_BINARY_LENGTH =                   0x8741,
NUM_PROGRAM_BINARY_FORMATS =              0x87FE,
PROGRAM_BINARY_FORMATS =                  0x87FF,

-- GL_ARB_separate_shader_objects
VERTEX_SHADER_BIT =                       0x00000001,
FRAGMENT_SHADER_BIT =                     0x00000002,
GEOMETRY_SHADER_BIT =                     0x00000004,
TESS_CONTROL_SHADER_BIT =                 0x00000008,
TESS_EVALUATION_SHADER_BIT =              0x00000010,
ALL_SHADER_BITS =                         0xFFFFFFFF,
PROGRAM_SEPARABLE =                       0x8258,
ACTIVE_PROGRAM =                          0x8259,
PROGRAM_PIPELINE_BINDING =                0x825A,

-- GL_ARB_shader_precision

-- GL_ARB_vertex_attrib_64bit
-- reuse GL_RGB32I
-- reuse GL_DOUBLE_VEC2
-- reuse GL_DOUBLE_VEC3
-- reuse GL_DOUBLE_VEC4
-- reuse GL_DOUBLE_MAT2
-- reuse GL_DOUBLE_MAT3
-- reuse GL_DOUBLE_MAT4
-- reuse GL_DOUBLE_MAT2x3
-- reuse GL_DOUBLE_MAT2x4
-- reuse GL_DOUBLE_MAT3x2
-- reuse GL_DOUBLE_MAT3x4
-- reuse GL_DOUBLE_MAT4x2
-- reuse GL_DOUBLE_MAT4x3

-- GL_ARB_viewport_array
-- reuse GL_SCISSOR_BOX
-- reuse GL_VIEWPORT
-- reuse GL_DEPTH_RANGE
-- reuse GL_SCISSOR_TEST
MAX_VIEWPORTS =                           0x825B,
VIEWPORT_SUBPIXEL_BITS =                  0x825C,
VIEWPORT_BOUNDS_RANGE =                   0x825D,
LAYER_PROVOKING_VERTEX =                  0x825E,
VIEWPORT_INDEX_PROVOKING_VERTEX =         0x825F,
UNDEFINED_VERTEX =                        0x8260,
-- reuse GL_FIRST_VERTEX_CONVENTION
-- reuse GL_LAST_VERTEX_CONVENTION
-- reuse GL_PROVOKING_VERTEX

-- GL_ARB_cl_event
SYNC_CL_EVENT_ARB =                       0x8240,
SYNC_CL_EVENT_COMPLETE_ARB =              0x8241,

-- GL_ARB_debug_output
DEBUG_OUTPUT_SYNCHRONOUS_ARB =            0x8242,
DEBUG_NEXT_LOGGED_MESSAGE_LENGTH_ARB =    0x8243,
DEBUG_CALLBACK_FUNCTION_ARB =             0x8244,
DEBUG_CALLBACK_USER_PARAM_ARB =           0x8245,
DEBUG_SOURCE_API_ARB =                    0x8246,
DEBUG_SOURCE_WINDOW_SYSTEM_ARB =          0x8247,
DEBUG_SOURCE_SHADER_COMPILER_ARB =        0x8248,
DEBUG_SOURCE_THIRD_PARTY_ARB =            0x8249,
DEBUG_SOURCE_APPLICATION_ARB =            0x824A,
DEBUG_SOURCE_OTHER_ARB =                  0x824B,
DEBUG_TYPE_ERROR_ARB =                    0x824C,
DEBUG_TYPE_DEPRECATED_BEHAVIOR_ARB =      0x824D,
DEBUG_TYPE_UNDEFINED_BEHAVIOR_ARB =       0x824E,
DEBUG_TYPE_PORTABILITY_ARB =              0x824F,
DEBUG_TYPE_PERFORMANCE_ARB =              0x8250,
DEBUG_TYPE_OTHER_ARB =                    0x8251,
MAX_DEBUG_MESSAGE_LENGTH_ARB =            0x9143,
MAX_DEBUG_LOGGED_MESSAGES_ARB =           0x9144,
DEBUG_LOGGED_MESSAGES_ARB =               0x9145,
DEBUG_SEVERITY_HIGH_ARB =                 0x9146,
DEBUG_SEVERITY_MEDIUM_ARB =               0x9147,
DEBUG_SEVERITY_LOW_ARB =                  0x9148,

-- GL_ARB_robustness
-- reuse GL_NO_ERROR
CONTEXT_FLAG_ROBUST_ACCESS_BIT_ARB =      0x00000004,
LOSE_CONTEXT_ON_RESET_ARB =               0x8252,
GUILTY_CONTEXT_RESET_ARB =                0x8253,
INNOCENT_CONTEXT_RESET_ARB =              0x8254,
UNKNOWN_CONTEXT_RESET_ARB =               0x8255,
RESET_NOTIFICATION_STRATEGY_ARB =         0x8256,
NO_RESET_NOTIFICATION_ARB =               0x8261,

-- GL_ARB_shader_stencil_export

-- GL_ARB_base_instance

-- GL_ARB_shading_language_420pack

-- GL_ARB_transform_feedback_instanced

-- GL_ARB_compressed_texture_pixel_storage
UNPACK_COMPRESSED_BLOCK_WIDTH =           0x9127,
UNPACK_COMPRESSED_BLOCK_HEIGHT =          0x9128,
UNPACK_COMPRESSED_BLOCK_DEPTH =           0x9129,
UNPACK_COMPRESSED_BLOCK_SIZE =            0x912A,
PACK_COMPRESSED_BLOCK_WIDTH =             0x912B,
PACK_COMPRESSED_BLOCK_HEIGHT =            0x912C,
PACK_COMPRESSED_BLOCK_DEPTH =             0x912D,
PACK_COMPRESSED_BLOCK_SIZE =              0x912E,

-- GL_ARB_conservative_depth

-- GL_ARB_internalformat_query
NUM_SAMPLE_COUNTS =                       0x9380,

-- GL_ARB_map_buffer_alignment
MIN_MAP_BUFFER_ALIGNMENT =                0x90BC,

-- GL_ARB_shader_atomic_counters
ATOMIC_COUNTER_BUFFER =                   0x92C0,
ATOMIC_COUNTER_BUFFER_BINDING =           0x92C1,
ATOMIC_COUNTER_BUFFER_START =             0x92C2,
ATOMIC_COUNTER_BUFFER_SIZE =              0x92C3,
ATOMIC_COUNTER_BUFFER_DATA_SIZE =         0x92C4,
ATOMIC_COUNTER_BUFFER_ACTIVE_ATOMIC_COUNTERS =
                                          0x92C5,
ATOMIC_COUNTER_BUFFER_ACTIVE_ATOMIC_COUNTER_INDICES =
                                          0x92C6,
ATOMIC_COUNTER_BUFFER_REFERENCED_BY_VERTEX_SHADER =
                                          0x92C7,
ATOMIC_COUNTER_BUFFER_REFERENCED_BY_TESS_CONTROL_SHADER =
                                          0x92C8,
ATOMIC_COUNTER_BUFFER_REFERENCED_BY_TESS_EVALUATION_SHADER =
                                          0x92C9,
ATOMIC_COUNTER_BUFFER_REFERENCED_BY_GEOMETRY_SHADER =
                                          0x92CA,
ATOMIC_COUNTER_BUFFER_REFERENCED_BY_FRAGMENT_SHADER =
                                          0x92CB,
MAX_VERTEX_ATOMIC_COUNTER_BUFFERS =       0x92CC,
MAX_TESS_CONTROL_ATOMIC_COUNTER_BUFFERS = 0x92CD,
MAX_TESS_EVALUATION_ATOMIC_COUNTER_BUFFERS =
                                          0x92CE,
MAX_GEOMETRY_ATOMIC_COUNTER_BUFFERS =     0x92CF,
MAX_FRAGMENT_ATOMIC_COUNTER_BUFFERS =     0x92D0,
MAX_COMBINED_ATOMIC_COUNTER_BUFFERS =     0x92D1,
MAX_VERTEX_ATOMIC_COUNTERS =              0x92D2,
MAX_TESS_CONTROL_ATOMIC_COUNTERS =        0x92D3,
MAX_TESS_EVALUATION_ATOMIC_COUNTERS =     0x92D4,
MAX_GEOMETRY_ATOMIC_COUNTERS =            0x92D5,
MAX_FRAGMENT_ATOMIC_COUNTERS =            0x92D6,
MAX_COMBINED_ATOMIC_COUNTERS =            0x92D7,
MAX_ATOMIC_COUNTER_BUFFER_SIZE =          0x92D8,
MAX_ATOMIC_COUNTER_BUFFER_BINDINGS =      0x92DC,
ACTIVE_ATOMIC_COUNTER_BUFFERS =           0x92D9,
UNIFORM_ATOMIC_COUNTER_BUFFER_INDEX =     0x92DA,
UNSIGNED_INT_ATOMIC_COUNTER =             0x92DB,

-- GL_ARB_shader_image_load_store
VERTEX_ATTRIB_ARRAY_BARRIER_BIT =         0x00000001,
ELEMENT_ARRAY_BARRIER_BIT =               0x00000002,
UNIFORM_BARRIER_BIT =                     0x00000004,
TEXTURE_FETCH_BARRIER_BIT =               0x00000008,
SHADER_IMAGE_ACCESS_BARRIER_BIT =         0x00000020,
COMMAND_BARRIER_BIT =                     0x00000040,
PIXEL_BUFFER_BARRIER_BIT =                0x00000080,
TEXTURE_UPDATE_BARRIER_BIT =              0x00000100,
BUFFER_UPDATE_BARRIER_BIT =               0x00000200,
FRAMEBUFFER_BARRIER_BIT =                 0x00000400,
TRANSFORM_FEEDBACK_BARRIER_BIT =          0x00000800,
ATOMIC_COUNTER_BARRIER_BIT =              0x00001000,
ALL_BARRIER_BITS =                        0xFFFFFFFF,
MAX_IMAGE_UNITS =                         0x8F38,
MAX_COMBINED_IMAGE_UNITS_AND_FRAGMENT_OUTPUTS =
                                          0x8F39,
IMAGE_BINDING_NAME =                      0x8F3A,
IMAGE_BINDING_LEVEL =                     0x8F3B,
IMAGE_BINDING_LAYERED =                   0x8F3C,
IMAGE_BINDING_LAYER =                     0x8F3D,
IMAGE_BINDING_ACCESS =                    0x8F3E,
IMAGE_1D =                                0x904C,
IMAGE_2D =                                0x904D,
IMAGE_3D =                                0x904E,
IMAGE_2D_RECT =                           0x904F,
IMAGE_CUBE =                              0x9050,
IMAGE_BUFFER =                            0x9051,
IMAGE_1D_ARRAY =                          0x9052,
IMAGE_2D_ARRAY =                          0x9053,
IMAGE_CUBE_MAP_ARRAY =                    0x9054,
IMAGE_2D_MULTISAMPLE =                    0x9055,
IMAGE_2D_MULTISAMPLE_ARRAY =              0x9056,
INT_IMAGE_1D =                            0x9057,
INT_IMAGE_2D =                            0x9058,
INT_IMAGE_3D =                            0x9059,
INT_IMAGE_2D_RECT =                       0x905A,
INT_IMAGE_CUBE =                          0x905B,
INT_IMAGE_BUFFER =                        0x905C,
INT_IMAGE_1D_ARRAY =                      0x905D,
INT_IMAGE_2D_ARRAY =                      0x905E,
INT_IMAGE_CUBE_MAP_ARRAY =                0x905F,
INT_IMAGE_2D_MULTISAMPLE =                0x9060,
INT_IMAGE_2D_MULTISAMPLE_ARRAY =          0x9061,
UNSIGNED_INT_IMAGE_1D =                   0x9062,
UNSIGNED_INT_IMAGE_2D =                   0x9063,
UNSIGNED_INT_IMAGE_3D =                   0x9064,
UNSIGNED_INT_IMAGE_2D_RECT =              0x9065,
UNSIGNED_INT_IMAGE_CUBE =                 0x9066,
UNSIGNED_INT_IMAGE_BUFFER =               0x9067,
UNSIGNED_INT_IMAGE_1D_ARRAY =             0x9068,
UNSIGNED_INT_IMAGE_2D_ARRAY =             0x9069,
UNSIGNED_INT_IMAGE_CUBE_MAP_ARRAY =       0x906A,
UNSIGNED_INT_IMAGE_2D_MULTISAMPLE =       0x906B,
UNSIGNED_INT_IMAGE_2D_MULTISAMPLE_ARRAY = 0x906C,
MAX_IMAGE_SAMPLES =                       0x906D,
IMAGE_BINDING_FORMAT =                    0x906E,
IMAGE_FORMAT_COMPATIBILITY_TYPE =         0x90C7,
IMAGE_FORMAT_COMPATIBILITY_BY_SIZE =      0x90C8,
IMAGE_FORMAT_COMPATIBILITY_BY_CLASS =     0x90C9,
MAX_VERTEX_IMAGE_UNIFORMS =               0x90CA,
MAX_TESS_CONTROL_IMAGE_UNIFORMS =         0x90CB,
MAX_TESS_EVALUATION_IMAGE_UNIFORMS =      0x90CC,
MAX_GEOMETRY_IMAGE_UNIFORMS =             0x90CD,
MAX_FRAGMENT_IMAGE_UNIFORMS =             0x90CE,
MAX_COMBINED_IMAGE_UNIFORMS =             0x90CF,

-- GL_ARB_shading_language_packing

-- GL_ARB_texture_storage
TEXTURE_IMMUTABLE_FORMAT =                0x912F,

-- GL_KHR_texture_compression_astc_ldr
COMPRESSED_RGBA_ASTC_4x4_KHR =            0x93B0,
COMPRESSED_RGBA_ASTC_5x4_KHR =            0x93B1,
COMPRESSED_RGBA_ASTC_5x5_KHR =            0x93B2,
COMPRESSED_RGBA_ASTC_6x5_KHR =            0x93B3,
COMPRESSED_RGBA_ASTC_6x6_KHR =            0x93B4,
COMPRESSED_RGBA_ASTC_8x5_KHR =            0x93B5,
COMPRESSED_RGBA_ASTC_8x6_KHR =            0x93B6,
COMPRESSED_RGBA_ASTC_8x8_KHR =            0x93B7,
COMPRESSED_RGBA_ASTC_10x5_KHR =           0x93B8,
COMPRESSED_RGBA_ASTC_10x6_KHR =           0x93B9,
COMPRESSED_RGBA_ASTC_10x8_KHR =           0x93BA,
COMPRESSED_RGBA_ASTC_10x10_KHR =          0x93BB,
COMPRESSED_RGBA_ASTC_12x10_KHR =          0x93BC,
COMPRESSED_RGBA_ASTC_12x12_KHR =          0x93BD,
COMPRESSED_SRGB8_ALPHA8_ASTC_4x4_KHR =    0x93D0,
COMPRESSED_SRGB8_ALPHA8_ASTC_5x4_KHR =    0x93D1,
COMPRESSED_SRGB8_ALPHA8_ASTC_5x5_KHR =    0x93D2,
COMPRESSED_SRGB8_ALPHA8_ASTC_6x5_KHR =    0x93D3,
COMPRESSED_SRGB8_ALPHA8_ASTC_6x6_KHR =    0x93D4,
COMPRESSED_SRGB8_ALPHA8_ASTC_8x5_KHR =    0x93D5,
COMPRESSED_SRGB8_ALPHA8_ASTC_8x6_KHR =    0x93D6,
COMPRESSED_SRGB8_ALPHA8_ASTC_8x8_KHR =    0x93D7,
COMPRESSED_SRGB8_ALPHA8_ASTC_10x5_KHR =   0x93D8,
COMPRESSED_SRGB8_ALPHA8_ASTC_10x6_KHR =   0x93D9,
COMPRESSED_SRGB8_ALPHA8_ASTC_10x8_KHR =   0x93DA,
COMPRESSED_SRGB8_ALPHA8_ASTC_10x10_KHR =  0x93DB,
COMPRESSED_SRGB8_ALPHA8_ASTC_12x10_KHR =  0x93DC,
COMPRESSED_SRGB8_ALPHA8_ASTC_12x12_KHR =  0x93DD,

-- GL_KHR_debug
DEBUG_OUTPUT_SYNCHRONOUS =                0x8242,
DEBUG_NEXT_LOGGED_MESSAGE_LENGTH =        0x8243,
DEBUG_CALLBACK_FUNCTION =                 0x8244,
DEBUG_CALLBACK_USER_PARAM =               0x8245,
DEBUG_SOURCE_API =                        0x8246,
DEBUG_SOURCE_WINDOW_SYSTEM =              0x8247,
DEBUG_SOURCE_SHADER_COMPILER =            0x8248,
DEBUG_SOURCE_THIRD_PARTY =                0x8249,
DEBUG_SOURCE_APPLICATION =                0x824A,
DEBUG_SOURCE_OTHER =                      0x824B,
DEBUG_TYPE_ERROR =                        0x824C,
DEBUG_TYPE_DEPRECATED_BEHAVIOR =          0x824D,
DEBUG_TYPE_UNDEFINED_BEHAVIOR =           0x824E,
DEBUG_TYPE_PORTABILITY =                  0x824F,
DEBUG_TYPE_PERFORMANCE =                  0x8250,
DEBUG_TYPE_OTHER =                        0x8251,
DEBUG_TYPE_MARKER =                       0x8268,
DEBUG_TYPE_PUSH_GROUP =                   0x8269,
DEBUG_TYPE_POP_GROUP =                    0x826A,
DEBUG_SEVERITY_NOTIFICATION =             0x826B,
MAX_DEBUG_GROUP_STACK_DEPTH =             0x826C,
DEBUG_GROUP_STACK_DEPTH =                 0x826D,
BUFFER =                                  0x82E0,
SHADER =                                  0x82E1,
PROGRAM =                                 0x82E2,
QUERY =                                   0x82E3,
PROGRAM_PIPELINE =                        0x82E4,
SAMPLER =                                 0x82E6,
DISPLAY_LIST =                            0x82E7,
-- DISPLAY_LIST used in compatibility profile only
MAX_LABEL_LENGTH =                        0x82E8,
MAX_DEBUG_MESSAGE_LENGTH =                0x9143,
MAX_DEBUG_LOGGED_MESSAGES =               0x9144,
DEBUG_LOGGED_MESSAGES =                   0x9145,
DEBUG_SEVERITY_HIGH =                     0x9146,
DEBUG_SEVERITY_MEDIUM =                   0x9147,
DEBUG_SEVERITY_LOW =                      0x9148,
DEBUG_OUTPUT =                            0x92E0,
CONTEXT_FLAG_DEBUG_BIT =                  0x00000002,
-- reuse GL_STACK_UNDERFLOW
-- reuse GL_STACK_OVERFLOW

-- GL_ARB_arrays_of_arrays

-- GL_ARB_clear_buffer_object

-- GL_ARB_compute_shader
COMPUTE_SHADER =                          0x91B9,
MAX_COMPUTE_UNIFORM_BLOCKS =              0x91BB,
MAX_COMPUTE_TEXTURE_IMAGE_UNITS =         0x91BC,
MAX_COMPUTE_IMAGE_UNIFORMS =              0x91BD,
MAX_COMPUTE_SHARED_MEMORY_SIZE =          0x8262,
MAX_COMPUTE_UNIFORM_COMPONENTS =          0x8263,
MAX_COMPUTE_ATOMIC_COUNTER_BUFFERS =      0x8264,
MAX_COMPUTE_ATOMIC_COUNTERS =             0x8265,
MAX_COMBINED_COMPUTE_UNIFORM_COMPONENTS = 0x8266,
MAX_COMPUTE_LOCAL_INVOCATIONS =           0x90EB,
MAX_COMPUTE_WORK_GROUP_COUNT =            0x91BE,
MAX_COMPUTE_WORK_GROUP_SIZE =             0x91BF,
COMPUTE_LOCAL_WORK_SIZE =                 0x8267,
UNIFORM_BLOCK_REFERENCED_BY_COMPUTE_SHADER =
                                          0x90EC,
ATOMIC_COUNTER_BUFFER_REFERENCED_BY_COMPUTE_SHADER =
                                          0x90ED,
DISPATCH_INDIRECT_BUFFER =                0x90EE,
DISPATCH_INDIRECT_BUFFER_BINDING =        0x90EF,
COMPUTE_SHADER_BIT =                      0x00000020,

-- GL_ARB_copy_image

-- GL_ARB_texture_view
TEXTURE_VIEW_MIN_LEVEL =                  0x82DB,
TEXTURE_VIEW_NUM_LEVELS =                 0x82DC,
TEXTURE_VIEW_MIN_LAYER =                  0x82DD,
TEXTURE_VIEW_NUM_LAYERS =                 0x82DE,
TEXTURE_IMMUTABLE_LEVELS =                0x82DF,

-- GL_ARB_vertex_attrib_binding
VERTEX_ATTRIB_BINDING =                   0x82D4,
VERTEX_ATTRIB_RELATIVE_OFFSET =           0x82D5,
VERTEX_BINDING_DIVISOR =                  0x82D6,
VERTEX_BINDING_OFFSET =                   0x82D7,
VERTEX_BINDING_STRIDE =                   0x82D8,
MAX_VERTEX_ATTRIB_RELATIVE_OFFSET =       0x82D9,
MAX_VERTEX_ATTRIB_BINDINGS =              0x82DA,

-- GL_ARB_robustness_isolation

-- GL_ARB_ES3_compatibility
COMPRESSED_RGB8_ETC2 =                    0x9274,
COMPRESSED_SRGB8_ETC2 =                   0x9275,
COMPRESSED_RGB8_PUNCHTHROUGH_ALPHA1_ETC2 =0x9276,
COMPRESSED_SRGB8_PUNCHTHROUGH_ALPHA1_ETC2 =
                                          0x9277,
COMPRESSED_RGBA8_ETC2_EAC =               0x9278,
COMPRESSED_SRGB8_ALPHA8_ETC2_EAC =        0x9279,
COMPRESSED_R11_EAC =                      0x9270,
COMPRESSED_SIGNED_R11_EAC =               0x9271,
COMPRESSED_RG11_EAC =                     0x9272,
COMPRESSED_SIGNED_RG11_EAC =              0x9273,
PRIMITIVE_RESTART_FIXED_INDEX =           0x8D69,
ANY_SAMPLES_PASSED_CONSERVATIVE =         0x8D6A,
MAX_ELEMENT_INDEX =                       0x8D6B,

-- GL_ARB_explicit_uniform_location
MAX_UNIFORM_LOCATIONS =                   0x826E,

-- GL_ARB_fragment_layer_viewport

-- GL_ARB_framebuffer_no_attachments
FRAMEBUFFER_DEFAULT_WIDTH =               0x9310,
FRAMEBUFFER_DEFAULT_HEIGHT =              0x9311,
FRAMEBUFFER_DEFAULT_LAYERS =              0x9312,
FRAMEBUFFER_DEFAULT_SAMPLES =             0x9313,
FRAMEBUFFER_DEFAULT_FIXED_SAMPLE_LOCATIONS =
                                          0x9314,
MAX_FRAMEBUFFER_WIDTH =                   0x9315,
MAX_FRAMEBUFFER_HEIGHT =                  0x9316,
MAX_FRAMEBUFFER_LAYERS =                  0x9317,
MAX_FRAMEBUFFER_SAMPLES =                 0x9318,

-- GL_ARB_internalformat_query2
-- reuse GL_IMAGE_FORMAT_COMPATIBILITY_TYPE
-- reuse GL_NUM_SAMPLE_COUNTS
-- reuse GL_RENDERBUFFER
-- reuse GL_SAMPLES
-- reuse GL_TEXTURE_1D
-- reuse GL_TEXTURE_1D_ARRAY
-- reuse GL_TEXTURE_2D
-- reuse GL_TEXTURE_2D_ARRAY
-- reuse GL_TEXTURE_3D
-- reuse GL_TEXTURE_CUBE_MAP
-- reuse GL_TEXTURE_CUBE_MAP_ARRAY
-- reuse GL_TEXTURE_RECTANGLE
-- reuse GL_TEXTURE_BUFFER
-- reuse GL_TEXTURE_2D_MULTISAMPLE
-- reuse GL_TEXTURE_2D_MULTISAMPLE_ARRAY
-- reuse GL_TEXTURE_COMPRESSED
INTERNALFORMAT_SUPPORTED =                0x826F,
INTERNALFORMAT_PREFERRED =                0x8270,
INTERNALFORMAT_RED_SIZE =                 0x8271,
INTERNALFORMAT_GREEN_SIZE =               0x8272,
INTERNALFORMAT_BLUE_SIZE =                0x8273,
INTERNALFORMAT_ALPHA_SIZE =               0x8274,
INTERNALFORMAT_DEPTH_SIZE =               0x8275,
INTERNALFORMAT_STENCIL_SIZE =             0x8276,
INTERNALFORMAT_SHARED_SIZE =              0x8277,
INTERNALFORMAT_RED_TYPE =                 0x8278,
INTERNALFORMAT_GREEN_TYPE =               0x8279,
INTERNALFORMAT_BLUE_TYPE =                0x827A,
INTERNALFORMAT_ALPHA_TYPE =               0x827B,
INTERNALFORMAT_DEPTH_TYPE =               0x827C,
INTERNALFORMAT_STENCIL_TYPE =             0x827D,
MAX_WIDTH =                               0x827E,
MAX_HEIGHT =                              0x827F,
MAX_DEPTH =                               0x8280,
MAX_LAYERS =                              0x8281,
MAX_COMBINED_DIMENSIONS =                 0x8282,
COLOR_COMPONENTS =                        0x8283,
DEPTH_COMPONENTS =                        0x8284,
STENCIL_COMPONENTS =                      0x8285,
COLOR_RENDERABLE =                        0x8286,
DEPTH_RENDERABLE =                        0x8287,
STENCIL_RENDERABLE =                      0x8288,
FRAMEBUFFER_RENDERABLE =                  0x8289,
FRAMEBUFFER_RENDERABLE_LAYERED =          0x828A,
FRAMEBUFFER_BLEND =                       0x828B,
READ_PIXELS =                             0x828C,
READ_PIXELS_FORMAT =                      0x828D,
READ_PIXELS_TYPE =                        0x828E,
TEXTURE_IMAGE_FORMAT =                    0x828F,
TEXTURE_IMAGE_TYPE =                      0x8290,
GET_TEXTURE_IMAGE_FORMAT =                0x8291,
GET_TEXTURE_IMAGE_TYPE =                  0x8292,
MIPMAP =                                  0x8293,
MANUAL_GENERATE_MIPMAP =                  0x8294,
AUTO_GENERATE_MIPMAP =                    0x8295,
COLOR_ENCODING =                          0x8296,
SRGB_READ =                               0x8297,
SRGB_WRITE =                              0x8298,
SRGB_DECODE_ARB =                         0x8299,
FILTER =                                  0x829A,
VERTEX_TEXTURE =                          0x829B,
TESS_CONTROL_TEXTURE =                    0x829C,
TESS_EVALUATION_TEXTURE =                 0x829D,
GEOMETRY_TEXTURE =                        0x829E,
FRAGMENT_TEXTURE =                        0x829F,
COMPUTE_TEXTURE =                         0x82A0,
TEXTURE_SHADOW =                          0x82A1,
TEXTURE_GATHER =                          0x82A2,
TEXTURE_GATHER_SHADOW =                   0x82A3,
SHADER_IMAGE_LOAD =                       0x82A4,
SHADER_IMAGE_STORE =                      0x82A5,
SHADER_IMAGE_ATOMIC =                     0x82A6,
IMAGE_TEXEL_SIZE =                        0x82A7,
IMAGE_COMPATIBILITY_CLASS =               0x82A8,
IMAGE_PIXEL_FORMAT =                      0x82A9,
IMAGE_PIXEL_TYPE =                        0x82AA,
SIMULTANEOUS_TEXTURE_AND_DEPTH_TEST =     0x82AC,
SIMULTANEOUS_TEXTURE_AND_STENCIL_TEST =   0x82AD,
SIMULTANEOUS_TEXTURE_AND_DEPTH_WRITE =    0x82AE,
SIMULTANEOUS_TEXTURE_AND_STENCIL_WRITE =  0x82AF,
TEXTURE_COMPRESSED_BLOCK_WIDTH =          0x82B1,
TEXTURE_COMPRESSED_BLOCK_HEIGHT =         0x82B2,
TEXTURE_COMPRESSED_BLOCK_SIZE =           0x82B3,
CLEAR_BUFFER =                            0x82B4,
TEXTURE_VIEW =                            0x82B5,
VIEW_COMPATIBILITY_CLASS =                0x82B6,
FULL_SUPPORT =                            0x82B7,
CAVEAT_SUPPORT =                          0x82B8,
IMAGE_CLASS_4_X_32 =                      0x82B9,
IMAGE_CLASS_2_X_32 =                      0x82BA,
IMAGE_CLASS_1_X_32 =                      0x82BB,
IMAGE_CLASS_4_X_16 =                      0x82BC,
IMAGE_CLASS_2_X_16 =                      0x82BD,
IMAGE_CLASS_1_X_16 =                      0x82BE,
IMAGE_CLASS_4_X_8 =                       0x82BF,
IMAGE_CLASS_2_X_8 =                       0x82C0,
IMAGE_CLASS_1_X_8 =                       0x82C1,
IMAGE_CLASS_11_11_10 =                    0x82C2,
IMAGE_CLASS_10_10_10_2 =                  0x82C3,
VIEW_CLASS_128_BITS =                     0x82C4,
VIEW_CLASS_96_BITS =                      0x82C5,
VIEW_CLASS_64_BITS =                      0x82C6,
VIEW_CLASS_48_BITS =                      0x82C7,
VIEW_CLASS_32_BITS =                      0x82C8,
VIEW_CLASS_24_BITS =                      0x82C9,
VIEW_CLASS_16_BITS =                      0x82CA,
VIEW_CLASS_8_BITS =                       0x82CB,
VIEW_CLASS_S3TC_DXT1_RGB =                0x82CC,
VIEW_CLASS_S3TC_DXT1_RGBA =               0x82CD,
VIEW_CLASS_S3TC_DXT3_RGBA =               0x82CE,
VIEW_CLASS_S3TC_DXT5_RGBA =               0x82CF,
VIEW_CLASS_RGTC1_RED =                    0x82D0,
VIEW_CLASS_RGTC2_RG =                     0x82D1,
VIEW_CLASS_BPTC_UNORM =                   0x82D2,
VIEW_CLASS_BPTC_FLOAT =                   0x82D3,

-- GL_ARB_invalidate_subdata

-- GL_ARB_multi_draw_indirect

-- GL_ARB_program_interface_query
UNIFORM =                                 0x92E1,
UNIFORM_BLOCK =                           0x92E2,
PROGRAM_INPUT =                           0x92E3,
PROGRAM_OUTPUT =                          0x92E4,
BUFFER_VARIABLE =                         0x92E5,
SHADER_STORAGE_BLOCK =                    0x92E6,
-- reuse GL_ATOMIC_COUNTER_BUFFER
VERTEX_SUBROUTINE =                       0x92E8,
TESS_CONTROL_SUBROUTINE =                 0x92E9,
TESS_EVALUATION_SUBROUTINE =              0x92EA,
GEOMETRY_SUBROUTINE =                     0x92EB,
FRAGMENT_SUBROUTINE =                     0x92EC,
COMPUTE_SUBROUTINE =                      0x92ED,
VERTEX_SUBROUTINE_UNIFORM =               0x92EE,
TESS_CONTROL_SUBROUTINE_UNIFORM =         0x92EF,
TESS_EVALUATION_SUBROUTINE_UNIFORM =      0x92F0,
GEOMETRY_SUBROUTINE_UNIFORM =             0x92F1,
FRAGMENT_SUBROUTINE_UNIFORM =             0x92F2,
COMPUTE_SUBROUTINE_UNIFORM =              0x92F3,
TRANSFORM_FEEDBACK_VARYING =              0x92F4,
ACTIVE_RESOURCES =                        0x92F5,
MAX_NAME_LENGTH =                         0x92F6,
MAX_NUM_ACTIVE_VARIABLES =                0x92F7,
MAX_NUM_COMPATIBLE_SUBROUTINES =          0x92F8,
NAME_LENGTH =                             0x92F9,
TYPE =                                    0x92FA,
ARRAY_SIZE =                              0x92FB,
OFFSET =                                  0x92FC,
BLOCK_INDEX =                             0x92FD,
ARRAY_STRIDE =                            0x92FE,
MATRIX_STRIDE =                           0x92FF,
IS_ROW_MAJOR =                            0x9300,
ATOMIC_COUNTER_BUFFER_INDEX =             0x9301,
BUFFER_BINDING =                          0x9302,
BUFFER_DATA_SIZE =                        0x9303,
NUM_ACTIVE_VARIABLES =                    0x9304,
ACTIVE_VARIABLES =                        0x9305,
REFERENCED_BY_VERTEX_SHADER =             0x9306,
REFERENCED_BY_TESS_CONTROL_SHADER =       0x9307,
REFERENCED_BY_TESS_EVALUATION_SHADER =    0x9308,
REFERENCED_BY_GEOMETRY_SHADER =           0x9309,
REFERENCED_BY_FRAGMENT_SHADER =           0x930A,
REFERENCED_BY_COMPUTE_SHADER =            0x930B,
TOP_LEVEL_ARRAY_SIZE =                    0x930C,
TOP_LEVEL_ARRAY_STRIDE =                  0x930D,
LOCATION =                                0x930E,
LOCATION_INDEX =                          0x930F,
IS_PER_PATCH =                            0x92E7,
-- reuse GL_NUM_COMPATIBLE_SUBROUTINES
-- reuse GL_COMPATIBLE_SUBROUTINES

-- GL_ARB_robust_buffer_access_behavior

-- GL_ARB_shader_image_size

-- GL_ARB_shader_storage_buffer_object
SHADER_STORAGE_BUFFER =                   0x90D2,
SHADER_STORAGE_BUFFER_BINDING =           0x90D3,
SHADER_STORAGE_BUFFER_START =             0x90D4,
SHADER_STORAGE_BUFFER_SIZE =              0x90D5,
MAX_VERTEX_SHADER_STORAGE_BLOCKS =        0x90D6,
MAX_GEOMETRY_SHADER_STORAGE_BLOCKS =      0x90D7,
MAX_TESS_CONTROL_SHADER_STORAGE_BLOCKS =  0x90D8,
MAX_TESS_EVALUATION_SHADER_STORAGE_BLOCKS =
                                          0x90D9,
MAX_FRAGMENT_SHADER_STORAGE_BLOCKS =      0x90DA,
MAX_COMPUTE_SHADER_STORAGE_BLOCKS =       0x90DB,
MAX_COMBINED_SHADER_STORAGE_BLOCKS =      0x90DC,
MAX_SHADER_STORAGE_BUFFER_BINDINGS =      0x90DD,
MAX_SHADER_STORAGE_BLOCK_SIZE =           0x90DE,
SHADER_STORAGE_BUFFER_OFFSET_ALIGNMENT =  0x90DF,
SHADER_STORAGE_BARRIER_BIT =              0x00002000,
MAX_COMBINED_SHADER_OUTPUT_RESOURCES =    0x8F39,
-- reuse GL_MAX_COMBINED_IMAGE_UNITS_AND_FRAGMENT_OUTPUTS

-- GL_ARB_stencil_texturing
DEPTH_STENCIL_TEXTURE_MODE =              0x90EA,

-- GL_ARB_texture_buffer_range
TEXTURE_BUFFER_OFFSET =                   0x919D,
TEXTURE_BUFFER_SIZE =                     0x919E,
TEXTURE_BUFFER_OFFSET_ALIGNMENT =         0x919F,

-- GL_ARB_texture_query_levels

-- GL_ARB_texture_storage_multisample
}

---------------------------------------------------------------

FFI.cdef [[
/* Base GL types */
typedef unsigned int GLenum;
typedef unsigned char GLboolean;
typedef unsigned int GLbitfield;
typedef signed char GLbyte;
typedef short GLshort;
typedef int GLint;
typedef int GLsizei;
typedef unsigned char GLubyte;
typedef unsigned short GLushort;
typedef unsigned int GLuint;
typedef unsigned short GLhalf;
typedef float GLfloat;
typedef float GLclampf;
typedef double GLdouble;
typedef double GLclampd;
typedef void GLvoid;

/* GL_VERSION_2_0 */
/* GL type for program/shader text */
typedef char GLchar;

/* GL_VERSION_1_5 */
/* GL types for handling large vertex buffer objects */
typedef ptrdiff_t GLintptr;
typedef ptrdiff_t GLsizeiptr;

/* GL_ARB_vertex_buffer_object */
/* GL types for handling large vertex buffer objects */
typedef ptrdiff_t GLintptrARB;
typedef ptrdiff_t GLsizeiptrARB;

/* GL_ARB_shader_objects */
/* GL types for program/shader text and shader object handles */
typedef char GLcharARB;
typedef unsigned int GLhandleARB;

/* GL type for "half" precision (s10e5) float data in host memory */
/* GL_ARB_half_float_pixel */
typedef unsigned short GLhalfARB;

/* GL_NV_half_float */
typedef unsigned short GLhalfNV;

/* GL_EXT_timer_query */
typedef int64_t GLint64EXT;
typedef uint64_t GLuint64EXT;

/* GL_ARB_sync */
typedef int64_t GLint64;
typedef uint64_t GLuint64;
typedef struct __GLsync *GLsync;

/* GL_ARB_cl_event */
/* These incomplete types let us declare types compatible with OpenCL's cl_context and cl_event */
struct _cl_context;
struct _cl_event;

/* GL_ARB_debug_output */
typedef void ( *GLDEBUGPROCARB)(GLenum source,GLenum type,GLuint id,GLenum severity,GLsizei length,const GLchar *message,GLvoid *userParam);

/* GL_AMD_debug_output */
typedef void ( *GLDEBUGPROCAMD)(GLuint id,GLenum category,GLenum severity,GLsizei length,const GLchar *message,GLvoid *userParam);

/* GL_KHR_debug */
typedef void ( *GLDEBUGPROC)(GLenum source,GLenum type,GLuint id,GLenum severity,GLsizei length,const GLchar *message,GLvoid *userParam);

/* GL_NV_vdpau_interop */
typedef GLintptr GLvdpauSurfaceNV;

/* GL_OES_fixed_point */
/* GLint must be 32 bits, a relatively safe assumption on modern CPUs */
typedef GLint GLfixed;

/* GL_VERSION_1_0 */
 void  glCullFace (GLenum mode);
 void  glFrontFace (GLenum mode);
 void  glHint (GLenum target, GLenum mode);
 void  glLineWidth (GLfloat width);
 void  glPointSize (GLfloat size);
 void  glPolygonMode (GLenum face, GLenum mode);
 void  glScissor (GLint x, GLint y, GLsizei width, GLsizei height);
 void  glTexParameterf (GLenum target, GLenum pname, GLfloat param);
 void  glTexParameterfv (GLenum target, GLenum pname, const GLfloat *params);
 void  glTexParameteri (GLenum target, GLenum pname, GLint param);
 void  glTexParameteriv (GLenum target, GLenum pname, const GLint *params);
 void  glTexImage1D (GLenum target, GLint level, GLint internalformat, GLsizei width, GLint border, GLenum format, GLenum type, const GLvoid *pixels);
 void  glTexImage2D (GLenum target, GLint level, GLint internalformat, GLsizei width, GLsizei height, GLint border, GLenum format, GLenum type, const GLvoid *pixels);
 void  glDrawBuffer (GLenum mode);
 void  glClear (GLbitfield mask);
 void  glClearColor (GLfloat red, GLfloat green, GLfloat blue, GLfloat alpha);
 void  glClearStencil (GLint s);
 void  glClearDepth (GLdouble depth);
 void  glStencilMask (GLuint mask);
 void  glColorMask (GLboolean red, GLboolean green, GLboolean blue, GLboolean alpha);
 void  glDepthMask (GLboolean flag);
 void  glDisable (GLenum cap);
 void  glEnable (GLenum cap);
 void  glFinish (void);
 void  glFlush (void);
 void  glBlendFunc (GLenum sfactor, GLenum dfactor);
 void  glLogicOp (GLenum opcode);
 void  glStencilFunc (GLenum func, GLint ref, GLuint mask);
 void  glStencilOp (GLenum fail, GLenum zfail, GLenum zpass);
 void  glDepthFunc (GLenum func);
 void  glPixelStoref (GLenum pname, GLfloat param);
 void  glPixelStorei (GLenum pname, GLint param);
 void  glReadBuffer (GLenum mode);
 void  glReadPixels (GLint x, GLint y, GLsizei width, GLsizei height, GLenum format, GLenum type, GLvoid *pixels);
 void  glGetBooleanv (GLenum pname, GLboolean *params);
 void  glGetDoublev (GLenum pname, GLdouble *params);
 GLenum  glGetError (void);
 void  glGetFloatv (GLenum pname, GLfloat *params);
 void  glGetIntegerv (GLenum pname, GLint *params);
 const GLubyte *  glGetString (GLenum name);
 void  glGetTexImage (GLenum target, GLint level, GLenum format, GLenum type, GLvoid *pixels);
 void  glGetTexParameterfv (GLenum target, GLenum pname, GLfloat *params);
 void  glGetTexParameteriv (GLenum target, GLenum pname, GLint *params);
 void  glGetTexLevelParameterfv (GLenum target, GLint level, GLenum pname, GLfloat *params);
 void  glGetTexLevelParameteriv (GLenum target, GLint level, GLenum pname, GLint *params);
 GLboolean  glIsEnabled (GLenum cap);
 void  glDepthRange (GLdouble near, GLdouble far);
 void  glViewport (GLint x, GLint y, GLsizei width, GLsizei height);
typedef void (* PFNGLCULLFACEPROC) (GLenum mode);
typedef void (* PFNGLFRONTFACEPROC) (GLenum mode);
typedef void (* PFNGLHINTPROC) (GLenum target, GLenum mode);
typedef void (* PFNGLLINEWIDTHPROC) (GLfloat width);
typedef void (* PFNGLPOINTSIZEPROC) (GLfloat size);
typedef void (* PFNGLPOLYGONMODEPROC) (GLenum face, GLenum mode);
typedef void (* PFNGLSCISSORPROC) (GLint x, GLint y, GLsizei width, GLsizei height);
typedef void (* PFNGLTEXPARAMETERFPROC) (GLenum target, GLenum pname, GLfloat param);
typedef void (* PFNGLTEXPARAMETERFVPROC) (GLenum target, GLenum pname, const GLfloat *params);
typedef void (* PFNGLTEXPARAMETERIPROC) (GLenum target, GLenum pname, GLint param);
typedef void (* PFNGLTEXPARAMETERIVPROC) (GLenum target, GLenum pname, const GLint *params);
typedef void (* PFNGLTEXIMAGE1DPROC) (GLenum target, GLint level, GLint internalformat, GLsizei width, GLint border, GLenum format, GLenum type, const GLvoid *pixels);
typedef void (* PFNGLTEXIMAGE2DPROC) (GLenum target, GLint level, GLint internalformat, GLsizei width, GLsizei height, GLint border, GLenum format, GLenum type, const GLvoid *pixels);
typedef void (* PFNGLDRAWBUFFERPROC) (GLenum mode);
typedef void (* PFNGLCLEARPROC) (GLbitfield mask);
typedef void (* PFNGLCLEARCOLORPROC) (GLfloat red, GLfloat green, GLfloat blue, GLfloat alpha);
typedef void (* PFNGLCLEARSTENCILPROC) (GLint s);
typedef void (* PFNGLCLEARDEPTHPROC) (GLdouble depth);
typedef void (* PFNGLSTENCILMASKPROC) (GLuint mask);
typedef void (* PFNGLCOLORMASKPROC) (GLboolean red, GLboolean green, GLboolean blue, GLboolean alpha);
typedef void (* PFNGLDEPTHMASKPROC) (GLboolean flag);
typedef void (* PFNGLDISABLEPROC) (GLenum cap);
typedef void (* PFNGLENABLEPROC) (GLenum cap);
typedef void (* PFNGLFINISHPROC) (void);
typedef void (* PFNGLFLUSHPROC) (void);
typedef void (* PFNGLBLENDFUNCPROC) (GLenum sfactor, GLenum dfactor);
typedef void (* PFNGLLOGICOPPROC) (GLenum opcode);
typedef void (* PFNGLSTENCILFUNCPROC) (GLenum func, GLint ref, GLuint mask);
typedef void (* PFNGLSTENCILOPPROC) (GLenum fail, GLenum zfail, GLenum zpass);
typedef void (* PFNGLDEPTHFUNCPROC) (GLenum func);
typedef void (* PFNGLPIXELSTOREFPROC) (GLenum pname, GLfloat param);
typedef void (* PFNGLPIXELSTOREIPROC) (GLenum pname, GLint param);
typedef void (* PFNGLREADBUFFERPROC) (GLenum mode);
typedef void (* PFNGLREADPIXELSPROC) (GLint x, GLint y, GLsizei width, GLsizei height, GLenum format, GLenum type, GLvoid *pixels);
typedef void (* PFNGLGETBOOLEANVPROC) (GLenum pname, GLboolean *params);
typedef void (* PFNGLGETDOUBLEVPROC) (GLenum pname, GLdouble *params);
typedef GLenum (* PFNGLGETERRORPROC) (void);
typedef void (* PFNGLGETFLOATVPROC) (GLenum pname, GLfloat *params);
typedef void (* PFNGLGETINTEGERVPROC) (GLenum pname, GLint *params);
typedef const GLubyte * (* PFNGLGETSTRINGPROC) (GLenum name);
typedef void (* PFNGLGETTEXIMAGEPROC) (GLenum target, GLint level, GLenum format, GLenum type, GLvoid *pixels);
typedef void (* PFNGLGETTEXPARAMETERFVPROC) (GLenum target, GLenum pname, GLfloat *params);
typedef void (* PFNGLGETTEXPARAMETERIVPROC) (GLenum target, GLenum pname, GLint *params);
typedef void (* PFNGLGETTEXLEVELPARAMETERFVPROC) (GLenum target, GLint level, GLenum pname, GLfloat *params);
typedef void (* PFNGLGETTEXLEVELPARAMETERIVPROC) (GLenum target, GLint level, GLenum pname, GLint *params);
typedef GLboolean (* PFNGLISENABLEDPROC) (GLenum cap);
typedef void (* PFNGLDEPTHRANGEPROC) (GLdouble near, GLdouble far);
typedef void (* PFNGLVIEWPORTPROC) (GLint x, GLint y, GLsizei width, GLsizei height);

/* GL_VERSION_1_1 */
 void  glDrawArrays (GLenum mode, GLint first, GLsizei count);
 void  glDrawElements (GLenum mode, GLsizei count, GLenum type, const GLvoid *indices);
 void  glGetPointerv (GLenum pname, GLvoid* *params);
 void  glPolygonOffset (GLfloat factor, GLfloat units);
 void  glCopyTexImage1D (GLenum target, GLint level, GLenum internalformat, GLint x, GLint y, GLsizei width, GLint border);
 void  glCopyTexImage2D (GLenum target, GLint level, GLenum internalformat, GLint x, GLint y, GLsizei width, GLsizei height, GLint border);
 void  glCopyTexSubImage1D (GLenum target, GLint level, GLint xoffset, GLint x, GLint y, GLsizei width);
 void  glCopyTexSubImage2D (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint x, GLint y, GLsizei width, GLsizei height);
 void  glTexSubImage1D (GLenum target, GLint level, GLint xoffset, GLsizei width, GLenum format, GLenum type, const GLvoid *pixels);
 void  glTexSubImage2D (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLenum type, const GLvoid *pixels);
 void  glBindTexture (GLenum target, GLuint texture);
 void  glDeleteTextures (GLsizei n, const GLuint *textures);
 void  glGenTextures (GLsizei n, GLuint *textures);
 GLboolean  glIsTexture (GLuint texture);
typedef void (* PFNGLDRAWARRAYSPROC) (GLenum mode, GLint first, GLsizei count);
typedef void (* PFNGLDRAWELEMENTSPROC) (GLenum mode, GLsizei count, GLenum type, const GLvoid *indices);
typedef void (* PFNGLGETPOINTERVPROC) (GLenum pname, GLvoid* *params);
typedef void (* PFNGLPOLYGONOFFSETPROC) (GLfloat factor, GLfloat units);
typedef void (* PFNGLCOPYTEXIMAGE1DPROC) (GLenum target, GLint level, GLenum internalformat, GLint x, GLint y, GLsizei width, GLint border);
typedef void (* PFNGLCOPYTEXIMAGE2DPROC) (GLenum target, GLint level, GLenum internalformat, GLint x, GLint y, GLsizei width, GLsizei height, GLint border);
typedef void (* PFNGLCOPYTEXSUBIMAGE1DPROC) (GLenum target, GLint level, GLint xoffset, GLint x, GLint y, GLsizei width);
typedef void (* PFNGLCOPYTEXSUBIMAGE2DPROC) (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint x, GLint y, GLsizei width, GLsizei height);
typedef void (* PFNGLTEXSUBIMAGE1DPROC) (GLenum target, GLint level, GLint xoffset, GLsizei width, GLenum format, GLenum type, const GLvoid *pixels);
typedef void (* PFNGLTEXSUBIMAGE2DPROC) (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLenum type, const GLvoid *pixels);
typedef void (* PFNGLBINDTEXTUREPROC) (GLenum target, GLuint texture);
typedef void (* PFNGLDELETETEXTURESPROC) (GLsizei n, const GLuint *textures);
typedef void (* PFNGLGENTEXTURESPROC) (GLsizei n, GLuint *textures);
typedef GLboolean (* PFNGLISTEXTUREPROC) (GLuint texture);

/* GL_VERSION_1_2 */
 void  glBlendColor (GLfloat red, GLfloat green, GLfloat blue, GLfloat alpha);
 void  glBlendEquation (GLenum mode);
 void  glDrawRangeElements (GLenum mode, GLuint start, GLuint end, GLsizei count, GLenum type, const GLvoid *indices);
 void  glTexImage3D (GLenum target, GLint level, GLint internalformat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLenum format, GLenum type, const GLvoid *pixels);
 void  glTexSubImage3D (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLenum type, const GLvoid *pixels);
 void  glCopyTexSubImage3D (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLint x, GLint y, GLsizei width, GLsizei height);
typedef void (* PFNGLBLENDCOLORPROC) (GLfloat red, GLfloat green, GLfloat blue, GLfloat alpha);
typedef void (* PFNGLBLENDEQUATIONPROC) (GLenum mode);
typedef void (* PFNGLDRAWRANGEELEMENTSPROC) (GLenum mode, GLuint start, GLuint end, GLsizei count, GLenum type, const GLvoid *indices);
typedef void (* PFNGLTEXIMAGE3DPROC) (GLenum target, GLint level, GLint internalformat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLenum format, GLenum type, const GLvoid *pixels);
typedef void (* PFNGLTEXSUBIMAGE3DPROC) (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLenum type, const GLvoid *pixels);
typedef void (* PFNGLCOPYTEXSUBIMAGE3DPROC) (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLint x, GLint y, GLsizei width, GLsizei height);

/* GL_VERSION_1_3 */
 void  glActiveTexture (GLenum texture);
 void  glSampleCoverage (GLfloat value, GLboolean invert);
 void  glCompressedTexImage3D (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLsizei imageSize, const GLvoid *data);
 void  glCompressedTexImage2D (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLint border, GLsizei imageSize, const GLvoid *data);
 void  glCompressedTexImage1D (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLint border, GLsizei imageSize, const GLvoid *data);
 void  glCompressedTexSubImage3D (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLsizei imageSize, const GLvoid *data);
 void  glCompressedTexSubImage2D (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLsizei imageSize, const GLvoid *data);
 void  glCompressedTexSubImage1D (GLenum target, GLint level, GLint xoffset, GLsizei width, GLenum format, GLsizei imageSize, const GLvoid *data);
 void  glGetCompressedTexImage (GLenum target, GLint level, GLvoid *img);
typedef void (* PFNGLACTIVETEXTUREPROC) (GLenum texture);
typedef void (* PFNGLSAMPLECOVERAGEPROC) (GLfloat value, GLboolean invert);
typedef void (* PFNGLCOMPRESSEDTEXIMAGE3DPROC) (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLsizei imageSize, const GLvoid *data);
typedef void (* PFNGLCOMPRESSEDTEXIMAGE2DPROC) (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLint border, GLsizei imageSize, const GLvoid *data);
typedef void (* PFNGLCOMPRESSEDTEXIMAGE1DPROC) (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLint border, GLsizei imageSize, const GLvoid *data);
typedef void (* PFNGLCOMPRESSEDTEXSUBIMAGE3DPROC) (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLsizei imageSize, const GLvoid *data);
typedef void (* PFNGLCOMPRESSEDTEXSUBIMAGE2DPROC) (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLsizei imageSize, const GLvoid *data);
typedef void (* PFNGLCOMPRESSEDTEXSUBIMAGE1DPROC) (GLenum target, GLint level, GLint xoffset, GLsizei width, GLenum format, GLsizei imageSize, const GLvoid *data);
typedef void (* PFNGLGETCOMPRESSEDTEXIMAGEPROC) (GLenum target, GLint level, GLvoid *img);

/* GL_VERSION_1_4 */
 void  glBlendFuncSeparate (GLenum sfactorRGB, GLenum dfactorRGB, GLenum sfactorAlpha, GLenum dfactorAlpha);
 void  glMultiDrawArrays (GLenum mode, const GLint *first, const GLsizei *count, GLsizei drawcount);
 void  glMultiDrawElements (GLenum mode, const GLsizei *count, GLenum type, const GLvoid* const *indices, GLsizei drawcount);
 void  glPointParameterf (GLenum pname, GLfloat param);
 void  glPointParameterfv (GLenum pname, const GLfloat *params);
 void  glPointParameteri (GLenum pname, GLint param);
 void  glPointParameteriv (GLenum pname, const GLint *params);
typedef void (* PFNGLBLENDFUNCSEPARATEPROC) (GLenum sfactorRGB, GLenum dfactorRGB, GLenum sfactorAlpha, GLenum dfactorAlpha);
typedef void (* PFNGLMULTIDRAWARRAYSPROC) (GLenum mode, const GLint *first, const GLsizei *count, GLsizei drawcount);
typedef void (* PFNGLMULTIDRAWELEMENTSPROC) (GLenum mode, const GLsizei *count, GLenum type, const GLvoid* const *indices, GLsizei drawcount);
typedef void (* PFNGLPOINTPARAMETERFPROC) (GLenum pname, GLfloat param);
typedef void (* PFNGLPOINTPARAMETERFVPROC) (GLenum pname, const GLfloat *params);
typedef void (* PFNGLPOINTPARAMETERIPROC) (GLenum pname, GLint param);
typedef void (* PFNGLPOINTPARAMETERIVPROC) (GLenum pname, const GLint *params);

/* GL_VERSION_1_5 */
 void  glGenQueries (GLsizei n, GLuint *ids);
 void  glDeleteQueries (GLsizei n, const GLuint *ids);
 GLboolean  glIsQuery (GLuint id);
 void  glBeginQuery (GLenum target, GLuint id);
 void  glEndQuery (GLenum target);
 void  glGetQueryiv (GLenum target, GLenum pname, GLint *params);
 void  glGetQueryObjectiv (GLuint id, GLenum pname, GLint *params);
 void  glGetQueryObjectuiv (GLuint id, GLenum pname, GLuint *params);
 void  glBindBuffer (GLenum target, GLuint buffer);
 void  glDeleteBuffers (GLsizei n, const GLuint *buffers);
 void  glGenBuffers (GLsizei n, GLuint *buffers);
 GLboolean  glIsBuffer (GLuint buffer);
 void  glBufferData (GLenum target, GLsizeiptr size, const GLvoid *data, GLenum usage);
 void  glBufferSubData (GLenum target, GLintptr offset, GLsizeiptr size, const GLvoid *data);
 void  glGetBufferSubData (GLenum target, GLintptr offset, GLsizeiptr size, GLvoid *data);
 GLvoid*  glMapBuffer (GLenum target, GLenum access);
 GLboolean  glUnmapBuffer (GLenum target);
 void  glGetBufferParameteriv (GLenum target, GLenum pname, GLint *params);
 void  glGetBufferPointerv (GLenum target, GLenum pname, GLvoid* *params);
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

/* GL_VERSION_2_0 */
 void  glBlendEquationSeparate (GLenum modeRGB, GLenum modeAlpha);
 void  glDrawBuffers (GLsizei n, const GLenum *bufs);
 void  glStencilOpSeparate (GLenum face, GLenum sfail, GLenum dpfail, GLenum dppass);
 void  glStencilFuncSeparate (GLenum face, GLenum func, GLint ref, GLuint mask);
 void  glStencilMaskSeparate (GLenum face, GLuint mask);
 void  glAttachShader (GLuint program, GLuint shader);
 void  glBindAttribLocation (GLuint program, GLuint index, const GLchar *name);
 void  glCompileShader (GLuint shader);
 GLuint  glCreateProgram (void);
 GLuint  glCreateShader (GLenum type);
 void  glDeleteProgram (GLuint program);
 void  glDeleteShader (GLuint shader);
 void  glDetachShader (GLuint program, GLuint shader);
 void  glDisableVertexAttribArray (GLuint index);
 void  glEnableVertexAttribArray (GLuint index);
 void  glGetActiveAttrib (GLuint program, GLuint index, GLsizei bufSize, GLsizei *length, GLint *size, GLenum *type, GLchar *name);
 void  glGetActiveUniform (GLuint program, GLuint index, GLsizei bufSize, GLsizei *length, GLint *size, GLenum *type, GLchar *name);
 void  glGetAttachedShaders (GLuint program, GLsizei maxCount, GLsizei *count, GLuint *obj);
 GLint  glGetAttribLocation (GLuint program, const GLchar *name);
 void  glGetProgramiv (GLuint program, GLenum pname, GLint *params);
 void  glGetProgramInfoLog (GLuint program, GLsizei bufSize, GLsizei *length, GLchar *infoLog);
 void  glGetShaderiv (GLuint shader, GLenum pname, GLint *params);
 void  glGetShaderInfoLog (GLuint shader, GLsizei bufSize, GLsizei *length, GLchar *infoLog);
 void  glGetShaderSource (GLuint shader, GLsizei bufSize, GLsizei *length, GLchar *source);
 GLint  glGetUniformLocation (GLuint program, const GLchar *name);
 void  glGetUniformfv (GLuint program, GLint location, GLfloat *params);
 void  glGetUniformiv (GLuint program, GLint location, GLint *params);
 void  glGetVertexAttribdv (GLuint index, GLenum pname, GLdouble *params);
 void  glGetVertexAttribfv (GLuint index, GLenum pname, GLfloat *params);
 void  glGetVertexAttribiv (GLuint index, GLenum pname, GLint *params);
 void  glGetVertexAttribPointerv (GLuint index, GLenum pname, GLvoid* *pointer);
 GLboolean  glIsProgram (GLuint program);
 GLboolean  glIsShader (GLuint shader);
 void  glLinkProgram (GLuint program);
 void  glShaderSource (GLuint shader, GLsizei count, const GLchar* const *string, const GLint *length);
 void  glUseProgram (GLuint program);
 void  glUniform1f (GLint location, GLfloat v0);
 void  glUniform2f (GLint location, GLfloat v0, GLfloat v1);
 void  glUniform3f (GLint location, GLfloat v0, GLfloat v1, GLfloat v2);
 void  glUniform4f (GLint location, GLfloat v0, GLfloat v1, GLfloat v2, GLfloat v3);
 void  glUniform1i (GLint location, GLint v0);
 void  glUniform2i (GLint location, GLint v0, GLint v1);
 void  glUniform3i (GLint location, GLint v0, GLint v1, GLint v2);
 void  glUniform4i (GLint location, GLint v0, GLint v1, GLint v2, GLint v3);
 void  glUniform1fv (GLint location, GLsizei count, const GLfloat *value);
 void  glUniform2fv (GLint location, GLsizei count, const GLfloat *value);
 void  glUniform3fv (GLint location, GLsizei count, const GLfloat *value);
 void  glUniform4fv (GLint location, GLsizei count, const GLfloat *value);
 void  glUniform1iv (GLint location, GLsizei count, const GLint *value);
 void  glUniform2iv (GLint location, GLsizei count, const GLint *value);
 void  glUniform3iv (GLint location, GLsizei count, const GLint *value);
 void  glUniform4iv (GLint location, GLsizei count, const GLint *value);
 void  glUniformMatrix2fv (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
 void  glUniformMatrix3fv (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
 void  glUniformMatrix4fv (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
 void  glValidateProgram (GLuint program);
 void  glVertexAttrib1d (GLuint index, GLdouble x);
 void  glVertexAttrib1dv (GLuint index, const GLdouble *v);
 void  glVertexAttrib1f (GLuint index, GLfloat x);
 void  glVertexAttrib1fv (GLuint index, const GLfloat *v);
 void  glVertexAttrib1s (GLuint index, GLshort x);
 void  glVertexAttrib1sv (GLuint index, const GLshort *v);
 void  glVertexAttrib2d (GLuint index, GLdouble x, GLdouble y);
 void  glVertexAttrib2dv (GLuint index, const GLdouble *v);
 void  glVertexAttrib2f (GLuint index, GLfloat x, GLfloat y);
 void  glVertexAttrib2fv (GLuint index, const GLfloat *v);
 void  glVertexAttrib2s (GLuint index, GLshort x, GLshort y);
 void  glVertexAttrib2sv (GLuint index, const GLshort *v);
 void  glVertexAttrib3d (GLuint index, GLdouble x, GLdouble y, GLdouble z);
 void  glVertexAttrib3dv (GLuint index, const GLdouble *v);
 void  glVertexAttrib3f (GLuint index, GLfloat x, GLfloat y, GLfloat z);
 void  glVertexAttrib3fv (GLuint index, const GLfloat *v);
 void  glVertexAttrib3s (GLuint index, GLshort x, GLshort y, GLshort z);
 void  glVertexAttrib3sv (GLuint index, const GLshort *v);
 void  glVertexAttrib4Nbv (GLuint index, const GLbyte *v);
 void  glVertexAttrib4Niv (GLuint index, const GLint *v);
 void  glVertexAttrib4Nsv (GLuint index, const GLshort *v);
 void  glVertexAttrib4Nub (GLuint index, GLubyte x, GLubyte y, GLubyte z, GLubyte w);
 void  glVertexAttrib4Nubv (GLuint index, const GLubyte *v);
 void  glVertexAttrib4Nuiv (GLuint index, const GLuint *v);
 void  glVertexAttrib4Nusv (GLuint index, const GLushort *v);
 void  glVertexAttrib4bv (GLuint index, const GLbyte *v);
 void  glVertexAttrib4d (GLuint index, GLdouble x, GLdouble y, GLdouble z, GLdouble w);
 void  glVertexAttrib4dv (GLuint index, const GLdouble *v);
 void  glVertexAttrib4f (GLuint index, GLfloat x, GLfloat y, GLfloat z, GLfloat w);
 void  glVertexAttrib4fv (GLuint index, const GLfloat *v);
 void  glVertexAttrib4iv (GLuint index, const GLint *v);
 void  glVertexAttrib4s (GLuint index, GLshort x, GLshort y, GLshort z, GLshort w);
 void  glVertexAttrib4sv (GLuint index, const GLshort *v);
 void  glVertexAttrib4ubv (GLuint index, const GLubyte *v);
 void  glVertexAttrib4uiv (GLuint index, const GLuint *v);
 void  glVertexAttrib4usv (GLuint index, const GLushort *v);
 void  glVertexAttribPointer (GLuint index, GLint size, GLenum type, GLboolean normalized, GLsizei stride, const GLvoid *pointer);
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
typedef void (* PFNGLGETVERTEXATTRIBDVPROC) (GLuint index, GLenum pname, GLdouble *params);
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
typedef void (* PFNGLVERTEXATTRIB1DPROC) (GLuint index, GLdouble x);
typedef void (* PFNGLVERTEXATTRIB1DVPROC) (GLuint index, const GLdouble *v);
typedef void (* PFNGLVERTEXATTRIB1FPROC) (GLuint index, GLfloat x);
typedef void (* PFNGLVERTEXATTRIB1FVPROC) (GLuint index, const GLfloat *v);
typedef void (* PFNGLVERTEXATTRIB1SPROC) (GLuint index, GLshort x);
typedef void (* PFNGLVERTEXATTRIB1SVPROC) (GLuint index, const GLshort *v);
typedef void (* PFNGLVERTEXATTRIB2DPROC) (GLuint index, GLdouble x, GLdouble y);
typedef void (* PFNGLVERTEXATTRIB2DVPROC) (GLuint index, const GLdouble *v);
typedef void (* PFNGLVERTEXATTRIB2FPROC) (GLuint index, GLfloat x, GLfloat y);
typedef void (* PFNGLVERTEXATTRIB2FVPROC) (GLuint index, const GLfloat *v);
typedef void (* PFNGLVERTEXATTRIB2SPROC) (GLuint index, GLshort x, GLshort y);
typedef void (* PFNGLVERTEXATTRIB2SVPROC) (GLuint index, const GLshort *v);
typedef void (* PFNGLVERTEXATTRIB3DPROC) (GLuint index, GLdouble x, GLdouble y, GLdouble z);
typedef void (* PFNGLVERTEXATTRIB3DVPROC) (GLuint index, const GLdouble *v);
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
typedef void (* PFNGLVERTEXATTRIB4DPROC) (GLuint index, GLdouble x, GLdouble y, GLdouble z, GLdouble w);
typedef void (* PFNGLVERTEXATTRIB4DVPROC) (GLuint index, const GLdouble *v);
typedef void (* PFNGLVERTEXATTRIB4FPROC) (GLuint index, GLfloat x, GLfloat y, GLfloat z, GLfloat w);
typedef void (* PFNGLVERTEXATTRIB4FVPROC) (GLuint index, const GLfloat *v);
typedef void (* PFNGLVERTEXATTRIB4IVPROC) (GLuint index, const GLint *v);
typedef void (* PFNGLVERTEXATTRIB4SPROC) (GLuint index, GLshort x, GLshort y, GLshort z, GLshort w);
typedef void (* PFNGLVERTEXATTRIB4SVPROC) (GLuint index, const GLshort *v);
typedef void (* PFNGLVERTEXATTRIB4UBVPROC) (GLuint index, const GLubyte *v);
typedef void (* PFNGLVERTEXATTRIB4UIVPROC) (GLuint index, const GLuint *v);
typedef void (* PFNGLVERTEXATTRIB4USVPROC) (GLuint index, const GLushort *v);
typedef void (* PFNGLVERTEXATTRIBPOINTERPROC) (GLuint index, GLint size, GLenum type, GLboolean normalized, GLsizei stride, const GLvoid *pointer);

/* GL_VERSION_2_1 */
 void  glUniformMatrix2x3fv (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
 void  glUniformMatrix3x2fv (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
 void  glUniformMatrix2x4fv (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
 void  glUniformMatrix4x2fv (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
 void  glUniformMatrix3x4fv (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
 void  glUniformMatrix4x3fv (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void (* PFNGLUNIFORMMATRIX2X3FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void (* PFNGLUNIFORMMATRIX3X2FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void (* PFNGLUNIFORMMATRIX2X4FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void (* PFNGLUNIFORMMATRIX4X2FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void (* PFNGLUNIFORMMATRIX3X4FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void (* PFNGLUNIFORMMATRIX4X3FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);

/* GL_VERSION_3_0 */
/* OpenGL 3.0 also reuses entry points from these extensions: */
/* ARB_framebuffer_object */
/* ARB_map_buffer_range */
/* ARB_vertex_array_object */
 void  glColorMaski (GLuint index, GLboolean r, GLboolean g, GLboolean b, GLboolean a);
 void  glGetBooleani_v (GLenum target, GLuint index, GLboolean *data);
 void  glGetIntegeri_v (GLenum target, GLuint index, GLint *data);
 void  glEnablei (GLenum target, GLuint index);
 void  glDisablei (GLenum target, GLuint index);
 GLboolean  glIsEnabledi (GLenum target, GLuint index);
 void  glBeginTransformFeedback (GLenum primitiveMode);
 void  glEndTransformFeedback (void);
 void  glBindBufferRange (GLenum target, GLuint index, GLuint buffer, GLintptr offset, GLsizeiptr size);
 void  glBindBufferBase (GLenum target, GLuint index, GLuint buffer);
 void  glTransformFeedbackVaryings (GLuint program, GLsizei count, const GLchar* const *varyings, GLenum bufferMode);
 void  glGetTransformFeedbackVarying (GLuint program, GLuint index, GLsizei bufSize, GLsizei *length, GLsizei *size, GLenum *type, GLchar *name);
 void  glClampColor (GLenum target, GLenum clamp);
 void  glBeginConditionalRender (GLuint id, GLenum mode);
 void  glEndConditionalRender (void);
 void  glVertexAttribIPointer (GLuint index, GLint size, GLenum type, GLsizei stride, const GLvoid *pointer);
 void  glGetVertexAttribIiv (GLuint index, GLenum pname, GLint *params);
 void  glGetVertexAttribIuiv (GLuint index, GLenum pname, GLuint *params);
 void  glVertexAttribI1i (GLuint index, GLint x);
 void  glVertexAttribI2i (GLuint index, GLint x, GLint y);
 void  glVertexAttribI3i (GLuint index, GLint x, GLint y, GLint z);
 void  glVertexAttribI4i (GLuint index, GLint x, GLint y, GLint z, GLint w);
 void  glVertexAttribI1ui (GLuint index, GLuint x);
 void  glVertexAttribI2ui (GLuint index, GLuint x, GLuint y);
 void  glVertexAttribI3ui (GLuint index, GLuint x, GLuint y, GLuint z);
 void  glVertexAttribI4ui (GLuint index, GLuint x, GLuint y, GLuint z, GLuint w);
 void  glVertexAttribI1iv (GLuint index, const GLint *v);
 void  glVertexAttribI2iv (GLuint index, const GLint *v);
 void  glVertexAttribI3iv (GLuint index, const GLint *v);
 void  glVertexAttribI4iv (GLuint index, const GLint *v);
 void  glVertexAttribI1uiv (GLuint index, const GLuint *v);
 void  glVertexAttribI2uiv (GLuint index, const GLuint *v);
 void  glVertexAttribI3uiv (GLuint index, const GLuint *v);
 void  glVertexAttribI4uiv (GLuint index, const GLuint *v);
 void  glVertexAttribI4bv (GLuint index, const GLbyte *v);
 void  glVertexAttribI4sv (GLuint index, const GLshort *v);
 void  glVertexAttribI4ubv (GLuint index, const GLubyte *v);
 void  glVertexAttribI4usv (GLuint index, const GLushort *v);
 void  glGetUniformuiv (GLuint program, GLint location, GLuint *params);
 void  glBindFragDataLocation (GLuint program, GLuint color, const GLchar *name);
 GLint  glGetFragDataLocation (GLuint program, const GLchar *name);
 void  glUniform1ui (GLint location, GLuint v0);
 void  glUniform2ui (GLint location, GLuint v0, GLuint v1);
 void  glUniform3ui (GLint location, GLuint v0, GLuint v1, GLuint v2);
 void  glUniform4ui (GLint location, GLuint v0, GLuint v1, GLuint v2, GLuint v3);
 void  glUniform1uiv (GLint location, GLsizei count, const GLuint *value);
 void  glUniform2uiv (GLint location, GLsizei count, const GLuint *value);
 void  glUniform3uiv (GLint location, GLsizei count, const GLuint *value);
 void  glUniform4uiv (GLint location, GLsizei count, const GLuint *value);
 void  glTexParameterIiv (GLenum target, GLenum pname, const GLint *params);
 void  glTexParameterIuiv (GLenum target, GLenum pname, const GLuint *params);
 void  glGetTexParameterIiv (GLenum target, GLenum pname, GLint *params);
 void  glGetTexParameterIuiv (GLenum target, GLenum pname, GLuint *params);
 void  glClearBufferiv (GLenum buffer, GLint drawbuffer, const GLint *value);
 void  glClearBufferuiv (GLenum buffer, GLint drawbuffer, const GLuint *value);
 void  glClearBufferfv (GLenum buffer, GLint drawbuffer, const GLfloat *value);
 void  glClearBufferfi (GLenum buffer, GLint drawbuffer, GLfloat depth, GLint stencil);
 const GLubyte *  glGetStringi (GLenum name, GLuint index);
typedef void (* PFNGLCOLORMASKIPROC) (GLuint index, GLboolean r, GLboolean g, GLboolean b, GLboolean a);
typedef void (* PFNGLGETBOOLEANI_VPROC) (GLenum target, GLuint index, GLboolean *data);
typedef void (* PFNGLGETINTEGERI_VPROC) (GLenum target, GLuint index, GLint *data);
typedef void (* PFNGLENABLEIPROC) (GLenum target, GLuint index);
typedef void (* PFNGLDISABLEIPROC) (GLenum target, GLuint index);
typedef GLboolean (* PFNGLISENABLEDIPROC) (GLenum target, GLuint index);
typedef void (* PFNGLBEGINTRANSFORMFEEDBACKPROC) (GLenum primitiveMode);
typedef void (* PFNGLENDTRANSFORMFEEDBACKPROC) (void);
typedef void (* PFNGLBINDBUFFERRANGEPROC) (GLenum target, GLuint index, GLuint buffer, GLintptr offset, GLsizeiptr size);
typedef void (* PFNGLBINDBUFFERBASEPROC) (GLenum target, GLuint index, GLuint buffer);
typedef void (* PFNGLTRANSFORMFEEDBACKVARYINGSPROC) (GLuint program, GLsizei count, const GLchar* const *varyings, GLenum bufferMode);
typedef void (* PFNGLGETTRANSFORMFEEDBACKVARYINGPROC) (GLuint program, GLuint index, GLsizei bufSize, GLsizei *length, GLsizei *size, GLenum *type, GLchar *name);
typedef void (* PFNGLCLAMPCOLORPROC) (GLenum target, GLenum clamp);
typedef void (* PFNGLBEGINCONDITIONALRENDERPROC) (GLuint id, GLenum mode);
typedef void (* PFNGLENDCONDITIONALRENDERPROC) (void);
typedef void (* PFNGLVERTEXATTRIBIPOINTERPROC) (GLuint index, GLint size, GLenum type, GLsizei stride, const GLvoid *pointer);
typedef void (* PFNGLGETVERTEXATTRIBIIVPROC) (GLuint index, GLenum pname, GLint *params);
typedef void (* PFNGLGETVERTEXATTRIBIUIVPROC) (GLuint index, GLenum pname, GLuint *params);
typedef void (* PFNGLVERTEXATTRIBI1IPROC) (GLuint index, GLint x);
typedef void (* PFNGLVERTEXATTRIBI2IPROC) (GLuint index, GLint x, GLint y);
typedef void (* PFNGLVERTEXATTRIBI3IPROC) (GLuint index, GLint x, GLint y, GLint z);
typedef void (* PFNGLVERTEXATTRIBI4IPROC) (GLuint index, GLint x, GLint y, GLint z, GLint w);
typedef void (* PFNGLVERTEXATTRIBI1UIPROC) (GLuint index, GLuint x);
typedef void (* PFNGLVERTEXATTRIBI2UIPROC) (GLuint index, GLuint x, GLuint y);
typedef void (* PFNGLVERTEXATTRIBI3UIPROC) (GLuint index, GLuint x, GLuint y, GLuint z);
typedef void (* PFNGLVERTEXATTRIBI4UIPROC) (GLuint index, GLuint x, GLuint y, GLuint z, GLuint w);
typedef void (* PFNGLVERTEXATTRIBI1IVPROC) (GLuint index, const GLint *v);
typedef void (* PFNGLVERTEXATTRIBI2IVPROC) (GLuint index, const GLint *v);
typedef void (* PFNGLVERTEXATTRIBI3IVPROC) (GLuint index, const GLint *v);
typedef void (* PFNGLVERTEXATTRIBI4IVPROC) (GLuint index, const GLint *v);
typedef void (* PFNGLVERTEXATTRIBI1UIVPROC) (GLuint index, const GLuint *v);
typedef void (* PFNGLVERTEXATTRIBI2UIVPROC) (GLuint index, const GLuint *v);
typedef void (* PFNGLVERTEXATTRIBI3UIVPROC) (GLuint index, const GLuint *v);
typedef void (* PFNGLVERTEXATTRIBI4UIVPROC) (GLuint index, const GLuint *v);
typedef void (* PFNGLVERTEXATTRIBI4BVPROC) (GLuint index, const GLbyte *v);
typedef void (* PFNGLVERTEXATTRIBI4SVPROC) (GLuint index, const GLshort *v);
typedef void (* PFNGLVERTEXATTRIBI4UBVPROC) (GLuint index, const GLubyte *v);
typedef void (* PFNGLVERTEXATTRIBI4USVPROC) (GLuint index, const GLushort *v);
typedef void (* PFNGLGETUNIFORMUIVPROC) (GLuint program, GLint location, GLuint *params);
typedef void (* PFNGLBINDFRAGDATALOCATIONPROC) (GLuint program, GLuint color, const GLchar *name);
typedef GLint (* PFNGLGETFRAGDATALOCATIONPROC) (GLuint program, const GLchar *name);
typedef void (* PFNGLUNIFORM1UIPROC) (GLint location, GLuint v0);
typedef void (* PFNGLUNIFORM2UIPROC) (GLint location, GLuint v0, GLuint v1);
typedef void (* PFNGLUNIFORM3UIPROC) (GLint location, GLuint v0, GLuint v1, GLuint v2);
typedef void (* PFNGLUNIFORM4UIPROC) (GLint location, GLuint v0, GLuint v1, GLuint v2, GLuint v3);
typedef void (* PFNGLUNIFORM1UIVPROC) (GLint location, GLsizei count, const GLuint *value);
typedef void (* PFNGLUNIFORM2UIVPROC) (GLint location, GLsizei count, const GLuint *value);
typedef void (* PFNGLUNIFORM3UIVPROC) (GLint location, GLsizei count, const GLuint *value);
typedef void (* PFNGLUNIFORM4UIVPROC) (GLint location, GLsizei count, const GLuint *value);
typedef void (* PFNGLTEXPARAMETERIIVPROC) (GLenum target, GLenum pname, const GLint *params);
typedef void (* PFNGLTEXPARAMETERIUIVPROC) (GLenum target, GLenum pname, const GLuint *params);
typedef void (* PFNGLGETTEXPARAMETERIIVPROC) (GLenum target, GLenum pname, GLint *params);
typedef void (* PFNGLGETTEXPARAMETERIUIVPROC) (GLenum target, GLenum pname, GLuint *params);
typedef void (* PFNGLCLEARBUFFERIVPROC) (GLenum buffer, GLint drawbuffer, const GLint *value);
typedef void (* PFNGLCLEARBUFFERUIVPROC) (GLenum buffer, GLint drawbuffer, const GLuint *value);
typedef void (* PFNGLCLEARBUFFERFVPROC) (GLenum buffer, GLint drawbuffer, const GLfloat *value);
typedef void (* PFNGLCLEARBUFFERFIPROC) (GLenum buffer, GLint drawbuffer, GLfloat depth, GLint stencil);
typedef const GLubyte * (* PFNGLGETSTRINGIPROC) (GLenum name, GLuint index);

/* GL_VERSION_3_1 */
/* OpenGL 3.1 also reuses entry points from these extensions: */
/* ARB_copy_buffer */
/* ARB_uniform_buffer_object */
 void  glDrawArraysInstanced (GLenum mode, GLint first, GLsizei count, GLsizei instancecount);
 void  glDrawElementsInstanced (GLenum mode, GLsizei count, GLenum type, const GLvoid *indices, GLsizei instancecount);
 void  glTexBuffer (GLenum target, GLenum internalformat, GLuint buffer);
 void  glPrimitiveRestartIndex (GLuint index);
typedef void (* PFNGLDRAWARRAYSINSTANCEDPROC) (GLenum mode, GLint first, GLsizei count, GLsizei instancecount);
typedef void (* PFNGLDRAWELEMENTSINSTANCEDPROC) (GLenum mode, GLsizei count, GLenum type, const GLvoid *indices, GLsizei instancecount);
typedef void (* PFNGLTEXBUFFERPROC) (GLenum target, GLenum internalformat, GLuint buffer);
typedef void (* PFNGLPRIMITIVERESTARTINDEXPROC) (GLuint index);

/* GL_VERSION_3_2 */
/* OpenGL 3.2 also reuses entry points from these extensions: */
/* ARB_draw_elements_base_vertex */
/* ARB_provoking_vertex */
/* ARB_sync */
/* ARB_texture_multisample */
 void  glGetInteger64i_v (GLenum target, GLuint index, GLint64 *data);
 void  glGetBufferParameteri64v (GLenum target, GLenum pname, GLint64 *params);
 void  glFramebufferTexture (GLenum target, GLenum attachment, GLuint texture, GLint level);
typedef void (* PFNGLGETINTEGER64I_VPROC) (GLenum target, GLuint index, GLint64 *data);
typedef void (* PFNGLGETBUFFERPARAMETERI64VPROC) (GLenum target, GLenum pname, GLint64 *params);
typedef void (* PFNGLFRAMEBUFFERTEXTUREPROC) (GLenum target, GLenum attachment, GLuint texture, GLint level);

/* GL_VERSION_3_3 */
/* OpenGL 3.3 also reuses entry points from these extensions: */
/* ARB_blend_func_extended */
/* ARB_sampler_objects */
/* ARB_explicit_attrib_location, but it has none */
/* ARB_occlusion_query2 (no entry points) */
/* ARB_shader_bit_encoding (no entry points) */
/* ARB_texture_rgb10_a2ui (no entry points) */
/* ARB_texture_swizzle (no entry points) */
/* ARB_timer_query */
/* ARB_vertex_type_2_10_10_10_rev */
 void  glVertexAttribDivisor (GLuint index, GLuint divisor);
typedef void (* PFNGLVERTEXATTRIBDIVISORPROC) (GLuint index, GLuint divisor);

/* GL_VERSION_4_0 */
/* OpenGL 4.0 also reuses entry points from these extensions: */
/* ARB_texture_query_lod (no entry points) */
/* ARB_draw_indirect */
/* ARB_gpu_shader5 (no entry points) */
/* ARB_gpu_shader_fp64 */
/* ARB_shader_subroutine */
/* ARB_tessellation_shader */
/* ARB_texture_buffer_object_rgb32 (no entry points) */
/* ARB_texture_cube_map_array (no entry points) */
/* ARB_texture_gather (no entry points) */
/* ARB_transform_feedback2 */
/* ARB_transform_feedback3 */
 void  glMinSampleShading (GLfloat value);
 void  glBlendEquationi (GLuint buf, GLenum mode);
 void  glBlendEquationSeparatei (GLuint buf, GLenum modeRGB, GLenum modeAlpha);
 void  glBlendFunci (GLuint buf, GLenum src, GLenum dst);
 void  glBlendFuncSeparatei (GLuint buf, GLenum srcRGB, GLenum dstRGB, GLenum srcAlpha, GLenum dstAlpha);
typedef void (* PFNGLMINSAMPLESHADINGPROC) (GLfloat value);
typedef void (* PFNGLBLENDEQUATIONIPROC) (GLuint buf, GLenum mode);
typedef void (* PFNGLBLENDEQUATIONSEPARATEIPROC) (GLuint buf, GLenum modeRGB, GLenum modeAlpha);
typedef void (* PFNGLBLENDFUNCIPROC) (GLuint buf, GLenum src, GLenum dst);
typedef void (* PFNGLBLENDFUNCSEPARATEIPROC) (GLuint buf, GLenum srcRGB, GLenum dstRGB, GLenum srcAlpha, GLenum dstAlpha);

/* GL_VERSION_4_1 */
/* OpenGL 4.1 reuses entry points from these extensions: */
/* ARB_ES2_compatibility */
/* ARB_get_program_binary */
/* ARB_separate_shader_objects */
/* ARB_shader_precision (no entry points) */
/* ARB_vertex_attrib_64bit */
/* ARB_viewport_array */

/* GL_VERSION_4_2 */
/* OpenGL 4.2 reuses entry points from these extensions: */
/* ARB_base_instance */
/* ARB_shading_language_420pack (no entry points) */
/* ARB_transform_feedback_instanced */
/* ARB_compressed_texture_pixel_storage (no entry points) */
/* ARB_conservative_depth (no entry points) */
/* ARB_internalformat_query */
/* ARB_map_buffer_alignment (no entry points) */
/* ARB_shader_atomic_counters */
/* ARB_shader_image_load_store */
/* ARB_shading_language_packing (no entry points) */
/* ARB_texture_storage */

/* GL_VERSION_4_3 */
/* OpenGL 4.3 reuses entry points from these extensions: */
/* ARB_arrays_of_arrays (no entry points, GLSL only) */
/* ARB_fragment_layer_viewport (no entry points, GLSL only) */
/* ARB_shader_image_size (no entry points, GLSL only) */
/* ARB_ES3_compatibility (no entry points) */
/* ARB_clear_buffer_object */
/* ARB_compute_shader */
/* ARB_copy_image */
/* KHR_debug (includes ARB_debug_output commands promoted to KHR without suffixes) */
/* ARB_explicit_uniform_location (no entry points) */
/* ARB_framebuffer_no_attachments */
/* ARB_internalformat_query2 */
/* ARB_invalidate_subdata */
/* ARB_multi_draw_indirect */
/* ARB_program_interface_query */
/* ARB_robust_buffer_access_behavior (no entry points) */
/* ARB_shader_storage_buffer_object */
/* ARB_stencil_texturing (no entry points) */
/* ARB_texture_buffer_range */
/* ARB_texture_query_levels (no entry points) */
/* ARB_texture_storage_multisample */
/* ARB_texture_view */
/* ARB_vertex_attrib_binding */

/* GL_ARB_depth_buffer_float */

/* GL_ARB_framebuffer_object */
 GLboolean  glIsRenderbuffer (GLuint renderbuffer);
 void  glBindRenderbuffer (GLenum target, GLuint renderbuffer);
 void  glDeleteRenderbuffers (GLsizei n, const GLuint *renderbuffers);
 void  glGenRenderbuffers (GLsizei n, GLuint *renderbuffers);
 void  glRenderbufferStorage (GLenum target, GLenum internalformat, GLsizei width, GLsizei height);
 void  glGetRenderbufferParameteriv (GLenum target, GLenum pname, GLint *params);
 GLboolean  glIsFramebuffer (GLuint framebuffer);
 void  glBindFramebuffer (GLenum target, GLuint framebuffer);
 void  glDeleteFramebuffers (GLsizei n, const GLuint *framebuffers);
 void  glGenFramebuffers (GLsizei n, GLuint *framebuffers);
 GLenum  glCheckFramebufferStatus (GLenum target);
 void  glFramebufferTexture1D (GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level);
 void  glFramebufferTexture2D (GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level);
 void  glFramebufferTexture3D (GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level, GLint zoffset);
 void  glFramebufferRenderbuffer (GLenum target, GLenum attachment, GLenum renderbuffertarget, GLuint renderbuffer);
 void  glGetFramebufferAttachmentParameteriv (GLenum target, GLenum attachment, GLenum pname, GLint *params);
 void  glGenerateMipmap (GLenum target);
 void  glBlitFramebuffer (GLint srcX0, GLint srcY0, GLint srcX1, GLint srcY1, GLint dstX0, GLint dstY0, GLint dstX1, GLint dstY1, GLbitfield mask, GLenum filter);
 void  glRenderbufferStorageMultisample (GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height);
 void  glFramebufferTextureLayer (GLenum target, GLenum attachment, GLuint texture, GLint level, GLint layer);
typedef GLboolean (* PFNGLISRENDERBUFFERPROC) (GLuint renderbuffer);
typedef void (* PFNGLBINDRENDERBUFFERPROC) (GLenum target, GLuint renderbuffer);
typedef void (* PFNGLDELETERENDERBUFFERSPROC) (GLsizei n, const GLuint *renderbuffers);
typedef void (* PFNGLGENRENDERBUFFERSPROC) (GLsizei n, GLuint *renderbuffers);
typedef void (* PFNGLRENDERBUFFERSTORAGEPROC) (GLenum target, GLenum internalformat, GLsizei width, GLsizei height);
typedef void (* PFNGLGETRENDERBUFFERPARAMETERIVPROC) (GLenum target, GLenum pname, GLint *params);
typedef GLboolean (* PFNGLISFRAMEBUFFERPROC) (GLuint framebuffer);
typedef void (* PFNGLBINDFRAMEBUFFERPROC) (GLenum target, GLuint framebuffer);
typedef void (* PFNGLDELETEFRAMEBUFFERSPROC) (GLsizei n, const GLuint *framebuffers);
typedef void (* PFNGLGENFRAMEBUFFERSPROC) (GLsizei n, GLuint *framebuffers);
typedef GLenum (* PFNGLCHECKFRAMEBUFFERSTATUSPROC) (GLenum target);
typedef void (* PFNGLFRAMEBUFFERTEXTURE1DPROC) (GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level);
typedef void (* PFNGLFRAMEBUFFERTEXTURE2DPROC) (GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level);
typedef void (* PFNGLFRAMEBUFFERTEXTURE3DPROC) (GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level, GLint zoffset);
typedef void (* PFNGLFRAMEBUFFERRENDERBUFFERPROC) (GLenum target, GLenum attachment, GLenum renderbuffertarget, GLuint renderbuffer);
typedef void (* PFNGLGETFRAMEBUFFERATTACHMENTPARAMETERIVPROC) (GLenum target, GLenum attachment, GLenum pname, GLint *params);
typedef void (* PFNGLGENERATEMIPMAPPROC) (GLenum target);
typedef void (* PFNGLBLITFRAMEBUFFERPROC) (GLint srcX0, GLint srcY0, GLint srcX1, GLint srcY1, GLint dstX0, GLint dstY0, GLint dstX1, GLint dstY1, GLbitfield mask, GLenum filter);
typedef void (* PFNGLRENDERBUFFERSTORAGEMULTISAMPLEPROC) (GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height);
typedef void (* PFNGLFRAMEBUFFERTEXTURELAYERPROC) (GLenum target, GLenum attachment, GLuint texture, GLint level, GLint layer);

/* GL_ARB_framebuffer_sRGB */

/* GL_ARB_half_float_vertex */

/* GL_ARB_map_buffer_range */
 GLvoid*  glMapBufferRange (GLenum target, GLintptr offset, GLsizeiptr length, GLbitfield access);
 void  glFlushMappedBufferRange (GLenum target, GLintptr offset, GLsizeiptr length);
typedef GLvoid* (* PFNGLMAPBUFFERRANGEPROC) (GLenum target, GLintptr offset, GLsizeiptr length, GLbitfield access);
typedef void (* PFNGLFLUSHMAPPEDBUFFERRANGEPROC) (GLenum target, GLintptr offset, GLsizeiptr length);

/* GL_ARB_texture_compression_rgtc */

/* GL_ARB_texture_rg */

/* GL_ARB_vertex_array_object */
 void  glBindVertexArray (GLuint array);
 void  glDeleteVertexArrays (GLsizei n, const GLuint *arrays);
 void  glGenVertexArrays (GLsizei n, GLuint *arrays);
 GLboolean  glIsVertexArray (GLuint array);
typedef void (* PFNGLBINDVERTEXARRAYPROC) (GLuint array);
typedef void (* PFNGLDELETEVERTEXARRAYSPROC) (GLsizei n, const GLuint *arrays);
typedef void (* PFNGLGENVERTEXARRAYSPROC) (GLsizei n, GLuint *arrays);
typedef GLboolean (* PFNGLISVERTEXARRAYPROC) (GLuint array);

/* GL_ARB_uniform_buffer_object */
 void  glGetUniformIndices (GLuint program, GLsizei uniformCount, const GLchar* const *uniformNames, GLuint *uniformIndices);
 void  glGetActiveUniformsiv (GLuint program, GLsizei uniformCount, const GLuint *uniformIndices, GLenum pname, GLint *params);
 void  glGetActiveUniformName (GLuint program, GLuint uniformIndex, GLsizei bufSize, GLsizei *length, GLchar *uniformName);
 GLuint  glGetUniformBlockIndex (GLuint program, const GLchar *uniformBlockName);
 void  glGetActiveUniformBlockiv (GLuint program, GLuint uniformBlockIndex, GLenum pname, GLint *params);
 void  glGetActiveUniformBlockName (GLuint program, GLuint uniformBlockIndex, GLsizei bufSize, GLsizei *length, GLchar *uniformBlockName);
 void  glUniformBlockBinding (GLuint program, GLuint uniformBlockIndex, GLuint uniformBlockBinding);
typedef void (* PFNGLGETUNIFORMINDICESPROC) (GLuint program, GLsizei uniformCount, const GLchar* const *uniformNames, GLuint *uniformIndices);
typedef void (* PFNGLGETACTIVEUNIFORMSIVPROC) (GLuint program, GLsizei uniformCount, const GLuint *uniformIndices, GLenum pname, GLint *params);
typedef void (* PFNGLGETACTIVEUNIFORMNAMEPROC) (GLuint program, GLuint uniformIndex, GLsizei bufSize, GLsizei *length, GLchar *uniformName);
typedef GLuint (* PFNGLGETUNIFORMBLOCKINDEXPROC) (GLuint program, const GLchar *uniformBlockName);
typedef void (* PFNGLGETACTIVEUNIFORMBLOCKIVPROC) (GLuint program, GLuint uniformBlockIndex, GLenum pname, GLint *params);
typedef void (* PFNGLGETACTIVEUNIFORMBLOCKNAMEPROC) (GLuint program, GLuint uniformBlockIndex, GLsizei bufSize, GLsizei *length, GLchar *uniformBlockName);
typedef void (* PFNGLUNIFORMBLOCKBINDINGPROC) (GLuint program, GLuint uniformBlockIndex, GLuint uniformBlockBinding);

/* GL_ARB_copy_buffer */
 void  glCopyBufferSubData (GLenum readTarget, GLenum writeTarget, GLintptr readOffset, GLintptr writeOffset, GLsizeiptr size);
typedef void (* PFNGLCOPYBUFFERSUBDATAPROC) (GLenum readTarget, GLenum writeTarget, GLintptr readOffset, GLintptr writeOffset, GLsizeiptr size);

/* GL_ARB_depth_clamp */

/* GL_ARB_draw_elements_base_vertex */
 void  glDrawElementsBaseVertex (GLenum mode, GLsizei count, GLenum type, const GLvoid *indices, GLint basevertex);
 void  glDrawRangeElementsBaseVertex (GLenum mode, GLuint start, GLuint end, GLsizei count, GLenum type, const GLvoid *indices, GLint basevertex);
 void  glDrawElementsInstancedBaseVertex (GLenum mode, GLsizei count, GLenum type, const GLvoid *indices, GLsizei instancecount, GLint basevertex);
 void  glMultiDrawElementsBaseVertex (GLenum mode, const GLsizei *count, GLenum type, const GLvoid* const *indices, GLsizei drawcount, const GLint *basevertex);
typedef void (* PFNGLDRAWELEMENTSBASEVERTEXPROC) (GLenum mode, GLsizei count, GLenum type, const GLvoid *indices, GLint basevertex);
typedef void (* PFNGLDRAWRANGEELEMENTSBASEVERTEXPROC) (GLenum mode, GLuint start, GLuint end, GLsizei count, GLenum type, const GLvoid *indices, GLint basevertex);
typedef void (* PFNGLDRAWELEMENTSINSTANCEDBASEVERTEXPROC) (GLenum mode, GLsizei count, GLenum type, const GLvoid *indices, GLsizei instancecount, GLint basevertex);
typedef void (* PFNGLMULTIDRAWELEMENTSBASEVERTEXPROC) (GLenum mode, const GLsizei *count, GLenum type, const GLvoid* const *indices, GLsizei drawcount, const GLint *basevertex);

/* GL_ARB_fragment_coord_conventions */

/* GL_ARB_provoking_vertex */
 void  glProvokingVertex (GLenum mode);
typedef void (* PFNGLPROVOKINGVERTEXPROC) (GLenum mode);

/* GL_ARB_seamless_cube_map */

/* GL_ARB_sync */
 GLsync  glFenceSync (GLenum condition, GLbitfield flags);
 GLboolean  glIsSync (GLsync sync);
 void  glDeleteSync (GLsync sync);
 GLenum  glClientWaitSync (GLsync sync, GLbitfield flags, GLuint64 timeout);
 void  glWaitSync (GLsync sync, GLbitfield flags, GLuint64 timeout);
 void  glGetInteger64v (GLenum pname, GLint64 *params);
 void  glGetSynciv (GLsync sync, GLenum pname, GLsizei bufSize, GLsizei *length, GLint *values);
typedef GLsync (* PFNGLFENCESYNCPROC) (GLenum condition, GLbitfield flags);
typedef GLboolean (* PFNGLISSYNCPROC) (GLsync sync);
typedef void (* PFNGLDELETESYNCPROC) (GLsync sync);
typedef GLenum (* PFNGLCLIENTWAITSYNCPROC) (GLsync sync, GLbitfield flags, GLuint64 timeout);
typedef void (* PFNGLWAITSYNCPROC) (GLsync sync, GLbitfield flags, GLuint64 timeout);
typedef void (* PFNGLGETINTEGER64VPROC) (GLenum pname, GLint64 *params);
typedef void (* PFNGLGETSYNCIVPROC) (GLsync sync, GLenum pname, GLsizei bufSize, GLsizei *length, GLint *values);

/* GL_ARB_texture_multisample */
 void  glTexImage2DMultisample (GLenum target, GLsizei samples, GLint internalformat, GLsizei width, GLsizei height, GLboolean fixedsamplelocations);
 void  glTexImage3DMultisample (GLenum target, GLsizei samples, GLint internalformat, GLsizei width, GLsizei height, GLsizei depth, GLboolean fixedsamplelocations);
 void  glGetMultisamplefv (GLenum pname, GLuint index, GLfloat *val);
 void  glSampleMaski (GLuint index, GLbitfield mask);
typedef void (* PFNGLTEXIMAGE2DMULTISAMPLEPROC) (GLenum target, GLsizei samples, GLint internalformat, GLsizei width, GLsizei height, GLboolean fixedsamplelocations);
typedef void (* PFNGLTEXIMAGE3DMULTISAMPLEPROC) (GLenum target, GLsizei samples, GLint internalformat, GLsizei width, GLsizei height, GLsizei depth, GLboolean fixedsamplelocations);
typedef void (* PFNGLGETMULTISAMPLEFVPROC) (GLenum pname, GLuint index, GLfloat *val);
typedef void (* PFNGLSAMPLEMASKIPROC) (GLuint index, GLbitfield mask);

/* GL_ARB_vertex_array_bgra */

/* GL_ARB_draw_buffers_blend */
 void  glBlendEquationiARB (GLuint buf, GLenum mode);
 void  glBlendEquationSeparateiARB (GLuint buf, GLenum modeRGB, GLenum modeAlpha);
 void  glBlendFunciARB (GLuint buf, GLenum src, GLenum dst);
 void  glBlendFuncSeparateiARB (GLuint buf, GLenum srcRGB, GLenum dstRGB, GLenum srcAlpha, GLenum dstAlpha);
typedef void (* PFNGLBLENDEQUATIONIARBPROC) (GLuint buf, GLenum mode);
typedef void (* PFNGLBLENDEQUATIONSEPARATEIARBPROC) (GLuint buf, GLenum modeRGB, GLenum modeAlpha);
typedef void (* PFNGLBLENDFUNCIARBPROC) (GLuint buf, GLenum src, GLenum dst);
typedef void (* PFNGLBLENDFUNCSEPARATEIARBPROC) (GLuint buf, GLenum srcRGB, GLenum dstRGB, GLenum srcAlpha, GLenum dstAlpha);

/* GL_ARB_sample_shading */
 void  glMinSampleShadingARB (GLfloat value);
typedef void (* PFNGLMINSAMPLESHADINGARBPROC) (GLfloat value);

/* GL_ARB_texture_cube_map_array */

/* GL_ARB_texture_gather */

/* GL_ARB_texture_query_lod */

/* GL_ARB_shading_language_include */
 void  glNamedStringARB (GLenum type, GLint namelen, const GLchar *name, GLint stringlen, const GLchar *string);
 void  glDeleteNamedStringARB (GLint namelen, const GLchar *name);
 void  glCompileShaderIncludeARB (GLuint shader, GLsizei count, const GLchar* *path, const GLint *length);
 GLboolean  glIsNamedStringARB (GLint namelen, const GLchar *name);
 void  glGetNamedStringARB (GLint namelen, const GLchar *name, GLsizei bufSize, GLint *stringlen, GLchar *string);
 void  glGetNamedStringivARB (GLint namelen, const GLchar *name, GLenum pname, GLint *params);
typedef void (* PFNGLNAMEDSTRINGARBPROC) (GLenum type, GLint namelen, const GLchar *name, GLint stringlen, const GLchar *string);
typedef void (* PFNGLDELETENAMEDSTRINGARBPROC) (GLint namelen, const GLchar *name);
typedef void (* PFNGLCOMPILESHADERINCLUDEARBPROC) (GLuint shader, GLsizei count, const GLchar* *path, const GLint *length);
typedef GLboolean (* PFNGLISNAMEDSTRINGARBPROC) (GLint namelen, const GLchar *name);
typedef void (* PFNGLGETNAMEDSTRINGARBPROC) (GLint namelen, const GLchar *name, GLsizei bufSize, GLint *stringlen, GLchar *string);
typedef void (* PFNGLGETNAMEDSTRINGIVARBPROC) (GLint namelen, const GLchar *name, GLenum pname, GLint *params);

/* GL_ARB_texture_compression_bptc */

/* GL_ARB_blend_func_extended */
 void  glBindFragDataLocationIndexed (GLuint program, GLuint colorNumber, GLuint index, const GLchar *name);
 GLint  glGetFragDataIndex (GLuint program, const GLchar *name);
typedef void (* PFNGLBINDFRAGDATALOCATIONINDEXEDPROC) (GLuint program, GLuint colorNumber, GLuint index, const GLchar *name);
typedef GLint (* PFNGLGETFRAGDATAINDEXPROC) (GLuint program, const GLchar *name);

/* GL_ARB_explicit_attrib_location */

/* GL_ARB_occlusion_query2 */

/* GL_ARB_sampler_objects */
 void  glGenSamplers (GLsizei count, GLuint *samplers);
 void  glDeleteSamplers (GLsizei count, const GLuint *samplers);
 GLboolean  glIsSampler (GLuint sampler);
 void  glBindSampler (GLuint unit, GLuint sampler);
 void  glSamplerParameteri (GLuint sampler, GLenum pname, GLint param);
 void  glSamplerParameteriv (GLuint sampler, GLenum pname, const GLint *param);
 void  glSamplerParameterf (GLuint sampler, GLenum pname, GLfloat param);
 void  glSamplerParameterfv (GLuint sampler, GLenum pname, const GLfloat *param);
 void  glSamplerParameterIiv (GLuint sampler, GLenum pname, const GLint *param);
 void  glSamplerParameterIuiv (GLuint sampler, GLenum pname, const GLuint *param);
 void  glGetSamplerParameteriv (GLuint sampler, GLenum pname, GLint *params);
 void  glGetSamplerParameterIiv (GLuint sampler, GLenum pname, GLint *params);
 void  glGetSamplerParameterfv (GLuint sampler, GLenum pname, GLfloat *params);
 void  glGetSamplerParameterIuiv (GLuint sampler, GLenum pname, GLuint *params);
typedef void (* PFNGLGENSAMPLERSPROC) (GLsizei count, GLuint *samplers);
typedef void (* PFNGLDELETESAMPLERSPROC) (GLsizei count, const GLuint *samplers);
typedef GLboolean (* PFNGLISSAMPLERPROC) (GLuint sampler);
typedef void (* PFNGLBINDSAMPLERPROC) (GLuint unit, GLuint sampler);
typedef void (* PFNGLSAMPLERPARAMETERIPROC) (GLuint sampler, GLenum pname, GLint param);
typedef void (* PFNGLSAMPLERPARAMETERIVPROC) (GLuint sampler, GLenum pname, const GLint *param);
typedef void (* PFNGLSAMPLERPARAMETERFPROC) (GLuint sampler, GLenum pname, GLfloat param);
typedef void (* PFNGLSAMPLERPARAMETERFVPROC) (GLuint sampler, GLenum pname, const GLfloat *param);
typedef void (* PFNGLSAMPLERPARAMETERIIVPROC) (GLuint sampler, GLenum pname, const GLint *param);
typedef void (* PFNGLSAMPLERPARAMETERIUIVPROC) (GLuint sampler, GLenum pname, const GLuint *param);
typedef void (* PFNGLGETSAMPLERPARAMETERIVPROC) (GLuint sampler, GLenum pname, GLint *params);
typedef void (* PFNGLGETSAMPLERPARAMETERIIVPROC) (GLuint sampler, GLenum pname, GLint *params);
typedef void (* PFNGLGETSAMPLERPARAMETERFVPROC) (GLuint sampler, GLenum pname, GLfloat *params);
typedef void (* PFNGLGETSAMPLERPARAMETERIUIVPROC) (GLuint sampler, GLenum pname, GLuint *params);

/* GL_ARB_shader_bit_encoding */

/* GL_ARB_texture_rgb10_a2ui */

/* GL_ARB_texture_swizzle */

/* GL_ARB_timer_query */
 void  glQueryCounter (GLuint id, GLenum target);
 void  glGetQueryObjecti64v (GLuint id, GLenum pname, GLint64 *params);
 void  glGetQueryObjectui64v (GLuint id, GLenum pname, GLuint64 *params);
typedef void (* PFNGLQUERYCOUNTERPROC) (GLuint id, GLenum target);
typedef void (* PFNGLGETQUERYOBJECTI64VPROC) (GLuint id, GLenum pname, GLint64 *params);
typedef void (* PFNGLGETQUERYOBJECTUI64VPROC) (GLuint id, GLenum pname, GLuint64 *params);

/* GL_ARB_vertex_type_2_10_10_10_rev */
 void  glVertexP2ui (GLenum type, GLuint value);
 void  glVertexP2uiv (GLenum type, const GLuint *value);
 void  glVertexP3ui (GLenum type, GLuint value);
 void  glVertexP3uiv (GLenum type, const GLuint *value);
 void  glVertexP4ui (GLenum type, GLuint value);
 void  glVertexP4uiv (GLenum type, const GLuint *value);
 void  glTexCoordP1ui (GLenum type, GLuint coords);
 void  glTexCoordP1uiv (GLenum type, const GLuint *coords);
 void  glTexCoordP2ui (GLenum type, GLuint coords);
 void  glTexCoordP2uiv (GLenum type, const GLuint *coords);
 void  glTexCoordP3ui (GLenum type, GLuint coords);
 void  glTexCoordP3uiv (GLenum type, const GLuint *coords);
 void  glTexCoordP4ui (GLenum type, GLuint coords);
 void  glTexCoordP4uiv (GLenum type, const GLuint *coords);
 void  glMultiTexCoordP1ui (GLenum texture, GLenum type, GLuint coords);
 void  glMultiTexCoordP1uiv (GLenum texture, GLenum type, const GLuint *coords);
 void  glMultiTexCoordP2ui (GLenum texture, GLenum type, GLuint coords);
 void  glMultiTexCoordP2uiv (GLenum texture, GLenum type, const GLuint *coords);
 void  glMultiTexCoordP3ui (GLenum texture, GLenum type, GLuint coords);
 void  glMultiTexCoordP3uiv (GLenum texture, GLenum type, const GLuint *coords);
 void  glMultiTexCoordP4ui (GLenum texture, GLenum type, GLuint coords);
 void  glMultiTexCoordP4uiv (GLenum texture, GLenum type, const GLuint *coords);
 void  glNormalP3ui (GLenum type, GLuint coords);
 void  glNormalP3uiv (GLenum type, const GLuint *coords);
 void  glColorP3ui (GLenum type, GLuint color);
 void  glColorP3uiv (GLenum type, const GLuint *color);
 void  glColorP4ui (GLenum type, GLuint color);
 void  glColorP4uiv (GLenum type, const GLuint *color);
 void  glSecondaryColorP3ui (GLenum type, GLuint color);
 void  glSecondaryColorP3uiv (GLenum type, const GLuint *color);
 void  glVertexAttribP1ui (GLuint index, GLenum type, GLboolean normalized, GLuint value);
 void  glVertexAttribP1uiv (GLuint index, GLenum type, GLboolean normalized, const GLuint *value);
 void  glVertexAttribP2ui (GLuint index, GLenum type, GLboolean normalized, GLuint value);
 void  glVertexAttribP2uiv (GLuint index, GLenum type, GLboolean normalized, const GLuint *value);
 void  glVertexAttribP3ui (GLuint index, GLenum type, GLboolean normalized, GLuint value);
 void  glVertexAttribP3uiv (GLuint index, GLenum type, GLboolean normalized, const GLuint *value);
 void  glVertexAttribP4ui (GLuint index, GLenum type, GLboolean normalized, GLuint value);
 void  glVertexAttribP4uiv (GLuint index, GLenum type, GLboolean normalized, const GLuint *value);
typedef void (* PFNGLVERTEXP2UIPROC) (GLenum type, GLuint value);
typedef void (* PFNGLVERTEXP2UIVPROC) (GLenum type, const GLuint *value);
typedef void (* PFNGLVERTEXP3UIPROC) (GLenum type, GLuint value);
typedef void (* PFNGLVERTEXP3UIVPROC) (GLenum type, const GLuint *value);
typedef void (* PFNGLVERTEXP4UIPROC) (GLenum type, GLuint value);
typedef void (* PFNGLVERTEXP4UIVPROC) (GLenum type, const GLuint *value);
typedef void (* PFNGLTEXCOORDP1UIPROC) (GLenum type, GLuint coords);
typedef void (* PFNGLTEXCOORDP1UIVPROC) (GLenum type, const GLuint *coords);
typedef void (* PFNGLTEXCOORDP2UIPROC) (GLenum type, GLuint coords);
typedef void (* PFNGLTEXCOORDP2UIVPROC) (GLenum type, const GLuint *coords);
typedef void (* PFNGLTEXCOORDP3UIPROC) (GLenum type, GLuint coords);
typedef void (* PFNGLTEXCOORDP3UIVPROC) (GLenum type, const GLuint *coords);
typedef void (* PFNGLTEXCOORDP4UIPROC) (GLenum type, GLuint coords);
typedef void (* PFNGLTEXCOORDP4UIVPROC) (GLenum type, const GLuint *coords);
typedef void (* PFNGLMULTITEXCOORDP1UIPROC) (GLenum texture, GLenum type, GLuint coords);
typedef void (* PFNGLMULTITEXCOORDP1UIVPROC) (GLenum texture, GLenum type, const GLuint *coords);
typedef void (* PFNGLMULTITEXCOORDP2UIPROC) (GLenum texture, GLenum type, GLuint coords);
typedef void (* PFNGLMULTITEXCOORDP2UIVPROC) (GLenum texture, GLenum type, const GLuint *coords);
typedef void (* PFNGLMULTITEXCOORDP3UIPROC) (GLenum texture, GLenum type, GLuint coords);
typedef void (* PFNGLMULTITEXCOORDP3UIVPROC) (GLenum texture, GLenum type, const GLuint *coords);
typedef void (* PFNGLMULTITEXCOORDP4UIPROC) (GLenum texture, GLenum type, GLuint coords);
typedef void (* PFNGLMULTITEXCOORDP4UIVPROC) (GLenum texture, GLenum type, const GLuint *coords);
typedef void (* PFNGLNORMALP3UIPROC) (GLenum type, GLuint coords);
typedef void (* PFNGLNORMALP3UIVPROC) (GLenum type, const GLuint *coords);
typedef void (* PFNGLCOLORP3UIPROC) (GLenum type, GLuint color);
typedef void (* PFNGLCOLORP3UIVPROC) (GLenum type, const GLuint *color);
typedef void (* PFNGLCOLORP4UIPROC) (GLenum type, GLuint color);
typedef void (* PFNGLCOLORP4UIVPROC) (GLenum type, const GLuint *color);
typedef void (* PFNGLSECONDARYCOLORP3UIPROC) (GLenum type, GLuint color);
typedef void (* PFNGLSECONDARYCOLORP3UIVPROC) (GLenum type, const GLuint *color);
typedef void (* PFNGLVERTEXATTRIBP1UIPROC) (GLuint index, GLenum type, GLboolean normalized, GLuint value);
typedef void (* PFNGLVERTEXATTRIBP1UIVPROC) (GLuint index, GLenum type, GLboolean normalized, const GLuint *value);
typedef void (* PFNGLVERTEXATTRIBP2UIPROC) (GLuint index, GLenum type, GLboolean normalized, GLuint value);
typedef void (* PFNGLVERTEXATTRIBP2UIVPROC) (GLuint index, GLenum type, GLboolean normalized, const GLuint *value);
typedef void (* PFNGLVERTEXATTRIBP3UIPROC) (GLuint index, GLenum type, GLboolean normalized, GLuint value);
typedef void (* PFNGLVERTEXATTRIBP3UIVPROC) (GLuint index, GLenum type, GLboolean normalized, const GLuint *value);
typedef void (* PFNGLVERTEXATTRIBP4UIPROC) (GLuint index, GLenum type, GLboolean normalized, GLuint value);
typedef void (* PFNGLVERTEXATTRIBP4UIVPROC) (GLuint index, GLenum type, GLboolean normalized, const GLuint *value);

/* GL_ARB_draw_indirect */
 void  glDrawArraysIndirect (GLenum mode, const GLvoid *indirect);
 void  glDrawElementsIndirect (GLenum mode, GLenum type, const GLvoid *indirect);
typedef void (* PFNGLDRAWARRAYSINDIRECTPROC) (GLenum mode, const GLvoid *indirect);
typedef void (* PFNGLDRAWELEMENTSINDIRECTPROC) (GLenum mode, GLenum type, const GLvoid *indirect);

/* GL_ARB_gpu_shader5 */

/* GL_ARB_gpu_shader_fp64 */
 void  glUniform1d (GLint location, GLdouble x);
 void  glUniform2d (GLint location, GLdouble x, GLdouble y);
 void  glUniform3d (GLint location, GLdouble x, GLdouble y, GLdouble z);
 void  glUniform4d (GLint location, GLdouble x, GLdouble y, GLdouble z, GLdouble w);
 void  glUniform1dv (GLint location, GLsizei count, const GLdouble *value);
 void  glUniform2dv (GLint location, GLsizei count, const GLdouble *value);
 void  glUniform3dv (GLint location, GLsizei count, const GLdouble *value);
 void  glUniform4dv (GLint location, GLsizei count, const GLdouble *value);
 void  glUniformMatrix2dv (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
 void  glUniformMatrix3dv (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
 void  glUniformMatrix4dv (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
 void  glUniformMatrix2x3dv (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
 void  glUniformMatrix2x4dv (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
 void  glUniformMatrix3x2dv (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
 void  glUniformMatrix3x4dv (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
 void  glUniformMatrix4x2dv (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
 void  glUniformMatrix4x3dv (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
 void  glGetUniformdv (GLuint program, GLint location, GLdouble *params);
typedef void (* PFNGLUNIFORM1DPROC) (GLint location, GLdouble x);
typedef void (* PFNGLUNIFORM2DPROC) (GLint location, GLdouble x, GLdouble y);
typedef void (* PFNGLUNIFORM3DPROC) (GLint location, GLdouble x, GLdouble y, GLdouble z);
typedef void (* PFNGLUNIFORM4DPROC) (GLint location, GLdouble x, GLdouble y, GLdouble z, GLdouble w);
typedef void (* PFNGLUNIFORM1DVPROC) (GLint location, GLsizei count, const GLdouble *value);
typedef void (* PFNGLUNIFORM2DVPROC) (GLint location, GLsizei count, const GLdouble *value);
typedef void (* PFNGLUNIFORM3DVPROC) (GLint location, GLsizei count, const GLdouble *value);
typedef void (* PFNGLUNIFORM4DVPROC) (GLint location, GLsizei count, const GLdouble *value);
typedef void (* PFNGLUNIFORMMATRIX2DVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void (* PFNGLUNIFORMMATRIX3DVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void (* PFNGLUNIFORMMATRIX4DVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void (* PFNGLUNIFORMMATRIX2X3DVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void (* PFNGLUNIFORMMATRIX2X4DVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void (* PFNGLUNIFORMMATRIX3X2DVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void (* PFNGLUNIFORMMATRIX3X4DVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void (* PFNGLUNIFORMMATRIX4X2DVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void (* PFNGLUNIFORMMATRIX4X3DVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void (* PFNGLGETUNIFORMDVPROC) (GLuint program, GLint location, GLdouble *params);

/* GL_ARB_shader_subroutine */
 GLint  glGetSubroutineUniformLocation (GLuint program, GLenum shadertype, const GLchar *name);
 GLuint  glGetSubroutineIndex (GLuint program, GLenum shadertype, const GLchar *name);
 void  glGetActiveSubroutineUniformiv (GLuint program, GLenum shadertype, GLuint index, GLenum pname, GLint *values);
 void  glGetActiveSubroutineUniformName (GLuint program, GLenum shadertype, GLuint index, GLsizei bufsize, GLsizei *length, GLchar *name);
 void  glGetActiveSubroutineName (GLuint program, GLenum shadertype, GLuint index, GLsizei bufsize, GLsizei *length, GLchar *name);
 void  glUniformSubroutinesuiv (GLenum shadertype, GLsizei count, const GLuint *indices);
 void  glGetUniformSubroutineuiv (GLenum shadertype, GLint location, GLuint *params);
 void  glGetProgramStageiv (GLuint program, GLenum shadertype, GLenum pname, GLint *values);
typedef GLint (* PFNGLGETSUBROUTINEUNIFORMLOCATIONPROC) (GLuint program, GLenum shadertype, const GLchar *name);
typedef GLuint (* PFNGLGETSUBROUTINEINDEXPROC) (GLuint program, GLenum shadertype, const GLchar *name);
typedef void (* PFNGLGETACTIVESUBROUTINEUNIFORMIVPROC) (GLuint program, GLenum shadertype, GLuint index, GLenum pname, GLint *values);
typedef void (* PFNGLGETACTIVESUBROUTINEUNIFORMNAMEPROC) (GLuint program, GLenum shadertype, GLuint index, GLsizei bufsize, GLsizei *length, GLchar *name);
typedef void (* PFNGLGETACTIVESUBROUTINENAMEPROC) (GLuint program, GLenum shadertype, GLuint index, GLsizei bufsize, GLsizei *length, GLchar *name);
typedef void (* PFNGLUNIFORMSUBROUTINESUIVPROC) (GLenum shadertype, GLsizei count, const GLuint *indices);
typedef void (* PFNGLGETUNIFORMSUBROUTINEUIVPROC) (GLenum shadertype, GLint location, GLuint *params);
typedef void (* PFNGLGETPROGRAMSTAGEIVPROC) (GLuint program, GLenum shadertype, GLenum pname, GLint *values);

/* GL_ARB_tessellation_shader */
 void  glPatchParameteri (GLenum pname, GLint value);
 void  glPatchParameterfv (GLenum pname, const GLfloat *values);
typedef void (* PFNGLPATCHPARAMETERIPROC) (GLenum pname, GLint value);
typedef void (* PFNGLPATCHPARAMETERFVPROC) (GLenum pname, const GLfloat *values);

/* GL_ARB_texture_buffer_object_rgb32 */

/* GL_ARB_transform_feedback2 */
 void  glBindTransformFeedback (GLenum target, GLuint id);
 void  glDeleteTransformFeedbacks (GLsizei n, const GLuint *ids);
 void  glGenTransformFeedbacks (GLsizei n, GLuint *ids);
 GLboolean  glIsTransformFeedback (GLuint id);
 void  glPauseTransformFeedback (void);
 void  glResumeTransformFeedback (void);
 void  glDrawTransformFeedback (GLenum mode, GLuint id);
typedef void (* PFNGLBINDTRANSFORMFEEDBACKPROC) (GLenum target, GLuint id);
typedef void (* PFNGLDELETETRANSFORMFEEDBACKSPROC) (GLsizei n, const GLuint *ids);
typedef void (* PFNGLGENTRANSFORMFEEDBACKSPROC) (GLsizei n, GLuint *ids);
typedef GLboolean (* PFNGLISTRANSFORMFEEDBACKPROC) (GLuint id);
typedef void (* PFNGLPAUSETRANSFORMFEEDBACKPROC) (void);
typedef void (* PFNGLRESUMETRANSFORMFEEDBACKPROC) (void);
typedef void (* PFNGLDRAWTRANSFORMFEEDBACKPROC) (GLenum mode, GLuint id);

/* GL_ARB_transform_feedback3 */
 void  glDrawTransformFeedbackStream (GLenum mode, GLuint id, GLuint stream);
 void  glBeginQueryIndexed (GLenum target, GLuint index, GLuint id);
 void  glEndQueryIndexed (GLenum target, GLuint index);
 void  glGetQueryIndexediv (GLenum target, GLuint index, GLenum pname, GLint *params);
typedef void (* PFNGLDRAWTRANSFORMFEEDBACKSTREAMPROC) (GLenum mode, GLuint id, GLuint stream);
typedef void (* PFNGLBEGINQUERYINDEXEDPROC) (GLenum target, GLuint index, GLuint id);
typedef void (* PFNGLENDQUERYINDEXEDPROC) (GLenum target, GLuint index);
typedef void (* PFNGLGETQUERYINDEXEDIVPROC) (GLenum target, GLuint index, GLenum pname, GLint *params);

/* GL_ARB_ES2_compatibility */
 void  glReleaseShaderCompiler (void);
 void  glShaderBinary (GLsizei count, const GLuint *shaders, GLenum binaryformat, const GLvoid *binary, GLsizei length);
 void  glGetShaderPrecisionFormat (GLenum shadertype, GLenum precisiontype, GLint *range, GLint *precision);
 void  glDepthRangef (GLfloat n, GLfloat f);
 void  glClearDepthf (GLfloat d);
typedef void (* PFNGLRELEASESHADERCOMPILERPROC) (void);
typedef void (* PFNGLSHADERBINARYPROC) (GLsizei count, const GLuint *shaders, GLenum binaryformat, const GLvoid *binary, GLsizei length);
typedef void (* PFNGLGETSHADERPRECISIONFORMATPROC) (GLenum shadertype, GLenum precisiontype, GLint *range, GLint *precision);
typedef void (* PFNGLDEPTHRANGEFPROC) (GLfloat n, GLfloat f);
typedef void (* PFNGLCLEARDEPTHFPROC) (GLfloat d);

/* GL_ARB_get_program_binary */
 void  glGetProgramBinary (GLuint program, GLsizei bufSize, GLsizei *length, GLenum *binaryFormat, GLvoid *binary);
 void  glProgramBinary (GLuint program, GLenum binaryFormat, const GLvoid *binary, GLsizei length);
 void  glProgramParameteri (GLuint program, GLenum pname, GLint value);
typedef void (* PFNGLGETPROGRAMBINARYPROC) (GLuint program, GLsizei bufSize, GLsizei *length, GLenum *binaryFormat, GLvoid *binary);
typedef void (* PFNGLPROGRAMBINARYPROC) (GLuint program, GLenum binaryFormat, const GLvoid *binary, GLsizei length);
typedef void (* PFNGLPROGRAMPARAMETERIPROC) (GLuint program, GLenum pname, GLint value);

/* GL_ARB_separate_shader_objects */
 void  glUseProgramStages (GLuint pipeline, GLbitfield stages, GLuint program);
 void  glActiveShaderProgram (GLuint pipeline, GLuint program);
 GLuint  glCreateShaderProgramv (GLenum type, GLsizei count, const GLchar* const *strings);
 void  glBindProgramPipeline (GLuint pipeline);
 void  glDeleteProgramPipelines (GLsizei n, const GLuint *pipelines);
 void  glGenProgramPipelines (GLsizei n, GLuint *pipelines);
 GLboolean  glIsProgramPipeline (GLuint pipeline);
 void  glGetProgramPipelineiv (GLuint pipeline, GLenum pname, GLint *params);
 void  glProgramUniform1i (GLuint program, GLint location, GLint v0);
 void  glProgramUniform1iv (GLuint program, GLint location, GLsizei count, const GLint *value);
 void  glProgramUniform1f (GLuint program, GLint location, GLfloat v0);
 void  glProgramUniform1fv (GLuint program, GLint location, GLsizei count, const GLfloat *value);
 void  glProgramUniform1d (GLuint program, GLint location, GLdouble v0);
 void  glProgramUniform1dv (GLuint program, GLint location, GLsizei count, const GLdouble *value);
 void  glProgramUniform1ui (GLuint program, GLint location, GLuint v0);
 void  glProgramUniform1uiv (GLuint program, GLint location, GLsizei count, const GLuint *value);
 void  glProgramUniform2i (GLuint program, GLint location, GLint v0, GLint v1);
 void  glProgramUniform2iv (GLuint program, GLint location, GLsizei count, const GLint *value);
 void  glProgramUniform2f (GLuint program, GLint location, GLfloat v0, GLfloat v1);
 void  glProgramUniform2fv (GLuint program, GLint location, GLsizei count, const GLfloat *value);
 void  glProgramUniform2d (GLuint program, GLint location, GLdouble v0, GLdouble v1);
 void  glProgramUniform2dv (GLuint program, GLint location, GLsizei count, const GLdouble *value);
 void  glProgramUniform2ui (GLuint program, GLint location, GLuint v0, GLuint v1);
 void  glProgramUniform2uiv (GLuint program, GLint location, GLsizei count, const GLuint *value);
 void  glProgramUniform3i (GLuint program, GLint location, GLint v0, GLint v1, GLint v2);
 void  glProgramUniform3iv (GLuint program, GLint location, GLsizei count, const GLint *value);
 void  glProgramUniform3f (GLuint program, GLint location, GLfloat v0, GLfloat v1, GLfloat v2);
 void  glProgramUniform3fv (GLuint program, GLint location, GLsizei count, const GLfloat *value);
 void  glProgramUniform3d (GLuint program, GLint location, GLdouble v0, GLdouble v1, GLdouble v2);
 void  glProgramUniform3dv (GLuint program, GLint location, GLsizei count, const GLdouble *value);
 void  glProgramUniform3ui (GLuint program, GLint location, GLuint v0, GLuint v1, GLuint v2);
 void  glProgramUniform3uiv (GLuint program, GLint location, GLsizei count, const GLuint *value);
 void  glProgramUniform4i (GLuint program, GLint location, GLint v0, GLint v1, GLint v2, GLint v3);
 void  glProgramUniform4iv (GLuint program, GLint location, GLsizei count, const GLint *value);
 void  glProgramUniform4f (GLuint program, GLint location, GLfloat v0, GLfloat v1, GLfloat v2, GLfloat v3);
 void  glProgramUniform4fv (GLuint program, GLint location, GLsizei count, const GLfloat *value);
 void  glProgramUniform4d (GLuint program, GLint location, GLdouble v0, GLdouble v1, GLdouble v2, GLdouble v3);
 void  glProgramUniform4dv (GLuint program, GLint location, GLsizei count, const GLdouble *value);
 void  glProgramUniform4ui (GLuint program, GLint location, GLuint v0, GLuint v1, GLuint v2, GLuint v3);
 void  glProgramUniform4uiv (GLuint program, GLint location, GLsizei count, const GLuint *value);
 void  glProgramUniformMatrix2fv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
 void  glProgramUniformMatrix3fv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
 void  glProgramUniformMatrix4fv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
 void  glProgramUniformMatrix2dv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
 void  glProgramUniformMatrix3dv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
 void  glProgramUniformMatrix4dv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
 void  glProgramUniformMatrix2x3fv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
 void  glProgramUniformMatrix3x2fv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
 void  glProgramUniformMatrix2x4fv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
 void  glProgramUniformMatrix4x2fv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
 void  glProgramUniformMatrix3x4fv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
 void  glProgramUniformMatrix4x3fv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
 void  glProgramUniformMatrix2x3dv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
 void  glProgramUniformMatrix3x2dv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
 void  glProgramUniformMatrix2x4dv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
 void  glProgramUniformMatrix4x2dv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
 void  glProgramUniformMatrix3x4dv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
 void  glProgramUniformMatrix4x3dv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
 void  glValidateProgramPipeline (GLuint pipeline);
 void  glGetProgramPipelineInfoLog (GLuint pipeline, GLsizei bufSize, GLsizei *length, GLchar *infoLog);
typedef void (* PFNGLUSEPROGRAMSTAGESPROC) (GLuint pipeline, GLbitfield stages, GLuint program);
typedef void (* PFNGLACTIVESHADERPROGRAMPROC) (GLuint pipeline, GLuint program);
typedef GLuint (* PFNGLCREATESHADERPROGRAMVPROC) (GLenum type, GLsizei count, const GLchar* const *strings);
typedef void (* PFNGLBINDPROGRAMPIPELINEPROC) (GLuint pipeline);
typedef void (* PFNGLDELETEPROGRAMPIPELINESPROC) (GLsizei n, const GLuint *pipelines);
typedef void (* PFNGLGENPROGRAMPIPELINESPROC) (GLsizei n, GLuint *pipelines);
typedef GLboolean (* PFNGLISPROGRAMPIPELINEPROC) (GLuint pipeline);
typedef void (* PFNGLGETPROGRAMPIPELINEIVPROC) (GLuint pipeline, GLenum pname, GLint *params);
typedef void (* PFNGLPROGRAMUNIFORM1IPROC) (GLuint program, GLint location, GLint v0);
typedef void (* PFNGLPROGRAMUNIFORM1IVPROC) (GLuint program, GLint location, GLsizei count, const GLint *value);
typedef void (* PFNGLPROGRAMUNIFORM1FPROC) (GLuint program, GLint location, GLfloat v0);
typedef void (* PFNGLPROGRAMUNIFORM1FVPROC) (GLuint program, GLint location, GLsizei count, const GLfloat *value);
typedef void (* PFNGLPROGRAMUNIFORM1DPROC) (GLuint program, GLint location, GLdouble v0);
typedef void (* PFNGLPROGRAMUNIFORM1DVPROC) (GLuint program, GLint location, GLsizei count, const GLdouble *value);
typedef void (* PFNGLPROGRAMUNIFORM1UIPROC) (GLuint program, GLint location, GLuint v0);
typedef void (* PFNGLPROGRAMUNIFORM1UIVPROC) (GLuint program, GLint location, GLsizei count, const GLuint *value);
typedef void (* PFNGLPROGRAMUNIFORM2IPROC) (GLuint program, GLint location, GLint v0, GLint v1);
typedef void (* PFNGLPROGRAMUNIFORM2IVPROC) (GLuint program, GLint location, GLsizei count, const GLint *value);
typedef void (* PFNGLPROGRAMUNIFORM2FPROC) (GLuint program, GLint location, GLfloat v0, GLfloat v1);
typedef void (* PFNGLPROGRAMUNIFORM2FVPROC) (GLuint program, GLint location, GLsizei count, const GLfloat *value);
typedef void (* PFNGLPROGRAMUNIFORM2DPROC) (GLuint program, GLint location, GLdouble v0, GLdouble v1);
typedef void (* PFNGLPROGRAMUNIFORM2DVPROC) (GLuint program, GLint location, GLsizei count, const GLdouble *value);
typedef void (* PFNGLPROGRAMUNIFORM2UIPROC) (GLuint program, GLint location, GLuint v0, GLuint v1);
typedef void (* PFNGLPROGRAMUNIFORM2UIVPROC) (GLuint program, GLint location, GLsizei count, const GLuint *value);
typedef void (* PFNGLPROGRAMUNIFORM3IPROC) (GLuint program, GLint location, GLint v0, GLint v1, GLint v2);
typedef void (* PFNGLPROGRAMUNIFORM3IVPROC) (GLuint program, GLint location, GLsizei count, const GLint *value);
typedef void (* PFNGLPROGRAMUNIFORM3FPROC) (GLuint program, GLint location, GLfloat v0, GLfloat v1, GLfloat v2);
typedef void (* PFNGLPROGRAMUNIFORM3FVPROC) (GLuint program, GLint location, GLsizei count, const GLfloat *value);
typedef void (* PFNGLPROGRAMUNIFORM3DPROC) (GLuint program, GLint location, GLdouble v0, GLdouble v1, GLdouble v2);
typedef void (* PFNGLPROGRAMUNIFORM3DVPROC) (GLuint program, GLint location, GLsizei count, const GLdouble *value);
typedef void (* PFNGLPROGRAMUNIFORM3UIPROC) (GLuint program, GLint location, GLuint v0, GLuint v1, GLuint v2);
typedef void (* PFNGLPROGRAMUNIFORM3UIVPROC) (GLuint program, GLint location, GLsizei count, const GLuint *value);
typedef void (* PFNGLPROGRAMUNIFORM4IPROC) (GLuint program, GLint location, GLint v0, GLint v1, GLint v2, GLint v3);
typedef void (* PFNGLPROGRAMUNIFORM4IVPROC) (GLuint program, GLint location, GLsizei count, const GLint *value);
typedef void (* PFNGLPROGRAMUNIFORM4FPROC) (GLuint program, GLint location, GLfloat v0, GLfloat v1, GLfloat v2, GLfloat v3);
typedef void (* PFNGLPROGRAMUNIFORM4FVPROC) (GLuint program, GLint location, GLsizei count, const GLfloat *value);
typedef void (* PFNGLPROGRAMUNIFORM4DPROC) (GLuint program, GLint location, GLdouble v0, GLdouble v1, GLdouble v2, GLdouble v3);
typedef void (* PFNGLPROGRAMUNIFORM4DVPROC) (GLuint program, GLint location, GLsizei count, const GLdouble *value);
typedef void (* PFNGLPROGRAMUNIFORM4UIPROC) (GLuint program, GLint location, GLuint v0, GLuint v1, GLuint v2, GLuint v3);
typedef void (* PFNGLPROGRAMUNIFORM4UIVPROC) (GLuint program, GLint location, GLsizei count, const GLuint *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX2FVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX3FVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX4FVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX2DVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX3DVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX4DVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX2X3FVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX3X2FVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX2X4FVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX4X2FVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX3X4FVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX4X3FVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX2X3DVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX3X2DVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX2X4DVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX4X2DVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX3X4DVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void (* PFNGLPROGRAMUNIFORMMATRIX4X3DVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void (* PFNGLVALIDATEPROGRAMPIPELINEPROC) (GLuint pipeline);
typedef void (* PFNGLGETPROGRAMPIPELINEINFOLOGPROC) (GLuint pipeline, GLsizei bufSize, GLsizei *length, GLchar *infoLog);

/* GL_ARB_vertex_attrib_64bit */
 void  glVertexAttribL1d (GLuint index, GLdouble x);
 void  glVertexAttribL2d (GLuint index, GLdouble x, GLdouble y);
 void  glVertexAttribL3d (GLuint index, GLdouble x, GLdouble y, GLdouble z);
 void  glVertexAttribL4d (GLuint index, GLdouble x, GLdouble y, GLdouble z, GLdouble w);
 void  glVertexAttribL1dv (GLuint index, const GLdouble *v);
 void  glVertexAttribL2dv (GLuint index, const GLdouble *v);
 void  glVertexAttribL3dv (GLuint index, const GLdouble *v);
 void  glVertexAttribL4dv (GLuint index, const GLdouble *v);
 void  glVertexAttribLPointer (GLuint index, GLint size, GLenum type, GLsizei stride, const GLvoid *pointer);
 void  glGetVertexAttribLdv (GLuint index, GLenum pname, GLdouble *params);
typedef void (* PFNGLVERTEXATTRIBL1DPROC) (GLuint index, GLdouble x);
typedef void (* PFNGLVERTEXATTRIBL2DPROC) (GLuint index, GLdouble x, GLdouble y);
typedef void (* PFNGLVERTEXATTRIBL3DPROC) (GLuint index, GLdouble x, GLdouble y, GLdouble z);
typedef void (* PFNGLVERTEXATTRIBL4DPROC) (GLuint index, GLdouble x, GLdouble y, GLdouble z, GLdouble w);
typedef void (* PFNGLVERTEXATTRIBL1DVPROC) (GLuint index, const GLdouble *v);
typedef void (* PFNGLVERTEXATTRIBL2DVPROC) (GLuint index, const GLdouble *v);
typedef void (* PFNGLVERTEXATTRIBL3DVPROC) (GLuint index, const GLdouble *v);
typedef void (* PFNGLVERTEXATTRIBL4DVPROC) (GLuint index, const GLdouble *v);
typedef void (* PFNGLVERTEXATTRIBLPOINTERPROC) (GLuint index, GLint size, GLenum type, GLsizei stride, const GLvoid *pointer);
typedef void (* PFNGLGETVERTEXATTRIBLDVPROC) (GLuint index, GLenum pname, GLdouble *params);

/* GL_ARB_viewport_array */
 void  glViewportArrayv (GLuint first, GLsizei count, const GLfloat *v);
 void  glViewportIndexedf (GLuint index, GLfloat x, GLfloat y, GLfloat w, GLfloat h);
 void  glViewportIndexedfv (GLuint index, const GLfloat *v);
 void  glScissorArrayv (GLuint first, GLsizei count, const GLint *v);
 void  glScissorIndexed (GLuint index, GLint left, GLint bottom, GLsizei width, GLsizei height);
 void  glScissorIndexedv (GLuint index, const GLint *v);
 void  glDepthRangeArrayv (GLuint first, GLsizei count, const GLdouble *v);
 void  glDepthRangeIndexed (GLuint index, GLdouble n, GLdouble f);
 void  glGetFloati_v (GLenum target, GLuint index, GLfloat *data);
 void  glGetDoublei_v (GLenum target, GLuint index, GLdouble *data);
typedef void (* PFNGLVIEWPORTARRAYVPROC) (GLuint first, GLsizei count, const GLfloat *v);
typedef void (* PFNGLVIEWPORTINDEXEDFPROC) (GLuint index, GLfloat x, GLfloat y, GLfloat w, GLfloat h);
typedef void (* PFNGLVIEWPORTINDEXEDFVPROC) (GLuint index, const GLfloat *v);
typedef void (* PFNGLSCISSORARRAYVPROC) (GLuint first, GLsizei count, const GLint *v);
typedef void (* PFNGLSCISSORINDEXEDPROC) (GLuint index, GLint left, GLint bottom, GLsizei width, GLsizei height);
typedef void (* PFNGLSCISSORINDEXEDVPROC) (GLuint index, const GLint *v);
typedef void (* PFNGLDEPTHRANGEARRAYVPROC) (GLuint first, GLsizei count, const GLdouble *v);
typedef void (* PFNGLDEPTHRANGEINDEXEDPROC) (GLuint index, GLdouble n, GLdouble f);
typedef void (* PFNGLGETFLOATI_VPROC) (GLenum target, GLuint index, GLfloat *data);
typedef void (* PFNGLGETDOUBLEI_VPROC) (GLenum target, GLuint index, GLdouble *data);

/* GL_ARB_cl_event */
 GLsync  glCreateSyncFromCLeventARB (struct _cl_context * context, struct _cl_event * event, GLbitfield flags);
typedef GLsync (* PFNGLCREATESYNCFROMCLEVENTARBPROC) (struct _cl_context * context, struct _cl_event * event, GLbitfield flags);

/* GL_ARB_debug_output */
 void  glDebugMessageControlARB (GLenum source, GLenum type, GLenum severity, GLsizei count, const GLuint *ids, GLboolean enabled);
 void  glDebugMessageInsertARB (GLenum source, GLenum type, GLuint id, GLenum severity, GLsizei length, const GLchar *buf);
 void  glDebugMessageCallbackARB (GLDEBUGPROCARB callback, const GLvoid *userParam);
 GLuint  glGetDebugMessageLogARB (GLuint count, GLsizei bufsize, GLenum *sources, GLenum *types, GLuint *ids, GLenum *severities, GLsizei *lengths, GLchar *messageLog);
typedef void (* PFNGLDEBUGMESSAGECONTROLARBPROC) (GLenum source, GLenum type, GLenum severity, GLsizei count, const GLuint *ids, GLboolean enabled);
typedef void (* PFNGLDEBUGMESSAGEINSERTARBPROC) (GLenum source, GLenum type, GLuint id, GLenum severity, GLsizei length, const GLchar *buf);
typedef void (* PFNGLDEBUGMESSAGECALLBACKARBPROC) (GLDEBUGPROCARB callback, const GLvoid *userParam);
typedef GLuint (* PFNGLGETDEBUGMESSAGELOGARBPROC) (GLuint count, GLsizei bufsize, GLenum *sources, GLenum *types, GLuint *ids, GLenum *severities, GLsizei *lengths, GLchar *messageLog);

/* GL_ARB_robustness */
 GLenum  glGetGraphicsResetStatusARB (void);
 void  glGetnTexImageARB (GLenum target, GLint level, GLenum format, GLenum type, GLsizei bufSize, GLvoid *img);
 void  glReadnPixelsARB (GLint x, GLint y, GLsizei width, GLsizei height, GLenum format, GLenum type, GLsizei bufSize, GLvoid *data);
 void  glGetnCompressedTexImageARB (GLenum target, GLint lod, GLsizei bufSize, GLvoid *img);
 void  glGetnUniformfvARB (GLuint program, GLint location, GLsizei bufSize, GLfloat *params);
 void  glGetnUniformivARB (GLuint program, GLint location, GLsizei bufSize, GLint *params);
 void  glGetnUniformuivARB (GLuint program, GLint location, GLsizei bufSize, GLuint *params);
 void  glGetnUniformdvARB (GLuint program, GLint location, GLsizei bufSize, GLdouble *params);
typedef GLenum (* PFNGLGETGRAPHICSRESETSTATUSARBPROC) (void);
typedef void (* PFNGLGETNTEXIMAGEARBPROC) (GLenum target, GLint level, GLenum format, GLenum type, GLsizei bufSize, GLvoid *img);
typedef void (* PFNGLREADNPIXELSARBPROC) (GLint x, GLint y, GLsizei width, GLsizei height, GLenum format, GLenum type, GLsizei bufSize, GLvoid *data);
typedef void (* PFNGLGETNCOMPRESSEDTEXIMAGEARBPROC) (GLenum target, GLint lod, GLsizei bufSize, GLvoid *img);
typedef void (* PFNGLGETNUNIFORMFVARBPROC) (GLuint program, GLint location, GLsizei bufSize, GLfloat *params);
typedef void (* PFNGLGETNUNIFORMIVARBPROC) (GLuint program, GLint location, GLsizei bufSize, GLint *params);
typedef void (* PFNGLGETNUNIFORMUIVARBPROC) (GLuint program, GLint location, GLsizei bufSize, GLuint *params);
typedef void (* PFNGLGETNUNIFORMDVARBPROC) (GLuint program, GLint location, GLsizei bufSize, GLdouble *params);

/* GL_ARB_shader_stencil_export */

/* GL_ARB_base_instance */
 void  glDrawArraysInstancedBaseInstance (GLenum mode, GLint first, GLsizei count, GLsizei instancecount, GLuint baseinstance);
 void  glDrawElementsInstancedBaseInstance (GLenum mode, GLsizei count, GLenum type, const void *indices, GLsizei instancecount, GLuint baseinstance);
 void  glDrawElementsInstancedBaseVertexBaseInstance (GLenum mode, GLsizei count, GLenum type, const void *indices, GLsizei instancecount, GLint basevertex, GLuint baseinstance);
typedef void (* PFNGLDRAWARRAYSINSTANCEDBASEINSTANCEPROC) (GLenum mode, GLint first, GLsizei count, GLsizei instancecount, GLuint baseinstance);
typedef void (* PFNGLDRAWELEMENTSINSTANCEDBASEINSTANCEPROC) (GLenum mode, GLsizei count, GLenum type, const void *indices, GLsizei instancecount, GLuint baseinstance);
typedef void (* PFNGLDRAWELEMENTSINSTANCEDBASEVERTEXBASEINSTANCEPROC) (GLenum mode, GLsizei count, GLenum type, const void *indices, GLsizei instancecount, GLint basevertex, GLuint baseinstance);

/* GL_ARB_shading_language_420pack */

/* GL_ARB_transform_feedback_instanced */
 void  glDrawTransformFeedbackInstanced (GLenum mode, GLuint id, GLsizei instancecount);
 void  glDrawTransformFeedbackStreamInstanced (GLenum mode, GLuint id, GLuint stream, GLsizei instancecount);
typedef void (* PFNGLDRAWTRANSFORMFEEDBACKINSTANCEDPROC) (GLenum mode, GLuint id, GLsizei instancecount);
typedef void (* PFNGLDRAWTRANSFORMFEEDBACKSTREAMINSTANCEDPROC) (GLenum mode, GLuint id, GLuint stream, GLsizei instancecount);

/* GL_ARB_compressed_texture_pixel_storage */

/* GL_ARB_conservative_depth */

/* GL_ARB_internalformat_query */
 void  glGetInternalformativ (GLenum target, GLenum internalformat, GLenum pname, GLsizei bufSize, GLint *params);
typedef void (* PFNGLGETINTERNALFORMATIVPROC) (GLenum target, GLenum internalformat, GLenum pname, GLsizei bufSize, GLint *params);

/* GL_ARB_map_buffer_alignment */

/* GL_ARB_shader_atomic_counters */
 void  glGetActiveAtomicCounterBufferiv (GLuint program, GLuint bufferIndex, GLenum pname, GLint *params);
typedef void (* PFNGLGETACTIVEATOMICCOUNTERBUFFERIVPROC) (GLuint program, GLuint bufferIndex, GLenum pname, GLint *params);

/* GL_ARB_shader_image_load_store */
 void  glBindImageTexture (GLuint unit, GLuint texture, GLint level, GLboolean layered, GLint layer, GLenum access, GLenum format);
 void  glMemoryBarrier (GLbitfield barriers);
typedef void (* PFNGLBINDIMAGETEXTUREPROC) (GLuint unit, GLuint texture, GLint level, GLboolean layered, GLint layer, GLenum access, GLenum format);
typedef void (* PFNGLMEMORYBARRIERPROC) (GLbitfield barriers);

/* GL_ARB_shading_language_packing */

/* GL_ARB_texture_storage */
 void  glTexStorage1D (GLenum target, GLsizei levels, GLenum internalformat, GLsizei width);
 void  glTexStorage2D (GLenum target, GLsizei levels, GLenum internalformat, GLsizei width, GLsizei height);
 void  glTexStorage3D (GLenum target, GLsizei levels, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth);
 void  glTextureStorage1DEXT (GLuint texture, GLenum target, GLsizei levels, GLenum internalformat, GLsizei width);
 void  glTextureStorage2DEXT (GLuint texture, GLenum target, GLsizei levels, GLenum internalformat, GLsizei width, GLsizei height);
 void  glTextureStorage3DEXT (GLuint texture, GLenum target, GLsizei levels, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth);
typedef void (* PFNGLTEXSTORAGE1DPROC) (GLenum target, GLsizei levels, GLenum internalformat, GLsizei width);
typedef void (* PFNGLTEXSTORAGE2DPROC) (GLenum target, GLsizei levels, GLenum internalformat, GLsizei width, GLsizei height);
typedef void (* PFNGLTEXSTORAGE3DPROC) (GLenum target, GLsizei levels, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth);
typedef void (* PFNGLTEXTURESTORAGE1DEXTPROC) (GLuint texture, GLenum target, GLsizei levels, GLenum internalformat, GLsizei width);
typedef void (* PFNGLTEXTURESTORAGE2DEXTPROC) (GLuint texture, GLenum target, GLsizei levels, GLenum internalformat, GLsizei width, GLsizei height);
typedef void (* PFNGLTEXTURESTORAGE3DEXTPROC) (GLuint texture, GLenum target, GLsizei levels, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth);

/* GL_KHR_texture_compression_astc_ldr */

/* GL_KHR_debug */
 void  glDebugMessageControl (GLenum source, GLenum type, GLenum severity, GLsizei count, const GLuint *ids, GLboolean enabled);
 void  glDebugMessageInsert (GLenum source, GLenum type, GLuint id, GLenum severity, GLsizei length, const GLchar *buf);
 void  glDebugMessageCallback (GLDEBUGPROC callback, const void *userParam);
 GLuint  glGetDebugMessageLog (GLuint count, GLsizei bufsize, GLenum *sources, GLenum *types, GLuint *ids, GLenum *severities, GLsizei *lengths, GLchar *messageLog);
 void  glPushDebugGroup (GLenum source, GLuint id, GLsizei length, const GLchar *message);
 void  glPopDebugGroup (void);
 void  glObjectLabel (GLenum identifier, GLuint name, GLsizei length, const GLchar *label);
 void  glGetObjectLabel (GLenum identifier, GLuint name, GLsizei bufSize, GLsizei *length, GLchar *label);
 void  glObjectPtrLabel (const void *ptr, GLsizei length, const GLchar *label);
 void  glGetObjectPtrLabel (const void *ptr, GLsizei bufSize, GLsizei *length, GLchar *label);
typedef void (* PFNGLDEBUGMESSAGECONTROLPROC) (GLenum source, GLenum type, GLenum severity, GLsizei count, const GLuint *ids, GLboolean enabled);
typedef void (* PFNGLDEBUGMESSAGEINSERTPROC) (GLenum source, GLenum type, GLuint id, GLenum severity, GLsizei length, const GLchar *buf);
typedef void (* PFNGLDEBUGMESSAGECALLBACKPROC) (GLDEBUGPROC callback, const void *userParam);
typedef GLuint (* PFNGLGETDEBUGMESSAGELOGPROC) (GLuint count, GLsizei bufsize, GLenum *sources, GLenum *types, GLuint *ids, GLenum *severities, GLsizei *lengths, GLchar *messageLog);
typedef void (* PFNGLPUSHDEBUGGROUPPROC) (GLenum source, GLuint id, GLsizei length, const GLchar *message);
typedef void (* PFNGLPOPDEBUGGROUPPROC) (void);
typedef void (* PFNGLOBJECTLABELPROC) (GLenum identifier, GLuint name, GLsizei length, const GLchar *label);
typedef void (* PFNGLGETOBJECTLABELPROC) (GLenum identifier, GLuint name, GLsizei bufSize, GLsizei *length, GLchar *label);
typedef void (* PFNGLOBJECTPTRLABELPROC) (const void *ptr, GLsizei length, const GLchar *label);
typedef void (* PFNGLGETOBJECTPTRLABELPROC) (const void *ptr, GLsizei bufSize, GLsizei *length, GLchar *label);

/* GL_ARB_arrays_of_arrays */

/* GL_ARB_clear_buffer_object */
 void  glClearBufferData (GLenum target, GLenum internalformat, GLenum format, GLenum type, const void *data);
 void  glClearBufferSubData (GLenum target, GLenum internalformat, GLintptr offset, GLsizeiptr size, GLenum format, GLenum type, const void *data);
 void  glClearNamedBufferDataEXT (GLuint buffer, GLenum internalformat, GLenum format, GLenum type, const void *data);
 void  glClearNamedBufferSubDataEXT (GLuint buffer, GLenum internalformat, GLenum format, GLenum type, GLsizeiptr offset, GLsizeiptr size, const void *data);
typedef void (* PFNGLCLEARBUFFERDATAPROC) (GLenum target, GLenum internalformat, GLenum format, GLenum type, const void *data);
typedef void (* PFNGLCLEARBUFFERSUBDATAPROC) (GLenum target, GLenum internalformat, GLintptr offset, GLsizeiptr size, GLenum format, GLenum type, const void *data);
typedef void (* PFNGLCLEARNAMEDBUFFERDATAEXTPROC) (GLuint buffer, GLenum internalformat, GLenum format, GLenum type, const void *data);
typedef void (* PFNGLCLEARNAMEDBUFFERSUBDATAEXTPROC) (GLuint buffer, GLenum internalformat, GLenum format, GLenum type, GLsizeiptr offset, GLsizeiptr size, const void *data);

/* GL_ARB_compute_shader */
 void  glDispatchCompute (GLuint num_groups_x, GLuint num_groups_y, GLuint num_groups_z);
 void  glDispatchComputeIndirect (GLintptr indirect);
typedef void (* PFNGLDISPATCHCOMPUTEPROC) (GLuint num_groups_x, GLuint num_groups_y, GLuint num_groups_z);
typedef void (* PFNGLDISPATCHCOMPUTEINDIRECTPROC) (GLintptr indirect);

/* GL_ARB_copy_image */
 void  glCopyImageSubData (GLuint srcName, GLenum srcTarget, GLint srcLevel, GLint srcX, GLint srcY, GLint srcZ, GLuint dstName, GLenum dstTarget, GLint dstLevel, GLint dstX, GLint dstY, GLint dstZ, GLsizei srcWidth, GLsizei srcHeight, GLsizei srcDepth);
typedef void (* PFNGLCOPYIMAGESUBDATAPROC) (GLuint srcName, GLenum srcTarget, GLint srcLevel, GLint srcX, GLint srcY, GLint srcZ, GLuint dstName, GLenum dstTarget, GLint dstLevel, GLint dstX, GLint dstY, GLint dstZ, GLsizei srcWidth, GLsizei srcHeight, GLsizei srcDepth);

/* GL_ARB_texture_view */
 void  glTextureView (GLuint texture, GLenum target, GLuint origtexture, GLenum internalformat, GLuint minlevel, GLuint numlevels, GLuint minlayer, GLuint numlayers);
typedef void (* PFNGLTEXTUREVIEWPROC) (GLuint texture, GLenum target, GLuint origtexture, GLenum internalformat, GLuint minlevel, GLuint numlevels, GLuint minlayer, GLuint numlayers);

/* GL_ARB_vertex_attrib_binding */
 void  glBindVertexBuffer (GLuint bindingindex, GLuint buffer, GLintptr offset, GLsizei stride);
 void  glVertexAttribFormat (GLuint attribindex, GLint size, GLenum type, GLboolean normalized, GLuint relativeoffset);
 void  glVertexAttribIFormat (GLuint attribindex, GLint size, GLenum type, GLuint relativeoffset);
 void  glVertexAttribLFormat (GLuint attribindex, GLint size, GLenum type, GLuint relativeoffset);
 void  glVertexAttribBinding (GLuint attribindex, GLuint bindingindex);
 void  glVertexBindingDivisor (GLuint bindingindex, GLuint divisor);
 void  glVertexArrayBindVertexBufferEXT (GLuint vaobj, GLuint bindingindex, GLuint buffer, GLintptr offset, GLsizei stride);
 void  glVertexArrayVertexAttribFormatEXT (GLuint vaobj, GLuint attribindex, GLint size, GLenum type, GLboolean normalized, GLuint relativeoffset);
 void  glVertexArrayVertexAttribIFormatEXT (GLuint vaobj, GLuint attribindex, GLint size, GLenum type, GLuint relativeoffset);
 void  glVertexArrayVertexAttribLFormatEXT (GLuint vaobj, GLuint attribindex, GLint size, GLenum type, GLuint relativeoffset);
 void  glVertexArrayVertexAttribBindingEXT (GLuint vaobj, GLuint attribindex, GLuint bindingindex);
 void  glVertexArrayVertexBindingDivisorEXT (GLuint vaobj, GLuint bindingindex, GLuint divisor);
typedef void (* PFNGLBINDVERTEXBUFFERPROC) (GLuint bindingindex, GLuint buffer, GLintptr offset, GLsizei stride);
typedef void (* PFNGLVERTEXATTRIBFORMATPROC) (GLuint attribindex, GLint size, GLenum type, GLboolean normalized, GLuint relativeoffset);
typedef void (* PFNGLVERTEXATTRIBIFORMATPROC) (GLuint attribindex, GLint size, GLenum type, GLuint relativeoffset);
typedef void (* PFNGLVERTEXATTRIBLFORMATPROC) (GLuint attribindex, GLint size, GLenum type, GLuint relativeoffset);
typedef void (* PFNGLVERTEXATTRIBBINDINGPROC) (GLuint attribindex, GLuint bindingindex);
typedef void (* PFNGLVERTEXBINDINGDIVISORPROC) (GLuint bindingindex, GLuint divisor);
typedef void (* PFNGLVERTEXARRAYBINDVERTEXBUFFEREXTPROC) (GLuint vaobj, GLuint bindingindex, GLuint buffer, GLintptr offset, GLsizei stride);
typedef void (* PFNGLVERTEXARRAYVERTEXATTRIBFORMATEXTPROC) (GLuint vaobj, GLuint attribindex, GLint size, GLenum type, GLboolean normalized, GLuint relativeoffset);
typedef void (* PFNGLVERTEXARRAYVERTEXATTRIBIFORMATEXTPROC) (GLuint vaobj, GLuint attribindex, GLint size, GLenum type, GLuint relativeoffset);
typedef void (* PFNGLVERTEXARRAYVERTEXATTRIBLFORMATEXTPROC) (GLuint vaobj, GLuint attribindex, GLint size, GLenum type, GLuint relativeoffset);
typedef void (* PFNGLVERTEXARRAYVERTEXATTRIBBINDINGEXTPROC) (GLuint vaobj, GLuint attribindex, GLuint bindingindex);
typedef void (* PFNGLVERTEXARRAYVERTEXBINDINGDIVISOREXTPROC) (GLuint vaobj, GLuint bindingindex, GLuint divisor);

/* GL_ARB_robustness_isolation */

/* GL_ARB_ES3_compatibility */

/* GL_ARB_explicit_uniform_location */

/* GL_ARB_fragment_layer_viewport */

/* GL_ARB_framebuffer_no_attachments */
 void  glFramebufferParameteri (GLenum target, GLenum pname, GLint param);
 void  glGetFramebufferParameteriv (GLenum target, GLenum pname, GLint *params);
 void  glNamedFramebufferParameteriEXT (GLuint framebuffer, GLenum pname, GLint param);
 void  glGetNamedFramebufferParameterivEXT (GLuint framebuffer, GLenum pname, GLint *params);
typedef void (* PFNGLFRAMEBUFFERPARAMETERIPROC) (GLenum target, GLenum pname, GLint param);
typedef void (* PFNGLGETFRAMEBUFFERPARAMETERIVPROC) (GLenum target, GLenum pname, GLint *params);
typedef void (* PFNGLNAMEDFRAMEBUFFERPARAMETERIEXTPROC) (GLuint framebuffer, GLenum pname, GLint param);
typedef void (* PFNGLGETNAMEDFRAMEBUFFERPARAMETERIVEXTPROC) (GLuint framebuffer, GLenum pname, GLint *params);

/* GL_ARB_internalformat_query2 */
 void  glGetInternalformati64v (GLenum target, GLenum internalformat, GLenum pname, GLsizei bufSize, GLint64 *params);
typedef void (* PFNGLGETINTERNALFORMATI64VPROC) (GLenum target, GLenum internalformat, GLenum pname, GLsizei bufSize, GLint64 *params);

/* GL_ARB_invalidate_subdata */
 void  glInvalidateTexSubImage (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth);
 void  glInvalidateTexImage (GLuint texture, GLint level);
 void  glInvalidateBufferSubData (GLuint buffer, GLintptr offset, GLsizeiptr length);
 void  glInvalidateBufferData (GLuint buffer);
 void  glInvalidateFramebuffer (GLenum target, GLsizei numAttachments, const GLenum *attachments);
 void  glInvalidateSubFramebuffer (GLenum target, GLsizei numAttachments, const GLenum *attachments, GLint x, GLint y, GLsizei width, GLsizei height);
typedef void (* PFNGLINVALIDATETEXSUBIMAGEPROC) (GLuint texture, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth);
typedef void (* PFNGLINVALIDATETEXIMAGEPROC) (GLuint texture, GLint level);
typedef void (* PFNGLINVALIDATEBUFFERSUBDATAPROC) (GLuint buffer, GLintptr offset, GLsizeiptr length);
typedef void (* PFNGLINVALIDATEBUFFERDATAPROC) (GLuint buffer);
typedef void (* PFNGLINVALIDATEFRAMEBUFFERPROC) (GLenum target, GLsizei numAttachments, const GLenum *attachments);
typedef void (* PFNGLINVALIDATESUBFRAMEBUFFERPROC) (GLenum target, GLsizei numAttachments, const GLenum *attachments, GLint x, GLint y, GLsizei width, GLsizei height);

/* GL_ARB_multi_draw_indirect */
 void  glMultiDrawArraysIndirect (GLenum mode, const void *indirect, GLsizei drawcount, GLsizei stride);
 void  glMultiDrawElementsIndirect (GLenum mode, GLenum type, const void *indirect, GLsizei drawcount, GLsizei stride);
typedef void (* PFNGLMULTIDRAWARRAYSINDIRECTPROC) (GLenum mode, const void *indirect, GLsizei drawcount, GLsizei stride);
typedef void (* PFNGLMULTIDRAWELEMENTSINDIRECTPROC) (GLenum mode, GLenum type, const void *indirect, GLsizei drawcount, GLsizei stride);

/* GL_ARB_program_interface_query */
 void  glGetProgramInterfaceiv (GLuint program, GLenum programInterface, GLenum pname, GLint *params);
 GLuint  glGetProgramResourceIndex (GLuint program, GLenum programInterface, const GLchar *name);
 void  glGetProgramResourceName (GLuint program, GLenum programInterface, GLuint index, GLsizei bufSize, GLsizei *length, GLchar *name);
 void  glGetProgramResourceiv (GLuint program, GLenum programInterface, GLuint index, GLsizei propCount, const GLenum *props, GLsizei bufSize, GLsizei *length, GLint *params);
 GLint  glGetProgramResourceLocation (GLuint program, GLenum programInterface, const GLchar *name);
 GLint  glGetProgramResourceLocationIndex (GLuint program, GLenum programInterface, const GLchar *name);
typedef void (* PFNGLGETPROGRAMINTERFACEIVPROC) (GLuint program, GLenum programInterface, GLenum pname, GLint *params);
typedef GLuint (* PFNGLGETPROGRAMRESOURCEINDEXPROC) (GLuint program, GLenum programInterface, const GLchar *name);
typedef void (* PFNGLGETPROGRAMRESOURCENAMEPROC) (GLuint program, GLenum programInterface, GLuint index, GLsizei bufSize, GLsizei *length, GLchar *name);
typedef void (* PFNGLGETPROGRAMRESOURCEIVPROC) (GLuint program, GLenum programInterface, GLuint index, GLsizei propCount, const GLenum *props, GLsizei bufSize, GLsizei *length, GLint *params);
typedef GLint (* PFNGLGETPROGRAMRESOURCELOCATIONPROC) (GLuint program, GLenum programInterface, const GLchar *name);
typedef GLint (* PFNGLGETPROGRAMRESOURCELOCATIONINDEXPROC) (GLuint program, GLenum programInterface, const GLchar *name);

/* GL_ARB_robust_buffer_access_behavior */

/* GL_ARB_shader_image_size */

/* GL_ARB_shader_storage_buffer_object */
 void  glShaderStorageBlockBinding (GLuint program, GLuint storageBlockIndex, GLuint storageBlockBinding);
typedef void (* PFNGLSHADERSTORAGEBLOCKBINDINGPROC) (GLuint program, GLuint storageBlockIndex, GLuint storageBlockBinding);

/* GL_ARB_stencil_texturing */

/* GL_ARB_texture_buffer_range */
 void  glTexBufferRange (GLenum target, GLenum internalformat, GLuint buffer, GLintptr offset, GLsizeiptr size);
 void  glTextureBufferRangeEXT (GLuint texture, GLenum target, GLenum internalformat, GLuint buffer, GLintptr offset, GLsizeiptr size);
typedef void (* PFNGLTEXBUFFERRANGEPROC) (GLenum target, GLenum internalformat, GLuint buffer, GLintptr offset, GLsizeiptr size);
typedef void (* PFNGLTEXTUREBUFFERRANGEEXTPROC) (GLuint texture, GLenum target, GLenum internalformat, GLuint buffer, GLintptr offset, GLsizeiptr size);

/* GL_ARB_texture_query_levels */

/* GL_ARB_texture_storage_multisample */
 void  glTexStorage2DMultisample (GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height, GLboolean fixedsamplelocations);
 void  glTexStorage3DMultisample (GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLboolean fixedsamplelocations);
 void  glTextureStorage2DMultisampleEXT (GLuint texture, GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height, GLboolean fixedsamplelocations);
 void  glTextureStorage3DMultisampleEXT (GLuint texture, GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLboolean fixedsamplelocations);
typedef void (* PFNGLTEXSTORAGE2DMULTISAMPLEPROC) (GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height, GLboolean fixedsamplelocations);
typedef void (* PFNGLTEXSTORAGE3DMULTISAMPLEPROC) (GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLboolean fixedsamplelocations);
typedef void (* PFNGLTEXTURESTORAGE2DMULTISAMPLEEXTPROC) (GLuint texture, GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height, GLboolean fixedsamplelocations);
typedef void (* PFNGLTEXTURESTORAGE3DMULTISAMPLEEXTPROC) (GLuint texture, GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLboolean fixedsamplelocations);
]]

return table
