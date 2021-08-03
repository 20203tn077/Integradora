var modal1 = new bootstrap.Modal(document.getElementById('pendingRecordModal'), {})
var modal2 = new bootstrap.Modal(document.getElementById('attendedRecordModal'), {})

function showModal1(recordId, channellingDate, assignmentDate, department, priority) {
    document.getElementById("modal1RecordId").innerHTML = recordId;
    document.getElementById("modal1ChannellingDate").innerHTML = channellingDate;
    document.getElementById("modal1AssignmentDate").innerHTML = assignmentDate;
    document.getElementById("modal1Department").innerHTML = department;
    document.getElementById("modal1Priority").innerHTML = priority;
    document.getElementById("modal1RecordIdInput").value = recordId;
    switch (priority) {
        case "Normal":
            document.getElementById("modal1Priority").className = "badge bg-success";
            break;
        case "Importante":
            document.getElementById("modal1Priority").className = "badge bg-warning text-dark";
            break;
        case "Muy importante":
            document.getElementById("modal1Priority").className = "badge bg-naranja";
            break;
        case "Urgente":
            document.getElementById("modal1Priority").className = "badge bg-danger";
    }
    modal1.show();
}

function showModal2(recordId, channellingDate, assignmentDate, responseDate, department, priority, comment) {
    document.getElementById("modal2RecordId").innerHTML = recordId;
    document.getElementById("modal2ChannellingDate").innerHTML = channellingDate;
    document.getElementById("modal2AssignmentDate").innerHTML = assignmentDate;
    document.getElementById("modal2ResponseDate").innerHTML = responseDate;
    document.getElementById("modal2Department").innerHTML = department;
    document.getElementById("modal2Priority").innerHTML = priority;
    document.getElementById("modal2RecordIdInput").value = recordId;
    document.getElementById("modal2Comment").innerHTML = comment;
    switch (priority) {
        case "Normal":
            document.getElementById("modal2Priority").className = "badge bg-success";
            break;
        case "Importante":
            document.getElementById("modal2Priority").className = "badge bg-warning text-dark";
            break;
        case "Muy importante":
            document.getElementById("modal2Priority").className = "badge bg-naranja";
            break;
        case "Urgente":
            document.getElementById("modal2Priority").className = "badge bg-danger";
    }
    modal2.show();
}