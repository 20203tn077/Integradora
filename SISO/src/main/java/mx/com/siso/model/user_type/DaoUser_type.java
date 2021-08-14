package mx.com.siso.model.user_type;

import mx.com.siso.service.ConnectionMySQL;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DaoUser_type {
    Connection con;
    CallableStatement cstm;
    ResultSet rs;
    public List<BeanUser_type> findUserType() {
        List<BeanUser_type> listUserType = new ArrayList<>();
        try {
            con = ConnectionMySQL.getConnection();
            cstm = con.prepareCall("{call find_userType}");
            rs = cstm.executeQuery();

            while (rs.next()) {
                BeanUser_type beanUserType = new BeanUser_type();

                beanUserType.setIdType(rs.getInt("type_id"));
                beanUserType.setNameType(rs.getString("type_name"));


                listUserType.add(beanUserType);
            }
        } catch (SQLException e) {
            System.out.println("Ha ocurrido un error: " + e.getMessage());
        } finally {
            ConnectionMySQL.closeConnection(con, cstm, rs);
        }
        return listUserType;
    }
}
