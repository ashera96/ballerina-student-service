# ballerina-student-service
Ballerina project to add and retrieve student details which are being passed from a form.

## Project Introduction
This project aims to capture student details through a basic html form and then pass it to a ballerina service through a POST request.
These details are maintained within the H2 database, where student details can be stored and retrieved.

## Steps to follow
- Install ballerina
- Install VSCode ballerina plugin

## Steps to run the project
- Clone the project
    - $ git clone https://github.com/ashera96/ballerina-student-service.git
    
- Build the modules
    - $ ballerina build -a

- Run the service module
    - $ ballerina run studentService

- Open up the index.html file and submit the form after filling the student details  

- Check the output within the terminal
