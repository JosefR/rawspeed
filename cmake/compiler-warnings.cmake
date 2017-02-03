include(CheckCXXCompilerFlagAndEnableIt)

# want -Werror to be enabled automatically for me.
add_definitions(-Werror)

CHECK_CXX_COMPILER_FLAG_AND_ENABLE_IT(-Wall)

CHECK_CXX_COMPILER_FLAG_AND_ENABLE_IT(-Wformat=2)

if(NOT (UNIX OR APPLE))
  # on windows, resuts in bogus false-positive varnings
  add_definitions(-Wno-format)
endif()

# cleanup this once we no longer need to support gcc-4.9
# disabled for now, see https://github.com/darktable-org/rawspeed/issues/32
if(CMAKE_CXX_COMPILER_ID AND NOT (CMAKE_CXX_COMPILER_ID STREQUAL "GNU" AND CMAKE_CXX_COMPILER_VERSION VERSION_LESS 5.0))
  CHECK_CXX_COMPILER_FLAG_AND_ENABLE_IT(-Wshadow)
endif()

CHECK_CXX_COMPILER_FLAG_AND_ENABLE_IT(-Wvla)

CHECK_CXX_COMPILER_FLAG_AND_ENABLE_IT(-Wextra-semi)

CHECK_CXX_COMPILER_FLAG_AND_ENABLE_IT(-Wextra)

CHECK_CXX_COMPILER_FLAG_AND_ENABLE_IT(-Wno-unused-parameter)

# should be < 64Kb
math(EXPR MAX_MEANINGFUL_SIZE 4*1024)
if(APPLE)
  # Apple XCode seems to generate HUGE stack/frames, much bigger than anything else.
  math(EXPR MAX_MEANINGFUL_SIZE 5*1024)
endif()

CHECK_CXX_COMPILER_FLAG_AND_ENABLE_IT(-Wframe-larger-than=${MAX_MEANINGFUL_SIZE})
CHECK_CXX_COMPILER_FLAG_AND_ENABLE_IT(-Wstack-usage=${MAX_MEANINGFUL_SIZE})

# as small as possible, but 1Mb+ is ok.
math(EXPR MAX_MEANINGFUL_SIZE 16*1024)
CHECK_CXX_COMPILER_FLAG_AND_ENABLE_IT(-Wlarger-than=${MAX_MEANINGFUL_SIZE})
