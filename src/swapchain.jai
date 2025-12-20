// Nabbo - 2025 / 11 / 22 - 08:04:09

Image_Layout :: enum{
	UNDEFINED                                      :: 0;
    GENERAL                                        :: 1;
    COLOR_ATTACHMENT_OPTIMAL                       :: 2;
    DEPTH_STENCIL_ATTACHMENT_OPTIMAL               :: 3;
    DEPTH_STENCIL_READ_ONLY_OPTIMAL                :: 4;
    SHADER_READ_ONLY_OPTIMAL                       :: 5;
    TRANSFER_SRC_OPTIMAL                           :: 6;
    TRANSFER_DST_OPTIMAL                           :: 7;
    PREINITIALIZED                                 :: 8;
    DEPTH_READ_ONLY_STENCIL_ATTACHMENT_OPTIMAL     :: 1000117000;
    DEPTH_ATTACHMENT_STENCIL_READ_ONLY_OPTIMAL     :: 1000117001;
    DEPTH_ATTACHMENT_OPTIMAL                       :: 1000241000;
    DEPTH_READ_ONLY_OPTIMAL                        :: 1000241001;
    STENCIL_ATTACHMENT_OPTIMAL                     :: 1000241002;
    STENCIL_READ_ONLY_OPTIMAL                      :: 1000241003;
    READ_ONLY_OPTIMAL                              :: 1000314000;
    ATTACHMENT_OPTIMAL                             :: 1000314001;
    PRESENT_SRC                                    :: 1000001002;
    VIDEO_DECODE_DST                               :: 1000024000;
    VIDEO_DECODE_SRC                               :: 1000024001;
    VIDEO_DECODE_DPB                               :: 1000024002;
    SHARED_PRESENT                                 :: 1000111000;
    FRAGMENT_DENSITY_MAP_OPTIMAL                   :: 1000218000;
    FRAGMENT_SHADING_RATE_ATTACHMENT_OPTIMAL       :: 1000164003;
    RENDERING_LOCAL_READ                           :: 1000232000;
    VIDEO_ENCODE_DST                               :: 1000299000;
    VIDEO_ENCODE_SRC                               :: 1000299001;
    VIDEO_ENCODE_DPB                               :: 1000299002;
    ATTACHMENT_FEEDBACK_LOOP_OPTIMAL               :: 1000339000;
}

Image_Usage :: enum_flags {
    NONE                                 :: 0x0;
    TRANSFER_SRC                         :: 0x1;
    TRANSFER_DST                         :: 0x2;
    SAMPLED                              :: 0x4;
    STORAGE                              :: 0x8;
    COLOR_ATTACHMENT                     :: 0x10;
    DEPTH_STENCIL_ATTACHMENT             :: 0x20;
    TRANSIENT_ATTACHMENT                 :: 0x40;
    INPUT_ATTACHMENT                     :: 0x80;
    VIDEO_DECODE_DST_KHR                 :: 0x400;
    VIDEO_DECODE_SRC_KHR                 :: 0x800;
    VIDEO_DECODE_DPB_KHR                 :: 0x1000;
    FRAGMENT_DENSITY_MAP_EXT             :: 0x200;
    FRAGMENT_SHADING_RATE_ATTACHMENT_KHR :: 0x100;
    HOST_TRANSFER_EXT                    :: 0x400000;
    VIDEO_ENCODE_DST_KHR                 :: 0x2000;
    VIDEO_ENCODE_SRC_KHR                 :: 0x4000;
    VIDEO_ENCODE_DPB_KHR                 :: 0x8000;
    ATTACHMENT_FEEDBACK_LOOP_EXT         :: 0x80000;
    INVOCATION_MASK_HUAWEI               :: 0x40000;
    SAMPLE_WEIGHT_QCOM                   :: 0x100000;
    SAMPLE_BLOCK_MATCH_QCOM              :: 0x200000;
    SHADING_RATE_IMAGE_NV                :: 0x100;
    FLAGS_MAX_ENUM                       :: 0x7fffffff;
}

