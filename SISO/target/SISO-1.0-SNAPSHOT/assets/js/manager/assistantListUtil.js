var context = document.getElementById("context").value;
var modalDetails = new bootstrap.Modal(document.getElementById("modalDetails"), {});
var modalDelete = new bootstrap.Modal(document.getElementById("modalDelete"), {});

function showModalDetails(id) {
    const request = new XMLHttpRequest();
    request.open("POST", context+"/Servlet", true);
    request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    request.send("action=getAssistantDetails&id="+id);
    request.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            let user = JSON.parse(this.responseText);
            document.getElementById("modalDetails_username").innerHTML = user.nameUser;
            document.getElementById("modalDetails_name").innerHTML = user.name + " " + user.lastname1 + " " + user.lastname2;
            document.getElementById("modalDetails_email").innerHTML = user.email;
            document.getElementById("modalDetails_role").innerHTML = user.type_id.nameType;
            document.getElementById("modalDetails_department").innerHTML = user.department_id.nameDepartment;
            modalDetails.show();
            document.getElementById("modalDelete_name").innerHTML = user.name + " " + user.lastname1 + " " + user.lastname2;
            document.getElementById("modalDelete_formId").value = user.id_user;
        }
    };
}

function showModalDelete(id) {  
    modalDelete.show();
}