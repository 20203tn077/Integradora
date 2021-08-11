package mx.com.siso.model.records;

import mx.com.siso.model.department.BeanDepartment;
import mx.com.siso.model.priority.BeanPriority;
import mx.com.siso.model.users.BeanUsers;
import mx.com.siso.service.ConnectionMySQL;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DaoRecords {
    Connection con;
    CallableStatement cstm;
    ResultSet rs;

    public List<BeanRecords> findAllRecords(int idUser, byte tableType){
        List<BeanRecords> listMinutes = new ArrayList<>();
        try {
            con = ConnectionMySQL.getConnection();
            cstm = con.prepareCall("{call view_records(?,?,?)}");
            cstm.setInt(1, idUser);
            cstm.setByte(2, tableType);
            cstm.registerOutParameter(3, java.sql.Types.INTEGER);
            rs = cstm.executeQuery();
            int errorUser  = cstm.getInt(3);
            if(errorUser==0){
                System.out.println("Consulta exitosa");
            }else{
                System.out.println("El usuario no existe");
            }

            while(rs.next()){
                BeanUsers beanUsers =new BeanUsers();
                BeanDepartment beanDepartment = new BeanDepartment();
                BeanPriority beanPriority = new BeanPriority();
                BeanRecords beanRecords = new BeanRecords();

                beanPriority.setIdPriority(rs.getInt("priority_id"));
                beanPriority.setNamePriority(rs.getString("priority_name"));
                beanDepartment.setIdDepartment(rs.getInt("department_id"));
                beanDepartment.setNameDepartment(rs.getString("department_name"));
                beanUsers.setName(rs.getString("name"));
                beanUsers.setId_user(rs.getInt("user_id"));
                beanRecords.setDateChannelling(rs.getTimestamp("channelling_date"));
                beanRecords.setDateAssignment(rs.getTimestamp("assignment_date"));
                beanRecords.setDateResponse(rs.getTimestamp("response_date"));
                beanRecords.setId_minutes(rs.getInt("records_id"));
                beanRecords.setAttended(rs.getInt("attended"));
                beanRecords.setDepartmentId(beanDepartment);
                beanRecords.setUserId(beanUsers);
                beanRecords.setPriorityId(beanPriority);


                listMinutes.add(beanRecords);
            }
        }catch (SQLException e){
            System.out.printf("Ha ocurrido un error: " + e.getMessage());
        } finally {
            ConnectionMySQL.closeConnection(con, cstm, rs);
        }
        return listMinutes;
    }

    public List<BeanRecords> findRecordsByAssistant(int idUser, byte tableType){
        List<BeanRecords> listMinutes = new ArrayList<>();
        try {
            con = ConnectionMySQL.getConnection();
            cstm = con.prepareCall("{call view_records(?,?,?)}");
            cstm.setInt(1, idUser);
            cstm.setByte(2, tableType);
            cstm.registerOutParameter(3, java.sql.Types.INTEGER);
            rs = cstm.executeQuery();
            int errorUser  = cstm.getInt(3);
            if(errorUser==0){
                System.out.println("Consulta exitosa");
            }else{
                System.out.println("El usuario no existe");
            }

            while(rs.next()){
                BeanUsers beanUsers =new BeanUsers();
                BeanDepartment beanDepartment = new BeanDepartment();
                BeanPriority beanPriority = new BeanPriority();
                BeanRecords beanRecords = new BeanRecords();

                beanPriority.setIdPriority(rs.getInt("priority_id"));
                beanPriority.setNamePriority(rs.getString("priority_name"));
                beanDepartment.setIdDepartment(rs.getInt("department_id"));
                beanDepartment.setNameDepartment(rs.getString("department_name"));
                beanRecords.setDateChannelling(rs.getTimestamp("channelling_date"));
                beanRecords.setDateAssignment(rs.getTimestamp("assignment_date"));
                beanRecords.setId_minutes(rs.getInt("records_id"));
                beanRecords.setAttended(rs.getInt("attended"));
                beanRecords.setDateResponse(rs.getTimestamp("response_date"));
                beanRecords.setComment(rs.getString("comment"));
                beanRecords.setDepartmentId(beanDepartment);
                beanRecords.setUserId(beanUsers);
                beanRecords.setPriorityId(beanPriority);
                listMinutes.add(beanRecords);
            }
        }catch (SQLException e){
            System.out.printf("findRecordsByAssistant - Ha ocurrido un error: " + e.getMessage());
        } finally {
            ConnectionMySQL.closeConnection(con, cstm, rs);
        }
        return listMinutes;
    }
    public int[] createRecord(BeanRecords minute) throws SQLException {
        int[] resultado = new int[3];
        try {
            con = ConnectionMySQL.getConnection();
            cstm = con.prepareCall("{call create_records(?,?,?,?,?)}");
            cstm.setBlob(1, minute.getFileMinutes());
            cstm.setInt(2,minute.getDepartmentId().getIdDepartment());
            cstm.setInt(3,minute.getPriorityId().getIdPriority());
            cstm.registerOutParameter(4, java.sql.Types.INTEGER);
            cstm.registerOutParameter(5, java.sql.Types.INTEGER);
            cstm.execute();
            int errorDepartament = cstm.getInt(4);
            int errorPriority = cstm.getInt(5);
            if(errorDepartament==0 && errorPriority==0){
                System.out.println("Se registro correctamente");
                resultado[0] = 1;
            }else{
                if(errorDepartament==1){
                    System.out.println("El departamento no existe");
                    resultado[1] = 1;
                }
                if(errorPriority==1){
                    System.out.println("La prioridad no existe");
                    resultado[2] = 1;
                }
            }
        }catch (SQLException e){
            System.out.printf("Ha ocurrido un error: " + e.getMessage());
        } finally {
            ConnectionMySQL.closeConnection(con, cstm);
        }
        return resultado;
    }

    public byte[]  findRecordFile(int id){
        byte[] b = null;
        byte[] datosPDF = null;
        try {
            con = ConnectionMySQL.getConnection();
            cstm = con.prepareCall("{call  find_record_file(?)}");
            cstm.setLong(1, id);
            rs = cstm.executeQuery();

            if(rs.next()){
                b = rs.getBytes(1);
            }
            InputStream bos = new ByteArrayInputStream(b);

            int tamanoInput = bos.available();
            datosPDF = new byte[tamanoInput];
            bos.read(datosPDF, 0, tamanoInput);

        }catch (SQLException | IOException e){
            System.out.println("Ha ocurrido un error: " + e.getMessage());
        } finally {
            ConnectionMySQL.closeConnection(con, cstm, rs);
        }
        return datosPDF;
    }
    public int[] assignRecord(BeanRecords records) throws SQLException {
        int[] resultado = new int[4];
        try {
            con = ConnectionMySQL.getConnection();
            cstm = con.prepareCall("{call assign_record(?,?,?,?,?)}");
            cstm.setInt(1,records.getId_minutes());
            cstm.setInt(2,records.getUserId().getId_user());
            cstm.registerOutParameter(3, java.sql.Types.INTEGER);
            cstm.registerOutParameter(4, java.sql.Types.INTEGER);
            cstm.registerOutParameter(5, java.sql.Types.INTEGER);
            cstm.execute();
            int errorUser = cstm.getInt(3);
            int errorRecord = cstm.getInt(4);
            int errorAssignment = cstm.getInt(5);
            if(errorUser==0 && errorRecord==0 && errorAssignment == 0) {
                resultado[0] = 1;
            }else{
                if (errorUser == 1) {
                    resultado[1] = 1;
                }
                if (errorRecord == 1){
                    resultado[2] = 1;
                }else {
                    if (errorAssignment == 1){
                        resultado[3] = 1;
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
    public List<BeanRecords> findAllRecordsByManager(int idUser, byte tableType){
        List<BeanRecords> listMinutes = new ArrayList<>();
        try {
            con = ConnectionMySQL.getConnection();
            cstm = con.prepareCall("{call view_records(?,?,?)}");
            cstm.setInt(1, idUser);
            cstm.setInt(2, tableType);
            cstm.registerOutParameter(3, java.sql.Types.INTEGER);
            rs = cstm.executeQuery();
            int errorUser  = cstm.getInt(3);
            if(errorUser==0){
                System.out.println("Consulta exitosa");
            }else{
                System.out.println("El usuario no existe");
            }

            while(rs.next()){
                BeanUsers beanUsers =new BeanUsers();
                BeanDepartment beanDepartment = new BeanDepartment();
                BeanPriority beanPriority = new BeanPriority();
                BeanRecords beanRecords = new BeanRecords();

                beanPriority.setIdPriority(rs.getInt("priority_id"));
                beanPriority.setNamePriority(rs.getString("priority_name"));
                beanUsers.setName(rs.getString("name"));
                beanUsers.setNameUser(rs.getString("username"));
                beanUsers.setLastname1(rs.getString("lastname_1"));
                beanUsers.setLastname2(rs.getString("lastname_2"));
                beanUsers.setId_user(rs.getInt("user_id"));
                beanRecords.setDateChannelling(rs.getTimestamp("channelling_date"));
                beanRecords.setDateAssignment(rs.getTimestamp("assignment_date"));
                beanRecords.setId_minutes(rs.getInt("records_id"));
                beanRecords.setAttended(rs.getInt("attended"));
                beanRecords.setDepartmentId(beanDepartment);
                beanRecords.setUserId(beanUsers);
                beanRecords.setPriorityId(beanPriority);


                listMinutes.add(beanRecords);
            }
        }catch (SQLException e){
            System.out.printf("Ha ocurrido un error: " + e.getMessage());
        } finally {
            ConnectionMySQL.closeConnection(con, cstm, rs);
        }
        return listMinutes;
    }

    public BeanRecords findRecordById(int id){
        BeanRecords beanRecords = new BeanRecords();
        try {
            con = ConnectionMySQL.getConnection();
            cstm = con.prepareCall("{call find_record_byId(?)}");
            cstm.setInt(1, id);
            rs = cstm.executeQuery();
            if(rs.next()){
                BeanUsers beanUsers =new BeanUsers();
                BeanDepartment beanDepartment = new BeanDepartment();
                BeanPriority beanPriority = new BeanPriority();
                beanDepartment.setIdDepartment(rs.getInt("department_id"));
                beanDepartment.setNameDepartment(rs.getString("department_name"));
                beanPriority.setIdPriority(rs.getInt("priority_id"));
                beanPriority.setNamePriority(rs.getString("priority_name"));
                beanUsers.setName(rs.getString("name"));
                beanUsers.setLastname1(rs.getString("lastname_1"));
                beanUsers.setLastname2(rs.getString("lastname_2"));
                beanUsers.setId_user(rs.getInt("user_id"));
                beanUsers.setNameUser(rs.getString("username"));
                beanRecords.setDateChannelling(rs.getTimestamp("channelling_date"));
                beanRecords.setDateAssignment(rs.getTimestamp("assignment_date"));
                beanRecords.setDateResponse(rs.getTimestamp("response_date"));
                beanRecords.setComment(rs.getString("comment"));
                beanRecords.setId_minutes(rs.getInt("records_id"));
                beanRecords.setAttended(rs.getInt("attended"));
                beanRecords.setDepartmentId(beanDepartment);
                beanRecords.setUserId(beanUsers);
                beanRecords.setPriorityId(beanPriority);
            }
        }catch (SQLException e){
            System.out.printf("Ha ocurrido un error: " + e.getMessage());
        } finally {
            ConnectionMySQL.closeConnection(con, cstm, rs);
        }
        return beanRecords;
    }
}
