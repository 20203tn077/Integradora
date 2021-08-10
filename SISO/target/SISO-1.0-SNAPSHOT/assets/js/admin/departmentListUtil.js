var context = document.getElementById("context").value;
var modalDetails = new bootstrap.Modal(document.getElementById("modalDetails"), {});
var modalDelete = new bootstrap.Modal(document.getElementById("modalDelete"), {});

function showModalDetails(id) {
    const request = new XMLHttpRequest();
    request.open("POST", context+"/Servlet", true);
    request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    request.send("action=getDepartmentDetails&id="+id);
    request.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            let department = JSON.parse(this.responseText);
            document.getElementById("modalDetails_name").innerHTML = department.nameDepartment;
            document.getElementById("modalDetails_description").innerHTML = department.description;
            document.getElementById("modalDetails_phone").innerHTML = department.telephoneNumber;
            modalDetails.show();
            document.getElementById("modalDelete_name").innerHTML = department.nameDepartment;
            document.getElementById("modalDelete_formId").value = department.idDepartment;
        }
    };
}

function showModalDelete(id) {  
    modalDelete.show();
}