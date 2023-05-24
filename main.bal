import ballerina/io;


public type OrderItemPartial record {|
    string orderId;
    string itemId;
|};
public type EmployeeInfo record {|
    string firstName;
    string lastName;
    record {|
        string deptName;
    |} department;
    Workspace workspace;
|};


function checkBuilding(Client rainierClient) returns error? {
    Building building1 = {
        buildingCode: "building-1",
        city: "Colombo",
        state: "Western Province",
        country: "Sri Lanka",
        postalCode: "10370",
        'type: "rented"
    };

    BuildingInsert building2 = {
        buildingCode: "building-2",
        city: "Manhattan",
        state: "New York",
        country: "USA",
        postalCode: "10570",
        'type: "owned"
    };

    BuildingInsert building3 = {
        buildingCode: "building-3",
        city: "London",
        state: "London",
        country: "United Kingdom",
        postalCode: "39202",
        'type: "rented"
    };

    Building updatedBuilding1 = {
        buildingCode: "building-1",
        city: "Galle",
        state: "Southern Province",
        country: "Sri Lanka",
        postalCode: "10890",
        'type: "owned"
    };

    string[] buildingCodes = check rainierClient->/buildings.post([building1]);
    Building buildingRetrieved = check rainierClient->/buildings/[building1.buildingCode].get();
    buildingCodes = check rainierClient->/buildings.post([building2, building3]);
    // buildingRetrieved = check rainierClient->/buildings/[building2.buildingCode].get();
    // buildingRetrieved = check rainierClient->/buildings/[building3.buildingCode].get();
    // buildingRetrieved = check rainierClient->/buildings/[building1.buildingCode].get();


    // stream<Building, error?> buildingStream = rainierClient->/buildings.get();
    // Building[] buildings = check from Building building_temp in buildingStream
    //     select building_temp;

    Building buildingUpdated = check rainierClient->/buildings/[building1.buildingCode].put({
        city: "Galle",
        state: "Southern Province",
        postalCode: "10890",
        'type: "owned"
    });
    buildingRetrieved = check rainierClient->/buildings/[building1.buildingCode].get();

    Building|error buildingRetrievedError = rainierClient->/buildings/["invalid-building-code"].put({
        city: "Galle",
        state: "Southern Province",
        postalCode: "10890"
    });
    if buildingRetrievedError !is error {
        panic error("Error expected");
    }
    // stream<Building, error?> buildingStream2 = rainierClient->/buildings.get();
    // Building[] buildingSet = check from Building building_temp2 in buildingStream2
    //     select building_temp2;
    Building buildingDeleted = check rainierClient->/buildings/[building1.buildingCode].delete();

    io:println("Building examples successfully executed!");

}


function checkDepartment(Client rainierClient) returns error? {
    Department department1 = {
        deptNo: "department-1",
        deptId:1,
        deptName: "Finance"
    };

    Department department2 = {
        deptNo: "department-2",
        deptId:2,
        deptName: "Marketing"
    };
    Department department3 = {
        deptNo: "department-3",
        deptId:3,
        deptName: "Engineering"
    };

    Department updatedDepartment1 = {
        deptNo: "department-1",
        deptId:1,
        deptName: "Finance & Legalities"
    };

    string[] deptNos = check rainierClient->/departments.post([department1]);
    Department departmentRetrieved = check rainierClient->/departments/[department1.deptNo].get();
    deptNos = check rainierClient->/departments.post([department2, department3]);
    departmentRetrieved = check rainierClient->/departments/[department2.deptNo].get();
    departmentRetrieved = check rainierClient->/departments/[department3.deptNo].get();
    departmentRetrieved = check rainierClient->/departments/[department1.deptNo].get();
    Department|error departmentError = rainierClient->/departments/["invalid-department-id"].get();
    if departmentError !is error {
        panic error("Error expected");
    }

    stream<Department, error?> departmentStream = rainierClient->/departments.get();
    Department[] departments = check from Department department_temp in departmentStream
        select department_temp;

    Department departmentUpdated = check rainierClient->/departments/[department1.deptNo].put({
        deptName: "Finance & Legalities"
    });

    departmentRetrieved = check rainierClient->/departments/[department1.deptNo].get();

    departmentError = rainierClient->/departments/["invalid-department-id"].put({
        deptName: "Human Resources"
    });
    if departmentError !is error {
        panic error("Error expected");
    }

    stream<Department, error?> departmentStream2 = rainierClient->/departments.get();
    departments = check from Department department_Temp2 in departmentStream2
        select department_Temp2;

    Department departmentDeleted = check rainierClient->/departments/[department1.deptNo].delete();


    io:println("Department examples successfully executed!");

}


