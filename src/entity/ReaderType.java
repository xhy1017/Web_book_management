package entity;

public class ReaderType {
    private int rdType;
    private int canLendDay;
    private String rdTypeName;
    private int canLendQty;

    public String getRdTypeName() {
        return rdTypeName;
    }

    public void setRdTypeName(String rdTypeName) {
        this.rdTypeName = rdTypeName;
    }


    public int getCanLendQty() {
        return canLendQty;
    }

    public void setCanLendQty(int canLendQty) {
        this.canLendQty = canLendQty;
    }


    public int getCanLendDay() {
        return canLendDay;
    }

    public void setCanLendDay(int canLendDay) {
        this.canLendDay = canLendDay;
    }

    public int getRdType() {
        return rdType;
    }

    public void setRdType(int rdType) {
        this.rdType = rdType;
    }

    @Override
    public String toString() {
        return "ReaderType{" +
                "rdType=" + rdType +
                ", canLendDay=" + canLendDay +
                ", rdTypeName='" + rdTypeName + '\'' +
                ", canLendQty=" + canLendQty +
                '}';
    }
}
