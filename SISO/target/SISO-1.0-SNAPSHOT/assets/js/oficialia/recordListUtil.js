var context = document.getElementById("context").value;
var modalDetails = new bootstrap.Modal(document.getElementById("modalDetails"), {});
var modalDelete = new bootstrap.Modal(document.getElementById("modalDelete"), {});

function showModalDetails(id) {
    const request = new XMLHttpRequest();
    request.open("POST", context + "/Servlet", true);
    request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    request.send("action=getRecordDetails&id=" + id);
    request.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
            let record = JSON.parse(this.responseText);
            document.getElementById("modalDetails_id").innerHTML = record.id_minutes;
            document.getElementById("modalDetails_channelling").innerHTML = record.dateChannelling;
            document.getElementById("modalDetails_assignment").innerHTML = record.dateAssignment;
            document.getElementById("modalDetails_department").innerHTML = record.departmentId.nameDepartment;
            switch (record.priorityId.idPriority) {
                case 1:
                    document.getElementById("modalDetails_priority").innerHTML = '<span class="badge bg-danger">' + record.priorityId.namePriority + '</span>';
                    break;
                case 2:
                    document.getElementById("modalDetails_priority").innerHTML = '<span class="badge bg-naranja">' + record.priorityId.namePriority + '</span>';
                    break;
                case 3:
                    document.getElementById("modalDetails_priority").innerHTML = '<span class="badge bg-warning text-dark">' + record.priorityId.namePriority + '</span>';
                    break;
                case 4:
                    document.getElementById("modalDetails_priority").innerHTML = '<span class="badge bg-success">' + record.priorityId.namePriority + '</span>';
            }
            if (record.dateResponse == null) {
                if (record.dateAssignment == null) {
                    document.getElementById("modalDetails_assignmentContainer").style.display = "none";
                    document.getElementById("modalDetails_responseContainer").style.display = "none";
                    document.getElementById("modalDetails_commentContainer").style.display = "none";
                    document.getElementById("modalDetails_rechannelButtonContainer").style.display = "initial";
                    document.getElementById("modalDetails_deleteButtonContainer").style.display = "initial";
                    document.getElementById("modalDetails_responseButtonContainer").style.display = "none";
                } else {
                    document.getElementById("modalDetails_assignmentContainer").style.display = "initial";
                    document.getElementById("modalDetails_responseContainer").style.display = "none";
                    document.getElementById("modalDetails_commentContainer").style.display = "none";
                    document.getElementById("modalDetails_rechannelButtonContainer").style.display = "none";
                    document.getElementById("modalDetails_deleteButtonContainer").style.display = "initial";
                    document.getElementById("modalDetails_responseButtonContainer").style.display = "none";
                    document.getElementById("modalDetails_response").innerHTML = record.dateAssignment;
                }
            } else {
                document.getElementById("modalDetails_assignmentContainer").style.display = "initial";
                document.getElementById("modalDetails_responseContainer").style.display = "initial";
                document.getElementById("modalDetails_commentContainer").style.display = "initial";
                document.getElementById("modalDetails_rechannelButtonContainer").style.display = "none";
                    document.getElementById("modalDetails_deleteButtonContainer").style.display = "none";
                document.getElementById("modalDetails_responseButtonContainer").style.display = "initial";
                document.getElementById("modalDetails_response").innerHTML = record.dateAssignment;
                document.getElementById("modalDetails_response").innerHTML = record.dateResponse;
                document.getElementById("modalDetails_comment").innerHTML = record.comment;
            }
            document.getElementById("modalDetails_viewForm").value = record.id_minutes;
            modalDetails.show();
            document.getElementById("modalDelete_id").innerHTML = record.id_minutes;
            document.getElementById("modalDelete_formId").value = record.id_minutes;
        }
    };
}

function showModalDelete(id) {  
    modalDelete.show();
}