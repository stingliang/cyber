add_library(JsonCpp SHARED IMPORTED)
set(JSONCPP_LIBRARY /usr/lib/x86_64-linux-gnu/libjsoncpp.a)
set(JSONCPP_INCLUDE_DIR /usr/include/jsoncpp)
set_property(TARGET JsonCpp PROPERTY IMPORTED_LOCATION ${JSONCPP_LIBRARY})
set_property(TARGET JsonCpp PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${JSONCPP_INCLUDE_DIR})
set_property(TARGET JsonCpp PROPERTY INTERFACE_LINK_LIBRARIES ${JSONCPP_LIBRARY})
