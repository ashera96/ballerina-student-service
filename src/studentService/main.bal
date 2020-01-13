import ballerina/http;
import ballerina/log;
import manageStudents;

@http:ServiceConfig {
    basePath: "/students"
}
service student on new http:Listener(9090) {

    @http:ResourceConfig {
        methods: ["POST"],
        path: "/addstudent"
    }
    resource function addStudent(http:Caller caller, http:Request request) {
        var data = request.getFormParams();
        if (data is map<string>) {
            // io:println(data);
            manageStudents:addStudent(data); // Calling the addStudent function within the manageStudents module
            manageStudents:getStudents(); // Retrieve student records from the database
        }
        
        error? result = caller->respond("OK");
        if (result is error) {
            log:printError("Error in responding", result);
        }
    }
}