Image_Format :: enum u32 {
    UNDEFINED                                      :: 0;
    R4G4_UNORM_PACK8                               :: 1;
    R4G4B4A4_UNORM_PACK16                          :: 2;
    B4G4R4A4_UNORM_PACK16                          :: 3;
    R5G6B5_UNORM_PACK16                            :: 4;
    B5G6R5_UNORM_PACK16                            :: 5;
    R5G5B5A1_UNORM_PACK16                          :: 6;
    B5G5R5A1_UNORM_PACK16                          :: 7;
    A1R5G5B5_UNORM_PACK16                          :: 8;
    R8_UNORM                                       :: 9;
    R8_SNORM                                       :: 10;
    R8_USCALED                                     :: 11;
    R8_SSCALED                                     :: 12;
    R8_UINT                                        :: 13;
    R8_SINT                                        :: 14;
    R8_SRGB                                        :: 15;
    R8G8_UNORM                                     :: 16;
    R8G8_SNORM                                     :: 17;
    R8G8_USCALED                                   :: 18;
    R8G8_SSCALED                                   :: 19;
    R8G8_UINT                                      :: 20;
    R8G8_SINT                                      :: 21;
    R8G8_SRGB                                      :: 22;
    R8G8B8_UNORM                                   :: 23;
    R8G8B8_SNORM                                   :: 24;
    R8G8B8_USCALED                                 :: 25;
    R8G8B8_SSCALED                                 :: 26;
    R8G8B8_UINT                                    :: 27;
    R8G8B8_SINT                                    :: 28;
    R8G8B8_SRGB                                    :: 29;
    B8G8R8_UNORM                                   :: 30;
    B8G8R8_SNORM                                   :: 31;
    B8G8R8_USCALED                                 :: 32;
    B8G8R8_SSCALED                                 :: 33;
    B8G8R8_UINT                                    :: 34;
    B8G8R8_SINT                                    :: 35;
    B8G8R8_SRGB                                    :: 36;
    R8G8B8A8_UNORM                                 :: 37;
    R8G8B8A8_SNORM                                 :: 38;
    R8G8B8A8_USCALED                               :: 39;
    R8G8B8A8_SSCALED                               :: 40;
    R8G8B8A8_UINT                                  :: 41;
    R8G8B8A8_SINT                                  :: 42;
    R8G8B8A8_SRGB                                  :: 43;
    B8G8R8A8_UNORM                                 :: 44;
    B8G8R8A8_SNORM                                 :: 45;
    B8G8R8A8_USCALED                               :: 46;
    B8G8R8A8_SSCALED                               :: 47;
    B8G8R8A8_UINT                                  :: 48;
    B8G8R8A8_SINT                                  :: 49;
    B8G8R8A8_SRGB                                  :: 50;
    A8B8G8R8_UNORM_PACK32                          :: 51;
    A8B8G8R8_SNORM_PACK32                          :: 52;
    A8B8G8R8_USCALED_PACK32                        :: 53;
    A8B8G8R8_SSCALED_PACK32                        :: 54;
    A8B8G8R8_UINT_PACK32                           :: 55;
    A8B8G8R8_SINT_PACK32                           :: 56;
    A8B8G8R8_SRGB_PACK32                           :: 57;
    A2R10G10B10_UNORM_PACK32                       :: 58;
    A2R10G10B10_SNORM_PACK32                       :: 59;
    A2R10G10B10_USCALED_PACK32                     :: 60;
    A2R10G10B10_SSCALED_PACK32                     :: 61;
    A2R10G10B10_UINT_PACK32                        :: 62;
    A2R10G10B10_SINT_PACK32                        :: 63;
    A2B10G10R10_UNORM_PACK32                       :: 64;
    A2B10G10R10_SNORM_PACK32                       :: 65;
    A2B10G10R10_USCALED_PACK32                     :: 66;
    A2B10G10R10_SSCALED_PACK32                     :: 67;
    A2B10G10R10_UINT_PACK32                        :: 68;
    A2B10G10R10_SINT_PACK32                        :: 69;
    R16_UNORM                                      :: 70;
    R16_SNORM                                      :: 71;
    R16_USCALED                                    :: 72;
    R16_SSCALED                                    :: 73;
    R16_UINT                                       :: 74;
    R16_SINT                                       :: 75;
    R16_SFLOAT                                     :: 76;
    R16G16_UNORM                                   :: 77;
    R16G16_SNORM                                   :: 78;
    R16G16_USCALED                                 :: 79;
    R16G16_SSCALED                                 :: 80;
    R16G16_UINT                                    :: 81;
    R16G16_SINT                                    :: 82;
    R16G16_SFLOAT                                  :: 83;
    R16G16B16_UNORM                                :: 84;
    R16G16B16_SNORM                                :: 85;
    R16G16B16_USCALED                              :: 86;
    R16G16B16_SSCALED                              :: 87;
    R16G16B16_UINT                                 :: 88;
    R16G16B16_SINT                                 :: 89;
    R16G16B16_SFLOAT                               :: 90;
    R16G16B16A16_UNORM                             :: 91;
    R16G16B16A16_SNORM                             :: 92;
    R16G16B16A16_USCALED                           :: 93;
    R16G16B16A16_SSCALED                           :: 94;
    R16G16B16A16_UINT                              :: 95;
    R16G16B16A16_SINT                              :: 96;
    R16G16B16A16_SFLOAT                            :: 97;
    R32_UINT                                       :: 98;
    R32_SINT                                       :: 99;
    R32_SFLOAT                                     :: 100;
    R32G32_UINT                                    :: 101;
    R32G32_SINT                                    :: 102;
    R32G32_SFLOAT                                  :: 103;
    R32G32B32_UINT                                 :: 104;
    R32G32B32_SINT                                 :: 105;
    R32G32B32_SFLOAT                               :: 106;
    R32G32B32A32_UINT                              :: 107;
    R32G32B32A32_SINT                              :: 108;
    R32G32B32A32_SFLOAT                            :: 109;
    R64_UINT                                       :: 110;
    R64_SINT                                       :: 111;
    R64_SFLOAT                                     :: 112;
    R64G64_UINT                                    :: 113;
    R64G64_SINT                                    :: 114;
    R64G64_SFLOAT                                  :: 115;
    R64G64B64_UINT                                 :: 116;
    R64G64B64_SINT                                 :: 117;
    R64G64B64_SFLOAT                               :: 118;
    R64G64B64A64_UINT                              :: 119;
    R64G64B64A64_SINT                              :: 120;
    R64G64B64A64_SFLOAT                            :: 121;
    B10G11R11_UFLOAT_PACK32                        :: 122;
    E5B9G9R9_UFLOAT_PACK32                         :: 123;
    D16_UNORM                                      :: 124;
    X8_D24_UNORM_PACK32                            :: 125;
    D32_SFLOAT                                     :: 126;
    S8_UINT                                        :: 127;
    D16_UNORM_S8_UINT                              :: 128;
    D24_UNORM_S8_UINT                              :: 129;
    D32_SFLOAT_S8_UINT                             :: 130;
    BC1_RGB_UNORM_BLOCK                            :: 131;
    BC1_RGB_SRGB_BLOCK                             :: 132;
    BC1_RGBA_UNORM_BLOCK                           :: 133;
    BC1_RGBA_SRGB_BLOCK                            :: 134;
    BC2_UNORM_BLOCK                                :: 135;
    BC2_SRGB_BLOCK                                 :: 136;
    BC3_UNORM_BLOCK                                :: 137;
    BC3_SRGB_BLOCK                                 :: 138;
    BC4_UNORM_BLOCK                                :: 139;
    BC4_SNORM_BLOCK                                :: 140;
    BC5_UNORM_BLOCK                                :: 141;
    BC5_SNORM_BLOCK                                :: 142;
    BC6H_UFLOAT_BLOCK                              :: 143;
    BC6H_SFLOAT_BLOCK                              :: 144;
    BC7_UNORM_BLOCK                                :: 145;
    BC7_SRGB_BLOCK                                 :: 146;
    ETC2_R8G8B8_UNORM_BLOCK                        :: 147;
    ETC2_R8G8B8_SRGB_BLOCK                         :: 148;
    ETC2_R8G8B8A1_UNORM_BLOCK                      :: 149;
    ETC2_R8G8B8A1_SRGB_BLOCK                       :: 150;
    ETC2_R8G8B8A8_UNORM_BLOCK                      :: 151;
    ETC2_R8G8B8A8_SRGB_BLOCK                       :: 152;
    EAC_R11_UNORM_BLOCK                            :: 153;
    EAC_R11_SNORM_BLOCK                            :: 154;
    EAC_R11G11_UNORM_BLOCK                         :: 155;
    EAC_R11G11_SNORM_BLOCK                         :: 156;
    ASTC_4x4_UNORM_BLOCK                           :: 157;
    ASTC_4x4_SRGB_BLOCK                            :: 158;
    ASTC_5x4_UNORM_BLOCK                           :: 159;
    ASTC_5x4_SRGB_BLOCK                            :: 160;
    ASTC_5x5_UNORM_BLOCK                           :: 161;
    ASTC_5x5_SRGB_BLOCK                            :: 162;
    ASTC_6x5_UNORM_BLOCK                           :: 163;
    ASTC_6x5_SRGB_BLOCK                            :: 164;
    ASTC_6x6_UNORM_BLOCK                           :: 165;
    ASTC_6x6_SRGB_BLOCK                            :: 166;
    ASTC_8x5_UNORM_BLOCK                           :: 167;
    ASTC_8x5_SRGB_BLOCK                            :: 168;
    ASTC_8x6_UNORM_BLOCK                           :: 169;
    ASTC_8x6_SRGB_BLOCK                            :: 170;
    ASTC_8x8_UNORM_BLOCK                           :: 171;
    ASTC_8x8_SRGB_BLOCK                            :: 172;
    ASTC_10x5_UNORM_BLOCK                          :: 173;
    ASTC_10x5_SRGB_BLOCK                           :: 174;
    ASTC_10x6_UNORM_BLOCK                          :: 175;
    ASTC_10x6_SRGB_BLOCK                           :: 176;
    ASTC_10x8_UNORM_BLOCK                          :: 177;
    ASTC_10x8_SRGB_BLOCK                           :: 178;
    ASTC_10x10_UNORM_BLOCK                         :: 179;
    ASTC_10x10_SRGB_BLOCK                          :: 180;
    ASTC_12x10_UNORM_BLOCK                         :: 181;
    ASTC_12x10_SRGB_BLOCK                          :: 182;
    ASTC_12x12_UNORM_BLOCK                         :: 183;
    ASTC_12x12_SRGB_BLOCK                          :: 184;
    G8B8G8R8_422_UNORM                             :: 1000156000;
    B8G8R8G8_422_UNORM                             :: 1000156001;
    G8_B8_R8_3PLANE_420_UNORM                      :: 1000156002;
    G8_B8R8_2PLANE_420_UNORM                       :: 1000156003;
    G8_B8_R8_3PLANE_422_UNORM                      :: 1000156004;
    G8_B8R8_2PLANE_422_UNORM                       :: 1000156005;
    G8_B8_R8_3PLANE_444_UNORM                      :: 1000156006;
    R10X6_UNORM_PACK16                             :: 1000156007;
    R10X6G10X6_UNORM_2PACK16                       :: 1000156008;
    R10X6G10X6B10X6A10X6_UNORM_4PACK16             :: 1000156009;
    G10X6B10X6G10X6R10X6_422_UNORM_4PACK16         :: 1000156010;
    B10X6G10X6R10X6G10X6_422_UNORM_4PACK16         :: 1000156011;
    G10X6_B10X6_R10X6_3PLANE_420_UNORM_3PACK16     :: 1000156012;
    G10X6_B10X6R10X6_2PLANE_420_UNORM_3PACK16      :: 1000156013;
    G10X6_B10X6_R10X6_3PLANE_422_UNORM_3PACK16     :: 1000156014;
    G10X6_B10X6R10X6_2PLANE_422_UNORM_3PACK16      :: 1000156015;
    G10X6_B10X6_R10X6_3PLANE_444_UNORM_3PACK16     :: 1000156016;
    R12X4_UNORM_PACK16                             :: 1000156017;
    R12X4G12X4_UNORM_2PACK16                       :: 1000156018;
    R12X4G12X4B12X4A12X4_UNORM_4PACK16             :: 1000156019;
    G12X4B12X4G12X4R12X4_422_UNORM_4PACK16         :: 1000156020;
    B12X4G12X4R12X4G12X4_422_UNORM_4PACK16         :: 1000156021;
    G12X4_B12X4_R12X4_3PLANE_420_UNORM_3PACK16     :: 1000156022;
    G12X4_B12X4R12X4_2PLANE_420_UNORM_3PACK16      :: 1000156023;
    G12X4_B12X4_R12X4_3PLANE_422_UNORM_3PACK16     :: 1000156024;
    G12X4_B12X4R12X4_2PLANE_422_UNORM_3PACK16      :: 1000156025;
    G12X4_B12X4_R12X4_3PLANE_444_UNORM_3PACK16     :: 1000156026;
    G16B16G16R16_422_UNORM                         :: 1000156027;
    B16G16R16G16_422_UNORM                         :: 1000156028;
    G16_B16_R16_3PLANE_420_UNORM                   :: 1000156029;
    G16_B16R16_2PLANE_420_UNORM                    :: 1000156030;
    G16_B16_R16_3PLANE_422_UNORM                   :: 1000156031;
    G16_B16R16_2PLANE_422_UNORM                    :: 1000156032;
    G16_B16_R16_3PLANE_444_UNORM                   :: 1000156033;
    G8_B8R8_2PLANE_444_UNORM                       :: 1000330000;
    G10X6_B10X6R10X6_2PLANE_444_UNORM_3PACK16      :: 1000330001;
    G12X4_B12X4R12X4_2PLANE_444_UNORM_3PACK16      :: 1000330002;
    G16_B16R16_2PLANE_444_UNORM                    :: 1000330003;
    A4R4G4B4_UNORM_PACK16                          :: 1000340000;
    A4B4G4R4_UNORM_PACK16                          :: 1000340001;
    ASTC_4x4_SFLOAT_BLOCK                          :: 1000066000;
    ASTC_5x4_SFLOAT_BLOCK                          :: 1000066001;
    ASTC_5x5_SFLOAT_BLOCK                          :: 1000066002;
    ASTC_6x5_SFLOAT_BLOCK                          :: 1000066003;
    ASTC_6x6_SFLOAT_BLOCK                          :: 1000066004;
    ASTC_8x5_SFLOAT_BLOCK                          :: 1000066005;
    ASTC_8x6_SFLOAT_BLOCK                          :: 1000066006;
    ASTC_8x8_SFLOAT_BLOCK                          :: 1000066007;
    ASTC_10x5_SFLOAT_BLOCK                         :: 1000066008;
    ASTC_10x6_SFLOAT_BLOCK                         :: 1000066009;
    ASTC_10x8_SFLOAT_BLOCK                         :: 1000066010;
    ASTC_10x10_SFLOAT_BLOCK                        :: 1000066011;
    ASTC_12x10_SFLOAT_BLOCK                        :: 1000066012;
    ASTC_12x12_SFLOAT_BLOCK                        :: 1000066013;
    PVRTC1_2BPP_UNORM_BLOCK_IMG                    :: 1000054000;
    PVRTC1_4BPP_UNORM_BLOCK_IMG                    :: 1000054001;
    PVRTC2_2BPP_UNORM_BLOCK_IMG                    :: 1000054002;
    PVRTC2_4BPP_UNORM_BLOCK_IMG                    :: 1000054003;
    PVRTC1_2BPP_SRGB_BLOCK_IMG                     :: 1000054004;
    PVRTC1_4BPP_SRGB_BLOCK_IMG                     :: 1000054005;
    PVRTC2_2BPP_SRGB_BLOCK_IMG                     :: 1000054006;
    PVRTC2_4BPP_SRGB_BLOCK_IMG                     :: 1000054007;
    R16G16_SFIXED5_NV                              :: 1000464000;
    A1B5G5R5_UNORM_PACK16_KHR                      :: 1000470000;
    A8_UNORM_KHR                                   :: 1000470001;
    ASTC_4x4_SFLOAT_BLOCK_EXT                      :: 1000066000;
    ASTC_5x4_SFLOAT_BLOCK_EXT                      :: 1000066001;
    ASTC_5x5_SFLOAT_BLOCK_EXT                      :: 1000066002;
    ASTC_6x5_SFLOAT_BLOCK_EXT                      :: 1000066003;
    ASTC_6x6_SFLOAT_BLOCK_EXT                      :: 1000066004;
    ASTC_8x5_SFLOAT_BLOCK_EXT                      :: 1000066005;
    ASTC_8x6_SFLOAT_BLOCK_EXT                      :: 1000066006;
    ASTC_8x8_SFLOAT_BLOCK_EXT                      :: 1000066007;
    ASTC_10x5_SFLOAT_BLOCK_EXT                     :: 1000066008;
    ASTC_10x6_SFLOAT_BLOCK_EXT                     :: 1000066009;
    ASTC_10x8_SFLOAT_BLOCK_EXT                     :: 1000066010;
    ASTC_10x10_SFLOAT_BLOCK_EXT                    :: 1000066011;
    ASTC_12x10_SFLOAT_BLOCK_EXT                    :: 1000066012;
    ASTC_12x12_SFLOAT_BLOCK_EXT                    :: 1000066013;
    G8B8G8R8_422_UNORM_KHR                         :: 1000156000;
    B8G8R8G8_422_UNORM_KHR                         :: 1000156001;
    G8_B8_R8_3PLANE_420_UNORM_KHR                  :: 1000156002;
    G8_B8R8_2PLANE_420_UNORM_KHR                   :: 1000156003;
    G8_B8_R8_3PLANE_422_UNORM_KHR                  :: 1000156004;
    G8_B8R8_2PLANE_422_UNORM_KHR                   :: 1000156005;
    G8_B8_R8_3PLANE_444_UNORM_KHR                  :: 1000156006;
    R10X6_UNORM_PACK16_KHR                         :: 1000156007;
    R10X6G10X6_UNORM_2PACK16_KHR                   :: 1000156008;
    R10X6G10X6B10X6A10X6_UNORM_4PACK16_KHR         :: 1000156009;
    G10X6B10X6G10X6R10X6_422_UNORM_4PACK16_KHR     :: 1000156010;
    B10X6G10X6R10X6G10X6_422_UNORM_4PACK16_KHR     :: 1000156011;
    G10X6_B10X6_R10X6_3PLANE_420_UNORM_3PACK16_KHR :: 1000156012;
    G10X6_B10X6R10X6_2PLANE_420_UNORM_3PACK16_KHR  :: 1000156013;
    G10X6_B10X6_R10X6_3PLANE_422_UNORM_3PACK16_KHR :: 1000156014;
    G10X6_B10X6R10X6_2PLANE_422_UNORM_3PACK16_KHR  :: 1000156015;
    G10X6_B10X6_R10X6_3PLANE_444_UNORM_3PACK16_KHR :: 1000156016;
    R12X4_UNORM_PACK16_KHR                         :: 1000156017;
    R12X4G12X4_UNORM_2PACK16_KHR                   :: 1000156018;
    R12X4G12X4B12X4A12X4_UNORM_4PACK16_KHR         :: 1000156019;
    G12X4B12X4G12X4R12X4_422_UNORM_4PACK16_KHR     :: 1000156020;
    B12X4G12X4R12X4G12X4_422_UNORM_4PACK16_KHR     :: 1000156021;
    G12X4_B12X4_R12X4_3PLANE_420_UNORM_3PACK16_KHR :: 1000156022;
    G12X4_B12X4R12X4_2PLANE_420_UNORM_3PACK16_KHR  :: 1000156023;
    G12X4_B12X4_R12X4_3PLANE_422_UNORM_3PACK16_KHR :: 1000156024;
    G12X4_B12X4R12X4_2PLANE_422_UNORM_3PACK16_KHR  :: 1000156025;
    G12X4_B12X4_R12X4_3PLANE_444_UNORM_3PACK16_KHR :: 1000156026;
    G16B16G16R16_422_UNORM_KHR                     :: 1000156027;
    B16G16R16G16_422_UNORM_KHR                     :: 1000156028;
    G16_B16_R16_3PLANE_420_UNORM_KHR               :: 1000156029;
    G16_B16R16_2PLANE_420_UNORM_KHR                :: 1000156030;
    G16_B16_R16_3PLANE_422_UNORM_KHR               :: 1000156031;
    G16_B16R16_2PLANE_422_UNORM_KHR                :: 1000156032;
    G16_B16_R16_3PLANE_444_UNORM_KHR               :: 1000156033;
    G8_B8R8_2PLANE_444_UNORM_EXT                   :: 1000330000;
    G10X6_B10X6R10X6_2PLANE_444_UNORM_3PACK16_EXT  :: 1000330001;
    G12X4_B12X4R12X4_2PLANE_444_UNORM_3PACK16_EXT  :: 1000330002;
    G16_B16R16_2PLANE_444_UNORM_EXT                :: 1000330003;
    A4R4G4B4_UNORM_PACK16_EXT                      :: 1000340000;
    A4B4G4R4_UNORM_PACK16_EXT                      :: 1000340001;
    R16G16_S10_5_NV                                :: 1000464000;
}

