var context = document.getElementById("context").value;
var modalDetails = new bootstrap.Modal(document.getElementById("modalDetails"), {});

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
                    document.getElementById("modalDetails_assistantContainer").style.display = "none";
                    document.getElementById("modalDetails_assignButtonContainer").style.display = "initial";
                    document.getElementById("modalDetails_reassignButtonContainer").style.display = "none";
                    document.getElementById("modalDetails_responseButtonContainer").style.display = "none";
                    document.getElementById("modalDetails_assignId").value = record.id_minutes;
                } else {
                    document.getElementById("modalDetails_assignmentContainer").style.display = "initial";
                    document.getElementById("modalDetails_responseContainer").style.display = "none";
                    document.getElementById("modalDetails_commentContainer").style.display = "none";
                    document.getElementById("modalDetails_assistantContainer").style.display = "initial";
                    document.getElementById("modalDetails_assignButtonContainer").style.display = "none";
                    document.getElementById("modalDetails_reassignButtonContainer").style.display = "initial";
                    document.getElementById("modalDetails_responseButtonContainer").style.display = "none";
                    document.getElementById("modalDetails_response").innerHTML = record.dateAssignment;
                    document.getElementById("modalDetails_assistant").innerHTML = record.userId.name + " " + record.userId.lastname1 + " " + record.userId.lastname2;
                }
            } else {
                document.getElementById("modalDetails_assignmentContainer").style.display = "initial";
                document.getElementById("modalDetails_responseContainer").style.display = "initial";
                document.getElementById("modalDetails_commentContainer").style.display = "initial";
                document.getElementById("modalDetails_assistantContainer").style.display = "initial";
                document.getElementById("modalDetails_assignButtonContainer").style.display = "none";
                document.getElementById("modalDetails_reassignButtonContainer").style.display = "none";
                document.getElementById("modalDetails_responseButtonContainer").style.display = "initial";
                document.getElementById("modalDetails_response").innerHTML = record.dateAssignment;
                document.getElementById("modalDetails_response").innerHTML = record.dateResponse;
                document.getElementById("modalDetails_comment").innerHTML = record.comment;
                document.getElementById("modalDetails_assistant").innerHTML = record.userId.name + " " + record.userId.lastname1 + " " + record.userId.lastname2;
            }
            document.getElementById("modalDetails_viewForm").value = record.id_minutes;
            modalDetails.show();
            if (record.attended == 1) {
                request.open("POST", context + "/Servlet", true);
                request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                request.send("action=getResponseList&id=" + id);
                request.onreadystatechange = function () {
                    if (this.readyState == 4 && this.status == 200) {
                        let files = JSON.parse(this.responseText);
                        document.getElementById("modalFiles_content").innerHTML = "";
                        let count = 0;
                        for (let file of files) {
                            count++;
                            document.getElementById("modalFiles_content").innerHTML +=
                            '<form action="' + context + '/Visualizar_Archivo" method="post" class="d-inline" target="_blank">' +
                                '<input type="hidden" name="id" value="' + file.id_response + '">' +
                                '<input type="hidden" name="action" value="viewResponseFile">' +
                                '<button class="btn btn-file m-2">' +
                                '<svg class="feather-48">' +
                                '<use xlink:href="' + context + '/assets/icons/feather-sprite.svg#file"/>' +
                                '</svg>' +
                                '<br>' +
                                '<span>Archivo ' + count + '</span>' +
                                '</button>' +
                                '</form>';
                        }
                        if (count == 0) {
                            document.getElementById("modalFiles_content").innerHTML = "Sin archivos de respuesta";
                        }
                    }
                };
            }
        }
    };
}