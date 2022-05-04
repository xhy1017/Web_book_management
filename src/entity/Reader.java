package entity;

public class Reader {
    private String rdID;
    private String rdType;
    private String rdName;
    private String rdDept;
    private String rdQQ;
    private String rdBorrowQty;
    private String rdpassword;
    private String rdTypeName;
    private String user_Image_URL;

    @Override
    public String toString() {
        return "Reader{" +
                "rdID='" + rdID + '\'' +
                ", rdType='" + rdType + '\'' +
                ", rdName='" + rdName + '\'' +
                ", rdDept='" + rdDept + '\'' +
                ", rdQQ='" + rdQQ + '\'' +
                ", rdBorrowQty='" + rdBorrowQty + '\'' +
                ", rdpassword='" + rdpassword + '\'' +
                ", rdTypeName='" + rdTypeName + '\'' +
                ", user_Image_URL='" + user_Image_URL + '\'' +
                '}';
    }

    public String getUser_Image_URL() {
        return user_Image_URL;
    }

    public void setUser_Image_URL(String user_Image_URL) {
        this.user_Image_URL = user_Image_URL;
    }

    public String getRdTypeName() {
        return rdTypeName;
    }

    public void setRdTypeName(String rdTypeName) {
        this.rdTypeName = rdTypeName;
    }

    public String getRdID() {
        return rdID;
    }

    public void setRdID(String rdID) {
        this.rdID = rdID;
    }

    public String getRdType() {
        return rdType;
    }
    public void setRdType(String rdType) {
        this.rdType = rdType;
    }
    public String getRdName() {
        return rdName;
    }

    public void setRdName(String rdName) {
        this.rdName = rdName;
    }

    public String getRdDept() {
        return rdDept;
    }

    public void setRdDept(String rdDept) {
        this.rdDept = rdDept;
    }

    public String getRdQQ() {
        return rdQQ;
    }

    public void setRdQQ(String rdQQ) {
        this.rdQQ = rdQQ;
    }

    public String getRdBorrowQty() {
        return rdBorrowQty;
    }

    public void setRdBorrowQty(String rdBorrowQty) {
        this.rdBorrowQty = rdBorrowQty;
    }

    public String getRdpassword() {
        return rdpassword;
    }

    public void setRdpassword(String rdpassword) {
        this.rdpassword = rdpassword;
    }

}
