package mx.com.siso.tool;

public class Formatter {
    public static String formatDate(String date) {
        String finalDate, day, month = "", year, time;
        day = date.substring(8,10);
        switch (date.substring(5,7)) {
            case "01":
                month = "enero";
                break;
            case "02":
                month = "febrero";
                break;
            case "03":
                month = "marzo";
                break;
            case "04":
                month = "abril";
                break;
            case "05":
                month = "mayo";
                break;
            case "06":
                month = "junio";
                break;
            case "07":
                month = "julio";
                break;
            case "08":
                month = "agosto";
                break;
            case "09":
                month = "septiembre";
                break;
            case "10":
                month = "octubre";
                break;
            case "11":
                month = "noviembre";
                break;
            case "12":
                month = "diciembre";
        }
        year = date.substring(0,4);
        time = date.substring(11,16);
        finalDate = day + " de " + month + " de " + year + " " + time;
        return finalDate;
    }
    public static String formatPhone(String phone) {
        String finalphone = phone.substring(0,3) + "-" + phone.substring(3,6) + "-" + phone.substring(6);
        return finalphone;
    }
}
