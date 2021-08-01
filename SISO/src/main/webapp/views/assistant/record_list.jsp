<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="context" value="${pageContext.request.contextPath}" />
<html>

<head>
    <title>SISO</title>
    <link href="${context}/assets/css/bootstrap.css" rel="stylesheet">
    <link href="${context}/assets/css/util.css" rel="stylesheet">
</head>

<body class="bg-light bg-gradient">
    <nav class="navbar navbar-expand-lg navbar-dark bg-azul shadow">
        <div class="container-fluid">
            <span class="navbar-brand">Sistema de Seguimiento a Oficios</span>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false"
                aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <nav class="navbar-nav">
                    <a class="nav-link active" href="#">Gestión de oficios</a>
                    <a class="nav-link" href="#">Perfil</a>
                </nav>
                <nav class="navbar-nav ms-auto">
                    <a class="nav-link active" href="${context}/views/common/login.jsp">
                        <svg class="feather">
                            <use xlink:href="${context}/assets/icons/feather-sprite.svg#log-out" />
                        </svg>
                        <span> Salir</span>
                    </a>
                </nav>
            </div>
        </div>
    </nav>

    <div class="container mt-5">
        <div class="card shadow-sm">
            <h5 class="card-header">Gestión de oficios</h5>
            <div class="card-body" height="100px">
                <h5>Pendientes:</h5>
                <div class="table-container">
                    <table class="table table-azul table-striped table-hover border text-center">
                        <thead class="thead-azul display-none">
                            <tr>
                                <th>No. de Oficio</th>
                                <th>Fecha de asignación</th>
                                <th>Prioridad</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${ pendingRecordList }" var="record" varStatus="status">
                                <tr role="button"
                                    onclick="showModal1('${record.id_minutes}', '${record.dateChannelling}', '${record.dateAssignment}', '${record.departmentId.nameDepartment}', '${record.priorityId.namePriority}')">
                                    <td>${ record.id_minutes }</td>
                                    <td>
                                        <c:if test="${   record.dateAssignment != null }">
                                            ${ record.dateAssignment}
                                        </c:if>
                                        <c:if test="${   record.dateAssignment == null }">
                                            Sin asignacion
                                        </c:if>
                                    </td>
                                    <td>
                                        <c:if test="${ record.priorityId.namePriority eq 'Urgente' }">
                                            <span class="badge bg-danger w-100">Urgente</span>
                                        </c:if>
                                        <c:if test="${ record.priorityId.namePriority eq 'Muy importante' }">
                                            <span class="badge bg-naranja w-100">Muy importante</span>
                                        </c:if>
                                        <c:if test="${ record.priorityId.namePriority eq 'Importante' }">
                                            <span class="badge bg-warning text-dark w-100">Importante</span>
                                        </c:if>
                                        <c:if test="${ record.priorityId.namePriority eq 'Normal' }">
                                            <span class="badge bg-success w-100">Normal</span>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <h5 class="mt-3">Atendidos:</h5>
                <div class="table-container">
                    <table class="table table-azul table-striped table-hover border text-center">
                        <thead class="thead-azul display-none">
                            <tr>
                                <th>No. de Oficio</th>
                                <th>Fecha de asignación</th>
                                <th>Fecha de respuesta</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${ attendedRecordList }" var="record" varStatus="status">
                                <tr role="button"
                                    onclick="showModal2('${record.id_minutes}', '${record.dateChannelling}', '${record.dateAssignment}', '${record.dateResponse}' , '${record.departmentId.nameDepartment}', '${record.priorityId.namePriority}', '${record.comment}')">
                                    <td>${ record.id_minutes }</td>
                                    <td>
                                        <c:if test="${   record.dateAssignment != null }">
                                            ${ record.dateAssignment}
                                        </c:if>
                                        <c:if test="${   record.dateAssignment == null }">
                                            Sin asignacion
                                        </c:if>
                                    </td>
                                    <td>
                                        <c:if test="${ record.dateResponse != null }">
                                            ${ record.dateResponse}
                                        </c:if>
                                        <c:if test="${ record.dateResponse == null }">
                                            Sin respuesta
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" tabindex="-1" id="pendingRecordModal">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Detalle del oficio</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="container">
                        <div class="row">
                            <div class="col-md-6">
                                <span class="fw-bold">
                                    Número de oficio:
                                </span>
                                <p id="modal1RecordId"></p>
                            </div>
                            <div class="col-md-6">
                                <span class="fw-bold">
                                    Fecha de canalización:
                                </span>
                                <p id="modal1ChannellingDate"></p>
                            </div>
                            <div class="col-md-6">
                                <span class="fw-bold">
                                    Fecha de asignación:
                                </span>
                                <p id="modal1AssignmentDate"></p>
                            </div>
                            <div class="col-md-6">
                                <span class="fw-bold">
                                    Departamento:
                                </span>
                                <p id="modal1Department"></p>
                            </div>
                            <div class="col-md-6">
                                <span class="fw-bold">
                                    Prioridad:
                                </span>
                                <p>
                                    <span id="modal1Priority"></span>
                                </p>
                            </div>
                        </div>
                        <div class="row">
                            <h5>Acciones:</h5>
                            <div class="col-md-6 col-lg-4 mb-3">
                                <form action="${context}/ServletRecords" method="POST" target="_blank" class="m-0">
                                    <input type="hidden" value="getRecordById" name="action">
                                    <input type="hidden" id="modal1RecordIdInput" name="recordIdInput">
                                    <button type="submit" class="btn btn-primary w-100">
                                        <svg class="feather">
                                            <use xlink:href="${context}/assets/icons/feather-sprite.svg#file-text" />
                                        </svg>
                                        <span> Visualizar archivo</span>
                                    </button>
                                </form>
                            </div>
                            <div class="col-md-6 col-lg-4 mb-3">
                                <button type="button" class="btn btn-primary w-100">
                                    <svg class="feather">
                                        <use xlink:href="${context}/assets/icons/feather-sprite.svg#edit" />
                                    </svg>
                                    <span> Atender oficio</span>
                                </button>
                            </div>
                            <div class="col-md-6 col-lg-4 mb-3">
                                <button type="button" class="btn btn-primary w-100">
                                    <svg class="feather">
                                        <use xlink:href="${context}/assets/icons/feather-sprite.svg#edit" />
                                    </svg>
                                    <span> Atender oficio</span>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" tabindex="-1" id="attendedRecordModal">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Detalle del oficio</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="container">
                        <div class="row">
                            <div class="col-md-6">
                                <span class="fw-bold">
                                    Número de oficio:
                                </span>
                                <p id="modal2RecordId"></p>
                            </div>
                            <div class="col-md-6">
                                <span class="fw-bold">
                                    Fecha de canalización:
                                </span>
                                <p id="modal2ChannellingDate"></p>
                            </div>
                            <div class="col-md-6">
                                <span class="fw-bold">
                                    Fecha de asignación:
                                </span>
                                <p id="modal2AssignmentDate"></p>
                            </div>
                            <div class="col-md-6">
                                <span class="fw-bold">
                                    Fecha de respuesta:
                                </span>
                                <p id="modal2ResponseDate"></p>
                            </div>
                            <div class="col-md-6">
                                <span class="fw-bold">
                                    Departamento:
                                </span>
                                <p id="modal2Department"></p>
                            </div>
                            <div class="col-md-6">
                                <span class="fw-bold">
                                    Prioridad:
                                </span>
                                <p>
                                    <span id="modal2Priority"></span>
                                </p>
                            </div>
                            <div class="col-md-6">
                                <span class="fw-bold">
                                    Comentario:
                                </span>
                                <p id="modal2Comment"></p>
                            </div>
                        </div>
                        <div class="row">
                            <h5>Acciones:</h5>
                            <div class="col-md-6 col-lg-4 mb-3">
                                <form action="${context}/ServletRecords" method="POST" target="_blank" class="m-0">
                                    <input type="hidden" value="getRecordById" name="action">
                                    <input type="hidden" id="modal2RecordIdInput" name="recordIdInput">
                                    <button type="submit" class="btn btn-primary w-100">
                                        <svg class="feather">
                                            <use xlink:href="${context}/assets/icons/feather-sprite.svg#file-text" />
                                        </svg>
                                        <span> Visualizar archivo</span>
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="${context}/assets/js/bootstrap.bundle.js"></script>
    <script src="${context}/assets/js/assistant/recordListUtil.js"></script>
</body>

</html>