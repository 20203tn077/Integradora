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
                    <a class="nav-link active" href="${context}/Gestión_de_Usuarios?redirect=users">Gestión de usuarios</a>
                    <a class="nav-link" href="${context}/Gestión_de_Departamentos?redirect=departments">Gestión de departamentos</a>
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
    <div class="container mt-4">
        <div class="card shadow-sm">
            <h5 class="card-header">Modificar datos de usuario</h5>
            <div class="card-body">
                <form action="${context}/Gestión_de_Usuarios" method="POST" class="m-0">
                    <input type="hidden" name="action" value="modifyUser">
                    <input type="hidden" name="id" value="${user.id_user}">
                    <div class="row gy-3">
                        <div class="col-md-6 col-xl-4">
                            <label class="form-label">Nombre de usuario:</label>
                            <input type="text" class="form-control" id="usernameInput" name="usernameInput" value="${user.nameUser}">
                        </div>
                        <div class="col-md-6 col-xl-4">
                            <label class="form-label">Nombre(s):</label>
                            <input type="text" class="form-control" id="nameInput" name="nameInput" value="${user.name}">
                        </div>
                        <div class="col-md-6 col-xl-4">
                            <label class="form-label">Primer apellido:</label>
                            <input type="text" class="form-control" id="lastname1Input" name="lastname1Input" value="${user.lastname1}">
                        </div>
                        <div class="col-md-6 col-xl-4">
                            <label class="form-label">Segundo apellido:</label>
                            <input type="text" class="form-control" id="lastname1Input" name="lastname2Input" value="${user.lastname2}">
                        </div>
                        <div class="col-md-6 col-xl-4">
                            <label class="form-label">Correo electrónico:</label>
                            <input type="email" class="form-control" id="emailInput" name="emailInput" value="${user.email}">
                        </div>
                        <div class="col-md-6 col-xl-4">
                            <label class="form-label">Contraseña:</label>
                            <input type="password" class="form-control" id="passwordInput" name="passwordInput">
                        </div>
                        <div class="col-md-6 col-xl-4">
                            <label class="form-label">Confimar contraseña:</label>
                            <input type="password" class="form-control">
                        </div>
                        <div class="col-md-6 col-xl-4">
                            <label class="form-label">Rol:</label>
                            <select class="form-select" aria-label="Default select example" id="roleInput" name="roleInput">
                                <option value="">Seleccione un rol...</option>
                                <c:forEach items="${roleList}" var="role">
                                    <c:choose>
                                        <c:when test="${role.idType == user.type_id.idType}">
                                            <option value="${role.idType}" selected>${role.nameType}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="${role.idType}">${role.nameType}</option>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                              </select>
                        </div>
                        <div class="col-md-6 col-xl-4" id="departmentContainer" <c:if test="${user.type_id.idType == 3}">style="display: none;"</c:if>>
                            <label class="form-label">Departamento:</label>
                            <select class="form-select" aria-label="Default select example" id="departmentInput" name="departmentInput">
                                <option value="">Seleccione un departamento...</option>
                                <c:forEach items="${departmentList}" var="department">
                                    <c:choose>
                                        <c:when test="${department.idDepartment == user.department_id.idDepartment}">
                                            <option value="${department.idDepartment}" selected>${department.nameDepartment}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="${department.idDepartment}">${department.nameDepartment}</option>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                              </select>
                        </div>
                    </div>
                    <button type="submit">enviar</button>
                </form>
            </div>
            <div class="card-footer bg-white">
                <div class="row">
                    <div class="p-1 col-md-4 col-xl-3">
                        <button type="button" class="btn btn-secondary w-100" data-bs-toggle="modal" data-bs-target="#modalExit">
                            <svg class="feather">
                                <use xlink:href="${context}/assets/icons/feather-sprite.svg#x" />
                            </svg>
                            <span> Cancelar</span>
                        </button>
                    </div>
                    <div class="p-1 col-md-4 col-xl-3">
                        <button class="btn btn-verde w-100">
                            <svg class="feather">
                                <use xlink:href="${context}/assets/icons/feather-sprite.svg#check" />
                            </svg>
                            <span> Guardar cambios</span>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" tabindex="-1" id="modalExit">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Descartar cambios</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col">
                            <p>¿Desea descartar los cambios realizados?</p>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="row w-100">
                        <div class="p-1 col-md-6 col-lg-4">
                            <button class="btn btn-secondary w-100" data-bs-dismiss="modal">
                                <svg class="feather">
                                    <use xlink:href="${context}/assets/icons/feather-sprite.svg#x" />
                                </svg>
                                <span> Cancelar</span>
                            </button>
                        </div>
                        <div class="p-1 col-md-6 col-lg-4">
                                <a class="btn btn-verde w-100" href="${context}/Gestión_de_Usuarios?redirect=users">
                                    <svg class="feather">
                                        <use xlink:href="${context}/assets/icons/feather-sprite.svg#corner-up-left" />
                                    </svg>
                                    <span> Descartar</span>
                                </a>
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
    <script src="/assets/js/bootstrap.bundle.js"></script>
</body>

</html>