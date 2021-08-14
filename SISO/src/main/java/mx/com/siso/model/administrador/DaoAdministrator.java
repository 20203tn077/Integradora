package mx.com.siso.model.administrador;

import mx.com.siso.service.ConnectionMySQL;

import java.sql.*;

public class DaoAdministrator {
    Connection con;
    CallableStatement cstm;
    ResultSet rs;

    public BeanAdministrador findAdministrator(){
        BeanAdministrador beanAdministrador = null;
        try {
            con = ConnectionMySQL.getConnection();
            cstm = con.prepareCall("{call find_administrator}");
            rs = cstm.executeQuery();
            while (rs.next()){
                beanAdministrador = new BeanAdministrador();
                beanAdministrador.setNameAdmin(rs.getString("administrator_name"));
                beanAdministrador.setPasswordAdmin(rs.getString("administrator_pass"));
            }
        }catch (SQLException e){
            System.out.println("Se ha encontrado el error " + e.getMessage());
        }finally {
            ConnectionMySQL.closeConnection(con, cstm, rs);
        }
        return beanAdministrador;
    }
    public boolean update(BeanAdministrador beanAdministrador, String id){
        boolean flag = false;
        try {
            con = ConnectionMySQL.getConnection();
            cstm = con.prepareCall("{call modify_administrator(?,?,?,?)}");
            cstm.setString(1, id);
            cstm.setString(2, beanAdministrador.getNameAdmin());
            cstm.setString(3, beanAdministrador.getPasswordAdmin());
            cstm.registerOutParameter(4, Types.INTEGER);
            cstm.execute();
            int success = cstm.getInt(4);
            if (success == 1){
                flag = true;
            }
        }catch (SQLException e){
            System.out.println("Se ha encontrado el error" +e.getMessage());
        }finally {
            ConnectionMySQL.closeConnection(con,cstm);
        }
        return  flag;
    }
}