function checkWorkspace(Client rainierClient) returns error? {
    Workspace workspace1 = {
        workspaceId: "workspace-1",
        workspaceNo: 1,
        workspaceType: "small",
        locationBuildingCode: "building-2"
    };
    Workspace workspace2 = {
        workspaceId: "workspace-2",
        workspaceNo: 2,
        workspaceType: "medium",
        locationBuildingCode: "building-2"
    };
    Workspace workspace3 = {
        workspaceId: "workspace-3",
        workspaceNo: 3,
        workspaceType: "small",
        locationBuildingCode: "building-2"
    };

    Workspace updatedWorkspace1 = {
        workspaceId: "workspace-1",
        workspaceNo: 1,
        workspaceType: "large",
        locationBuildingCode: "building-2"
    };

    string[] workspaceIds = check rainierClient->/workspaces.post([workspace1]);
    // Workspace workspaceRetrieved = check rainierClient->/workspaces/[workspace1.workspaceId].get();
    workspaceIds = check rainierClient->/workspaces.post([workspace2, workspace3]);
    // Workspace workspaceRetrieved = check rainierClient->/workspaces/[workspace2.workspaceId].get();
    // workspaceRetrieved = check rainierClient->/workspaces/[workspace3.workspaceId].get();
    // workspaceRetrieved = check rainierClient->/workspaces/[workspace1.workspaceId].get();
    Workspace|error workspaceError = rainierClient->/workspaces/["invalid-workspace-id"].get();
    if workspaceError !is error {
        panic error("Error expected");
    }
    // stream<Workspace, error?> workspaceStream = rainierClient->/workspaces.get();
    // Workspace[] workspaces = check from Workspace workspace_temp in workspaceStream
    //     select workspace_temp;
    Workspace workspaceUpdated = check rainierClient->/workspaces/[workspace1.workspaceId].put({
        workspaceType: "large"
    });
    //workspaceRetrieved = check rainierClient->/workspaces/[workspace1.workspaceId].get();

    workspaceError = rainierClient->/workspaces/["invalid-workspace-id"].put({
        workspaceType: "large"
    });

    // stream<Workspace, error?> workspaceStream2 = rainierClient->/workspaces.get();
    // workspaces = check from Workspace workspace_temp2 in workspaceStream2
    //     select workspace_temp2;
    Workspace workspaceDeleted = check rainierClient->/workspaces/[workspace1.workspaceId].delete();

    workspaceIds = check rainierClient->/workspaces.post([workspace1]);

    io:println("Workspace examples successfully executed!");

}

