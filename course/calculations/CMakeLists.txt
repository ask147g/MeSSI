cmake_minimum_required(VERSION 3.0.0)
project(main VERSION 0.1.0)

include(CTest)
enable_testing()

file(GLOB headers ${PROJECT_SOURCE_DIR}/*.h)
file(GLOB_RECURSE Opencv3.9_LIB "/usr/lib/python3.9/config-x86_64-linux-gnu/*.so")
set(Opencv3.9_INLCUDE_DIRS "/usr/include/python3.9")
include_directories(include
        ${Opencv3.9_INLCUDE_DIRS}
        )
 # Usually this setting is fine, if your project contains qrc files, you need to add them separately
aux_source_directory(. DIRS_SRCS)

add_executable(main main.cpp)

set(CPACK_PROJECT_NAME ${PROJECT_NAME})
set(CPACK_PROJECT_VERSION ${PROJECT_VERSION})
include(CPack)
target_link_libraries (main X11 pthread ${OpenCV_LIBS} ${Boost_LIBRARIES} libpython3.9.so)
