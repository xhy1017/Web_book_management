package Utils;

public class isMobileAgent {
    public static boolean  isMobileDevice(String requestHeader){
        /**
         * android : 所有android设备
         * mac os : iphone ipad
         * windows phone:Nokia等windows系统的手机
         */
        String[] deviceArray = new String[]{"okhttp/4.9.3","android","mac os","windows phone"};
        if(requestHeader == null)
            return false;
        requestHeader = requestHeader.toLowerCase();
        for (String s : deviceArray) {
            if (requestHeader.indexOf(s) > 0) {
                return true;
            }
        }
        return false;
    }
}
