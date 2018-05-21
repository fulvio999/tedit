file(GLOB UI_QML_JS_FILES *.qml *.js)

# Make the files visible in the qtcreator tree
add_custom_target(edit_ui_QMlFiles ALL SOURCES ${UI_QML_JS_FILES})

install(FILES ${UI_QML_JS_FILES} DESTINATION ${EDIT_DIR}/ui)

