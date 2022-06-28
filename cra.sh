#!/bin/bash

create_goto_project_dir() {
    mkdir -p $1
    cd $1
}

write_package_json() {
    PACKAGE_CODE="{\n\t\"name\": \"$1\",\n\t\"version\": \"1.0.0\",\n\t\"description\": \"\",\n\t\"main\": \"src/index.js\",\n\t\"scripts\": {\n\t\t\"start\": \"react-scripts start\",\n\t\t\"build\": \"react-scripts build\",\n\t\t\"test\": \"react-scripts test\",\n\t\t\"eject\": \"react-scripts eject\"\n\t},\n\t\"keywords\": [],\n\t\"author\": \"\",\n\t\"license\": \"ISC\",\n\t\"dependencies\": {}\n}"
    echo $PACKAGE_CODE > package.json
}

write_html() {
    mkdir public
    HTML_CODE="<!DOCTYPE html>\n<html lang=\"en\">\n\t<head>\n\t\t<meta charset=\"UTF-8\" />\n\t\t<meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\" />\n\t\t<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" />\n\t\t<title>$1</title>\n\t</head>\n\t<body>\n\t\t<div id=\"root\"></div>\n\t</body>\n</html>"
    echo $HTML_CODE > public/index.html
}


write_javascript() {
    APP_JS_CODE="import React from \"react\";\n\nconst App = () => <h1>$1</h1>;\n\nexport default App;"
    INDEX_JS_CODE="import React from \"react\";\nimport { createRoot } from \"react-dom/client\";\nimport App from \"./App\";\n\nconst rootElement = document.getElementById(\"root\");\nconst root = createRoot(rootElement);\n\nroot.render(<App />);"
    mkdir src
    echo $APP_JS_CODE > src/App.js
    echo $INDEX_JS_CODE > src/index.js
}


create_project() {
    PROJECT_PATH="$1"
    APP_NAME=${PROJECT_PATH##*/}
    
    if [ -z "$1" -o -z "$APP_NAME" ]; then
        PROJECT_PATH="."
        APP_NAME="App"
    fi
    
    
    # Step 1 - create project folder and go there
    create_goto_project_dir $PROJECT_PATH
    # Step 2 - write package.json
    write_package_json $APP_NAME
    # Step 3 - install dependencies
    npm i react react-dom react-scripts
    # Step 4 - write markup
    write_html $APP_NAME
    # Step 5 - write javascript
    write_javascript $APP_NAME
}

create_project $1