function checkEmployee(Client rainierClient) returns error? {
    Employee employee1 = {
        empNo: "employee-1",
        firstName: "Tom",
        lastName: "Scott",
        birthDate: {year: 1992, month: 11, day: 13},
        gender: "M",
        hireDate: {year: 2022, month: 8, day: 1},
        departmentDeptNo: "department-2",
        workspaceWorkspaceId: "workspace-1"
    };

    Employee invalidEmployee = {
        empNo: "invalid-employee-no-extra-characters-to-force-failure",
        firstName: "Tom",
        lastName: "Scott",
        birthDate: {year: 1992, month: 11, day: 13},
        gender: "M",
        hireDate: {year: 2022, month: 8, day: 1},
        departmentDeptNo: "department-2",
        workspaceWorkspaceId: "workspace-2"
    };
    Employee employee2 = {
        empNo: "employee-2",
        firstName: "Jane",
        lastName: "Doe",
        birthDate: {year: 1996, month: 9, day: 15},
        gender: "F",
        hireDate: {year: 2022, month: 6, day: 1},
        departmentDeptNo: "department-2",
        workspaceWorkspaceId: "workspace-2"
    };
    Employee employee3 = {
        empNo: "employee-3",
        firstName: "Hugh",
        lastName: "Smith",
        birthDate: {year: 1986, month: 9, day: 15},
        gender: "F",
        hireDate: {year: 2021, month: 6, day: 1},
        departmentDeptNo: "department-3",
        workspaceWorkspaceId: "workspace-3"
    };

    Employee updatedEmployee1 = {
        empNo: "employee-1",
        firstName: "Tom",
        lastName: "Jones",
        birthDate: {year: 1994, month: 11, day: 13},
        gender: "M",
        hireDate: {year: 2022, month: 8, day: 1},
        departmentDeptNo: "department-3",
        workspaceWorkspaceId: "workspace-2"
    };

    string[] empNos = check rainierClient->/employees.post([employee1]);

    Employee employeeRetrieved = check rainierClient->/employees/[employee1.empNo].get();


    empNos = check rainierClient->/employees.post([employee2, employee3]);
    // employeeRetrieved = check rainierClient->/employees/[employee2.empNo].get();

    // employeeRetrieved = check rainierClient->/employees/[employee3.empNo].get();
    // employeeRetrieved = check rainierClient->/employees/[employee1.empNo].get();
    Employee|error employeeError = rainierClient->/employees/["invalid-employee-id"].get();
    // stream<Employee, error?> employeeStream = rainierClient->/employees.get();
    // Employee[] employees = check from Employee employee in employeeStream
    //     select employee;

    Employee employeeUpdated = check rainierClient->/employees/[employee1.empNo].put({
        lastName: "Jones",
        departmentDeptNo: "department-3"
    });
    employeeRetrieved = check rainierClient->/employees/[employee1.empNo].get();
    employeeError = rainierClient->/employees/["invalid-employee-id"].put({
        lastName: "Jones"
    });

    // employeeError = rainierClient->/employees/[employee1.empNo].put({
    //     workspaceWorkspaceId: "invalid-workspaceWorkspaceId"
    // });

    // stream<Employee, error?> employeeStream2 = rainierClient->/employees.get();
    // employees = check from Employee employee_temp2 in employeeStream2
    //     select employee_temp2;

    Employee employeeDeleted = check rainierClient->/employees/[employee1.empNo].delete();
    io:println("Employee examples successfully executed!");
}

