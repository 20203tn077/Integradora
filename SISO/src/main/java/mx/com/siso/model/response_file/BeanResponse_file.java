package mx.com.siso.model.response_file;

import mx.com.siso.model.records.BeanRecords;

import java.io.InputStream;

public class BeanResponse_file {

    private int id_response;
    private String fileResponse;
    private BeanRecords minutes_id;

    public BeanResponse_file() {
    }

    public BeanResponse_file(int id_response, String fileResponse, BeanRecords minutes_id) {
        this.id_response = id_response;
        this.fileResponse = fileResponse;
        this.minutes_id = minutes_id;
    }

    public int getId_response() {
        return id_response;
    }

    public void setId_response(int id_response) {
        this.id_response = id_response;
    }

    public String getFileResponse() {
        return fileResponse;
    }

    public void setFileResponse(String fileResponse) {
        this.fileResponse = fileResponse;
    }

    public BeanRecords getMinutes_id() {
        return minutes_id;
    }

    public void setMinutes_id(BeanRecords minutes_id) {
        this.minutes_id = minutes_id;
    }
}