Image :: struct{
	#as handle: VkImage;
    using extent: VkExtent3D;
	view: VkImageView;
	layout : Image_Layout;
	usage : Image_Usage;
    format: Image_Format;
    allocation: GPU_Allocation;
}

Swap_Chain_Present_Mode :: enum u32{
	IMMEDIATE				  :: 0;
	MAILBOX					  :: 1;
	FIFO					  :: 2;
	FIFO_RELAXED			  :: 3;
	SHARED_DEMAND_REFRESH	  :: 1000111000;
	SHARED_CONTINUOUS_REFRESH :: 1000111001;
}

#scope_module

Swapchain :: struct{
	#as handle: VkSwapchainKHR;
	images: [] Image;
	extent: VkExtent2D;
	surface_format: VkSurfaceFormatKHR;
	present_mode: Swap_Chain_Present_Mode;
	current_image: u32;

	current_sync: u32;
	semaphores: [] Semaphore;
}

create_swapchain :: (window: *void, width:s32, height: s32, present_mode: Swap_Chain_Present_Mode, old_handle: VkSwapchainKHR = VK_NULL_HANDLE) -> Swapchain {
	swapchain: Swapchain;
	surface := create_surface(window);

	swapchain.surface_format = .{.B8G8R8A8_SRGB, .COLOR_SPACE_SRGB_NONLINEAR_KHR};
	swapchain.present_mode = xx present_mode;
	swapchain.extent = .{xx width, xx height};

	image_count := ifx (!surface.capabilities.maxImageCount) then surface.capabilities.minImageCount + 1 else clamp_hi(surface.capabilities.minImageCount + 1, surface.capabilities.maxImageCount);
	
	swapchain_create_info: VkSwapchainCreateInfoKHR;
	swapchain_create_info.surface = surface.handle;
	swapchain_create_info.minImageCount = image_count;
	swapchain_create_info.imageFormat = swapchain.surface_format.format;
	swapchain_create_info.imageColorSpace = swapchain.surface_format.colorSpace;
	swapchain_create_info.imageExtent = swapchain.extent;
	swapchain_create_info.imageArrayLayers = 1;
	swapchain_create_info.imageUsage = .COLOR_ATTACHMENT_BIT | .TRANSFER_DST_BIT;

	swapchain_create_info.imageSharingMode = .EXCLUSIVE;
	swapchain_create_info.queueFamilyIndexCount = 0;
	swapchain_create_info.pQueueFamilyIndices = null;
	swapchain_create_info.preTransform = surface.capabilities.currentTransform;
	swapchain_create_info.compositeAlpha = .OPAQUE_BIT_KHR;
	swapchain_create_info.presentMode = xx present_mode; 
	swapchain_create_info.clipped = VK_TRUE;
	swapchain_create_info.oldSwapchain = old_handle;

	// // MIN_BIT_EXT            :: 0x1;
    // // MAX_BIT_EXT            :: 0x2;
    // // CENTERED_BIT_EXT       :: 0x4;
	//     ONE_TO_ONE_BIT_EXT           :: 0x1;
    // ASPECT_RATIO_STRETCH_BIT_EXT :: 0x2;
    // STRETCH_BIT_EXT              :: 0x4;
    // FLAG_BITS_MAX_ENUM_EXT       :: 0x7fffffff;

	scaling :VkSwapchainPresentScalingCreateInfoEXT;
	scaling.scalingBehavior = .STRETCH_BIT_EXT;
	scaling.presentGravityX = .MIN_BIT_EXT;
	scaling.presentGravityY = .MIN_BIT_EXT;
	swapchain_create_info.pNext = *scaling;
	
	vk_assert(vkCreateSwapchainKHR(device.handle, *swapchain_create_info, null, *swapchain.handle));
	
	swapchain.images = array_new(image_count, Image);
	swapchain.semaphores = array_new(image_count, Semaphore);
	raw_images := array_new(image_count, VkImage,, temp);
	vkGetSwapchainImagesKHR(device.handle, swapchain.handle, *image_count, raw_images.data);

	for * swapchain.semaphores{
		it.* = gpu_create_binary_semaphore();
	}
	
	for raw_images{
		swapchain.images[it_index].handle = it;
		swapchain.images[it_index].layout = .UNDEFINED;
		swapchain.images[it_index].format = .B8G8R8A8_SRGB;
		swapchain.images[it_index].extent = .{xx width, xx height, 1};
	}
	return swapchain;
}