public function main() returns error? {
    Client rainierClient = check new ();
    OrderItem orderItem1 = {
        orderId: "order-1",
        itemId: "item-1",
        quantity: 5,
        notes: "none"
    };
    OrderItem orderItem2 = {
        orderId: "order-2",
        itemId: "item-2",
        quantity: 10,
        notes: "more"
    };
    OrderItem orderItem3 = {
        orderId: "order-3",
        itemId: "item-3",
        quantity: 10,
        notes: "more"
    };
    OrderItem orderItem4 = {
        orderId: "order-4",
        itemId: "item-4",
        quantity: 10,
        notes: "more"
    };
    OrderItem orderItem2Updated = {
        orderId: "order-2",
        itemId: "item-2",
        quantity: 20,
        notes: "more than more"
    };

    io:println("*********************************");
    io:println("*********************************");
    io:println("Operations on OrderItem Sheet");
    io:println("*********************************");
    io:println("*********************************");

    io:println("Insert orderItem1 to the OrderItem sheet");
    [string, string][] ids = check rainierClient->/orderitems.post([orderItem1]);
    io:println(ids);
    io:println("================================");
    io:println("Insert orderItem2, orderItem3, orderItem4 to the OrderItem sheet");
    ids = check rainierClient->/orderitems.post([orderItem2, orderItem3, orderItem4]);
    io:println(ids);
    io:println("================================");
    io:println("Get orderItem1 from the OrderItem sheet");
    OrderItem orderItemRetrieved = check rainierClient->/orderitems/[orderItem1.orderId]/[orderItem1.itemId].get();
    io:println(orderItemRetrieved);
    io:println("================================");
    io:println("Get columns of orderItem1 from the OrderItem sheet");
    OrderItemPartial recordRetrieved = check rainierClient->/orderitems/[orderItem1.orderId]/[orderItem1.itemId].get();
    io:println(recordRetrieved);
    io:println("================================");
    io:println("Get columns of orderItem2 from the OrderItem sheet");
    orderItemRetrieved = check rainierClient->/orderitems/[orderItem2.orderId]/[orderItem2.itemId].get();
    io:println(orderItemRetrieved);
    io:println("================================");
    io:println("Update orderItem2 in the OrderItem sheet");
    OrderItem orderItemRetrieved2 = check rainierClient->/orderitems/[orderItem2.orderId]/[orderItem2.itemId].put({
        quantity: orderItem2Updated.quantity,
        notes: orderItem2Updated.notes
    });
    io:println(orderItemRetrieved2);
    io:println("================================");
    io:println("Get rows as a stream from the sheet OrderItem");
    stream<OrderItem, error?> orderItemStream = rainierClient->/orderitems.get();
    OrderItem[] records = check from OrderItem element in orderItemStream
                        select element;
    io:println(records);
    io:println("================================");
    io:println("Get rows as a stream from the tabsheetle OrderItem");
    stream<OrderItemPartial, error?> orderItemStream2 = rainierClient->/orderitems.get();
    OrderItemPartial[] records2 = check from OrderItemPartial element in orderItemStream2
                        select element;
    io:println(records2);
    io:println("================================");
    io:println("Delete orderItem2 from the table OrderItem");
    orderItemRetrieved2 = <OrderItem> check rainierClient->/orderitems/[orderItem2.orderId]/[orderItem2.itemId].delete();
    io:println(orderItemRetrieved2);

    check checkBuilding(rainierClient);
    check checkDepartment(rainierClient);
    check checkWorkspace(rainierClient);
    check checkEmployee(rainierClient);
    

    io:println("\n========== Building ==========");
    _ = check from Building building in rainierClient->/buildings.get(Building)
        do {
            io:println(building);
        };

    io:println("\n========== Department ==========");
    _ = check from Department department in rainierClient->/departments.get(Department)
        do {
            io:println(department);
        };

    io:println("\n========== Workspace ==========");
    _ = check from Workspace workspace in rainierClient->/workspaces.get(Workspace)
        do {
            io:println(workspace);
        };

    io:println("\n========== Employee ==========");
    _ = check from Employee employee in rainierClient->/employees.get(Employee)
        do {
            io:println(employee);
        };


    io:println("\n========== partial records ==========");

    stream<EmployeeInfo, error?> employeeStream = rainierClient->/employees.get();
    EmployeeInfo[] employees = check from EmployeeInfo employee in employeeStream
        select employee;
    io:println(employees);

    io:println("\n========== Many relations ==========");

    stream<BuildingWithRelations, error?> buildingsStream = rainierClient->/buildings.get();
    BuildingWithRelations[] buildings = check from BuildingWithRelations building in buildingsStream
        select building;
    io:println(buildings);

    // OrderItem|error orderItem = rainierClient->/orderitems/[orderItem1.orderId]/[orderItem2.itemId].put({
    //     quantity: 239,
    //     notes: "updated notes"
    // });

    // if orderItem is error {
    //     io:println(orderItem);
    // } 
    // OrderItem|error orderItem = rainierClient->/orderitems/["invalid-order-id"]/[orderItem2.itemId].delete();
    // if orderItem is error {
    //     io:println(orderItem);
    // } 
}
