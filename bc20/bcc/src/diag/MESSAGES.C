/* target: ovr095_C71MSG */
/* opts: -mm -zCCO026_TEXT -zECO026_TEXT -zFCODE */
/* Role: diagnostic message table. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: the text of every compiler message, as one data block that is linked as its
   own overlay segment (the far data goes to segment CO026_TEXT, class CODE, by the -z
   options above) and loaded
   only when a message is printed (BCC_MESSAGE_TEXT in MSGGET.C).
   Layout of the block (struct diagnostic_message_payload, 13406 bytes in all):
   - offsets[393]: one word per message number 0..392, the offset of the text from the
     start of the block. The names of the numbers are the MSG_* constants of MSG.H.
     A 0 entry is a number BCC does not use (25 of them). Several numbers share one text
     (the same message_NNN appears twice), and number 182 points 15 bytes into
     message_160, reusing the tail of that string.
   - message_000 .. message_356: the 357 distinct texts, 0-terminated, as printf formats
     (%s for names, %d and %ld for numbers). Each array is sized to its string so the
     layout, and so every offset, comes out as in the original.
   Ranges by number: 0 is "Noerror"; 1..9 are fatal (REPORT_DIAGNOSTIC_AT in DIAG.C sends
   them to REPORT_FATAL); 10..331 are errors; 332 is unused; 333..392 are warnings. The
   typedef payload_size_must_be_13406 fails to compile if the size ever changes.
   The message_NNN numbers count the strings in order; they are not message numbers. */
#include <stddef.h>
/* Loader resource: relative WORD offsets followed by literal NUL strings.
 * Zero entries remain offset zero; entry 182 deliberately shares a suffix.
 * The existing BCC_MESSAGE_IMAGE address carrier denotes the loader
 * descriptor, separately from this private loaded-image payload. */
struct diagnostic_message_payload {
    unsigned int offsets[393];
    char message_000[8];
    char message_001[28];
    char message_002[28];
    char message_003[31];
    char message_004[31];
    char message_005[34];
    char message_006[14];
    char message_007[26];
    char message_008[20];
    char message_009[30];
    char message_010[25];
    char message_011[42];
    char message_012[21];
    char message_013[33];
    char message_014[29];
    char message_015[28];
    char message_016[33];
    char message_017[42];
    char message_018[20];
    char message_019[23];
    char message_020[20];
    char message_021[29];
    char message_022[24];
    char message_023[25];
    char message_024[19];
    char message_025[30];
    char message_026[24];
    char message_027[25];
    char message_028[28];
    char message_029[29];
    char message_030[29];
    char message_031[22];
    char message_032[37];
    char message_033[37];
    char message_034[21];
    char message_035[40];
    char message_036[30];
    char message_037[25];
    char message_038[25];
    char message_039[26];
    char message_040[18];
    char message_041[53];
    char message_042[57];
    char message_043[18];
    char message_044[31];
    char message_045[27];
    char message_046[35];
    char message_047[30];
    char message_048[19];
    char message_049[27];
    char message_050[29];
    char message_051[34];
    char message_052[27];
    char message_053[28];
    char message_054[30];
    char message_055[23];
    char message_056[33];
    char message_057[20];
    char message_058[28];
    char message_059[16];
    char message_060[35];
    char message_061[23];
    char message_062[23];
    char message_063[23];
    char message_064[39];
    char message_065[26];
    char message_066[25];
    char message_067[24];
    char message_068[19];
    char message_069[22];
    char message_070[28];
    char message_071[20];
    char message_072[24];
    char message_073[27];
    char message_074[20];
    char message_075[47];
    char message_076[48];
    char message_077[31];
    char message_078[32];
    char message_079[36];
    char message_080[25];
    char message_081[28];
    char message_082[28];
    char message_083[47];
    char message_084[42];
    char message_085[25];
    char message_086[27];
    char message_087[37];
    char message_088[22];
    char message_089[24];
    char message_090[25];
    char message_091[31];
    char message_092[24];
    char message_093[30];
    char message_094[51];
    char message_095[32];
    char message_096[39];
    char message_097[42];
    char message_098[39];
    char message_099[50];
    char message_100[50];
    char message_101[37];
    char message_102[44];
    char message_103[27];
    char message_104[50];
    char message_105[40];
    char message_106[42];
    char message_107[16];
    char message_108[53];
    char message_109[30];
    char message_110[19];
    char message_111[52];
    char message_112[52];
    char message_113[19];
    char message_114[35];
    char message_115[30];
    char message_116[22];
    char message_117[51];
    char message_118[33];
    char message_119[42];
    char message_120[51];
    char message_121[15];
    char message_122[35];
    char message_123[52];
    char message_124[43];
    char message_125[46];
    char message_126[44];
    char message_127[49];
    char message_128[51];
    char message_129[38];
    char message_130[33];
    char message_131[38];
    char message_132[44];
    char message_133[36];
    char message_134[25];
    char message_135[52];
    char message_136[59];
    char message_137[50];
    char message_138[40];
    char message_139[40];
    char message_140[41];
    char message_141[65];
    char message_142[53];
    char message_143[24];
    char message_144[51];
    char message_145[44];
    char message_146[47];
    char message_147[47];
    char message_148[49];
    char message_149[23];
    char message_150[42];
    char message_151[20];
    char message_152[41];
    char message_153[31];
    char message_154[36];
    char message_155[62];
    char message_156[32];
    char message_157[52];
    char message_158[46];
    char message_159[46];
    char message_160[38];
    char message_161[17];
    char message_162[23];
    char message_163[44];
    char message_164[43];
    char message_165[15];
    char message_166[42];
    char message_167[30];
    char message_168[46];
    char message_169[31];
    char message_170[48];
    char message_171[33];
    char message_172[52];
    char message_173[52];
    char message_174[30];
    char message_175[13];
    char message_176[44];
    char message_177[37];
    char message_178[44];
    char message_179[21];
    char message_180[32];
    char message_181[45];
    char message_182[26];
    char message_183[33];
    char message_184[31];
    char message_185[41];
    char message_186[27];
    char message_187[59];
    char message_188[28];
    char message_189[11];
    char message_190[37];
    char message_191[26];
    char message_192[20];
    char message_193[21];
    char message_194[11];
    char message_195[53];
    char message_196[34];
    char message_197[25];
    char message_198[50];
    char message_199[20];
    char message_200[26];
    char message_201[29];
    char message_202[49];
    char message_203[47];
    char message_204[20];
    char message_205[27];
    char message_206[50];
    char message_207[41];
    char message_208[11];
    char message_209[50];
    char message_210[11];
    char message_211[41];
    char message_212[32];
    char message_213[14];
    char message_214[48];
    char message_215[42];
    char message_216[42];
    char message_217[40];
    char message_218[27];
    char message_219[23];
    char message_220[17];
    char message_221[13];
    char message_222[11];
    char message_223[39];
    char message_224[31];
    char message_225[11];
    char message_226[20];
    char message_227[32];
    char message_228[27];
    char message_229[27];
    char message_230[34];
    char message_231[30];
    char message_232[48];
    char message_233[29];
    char message_234[26];
    char message_235[55];
    char message_236[20];
    char message_237[23];
    char message_238[41];
    char message_239[19];
    char message_240[30];
    char message_241[48];
    char message_242[34];
    char message_243[29];
    char message_244[58];
    char message_245[45];
    char message_246[43];
    char message_247[35];
    char message_248[41];
    char message_249[40];
    char message_250[39];
    char message_251[49];
    char message_252[50];
    char message_253[35];
    char message_254[29];
    char message_255[47];
    char message_256[43];
    char message_257[32];
    char message_258[36];
    char message_259[25];
    char message_260[22];
    char message_261[23];
    char message_262[47];
    char message_263[34];
    char message_264[59];
    char message_265[39];
    char message_266[46];
    char message_267[48];
    char message_268[46];
    char message_269[31];
    char message_270[43];
    char message_271[23];
    char message_272[40];
    char message_273[40];
    char message_274[49];
    char message_275[42];
    char message_276[41];
    char message_277[46];
    char message_278[38];
    char message_279[65];
    char message_280[52];
    char message_281[35];
    char message_282[27];
    char message_283[64];
    char message_284[56];
    char message_285[53];
    char message_286[51];
    char message_287[46];
    char message_288[42];
    char message_289[55];
    char message_290[15];
    char message_291[26];
    char message_292[43];
    char message_293[44];
    char message_294[43];
    char message_295[33];
    char message_296[53];
    char message_297[53];
    char message_298[54];
    char message_299[54];
    char message_300[42];
    char message_301[50];
    char message_302[34];
    char message_303[65];
    char message_304[49];
    char message_305[45];
    char message_306[69];
    char message_307[54];
    char message_308[62];
    char message_309[24];
    char message_310[54];
    char message_311[34];
    char message_312[49];
    char message_313[50];
    char message_314[33];
    char message_315[34];
    char message_316[41];
    char message_317[40];
    char message_318[48];
    char message_319[57];
    char message_320[45];
    char message_321[41];
    char message_322[43];
    char message_323[32];
    char message_324[37];
    char message_325[28];
    char message_326[29];
    char message_327[34];
    char message_328[30];
    char message_329[40];
    char message_330[35];
    char message_331[17];
    char message_332[31];
    char message_333[39];
    char message_334[36];
    char message_335[38];
    char message_336[30];
    char message_337[39];
    char message_338[33];
    char message_339[19];
    char message_340[44];
    char message_341[18];
    char message_342[30];
    char message_343[17];
    char message_344[26];
    char message_345[38];
    char message_346[46];
    char message_347[44];
    char message_348[32];
    char message_349[45];
    char message_350[37];
    char message_351[39];
    char message_352[19];
    char message_353[33];
    char message_354[46];
    char message_355[52];
    char message_356[28];
};
typedef char payload_size_must_be_13406[(sizeof(struct diagnostic_message_payload)==13406)?1:-1];
/* The data: the offset table (each line notes its message number), then the strings
   in the order of the message_NNN fields. */