destroy_swapchain :: (swapchain: *Swapchain){
	vkDeviceWaitIdle(device);
	vkDestroySwapchainKHR(device, swapchain, null);
	array_free(swapchain.images);
}
#if false{

acquire_image_from_swapchain :: (swapchain: Swapchain, semaphore: GPU_Semaphore, fence: Fence = .{}, timeout: u64 = U64_MAX) -> *Image, u32, bool{
	using rendering_context;
	index: u32;
	e := vkAcquireNextImageKHR(device, swapchain, timeout, semaphore, fence, *index);
	if e == VkResult.ERROR_OUT_OF_DATE_KHR return null, U32_MAX, true;
	return *swapchain.images[index], index, false;
}

present_queue_to_swapchain :: (swapchain: Swapchain, index: u32 /*temp*/, semaphore: *GPU_Semaphore = null){
	using rendering_context;
	present_info: VkPresentInfoKHR;
	present_info.pSwapchains = *swapchain.handle;
	present_info.swapchainCount = 1;

	if semaphore{
		present_info.pWaitSemaphores = *semaphore.handle;
		present_info.waitSemaphoreCount = 1;
	}

	present_info.pImageIndices = *index;

	vkQueuePresentKHR(device.queues[Device_Queue.GRAPHIC_PRESENT], *present_info);
}

}

