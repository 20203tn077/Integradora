package mx.com.siso.model.administrador;

public class BeanAdministrador {
    private String nameAdmin;
    private String passwordAdmin;

    public BeanAdministrador() {
    }

    public BeanAdministrador(String nameAdmin, String passwordAdmin) {
        this.nameAdmin = nameAdmin;
        this.passwordAdmin = passwordAdmin;
    }

    public String getNameAdmin() {
        return nameAdmin;
    }

    public void setNameAdmin(String nameAdmin) {
        this.nameAdmin = nameAdmin;
    }

    public String getPasswordAdmin() {
        return passwordAdmin;
    }

    public void setPasswordAdmin(String passwordAdmin) {
        this.passwordAdmin = passwordAdmin;
    }
}
