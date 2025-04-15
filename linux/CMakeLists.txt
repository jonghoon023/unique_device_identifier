cmake_minimum_required(VERSION 3.10)

set(PROJECT_NAME "unique_device_identifier")
project(${PROJECT_NAME} LANGUAGES CXX)

set(PLUGIN_NAME "unique_device_identifier_plugin")

list(APPEND PLUGIN_SOURCES
  "unique_device_identifier_plugin.cc"
)

add_library(${PLUGIN_NAME} SHARED
  ${PLUGIN_SOURCES}
)

apply_standard_settings(${PLUGIN_NAME})

set_target_properties(${PLUGIN_NAME} PROPERTIES
  CXX_VISIBILITY_PRESET hidden
)
target_compile_definitions(${PLUGIN_NAME} PRIVATE FLUTTER_PLUGIN_IMPL)

target_include_directories(${PLUGIN_NAME} INTERFACE
  "${CMAKE_CURRENT_SOURCE_DIR}/include"
)

# GTK 설정
find_package(PkgConfig REQUIRED)
pkg_check_modules(GTK REQUIRED gtk+-3.0)

target_link_libraries(${PLUGIN_NAME} PRIVATE flutter)
target_link_libraries(${PLUGIN_NAME} PRIVATE ${GTK_LIBRARIES})
target_include_directories(${PLUGIN_NAME} PRIVATE ${GTK_INCLUDE_DIRS})