#scope_file;

Surface :: struct {
	#as handle: VkSurfaceKHR;
	capabilities: VkSurfaceCapabilitiesKHR ;
	formats: [..] VkSurfaceFormatKHR;
	present_modes: [..] VkPresentModeKHR;
	window_handle: *void;
}

create_surface :: (window_handle: * void) -> Surface { 
	#import "Windows";
	surface: Surface;
	surface.window_handle = window_handle;
	
	surface_info: VkWin32SurfaceCreateInfoKHR;
	surface_info.hwnd = cast(HWND, window_handle);
	surface_info.hinstance = GetModuleHandleA(null);
	
	vk_assert(vkCreateWin32SurfaceKHR(instance.handle, *surface_info, null, *surface.handle));
	
	vkGetPhysicalDeviceSurfaceCapabilitiesKHR(physical_device.handle, surface.handle, *surface.capabilities);

	format_count: u32;
	vkGetPhysicalDeviceSurfaceFormatsKHR(physical_device.handle, surface.handle, *format_count, null);
	array_resize(*surface.formats, format_count);
	vkGetPhysicalDeviceSurfaceFormatsKHR(physical_device.handle, surface.handle, *format_count, surface.formats.data);
	
	present_mode_count: u32;
	vkGetPhysicalDeviceSurfacePresentModesKHR(physical_device.handle, surface.handle, *present_mode_count, null);
	array_resize(*surface.present_modes, present_mode_count);
	vkGetPhysicalDeviceSurfacePresentModesKHR(physical_device.handle, surface.handle, *present_mode_count, surface.present_modes.data);
	
	return surface;
}