static struct diagnostic_message_payload far private_message_payload = {
    {
        offsetof(struct diagnostic_message_payload, message_000), /* 0 */
        offsetof(struct diagnostic_message_payload, message_001), /* 1 */
        offsetof(struct diagnostic_message_payload, message_002), /* 2 */
        offsetof(struct diagnostic_message_payload, message_003), /* 3 */
        offsetof(struct diagnostic_message_payload, message_004), /* 4 */
        offsetof(struct diagnostic_message_payload, message_005), /* 5 */
        offsetof(struct diagnostic_message_payload, message_006), /* 6 */
        offsetof(struct diagnostic_message_payload, message_007), /* 7 */
        offsetof(struct diagnostic_message_payload, message_008), /* 8 */
        offsetof(struct diagnostic_message_payload, message_009), /* 9 */
        offsetof(struct diagnostic_message_payload, message_010), /* 10 */
        offsetof(struct diagnostic_message_payload, message_011), /* 11 */
        offsetof(struct diagnostic_message_payload, message_012), /* 12 */
        offsetof(struct diagnostic_message_payload, message_013), /* 13 */
        offsetof(struct diagnostic_message_payload, message_014), /* 14 */
        offsetof(struct diagnostic_message_payload, message_015), /* 15 */
        offsetof(struct diagnostic_message_payload, message_016), /* 16 */
        offsetof(struct diagnostic_message_payload, message_017), /* 17 */
        offsetof(struct diagnostic_message_payload, message_018), /* 18 */
        offsetof(struct diagnostic_message_payload, message_019), /* 19 */
        offsetof(struct diagnostic_message_payload, message_020), /* 20 */
        offsetof(struct diagnostic_message_payload, message_021), /* 21 */
        offsetof(struct diagnostic_message_payload, message_022), /* 22 */
        offsetof(struct diagnostic_message_payload, message_023), /* 23 */
        offsetof(struct diagnostic_message_payload, message_024), /* 24 */
        offsetof(struct diagnostic_message_payload, message_025), /* 25 */
        offsetof(struct diagnostic_message_payload, message_026), /* 26 */
        offsetof(struct diagnostic_message_payload, message_027), /* 27 */
        offsetof(struct diagnostic_message_payload, message_028), /* 28 */
        offsetof(struct diagnostic_message_payload, message_029), /* 29 */
        offsetof(struct diagnostic_message_payload, message_030), /* 30 */
        offsetof(struct diagnostic_message_payload, message_031), /* 31 */
        offsetof(struct diagnostic_message_payload, message_032), /* 32 */
        offsetof(struct diagnostic_message_payload, message_033), /* 33 */
        offsetof(struct diagnostic_message_payload, message_034), /* 34 */
        offsetof(struct diagnostic_message_payload, message_035), /* 35 */
        offsetof(struct diagnostic_message_payload, message_036), /* 36 */
        offsetof(struct diagnostic_message_payload, message_037), /* 37 */
        offsetof(struct diagnostic_message_payload, message_038), /* 38 */
        offsetof(struct diagnostic_message_payload, message_039), /* 39 */
        offsetof(struct diagnostic_message_payload, message_040), /* 40 */
        offsetof(struct diagnostic_message_payload, message_041), /* 41 */
        offsetof(struct diagnostic_message_payload, message_042), /* 42 */
        offsetof(struct diagnostic_message_payload, message_043), /* 43 */
        offsetof(struct diagnostic_message_payload, message_044), /* 44 */
        offsetof(struct diagnostic_message_payload, message_045), /* 45 */
        offsetof(struct diagnostic_message_payload, message_046), /* 46 */
        offsetof(struct diagnostic_message_payload, message_047), /* 47 */
        offsetof(struct diagnostic_message_payload, message_048), /* 48 */
        offsetof(struct diagnostic_message_payload, message_049), /* 49 */
        0, /* 50 */
        offsetof(struct diagnostic_message_payload, message_050), /* 51 */
        offsetof(struct diagnostic_message_payload, message_051), /* 52 */
        offsetof(struct diagnostic_message_payload, message_052), /* 53 */
        offsetof(struct diagnostic_message_payload, message_053), /* 54 */
        offsetof(struct diagnostic_message_payload, message_054), /* 55 */
        offsetof(struct diagnostic_message_payload, message_055), /* 56 */
        offsetof(struct diagnostic_message_payload, message_056), /* 57 */
        offsetof(struct diagnostic_message_payload, message_057), /* 58 */
        offsetof(struct diagnostic_message_payload, message_058), /* 59 */
        offsetof(struct diagnostic_message_payload, message_059), /* 60 */
        offsetof(struct diagnostic_message_payload, message_060), /* 61 */
        offsetof(struct diagnostic_message_payload, message_061), /* 62 */
        offsetof(struct diagnostic_message_payload, message_062), /* 63 */
        offsetof(struct diagnostic_message_payload, message_063), /* 64 */
        offsetof(struct diagnostic_message_payload, message_064), /* 65 */
        offsetof(struct diagnostic_message_payload, message_065), /* 66 */
        offsetof(struct diagnostic_message_payload, message_066), /* 67 */
        offsetof(struct diagnostic_message_payload, message_067), /* 68 */
        offsetof(struct diagnostic_message_payload, message_068), /* 69 */
        offsetof(struct diagnostic_message_payload, message_069), /* 70 */
        offsetof(struct diagnostic_message_payload, message_070), /* 71 */
        0, /* 72 */
        offsetof(struct diagnostic_message_payload, message_071), /* 73 */
        offsetof(struct diagnostic_message_payload, message_072), /* 74 */
        offsetof(struct diagnostic_message_payload, message_073), /* 75 */
        offsetof(struct diagnostic_message_payload, message_074), /* 76 */
        offsetof(struct diagnostic_message_payload, message_075), /* 77 */
        offsetof(struct diagnostic_message_payload, message_076), /* 78 */
        offsetof(struct diagnostic_message_payload, message_077), /* 79 */
        offsetof(struct diagnostic_message_payload, message_078), /* 80 */
        offsetof(struct diagnostic_message_payload, message_079), /* 81 */
        offsetof(struct diagnostic_message_payload, message_080), /* 82 */
        offsetof(struct diagnostic_message_payload, message_081), /* 83 */
        offsetof(struct diagnostic_message_payload, message_082), /* 84 */
        offsetof(struct diagnostic_message_payload, message_083), /* 85 */
        offsetof(struct diagnostic_message_payload, message_084), /* 86 */
        offsetof(struct diagnostic_message_payload, message_085), /* 87 */
        offsetof(struct diagnostic_message_payload, message_086), /* 88 */
        offsetof(struct diagnostic_message_payload, message_087), /* 89 */
        offsetof(struct diagnostic_message_payload, message_088), /* 90 */
        offsetof(struct diagnostic_message_payload, message_089), /* 91 */
        offsetof(struct diagnostic_message_payload, message_090), /* 92 */
        0, /* 93 */
        offsetof(struct diagnostic_message_payload, message_091), /* 94 */
        0, /* 95 */
        offsetof(struct diagnostic_message_payload, message_092), /* 96 */
        offsetof(struct diagnostic_message_payload, message_093), /* 97 */
        0, /* 98 */
        0, /* 99 */
        offsetof(struct diagnostic_message_payload, message_094), /* 100 */
        offsetof(struct diagnostic_message_payload, message_095), /* 101 */
        offsetof(struct diagnostic_message_payload, message_096), /* 102 */
        offsetof(struct diagnostic_message_payload, message_097), /* 103 */
        offsetof(struct diagnostic_message_payload, message_098), /* 104 */
        offsetof(struct diagnostic_message_payload, message_099), /* 105 */
        offsetof(struct diagnostic_message_payload, message_100), /* 106 */
        offsetof(struct diagnostic_message_payload, message_101), /* 107 */
        offsetof(struct diagnostic_message_payload, message_102), /* 108 */
        offsetof(struct diagnostic_message_payload, message_103), /* 109 */
        offsetof(struct diagnostic_message_payload, message_104), /* 110 */
        offsetof(struct diagnostic_message_payload, message_105), /* 111 */
        offsetof(struct diagnostic_message_payload, message_106), /* 112 */
        offsetof(struct diagnostic_message_payload, message_107), /* 113 */
        offsetof(struct diagnostic_message_payload, message_108), /* 114 */
        offsetof(struct diagnostic_message_payload, message_109), /* 115 */
        offsetof(struct diagnostic_message_payload, message_110), /* 116 */
        offsetof(struct diagnostic_message_payload, message_111), /* 117 */
        offsetof(struct diagnostic_message_payload, message_112), /* 118 */
        offsetof(struct diagnostic_message_payload, message_113), /* 119 */
        offsetof(struct diagnostic_message_payload, message_114), /* 120 */
        offsetof(struct diagnostic_message_payload, message_115), /* 121 */
        offsetof(struct diagnostic_message_payload, message_116), /* 122 */
        offsetof(struct diagnostic_message_payload, message_117), /* 123 */
        offsetof(struct diagnostic_message_payload, message_118), /* 124 */
        offsetof(struct diagnostic_message_payload, message_119), /* 125 */
        offsetof(struct diagnostic_message_payload, message_120), /* 126 */
        offsetof(struct diagnostic_message_payload, message_121), /* 127 */
        offsetof(struct diagnostic_message_payload, message_122), /* 128 */
        offsetof(struct diagnostic_message_payload, message_123), /* 129 */
        offsetof(struct diagnostic_message_payload, message_124), /* 130 */
        offsetof(struct diagnostic_message_payload, message_125), /* 131 */
        offsetof(struct diagnostic_message_payload, message_126), /* 132 */
        offsetof(struct diagnostic_message_payload, message_127), /* 133 */
        offsetof(struct diagnostic_message_payload, message_128), /* 134 */
        offsetof(struct diagnostic_message_payload, message_129), /* 135 */
        offsetof(struct diagnostic_message_payload, message_130), /* 136 */
        offsetof(struct diagnostic_message_payload, message_131), /* 137 */
        offsetof(struct diagnostic_message_payload, message_132), /* 138 */
        offsetof(struct diagnostic_message_payload, message_133), /* 139 */
        offsetof(struct diagnostic_message_payload, message_134), /* 140 */
        offsetof(struct diagnostic_message_payload, message_135), /* 141 */
        offsetof(struct diagnostic_message_payload, message_136), /* 142 */
        offsetof(struct diagnostic_message_payload, message_137), /* 143 */
        offsetof(struct diagnostic_message_payload, message_138), /* 144 */
        offsetof(struct diagnostic_message_payload, message_139), /* 145 */
        offsetof(struct diagnostic_message_payload, message_140), /* 146 */
        offsetof(struct diagnostic_message_payload, message_141), /* 147 */
        offsetof(struct diagnostic_message_payload, message_142), /* 148 */
        offsetof(struct diagnostic_message_payload, message_143), /* 149 */
        offsetof(struct diagnostic_message_payload, message_144), /* 150 */
        offsetof(struct diagnostic_message_payload, message_145), /* 151 */
        offsetof(struct diagnostic_message_payload, message_146), /* 152 */
        offsetof(struct diagnostic_message_payload, message_147), /* 153 */
        offsetof(struct diagnostic_message_payload, message_148), /* 154 */
        offsetof(struct diagnostic_message_payload, message_149), /* 155 */
        offsetof(struct diagnostic_message_payload, message_150), /* 156 */
        offsetof(struct diagnostic_message_payload, message_151), /* 157 */
        offsetof(struct diagnostic_message_payload, message_152), /* 158 */
        offsetof(struct diagnostic_message_payload, message_153), /* 159 */
        offsetof(struct diagnostic_message_payload, message_154), /* 160 */
        offsetof(struct diagnostic_message_payload, message_155), /* 161 */
        offsetof(struct diagnostic_message_payload, message_156), /* 162 */
        offsetof(struct diagnostic_message_payload, message_157), /* 163 */
        offsetof(struct diagnostic_message_payload, message_158), /* 164 */
        offsetof(struct diagnostic_message_payload, message_159), /* 165 */
        offsetof(struct diagnostic_message_payload, message_160), /* 166 */
        offsetof(struct diagnostic_message_payload, message_161), /* 167 */
        offsetof(struct diagnostic_message_payload, message_162), /* 168 */
        offsetof(struct diagnostic_message_payload, message_163), /* 169 */
        offsetof(struct diagnostic_message_payload, message_164), /* 170 */
        offsetof(struct diagnostic_message_payload, message_165), /* 171 */
        offsetof(struct diagnostic_message_payload, message_166), /* 172 */
        offsetof(struct diagnostic_message_payload, message_167), /* 173 */
        offsetof(struct diagnostic_message_payload, message_168), /* 174 */
        offsetof(struct diagnostic_message_payload, message_169), /* 175 */
        offsetof(struct diagnostic_message_payload, message_170), /* 176 */
        offsetof(struct diagnostic_message_payload, message_171), /* 177 */
        offsetof(struct diagnostic_message_payload, message_172), /* 178 */
        offsetof(struct diagnostic_message_payload, message_173), /* 179 */
        offsetof(struct diagnostic_message_payload, message_174), /* 180 */
        offsetof(struct diagnostic_message_payload, message_175), /* 181 */
        offsetof(struct diagnostic_message_payload, message_160)+15, /* 182 */
        0, /* 183 */
        offsetof(struct diagnostic_message_payload, message_176), /* 184 */
        offsetof(struct diagnostic_message_payload, message_177), /* 185 */
        offsetof(struct diagnostic_message_payload, message_178), /* 186 */
        offsetof(struct diagnostic_message_payload, message_179), /* 187 */
        offsetof(struct diagnostic_message_payload, message_180), /* 188 */
        offsetof(struct diagnostic_message_payload, message_181), /* 189 */
        offsetof(struct diagnostic_message_payload, message_182), /* 190 */
        offsetof(struct diagnostic_message_payload, message_183), /* 191 */
        offsetof(struct diagnostic_message_payload, message_184), /* 192 */
        offsetof(struct diagnostic_message_payload, message_185), /* 193 */
        offsetof(struct diagnostic_message_payload, message_186), /* 194 */
        offsetof(struct diagnostic_message_payload, message_187), /* 195 */
        offsetof(struct diagnostic_message_payload, message_188), /* 196 */
        offsetof(struct diagnostic_message_payload, message_189), /* 197 */
        offsetof(struct diagnostic_message_payload, message_190), /* 198 */
        offsetof(struct diagnostic_message_payload, message_191), /* 199 */
        offsetof(struct diagnostic_message_payload, message_192), /* 200 */
        offsetof(struct diagnostic_message_payload, message_193), /* 201 */
        offsetof(struct diagnostic_message_payload, message_194), /* 202 */
        offsetof(struct diagnostic_message_payload, message_195), /* 203 */
        offsetof(struct diagnostic_message_payload, message_196), /* 204 */
        offsetof(struct diagnostic_message_payload, message_197), /* 205 */
        offsetof(struct diagnostic_message_payload, message_198), /* 206 */
        offsetof(struct diagnostic_message_payload, message_199), /* 207 */
        offsetof(struct diagnostic_message_payload, message_200), /* 208 */
        offsetof(struct diagnostic_message_payload, message_201), /* 209 */
        offsetof(struct diagnostic_message_payload, message_202), /* 210 */
        offsetof(struct diagnostic_message_payload, message_203), /* 211 */
        offsetof(struct diagnostic_message_payload, message_204), /* 212 */
        offsetof(struct diagnostic_message_payload, message_205), /* 213 */
        offsetof(struct diagnostic_message_payload, message_206), /* 214 */
        offsetof(struct diagnostic_message_payload, message_207), /* 215 */
        offsetof(struct diagnostic_message_payload, message_208), /* 216 */
        offsetof(struct diagnostic_message_payload, message_209), /* 217 */
        offsetof(struct diagnostic_message_payload, message_210), /* 218 */
        offsetof(struct diagnostic_message_payload, message_211), /* 219 */
        offsetof(struct diagnostic_message_payload, message_212), /* 220 */
        offsetof(struct diagnostic_message_payload, message_213), /* 221 */
        offsetof(struct diagnostic_message_payload, message_214), /* 222 */
        offsetof(struct diagnostic_message_payload, message_215), /* 223 */
        offsetof(struct diagnostic_message_payload, message_216), /* 224 */
        offsetof(struct diagnostic_message_payload, message_217), /* 225 */
        offsetof(struct diagnostic_message_payload, message_218), /* 226 */
        offsetof(struct diagnostic_message_payload, message_219), /* 227 */
        offsetof(struct diagnostic_message_payload, message_220), /* 228 */
        offsetof(struct diagnostic_message_payload, message_221), /* 229 */
        offsetof(struct diagnostic_message_payload, message_222), /* 230 */
        offsetof(struct diagnostic_message_payload, message_223), /* 231 */
        offsetof(struct diagnostic_message_payload, message_224), /* 232 */
        offsetof(struct diagnostic_message_payload, message_225), /* 233 */
        offsetof(struct diagnostic_message_payload, message_226), /* 234 */
        offsetof(struct diagnostic_message_payload, message_227), /* 235 */
        offsetof(struct diagnostic_message_payload, message_228), /* 236 */
        offsetof(struct diagnostic_message_payload, message_229), /* 237 */
        offsetof(struct diagnostic_message_payload, message_230), /* 238 */
        offsetof(struct diagnostic_message_payload, message_231), /* 239 */
        offsetof(struct diagnostic_message_payload, message_232), /* 240 */
        offsetof(struct diagnostic_message_payload, message_233), /* 241 */
        offsetof(struct diagnostic_message_payload, message_234), /* 242 */
        offsetof(struct diagnostic_message_payload, message_235), /* 243 */
        offsetof(struct diagnostic_message_payload, message_236), /* 244 */
        offsetof(struct diagnostic_message_payload, message_237), /* 245 */
        offsetof(struct diagnostic_message_payload, message_238), /* 246 */
        offsetof(struct diagnostic_message_payload, message_239), /* 247 */
        offsetof(struct diagnostic_message_payload, message_240), /* 248 */
        offsetof(struct diagnostic_message_payload, message_241), /* 249 */
        offsetof(struct diagnostic_message_payload, message_242), /* 250 */
        offsetof(struct diagnostic_message_payload, message_243), /* 251 */
        offsetof(struct diagnostic_message_payload, message_244), /* 252 */
        offsetof(struct diagnostic_message_payload, message_245), /* 253 */
        offsetof(struct diagnostic_message_payload, message_246), /* 254 */
        offsetof(struct diagnostic_message_payload, message_247), /* 255 */
        offsetof(struct diagnostic_message_payload, message_248), /* 256 */
        offsetof(struct diagnostic_message_payload, message_249), /* 257 */
        offsetof(struct diagnostic_message_payload, message_250), /* 258 */
        offsetof(struct diagnostic_message_payload, message_251), /* 259 */
        offsetof(struct diagnostic_message_payload, message_252), /* 260 */
        offsetof(struct diagnostic_message_payload, message_253), /* 261 */
        offsetof(struct diagnostic_message_payload, message_254), /* 262 */
        offsetof(struct diagnostic_message_payload, message_255), /* 263 */
        offsetof(struct diagnostic_message_payload, message_256), /* 264 */
        offsetof(struct diagnostic_message_payload, message_257), /* 265 */
        offsetof(struct diagnostic_message_payload, message_258), /* 266 */
        offsetof(struct diagnostic_message_payload, message_259), /* 267 */
        offsetof(struct diagnostic_message_payload, message_260), /* 268 */
        offsetof(struct diagnostic_message_payload, message_261), /* 269 */
        offsetof(struct diagnostic_message_payload, message_262), /* 270 */
        offsetof(struct diagnostic_message_payload, message_263), /* 271 */
        offsetof(struct diagnostic_message_payload, message_264), /* 272 */
        offsetof(struct diagnostic_message_payload, message_265), /* 273 */
        offsetof(struct diagnostic_message_payload, message_266), /* 274 */
        offsetof(struct diagnostic_message_payload, message_267), /* 275 */
        offsetof(struct diagnostic_message_payload, message_268), /* 276 */
        offsetof(struct diagnostic_message_payload, message_269), /* 277 */
        offsetof(struct diagnostic_message_payload, message_270), /* 278 */
        offsetof(struct diagnostic_message_payload, message_271), /* 279 */
        offsetof(struct diagnostic_message_payload, message_272), /* 280 */
        offsetof(struct diagnostic_message_payload, message_273), /* 281 */
        offsetof(struct diagnostic_message_payload, message_274), /* 282 */
        offsetof(struct diagnostic_message_payload, message_275), /* 283 */
        offsetof(struct diagnostic_message_payload, message_276), /* 284 */
        offsetof(struct diagnostic_message_payload, message_277), /* 285 */
        0, /* 286 */
        0, /* 287 */
        0, /* 288 */
        0, /* 289 */
        offsetof(struct diagnostic_message_payload, message_278), /* 290 */
        offsetof(struct diagnostic_message_payload, message_279), /* 291 */
        offsetof(struct diagnostic_message_payload, message_280), /* 292 */
        offsetof(struct diagnostic_message_payload, message_281), /* 293 */
        offsetof(struct diagnostic_message_payload, message_282), /* 294 */
        offsetof(struct diagnostic_message_payload, message_283), /* 295 */
        offsetof(struct diagnostic_message_payload, message_284), /* 296 */
        offsetof(struct diagnostic_message_payload, message_285), /* 297 */
        offsetof(struct diagnostic_message_payload, message_286), /* 298 */
        offsetof(struct diagnostic_message_payload, message_287), /* 299 */
        offsetof(struct diagnostic_message_payload, message_288), /* 300 */
        offsetof(struct diagnostic_message_payload, message_289), /* 301 */
        offsetof(struct diagnostic_message_payload, message_290), /* 302 */
        offsetof(struct diagnostic_message_payload, message_291), /* 303 */
        offsetof(struct diagnostic_message_payload, message_292), /* 304 */
        offsetof(struct diagnostic_message_payload, message_293), /* 305 */
        offsetof(struct diagnostic_message_payload, message_294), /* 306 */
        offsetof(struct diagnostic_message_payload, message_295), /* 307 */
        offsetof(struct diagnostic_message_payload, message_296), /* 308 */
        offsetof(struct diagnostic_message_payload, message_297), /* 309 */
        offsetof(struct diagnostic_message_payload, message_298), /* 310 */
        offsetof(struct diagnostic_message_payload, message_299), /* 311 */
        offsetof(struct diagnostic_message_payload, message_300), /* 312 */
        offsetof(struct diagnostic_message_payload, message_301), /* 313 */
        offsetof(struct diagnostic_message_payload, message_302), /* 314 */
        offsetof(struct diagnostic_message_payload, message_303), /* 315 */
        offsetof(struct diagnostic_message_payload, message_304), /* 316 */
        offsetof(struct diagnostic_message_payload, message_305), /* 317 */
        offsetof(struct diagnostic_message_payload, message_306), /* 318 */
        offsetof(struct diagnostic_message_payload, message_307), /* 319 */
        0, /* 320 */
        0, /* 321 */
        0, /* 322 */
        0, /* 323 */
        0, /* 324 */
        0, /* 325 */
        0, /* 326 */
        0, /* 327 */
        0, /* 328 */
        0, /* 329 */
        0, /* 330 */
        0, /* 331 */
        0, /* 332 */
        offsetof(struct diagnostic_message_payload, message_308), /* 333 */
        offsetof(struct diagnostic_message_payload, message_106), /* 334 */
        offsetof(struct diagnostic_message_payload, message_278), /* 335 */
        offsetof(struct diagnostic_message_payload, message_309), /* 336 */
        offsetof(struct diagnostic_message_payload, message_310), /* 337 */
        offsetof(struct diagnostic_message_payload, message_311), /* 338 */
        offsetof(struct diagnostic_message_payload, message_312), /* 339 */
        offsetof(struct diagnostic_message_payload, message_313), /* 340 */
        offsetof(struct diagnostic_message_payload, message_314), /* 341 */
        offsetof(struct diagnostic_message_payload, message_315), /* 342 */
        offsetof(struct diagnostic_message_payload, message_316), /* 343 */
        offsetof(struct diagnostic_message_payload, message_317), /* 344 */
        offsetof(struct diagnostic_message_payload, message_318), /* 345 */
        offsetof(struct diagnostic_message_payload, message_319), /* 346 */
        offsetof(struct diagnostic_message_payload, message_320), /* 347 */
        offsetof(struct diagnostic_message_payload, message_321), /* 348 */
        offsetof(struct diagnostic_message_payload, message_322), /* 349 */
        offsetof(struct diagnostic_message_payload, message_323), /* 350 */
        0, /* 351 */
        offsetof(struct diagnostic_message_payload, message_173), /* 352 */
        offsetof(struct diagnostic_message_payload, message_324), /* 353 */
        offsetof(struct diagnostic_message_payload, message_325), /* 354 */
        offsetof(struct diagnostic_message_payload, message_326), /* 355 */
        offsetof(struct diagnostic_message_payload, message_327), /* 356 */
        offsetof(struct diagnostic_message_payload, message_328), /* 357 */
        offsetof(struct diagnostic_message_payload, message_127), /* 358 */
        offsetof(struct diagnostic_message_payload, message_329), /* 359 */
        offsetof(struct diagnostic_message_payload, message_330), /* 360 */
        offsetof(struct diagnostic_message_payload, message_331), /* 361 */
        offsetof(struct diagnostic_message_payload, message_332), /* 362 */
        offsetof(struct diagnostic_message_payload, message_333), /* 363 */
        offsetof(struct diagnostic_message_payload, message_334), /* 364 */
        offsetof(struct diagnostic_message_payload, message_335), /* 365 */
        offsetof(struct diagnostic_message_payload, message_336), /* 366 */
        offsetof(struct diagnostic_message_payload, message_224), /* 367 */
        offsetof(struct diagnostic_message_payload, message_337), /* 368 */
        offsetof(struct diagnostic_message_payload, message_338), /* 369 */
        offsetof(struct diagnostic_message_payload, message_339), /* 370 */
        offsetof(struct diagnostic_message_payload, message_340), /* 371 */
        offsetof(struct diagnostic_message_payload, message_341), /* 372 */
        offsetof(struct diagnostic_message_payload, message_342), /* 373 */
        offsetof(struct diagnostic_message_payload, message_343), /* 374 */
        offsetof(struct diagnostic_message_payload, message_091), /* 375 */
        offsetof(struct diagnostic_message_payload, message_344), /* 376 */
        offsetof(struct diagnostic_message_payload, message_345), /* 377 */
        offsetof(struct diagnostic_message_payload, message_346), /* 378 */
        offsetof(struct diagnostic_message_payload, message_347), /* 379 */
        offsetof(struct diagnostic_message_payload, message_348), /* 380 */
        offsetof(struct diagnostic_message_payload, message_161), /* 381 */
        offsetof(struct diagnostic_message_payload, message_251), /* 382 */
        offsetof(struct diagnostic_message_payload, message_259), /* 383 */
        offsetof(struct diagnostic_message_payload, message_349), /* 384 */
        offsetof(struct diagnostic_message_payload, message_350), /* 385 */
        offsetof(struct diagnostic_message_payload, message_351), /* 386 */
        offsetof(struct diagnostic_message_payload, message_235), /* 387 */
        offsetof(struct diagnostic_message_payload, message_352), /* 388 */
        offsetof(struct diagnostic_message_payload, message_353), /* 389 */
        offsetof(struct diagnostic_message_payload, message_354), /* 390 */
        offsetof(struct diagnostic_message_payload, message_355), /* 391 */
        offsetof(struct diagnostic_message_payload, message_356), /* 392 */
    },
    "Noerror",
    "Irreducible expression tree",
    "Register allocation failure",
    "Bad call of intrinsic function",
    "Unable to open input file '%s'",
    "Unable to create output file '%s'",
    "Out of memory",
    "Error writing output file",
    "Error directive: %s",
    "Compiler table limit exceeded",
    "Declaration syntax error",
    "Wrong number of arguments in call of '%s'",
    "Array size too large",
    "Invalid macro argument separator",
    "Assembler statement too long",
    "Macro argument syntax error",
    "Improper use of a typedef symbol",
    "Bad file name format in include directive",
    "Invalid indirection",
    "Illegal use of pointer",
    "Not an allowed type",
    "Incompatible type conversion",
    "Misplaced decimal point",
    "Incorrect use of default",
    "Invalid use of dot",
    "Illegal parameter to __emit__",
    "Function call missing )",
    "Case statement missing :",
    "Character constant too long",
    "Compound statement missing }",
    "Cannot modify a const object",
    "Declaration missing ;",
    "Define directive needs an identifier",
    "Too much global data defined in file",
    "Two consecutive dots",
    "Too many storage classes in declaration",
    "Too many types in declaration",
    "Misplaced elif directive",
    "Misplaced else directive",
    "Misplaced endif directive",
    "Enum syntax error",
    "Unexpected end of file in comment started on line %d",
    "Unexpected end of file in conditional started on line %d",
    "Expression syntax",
    "Unable to execute command '%s'",
    "Too few parameters in call",
    "Too few parameters in call to '%s'",
    "Illegal use of floating point",
    "File name too long",
    "Conflicting type modifiers",
    "Goto statement missing label",
    "Group overflowed maximum size: %s",
    "Bad ifdef directive syntax",
    "Bad ifndef directive syntax",
    "Illegal character '%c' (0x%x)",
    "Illegal initialization",
    "Unable to open include file '%s'",
    "No file name ending",
    "Unable to create turboc.$ln",
    "Lvalue required",
    "Too many error or warning messages",
    "%s statement missing (",
    "%s statement missing )",
    "%s statement missing ;",
    "Type mismatch in redeclaration of '%s'",
    "Default outside of switch",
    "Macro expansion too long",
    "Too many decimal points",
    "Too many exponents",
    "Too many initializers",
    "Inline assembly not allowed",
    "No file names given",
    "Incorrect number format",
    "Numeric constant too large",
    "Illegal octal digit",
    "Type mismatch in parameter %ld in call to '%s'",
    "Type mismatch in parameter '%s' in call to '%s'",
    "Type mismatch in parameter %ld",
    "Type mismatch in parameter '%s'",
    "Pointer required on left side of ->",
    "Invalid pointer addition",
    "Illegal pointer subtraction",
    "Illegal structure operation",
    "# operator not followed by macro argument name",
    "Unterminated string or character constant",
    "Structure size too large",
    "Bad undef directive syntax",
    "Unknown preprocessor directive: '%s'",
    "Undefined symbol '%s'",
    "Incorrect %s option: %s",
    "Could not find file '%s'",
    "Nonportable pointer conversion",
    "Extra parameter in call",
    "Extra parameter in call to %s",
    "Multiple base classes require explicit class names",
    "Field '%s' is ambiguous in '%s'",
    "'%s' cannot be distinguished from '%s'",
    "'%s' is inaccessible because also in '%s'",
    "Expression of arithmetic type expected",
    "Access declarations cannot grant or reduce access",
    "Operator cannot be applied to these operand types",
    "Array must have at least one element",
    "operator-> must return a pointer or a class",
    "Cannot assign '%s' to '%s'",
    "'%s' must be a previously defined class or struct",
    "Base class cannot be declared protected",
    "Bit fields must be signed or unsigned int",
    "Misplaced break",
    "Switch selection expression must be of integral type",
    "Cannot cast from '%s' to '%s'",
    "Unexpected : found",
    ":: requires a preceeding identifier in this context",
    "constructor cannot have a return type specification",
    "Misplaced continue",
    "Declaration terminated incorrectly",
    "Need an identifier to declare",
    "Default value missing",
    "Declare operator delete (void*) or (void*, size_t)",
    "operator delete must return void",
    "Destructor name must match the class name",
    "Destructor cannot have a return type specification",
    "Misplaced else",
    "Unknown language, must be C or C++",
    "'%s' was previously declared with the language '%s'",
    "Storage class '%s' not allowed for a field",
    "Storage class '%s' not allowed for a function",
    "Functions cannot return arrays or functions",
    "Goto bypasses initialization of a local variable",
    "Parameter names are used only with a function body",
    "extern variable cannot be initialized",
    "Cannot initialize '%s' with '%s'",
    "Classes cannot be initialized with {}",
    "'%s' was previously declared without static",
    "main must have a return type of int",
    ".* operands do not match",
    "Member functions can only have static storage class",
    "operator new must have an initial parameter of type size_t",
    "operator new must return an object of type void *",
    "'%s' must be declared with no arguments",
    "'%s' must be declared with one argument",
    "'%s' must be declared with two arguments",
    "'%s' must be a member function or have an argument of class type",
    "Only one of a set of overloaded functions can be \"C\"",
    "'%s' is not a parameter",
    "Type qualifier '%s' must be a struct or class name",
    "Two operands must evaluate to the same type",
    "Expression type does not match the return type",
    "Unexpected ) -- check for matching parenthesis",
    "'this' can only be used within a member function",
    "'%s' is not legal here",
    "Virtual function '%s' conflicts with '%s'",
    "Bit field too large",
    "Bit fields must contain at least one bit",
    "Overloadable operator expected",
    "The constructor '%s' is not allowed",
    "Previously specified default argument value cannot be changed",
    "Declaration is not allowed here",
    "Vectors of classes must use the default constructor",
    "Trying to derive a far class from a near base",
    "Trying to derive a near class from a far base",
    "Destructor for '%s' is not accessible",
    "Division by zero",
    "Too many default cases",
    "'%s' specifies multiple or duplicate access",
    "Base class '%s' is included more than once",
    "Duplicate case",
    "Member '%s' is initialized more than once",
    "Multiple declaration for '%s'",
    "Base class '%s' is initialized more than once",
    "'%s' has already been included",
    "Body has already been defined for this function",
    "virtual specified more than once",
    "File must contain at least one external declaration",
    "Declaration does not specify a tag or an identifier",
    "Expression is too complicated",
    "Unexpected }",
    "Union members cannot require initialization",
    "Expression of integral type expected",
    "Function defined inline after use as extern",
    "Undefined label '%s'",
    "Ambiguity between '%s' and '%s'",
    "Class member '%s' declared outside its class",
    "Multiple scope qualifiers",
    "'%s' is not a base class of '%s'",
    "'%s' must be a member function",
    "Cannot have a near member in a far class",
    "Parameter %ld missing name",
    "Cannot specify base classes except when defining the class",
    "No base class to initialize",
    "= expected",
    "Illegal to take address of bit field",
    "Cannot initialize a field",
    ": expected after %s",
    "No : following the ?",
    ", expected",
    "No constructor parameters allowed for array of class",
    "Cannot find '%s' to copy a vector",
    "Declaration was expected",
    "'%s' must be a previously defined enumeration tag",
    "Expression expected",
    "Field identifier expected",
    "'%s' is not a member of '%s'",
    "Friends must be functions or classes, not fields",
    "Functions may not be part of a struct or union",
    "Identifier expected",
    "Object must be initialized",
    "Inline assembly not allowed in an inline function",
    "No body defined for this inline function",
    "{ expected",
    "Attempting to return a reference to local name %s",
    "( expected",
    "Reference member '%s' is not initialized",
    "Could not find a match for '%s'",
    "No matching )",
    "Use :: to take the address of a member function",
    "Cannot find '%s' to initialize base class",
    "Cannot find '%s' to initialize field '%s'",
    "Cannot find '%s' to initialize a vector",
    "'%s' cannot return a value",
    "Use . or -> to call %s",
    "Operand expected",
    "%s missing ]",
    "} expected",
    "Must take address of a memory location",
    "Function should return a value",
    ") expected",
    "Statement missing ;",
    "Use ; to terminate declarations",
    "Statement is required here",
    "Bit field cannot be static",
    "Global anonymous union not static",
    "Left side must be a structure",
    "'%s' must be a previously defined structure tag",
    "Constant expression required",
    "%s is only allowed in C++",
    "Function definition cannot be a typedef'ed declaration",
    "Call of nonfunction",
    "Case outside of switch",
    "Right side of .* is not a member pointer",
    "Type name expected",
    "union cannot have a base type",
    "'%s' cannot be used in a static member function",
    "Value of type void is not allowed",
    "Do statement must have while",
    "Other objects cannot be declared in a function definition",
    "Identifier '%s' cannot have a type qualifier",
    "register is the only storage class allowed",
    "Expression of scalar type expected",
    "sizeof may not be applied to a bit field",
    "sizeof may not be applied to a function",
    "Storage class '%s' is not allowed here",
    "Case bypasses initialization of a local variable",
    "Access can only be changed to public or protected",
    "Variable '%s' is initialized twice",
    "Improper use of typedef '%s'",
    "Operands are of differing or incompatible type",
    "Size of this expression is unknown or zero",
    "Size of '%s' is unknown or zero",
    "Size of the type is unknown or zero",
    "Undefined structure '%s'",
    "Found : instead of ::",
    "Variable name expected",
    "Bad return type for a type conversion operator",
    "Linkage specification not allowed",
    "Reference member '%s' needs a temporary for initialization",
    "Access specifier '%s' found in a union",
    "'%s' cannot be declared in an anonymous union",
    "Class %s has a constructor and cannot be hidden",
    "Friend declarations need a function signature",
    "Function '%s' cannot be static",
    "Cannot call 'main' from within the program",
    "Cannot overload 'main'",
    "Non-virtual function '%s' declared pure",
    "Bad syntax for pure function definition",
    "Cannot create a variable for abstract class '%s'",
    "Pure function '%s' not overridden in '%s'",
    "Bad virtual function type match for '%s'",
    "Ambiguous conversion functions: '%s' and '%s'",
    "Function '%s' should have a prototype",
    "Overlays only supported in medium, large, and huge memory models",
    "Cannot define a pointer or reference to a reference",
    "Array of references is not allowed",
    "void & is not a valid type",
    "Items of type %s need constructors and can't be passed with ...",
    "'%s' is not a data member and can't be initialized here",
    "Destructor for %s required in conditional expression",
    "The value for %s is not within the range of an int",
    "Case constant is out of range of the selector",
    "Field %s cannot be used without an object",
    "Attempting to return a reference to a temporary object",
    "Stack overflow",
    "Memory reference expected",
    "Cannot add or subtract relocatable symbols",
    "Invalid register combination (e.g. [BP+BX])",
    "Invalid combination of opcode and operands",
    "286/287 instructions not enabled",
    "Trying to derive a huge class from the far base '%s'",
    "Trying to derive a far class from the huge base '%s'",
    "Trying to derive a huge class from the near base '%s'",
    "Trying to derive a near class from the huge base '%s'",
    "Cannot have a near member in a huge class",
    "Cannot use tiny or huge memory model with Windows",
    "Cannot have a %s in a local class",
    "Reference member '%s' initialized with a non-reference parameter",
    "Cannot call dynamically dispatched function '%s'",
    "Cannot use multiple inheritance with DDVT's.",
    "Matching base class function for '%s' has different dispatch number.",
    "Matching base class function for '%s' is not dynamic.",
    "Assignment to 'this' is obsolete, use X::operator new instead",
    "Initializing %s with %s",
    "'%s' is both a structure tag and a name, now obsolete",
    "Temporary used to initialize '%s'",
    "Temporary used for parameter %ld in call to '%s'",
    "Temporary used for parameter '%s' in call to '%s'",
    "Temporary used for parameter %ld",
    "Temporary used for parameter '%s'",
    "Both return and return with a value used",
    "Constant member '%s' is not initialized",
    "Functions containing %s are not expanded inline",
    "Base initialization without a class name is now obsolete",
    "Style of function definition is now obsolete",
    "overload is now unnecessary and obsolete",
    "Initialization is only partially bracketed",
    "Obsolete syntax; use :: instead",
    "Ambiguous operators need parentheses",
    "Superfluous & with function",
    "Parameter '%s' is never used",
    "Restarting compile using assembly",
    "Unknown assembler instruction",
    "Call to function '%s' with no prototype",
    "Call to function with no prototype",
    "Constant is long",
    "Nonportable pointer comparison",
    "Possible use of '%s' before definition",
    "Constant out of range in comparison",
    "Redefinition of '%s' is not identical",
    "Possibly incorrect assignment",
    "Conversion may lose significant digits",
    "No declaration for function '%s'",
    "Code has no effect",
    "'%s' is assigned a value that is never used",
    "Ill-formed pragma",
    "Suspicious pointer conversion",
    "Unreachable code",
    "Structure passed by value",
    "Void functions may not return a value",
    "Hexadecimal value contains more than 3 digits",
    "Mixing pointers to signed and unsigned char",
    "'%s' is declared but never used",
    "'%s' is declared as both external and static",
    "Untyped bit field assumed signed int",
    "Declare '%s' prior to use in prototype",
    "Assigning %s to %s",
    "'%s' hides virtual function '%s'",
    "Non-const function %s called for const object",
    "Non-volatile function %s called for volatile object",
    "Array variable '%s' is near",
};
