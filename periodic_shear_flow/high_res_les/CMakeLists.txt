cmake_minimum_required(VERSION 3.10)
project(OneDimensionalRANS)
include("$ENV{PADELIBS_ROOT_DIR}/cmake/cmake_config.cmake")

file(GLOB src_files *.cpp)

foreach (file_name ${src_files})
	get_filename_component(exec_name ${file_name} NAME_WE)
	add_executable(${exec_name} ${file_name})
	target_include_directories(${exec_name} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
	target_link_libraries(${exec_name} padelibs)
	target_compile_options(${exec_name} PRIVATE "-Wno-unknown-pragmas" ${CXX_WARNING_FLAGS})
endforeach()
