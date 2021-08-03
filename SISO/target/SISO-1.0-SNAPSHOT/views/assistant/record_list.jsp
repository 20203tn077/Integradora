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
    <c:if test="${access}">
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
        <div class="container mt-4">
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
                                <c:forEach items="${recordList1}" var="record">
                                    <tr role="button"
                                    onclick="showModal1('10', '2021-07-26 04:47:54.0', '2021-07-18 11:59:49.0', 'DAMI', 'Muy importante')">
                                    <td>${record.id_minutes}</td>
                                    <td>
                                        ${record.dateAssignment}
                                    </td>
                                    <td>
                                        <c:if test="${record.priorityId.idPriority == 1}">
                                            <span class="badge bg-danger w-100">${record.priorityId.namePriority}</span>
                                        </c:if>
                                        <c:if test="${record.priorityId.idPriority == 2}">
                                            <span class="badge bg-naranja w-100">${record.priorityId.namePriority}</span>
                                        </c:if>
                                        <c:if test="${record.priorityId.idPriority == 3}">
                                            <span class="badge bg-warning w-100">${record.priorityId.namePriority}</span>
                                        </c:if>
                                        <c:if test="${record.priorityId.idPriority == 4}">
                                            <span class="badge bg-success w-100">${record.priorityId.namePriority}</span>
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
                                <c:forEach items="${recordList2}" var="record">
                                    <tr role="button"
                                    onclick="showModal2('4', '2021-07-26 04:47:21.0', '2021-06-08 14:10:46.0', '2021-06-12 18:10:46.0' , 'DATIC', 'Urgente', 'Revisión Completa')">
                                    <td>${record.id_minutes}</td>
                                    <td>
                                        ${record.dateAssignment}
                                    </td>
                                    <td>
                                        ${record.dateChannelling}
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
                                    <form action="/SISO_war/ServletRecords" method="POST" target="_blank" class="m-0">
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
                                    <form action="/ServletRecords" method="POST" target="_blank" class="m-0">
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
    </c:if>
    <c:if test="${! access}">
        <div class="alert alert-danger m-3">
            <svg class="feather-24">
                <use xlink:href="${context}/assets/icons/feather-sprite.svg#alert-triangle" />
            </svg>
            <span> Error: No tienes acceso a este sitio.</span>
        </div>
    </c:if>
    <script src="${context}/assets/js/bootstrap.bundle.js"></script>
    <script src="${context}/assets/js/assistant/recordListUtil.js"></script>
</body>

</html>