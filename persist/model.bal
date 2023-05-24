import ballerina/time;
import ballerina/persist as _;

type Employee record {|
    readonly string empNo;
    string firstName;
    string lastName;
    time:Date birthDate;
    string gender;
    time:Date hireDate;

    Department department;
    Workspace workspace;
|};

type Workspace record {|
    readonly string workspaceId;
    int workspaceNo;
    string workspaceType;

    Building location;
    Employee[] employees;
|};

type Building record {|
    readonly string buildingCode;
    string city;
    string state;
    string country;
    string postalCode;
    string 'type;

    Workspace[] workspaces;
|};

type Department record {|
    readonly string deptNo;
    int deptId;
    string deptName;

    Employee[] employees;
|};

type OrderItem record {|
    readonly string orderId;
    readonly string itemId;
    int quantity;
    string notes;
|};
