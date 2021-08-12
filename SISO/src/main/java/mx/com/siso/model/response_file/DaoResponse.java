package mx.com.siso.model.response_file;

import mx.com.siso.model.records.BeanRecords;
import mx.com.siso.service.ConnectionMySQL;

import java.io.InputStream;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

public class DaoResponse {
    Connection con;
    CallableStatement cstm;
    ResultSet rs;
    public int[] createResponse(BeanResponse_file file, InputStream pdf) throws SQLException {
        int[] resultado = new int[3];
        try {
            if(pdf==null){
                con = ConnectionMySQL.getConnection();
                cstm = con.prepareCall("{call create_response_comment(?,?,?,?)}");
                System.out.println(file.getMinutes_id().getId_minutes());
                cstm.setInt(1, file.getMinutes_id().getId_minutes());
                cstm.setString(2,file.getMinutes_id().getComment());
                cstm.registerOutParameter(3, java.sql.Types.INTEGER);
                cstm.registerOutParameter(4, java.sql.Types.INTEGER);
                cstm.execute();
                int errorId  = cstm.getInt(3);
                int errorAttended  = cstm.getInt(4);
                if(errorId == 0 &&  errorAttended==0){
                    resultado[0] = 1;
                }else {
                    if (errorId == 1){
                        resultado[1] = 1;
                    }else {
                        if (errorAttended == 1){
                            resultado[2] = 1;
                        }
                    }
                }
            }else{
                con = ConnectionMySQL.getConnection();
                cstm = con.prepareCall("{call create_response(?,?,?,?,?)}");
                cstm.setInt(1, file.getMinutes_id().getId_minutes());
                cstm.setString(2,file.getMinutes_id().getComment());
                cstm.setBlob(3,pdf);
                cstm.registerOutParameter(4, java.sql.Types.INTEGER);
                cstm.registerOutParameter(5, java.sql.Types.INTEGER);
                cstm.execute();
                int errorId  = cstm.getInt(4);
                int errorAttended  = cstm.getInt(5);
                if(errorId == 0 &&  errorAttended==0){
                    resultado[0] = 1;
                }else {
                    if (errorId == 1){
                        resultado[1] = 1;
                    }else {
                        if (errorAttended == 1){
                            resultado[2] = 1;
                        }
                    }
                }
            }

        }catch (SQLException e){
            System.out.printf("Ha ocurrido un error: " + e.getMessage());
        } finally {
            ConnectionMySQL.closeConnection(con, cstm);
        }
        return resultado;
    }
    public boolean changeAttended(BeanResponse_file file) throws SQLException {
        boolean flag = false;
        try {
            con = ConnectionMySQL.getConnection();
            cstm = con.prepareCall("{call change_attended(?)}");
            cstm.setInt(1, file.getMinutes_id().getId_minutes());
            flag = cstm.execute();

        }catch (SQLException e){
            System.out.printf("Ha ocurrido un error: " + e.getMessage());
        } finally {
            ConnectionMySQL.closeConnection(con, cstm);
        }
        return flag;
    }
    public List<BeanResponse_file> findResponse(int idRecord){
        List<BeanResponse_file> listReponse = new ArrayList<>();
        try{
            System.out.println(idRecord);
            con = ConnectionMySQL.getConnection();
            cstm = con.prepareCall("{call find_response(?)}");
            cstm.setInt(1, idRecord);
            rs = cstm.executeQuery();

            while(rs.next()){
                BeanResponse_file beanResponse_file =new BeanResponse_file();
                BeanRecords beanRecords = new BeanRecords();
                beanResponse_file.setId_response(rs.getInt("response_id"));
                beanResponse_file.setFileResponse(Base64.getEncoder().encodeToString(rs.getBytes("response_file")));
                beanRecords.setId_minutes(rs.getInt("records_id"));
                beanResponse_file.setMinutes_id(beanRecords);
                listReponse.add(beanResponse_file);
            }

        }catch(SQLException e){
            System.out.println("Se ha encontrado un error: " + e.getMessage());
        }finally {
            ConnectionMySQL.closeConnection(con, cstm, rs);
        }
        return listReponse;
    }
    public String  findResponseById(int id){
        String PDF="";
        try {
            con = ConnectionMySQL.getConnection();
            cstm = con.prepareCall("{call  find_response_byId(?)}");
            cstm.setLong(1, id);
            rs = cstm.executeQuery();

            if(rs.next()){
                PDF = Base64.getEncoder().encodeToString(rs.getBytes(1));
            }

        }catch (SQLException e){
            System.out.println("Ha ocurrido un error: " + e.getMessage());
        } finally {
            ConnectionMySQL.closeConnection(con, cstm, rs);
        }
        return PDF;
    }
}
