import ballerina/io;
import ballerinax/java.jdbc;
import ballerina/lang.'int as ints;

const string MALE = "MALE";
const string FEMALE = "FEMALE";

// JDBC Client for H2 database.
jdbc:Client testDB = new ({
    url: "jdbc:h2:file:./db_files/demodb",
    username: "test",
    password: "test"
});

type Person record {|
    string nameWithInitial;
    string fullName;
    string gender;
|};

type Student record {
    int id;
    *Person;
};

public function main() {
}

// Function to add students to the database
public function addStudent(map<string> data) {
    int|error id = ints:fromString(data.get("id"));
    var nameWithInitials = data.get("nameWithInitials");
    var fullName = data.get("fullName");
    var gender = data.get("gender");
    
    // Create the table
    var response = testDB->update("CREATE TABLE STUDENT (ID INTEGER, NAMEWITHINITIAL VARCHAR(30), FULLNAME VARCHAR(100), GENDER VARCHAR(10))");
    handleUpdate(response, "Create STUDENT table");
    
    // Insert data to the table
    response = testDB->update("INSERT INTO STUDENT (ID, NAMEWITHINITIAL, FULLNAME, GENDER) VALUES (?, ?, ?, ?)", id.toString(), nameWithInitials, fullName, gender);
    handleUpdate(response, "INSERT data to STUDENT table");
}

// Function to retrieve students 
public function getStudents() {

    // Retrieving data from the table
    io:println("\n****** STUDENT TABLE ENTRIES ******\n");
    var res = testDB->select("SELECT * FROM STUDENT", Student);
    if (res is table<Student>) {
        foreach var row in res {
            io:println(row);
        }
    }
}

// Function to handle the return value of the `update` remote function.
function handleUpdate(jdbc:UpdateResult|error returned, string message) {
    if (returned is jdbc:UpdateResult) {
        io:println(message + " status: ", returned.updatedRowCount);
    } else {
        io:println(message + " failed: ", <string>returned.detail()?.message);
    }
}
