<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="context" value="${pageContext.request.contextPath}" />
<html>

<head>
    <title>SISO</title>
    <link href="${context}/assets/css/bootstrap.css" rel="stylesheet">
    <link href="${context}/assets/css/util.css" rel="stylesheet">
</head>

<body class="bg-light">

    <!--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////-->

    <c:if test="${access}">
        <nav class="navbar navbar-expand-lg navbar-dark bg-azul shadow">
            <div class="container-fluid">
                <span class="navbar-brand">Sistema de Seguimiento a Oficios</span>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                    aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <nav class="navbar-nav">
                        <a class="nav-link active" href="${context}/Gestión_de_Oficios?redirect=records">Gestión de
                            oficios</a>
                        <a class="nav-link" href="${context}/Gestión_de_Auxiliares?redirect=assistants">Gestión de
                            auxiliares</a>
                        <a class="nav-link" href="${context}/Perfil?redirect=profile">Perfil</a>
                    </nav>
                    <nav class="navbar-nav ms-auto">
                        <a class="nav-link active" href="${context}/Inicio_de_Sesión?redirect=login">
                            <svg class="feather">
                                <use xlink:href="${context}/assets/icons/feather-sprite.svg#log-out" />
                            </svg>
                            <span> Salir</span>
                        </a>
                    </nav>
                </div>
            </div>
        </nav>

        <!--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////-->

        <c:if test="${message != null}">
            <c:if test="${messageType == 1}">
                <div class="alert alert-primary alert-dismissible fade show m-3" role="alert">
                    <svg class="feather-24">
                        <use xlink:href="${context}/assets/icons/feather-sprite.svg#info" />
                    </svg>
                    <span> ${message}</span>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            <c:if test="${messageType == 2}">
                <div class="alert alert-success alert-dismissible fade show m-3" role="alert">
                    <svg class="feather-24">
                        <use xlink:href="${context}/assets/icons/feather-sprite.svg#check-circle" />
                    </svg>
                    <span> ${message}</span>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            <c:if test="${messageType == 3}">
                <div class="alert alert-warning alert-dismissible fade show m-3" role="alert">
                    <svg class="feather-24">
                        <use xlink:href="${context}/assets/icons/feather-sprite.svg#alert-circle" />
                    </svg>
                    <span> ${message}</span>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            <c:if test="${messageType == 4}">
                <div class="alert alert-danger alert-dismissible fade show m-3" role="alert">
                    <svg class="feather-24">
                        <use xlink:href="${context}/assets/icons/feather-sprite.svg#alert-triangle" />
                    </svg>
                    <span> ${message}</span>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
        </c:if>

        <!--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////-->

        <div class="container mt-4">
            <div class="card shadow-sm">
                <h5 class="card-header">Gestión de oficios</h5>
                <div class="card-body" height="100px">
                    <h5>Pendientes:</h5>
                    <div class="table-container">
                        <table class="table table-azul table-striped table-hover border text-center m-0">
                            <thead class="thead-azul display-none">
                                <tr>
                                    <th>Nombre del archivo</th>
                                    <th>Fecha de canalización</th>
                                    <th>Prioridad</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${empty recordList1}">
                                        <td colspan="3">Sin oficios</td>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach items="${recordList1}" var="record">
                                            <tr role="button" onclick="showModalDetails('${record.id_minutes}')">
                                                <td>${record.filename}</td>
                                                <td>
                                                    ${record.dateChannelling}
                                                </td>
                                                <c:if test="${record.priorityId.idPriority == 1}">
                                                    <td>
                                                        <span
                                                            class="badge bg-danger w-100">${record.priorityId.namePriority}</span>
                                                    </td>
                                                </c:if>
                                                <c:if test="${record.priorityId.idPriority == 2}">
                                                    <td>
                                                        <span
                                                            class="badge bg-naranja w-100">${record.priorityId.namePriority}</span>
                                                    </td>
                                                </c:if>
                                                <c:if test="${record.priorityId.idPriority == 3}">
                                                    <td>
                                                        <span
                                                            class="badge bg-warning w-100">${record.priorityId.namePriority}</span>
                                                    </td>
                                                </c:if>
                                                <c:if test="${record.priorityId.idPriority == 4}">
                                                    <td>
                                                        <span
                                                            class="badge bg-success w-100">${record.priorityId.namePriority}</span>
                                                    </td>
                                                </c:if>
                                            </tr>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>

                            </tbody>
                        </table>
                    </div>
                    <hr>
                    <h5>Asignados:</h5>
                    <div class="table-container">
                        <table class="table table-azul table-striped table-hover border text-center m-0">
                            <thead class="thead-azul display-none">
                                <tr>
                                    <th>Nombre del archivo</th>
                                    <th>Fecha de canalización</th>
                                    <th>Fecha de asignación</th>
                                    <th>Auxiliar asignado</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${empty recordList2}">
                                        <td colspan="4">Sin oficios</td>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach items="${recordList2}" var="record">
                                            <tr role="button" onclick="showModalDetails('${record.id_minutes}')">
                                                <td>${record.filename}</td>
                                                <td>
                                                    ${record.dateChannelling}
                                                </td>
                                                <td>
                                                    ${record.dateAssignment}
                                                </td>
                                                <td>
                                                    ${record.userId.name.concat("
                                                    ").concat(record.userId.lastname1).concat("
                                                    ").concat(record.userId.lastname2)}
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>

                            </tbody>
                        </table>
                    </div>
                    <hr>
                    <h5>Atendidos:</h5>
                    <div class="table-container">
                        <table class="table table-azul table-striped table-hover border text-center m-0">
                            <thead class="thead-azul display-none">
                                <tr>
                                    <th>Nombre del archivo</th>
                                    <th>Fecha de asignación</th>
                                    <th>Fecha de respuesta</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${empty recordList3}">
                                        <td colspan="3">Sin oficios</td>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach items="${recordList3}" var="record">
                                            <tr role="button" onclick="showModalDetails('${record.id_minutes}')">
                                                <td>${record.filename}</td>
                                                <td>
                                                    ${record.dateAssignment}
                                                </td>
                                                <td>
                                                    ${record.dateResponse}
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////-->

        <div class="modal fade" tabindex="-1" id="modalDetails">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Auxiliar</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6">
                                <span class="fw-bold">
                                    Nombre del archivo:
                                </span>
                                <p id="modalDetails_filename"></p>
                            </div>
                            <div class="col-md-6">
                                <span class="fw-bold">
                                    Fecha de canalización:
                                </span>
                                <p id="modalDetails_channelling"></p>
                            </div>
                            <div class="col-md-6" id="modalDetails_assignmentContainer">
                                <span class="fw-bold">
                                    Fecha de asignación:
                                </span>
                                <p id="modalDetails_assignment"></p>
                            </div>
                            <div class="col-md-6" id="modalDetails_assistantContainer">
                                <span class="fw-bold">
                                    Auxiliar asignado:
                                </span>
                                <p id="modalDetails_assistant"></p>
                            </div>
                            <div class="col-md-6" id="modalDetails_responseContainer">
                                <span class="fw-bold">
                                    Fecha de respuesta:
                                </span>
                                <p id="modalDetails_response"></p>
                            </div>
                            <div class="col-md-6">
                                <span class="fw-bold">
                                    Prioridad:
                                </span>
                                <p id="modalDetails_priority"></p>
                            </div>
                            <div class="col-md-6">
                                <span class="fw-bold">
                                    Departamento:
                                </span>
                                <p id="modalDetails_department"></p>
                            </div>
                            <div class="col-md-6" id="modalDetails_commentContainer">
                                <span class="fw-bold">
                                    Comentario:
                                </span>
                                <p id="modalDetails_comment"></p>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <div class="row w-100">
                            <div class="p-1 col-md-6 col-lg-4">
                                <form action="${context}/Visualizar_Oficio" method="post" class="d-inline m-0"
                                    target="_blank">
                                    <input type="hidden" name="action" value="viewRecordFile">
                                    <input type="hidden" name="id" id="modalDetails_viewForm">
                                    <button type="submit" class="btn btn-verde w-100">
                                        <svg class="feather">
                                            <use xlink:href="${context}/assets/icons/feather-sprite.svg#file-text" />
                                        </svg>
                                        <span> Visualizar oficio</span>
                                    </button>
                                </form>
                            </div>
                            <div class="p-1 col-md-6 col-lg-4" id="modalDetails_assignButtonContainer">
                                <form action="${context}/Asignar_Oficio" method="post" class="d-inline m-0">
                                    <input type="hidden" name="action" value="redirect">
                                    <input type="hidden" name="redirect" value="recordAssign">
                                    <input type="hidden" name="id" id="modalDetails_assignId">
                                    <button type="submit" class="btn btn-verde w-100">
                                        <svg class="feather">
                                            <use xlink:href="${context}/assets/icons/feather-sprite.svg#user-plus" />
                                        </svg>
                                        <span> Asignar oficio</span>
                                    </button>
                                </form>
                            </div>
                            <div class="p-1 col-md-6 col-lg-4" id="modalDetails_reassignButtonContainer">
                                <form action="${context}/Reasignar_Oficio" method="post" class="d-inline m-0">
                                    <input type="hidden" name="action" value="redirect">
                                    <input type="hidden" name="redirect" value="recordReassign">
                                    <input type="hidden" name="id" id="modalDetails_reassignId">
                                    <button type="submit" class="btn btn-verde w-100">
                                        <svg class="feather">
                                            <use xlink:href="${context}/assets/icons/feather-sprite.svg#edit" />
                                        </svg>
                                        <span> Reasignar oficio</span>
                                    </button>
                                </form>
                            </div>
                            <div class="p-1 col-md-6 col-lg-4" data-bs-target="#modalDelete" data-bs-toggle="modal"
                                data-bs-dismiss="modal" id="modalDetails_responseButtonContainer">
                                <button type="button" class="btn btn-verde w-100" data-bs-target="#modalFiles"
                                    data-bs-toggle="modal" data-bs-dismiss="modal">
                                    <svg class="feather">
                                        <use xlink:href="${context}/assets/icons/feather-sprite.svg#folder" />
                                    </svg>
                                    <span> Archivos de respuesta</span>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////-->

        <div class="modal fade" tabindex="-1" id="modalFiles">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Archivos de respuesta</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" id="modalFiles_content"></div>
                    <div class="modal-footer">
                        <div class="row w-100">
                            <div class="p-1 col-md-4 col-lg-3">
                                <button class="btn btn-secondary w-100" data-bs-target="#modalDetails"
                                    data-bs-toggle="modal" data-bs-dismiss="modal">
                                    <svg class="feather">
                                        <use xlink:href="${context}/assets/icons/feather-sprite.svg#arrow-left" />
                                    </svg>
                                    <span> Regresar</span>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </c:if>

    <!--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////-->

    <c:if test="${! access}">
        <div class="alert alert-danger m-3">
            <svg class="feather-24">
                <use xlink:href="${context}/assets/icons/feather-sprite.svg#alert-triangle" />
            </svg>
            <span> Error: No tienes acceso a este sitio.</span>
        </div>
    </c:if>

    <!--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////-->

    <input type="hidden" id="context" value="${context}">
    <script src="${context}/assets/js/bootstrap.bundle.js"></script>
    <script src="${context}/assets/js/manager/recordListUtil.js"></script>
</body>

</html>