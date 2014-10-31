package com.courtpicker.courtpicker;

import java.math.BigDecimal;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

@Component("monthlyFeeCalculator")
@Scope("prototype")
public class MonthlyFeeCalculator {
    public BigDecimal calculateMonthlyFee(Integer nrOfCourts) {
        BigDecimal fee;
        
        switch(nrOfCourts) {
            case 0: fee = new BigDecimal(0); break;
            case 1: fee = new BigDecimal(20); break;
            case 2: fee = new BigDecimal(24); break;
            case 3: fee = new BigDecimal(28); break;
            case 4: fee = new BigDecimal(32); break;
            case 5: fee = new BigDecimal(36); break;
            case 6: fee = new BigDecimal(42); break;
            case 7: fee = new BigDecimal(48); break;
            case 8: fee = new BigDecimal(54); break;
            case 9: fee = new BigDecimal(60); break;
            case 10: fee = new BigDecimal(66); break;
            case 11: fee = new BigDecimal(74); break;
            case 12: fee = new BigDecimal(82); break;
            case 13: fee = new BigDecimal(90); break;
            case 14: fee = new BigDecimal(98); break;
            case 15: fee = new BigDecimal(106); break;
            case 16: fee = new BigDecimal(114); break;
            case 17: fee = new BigDecimal(122); break;
            case 18: fee = new BigDecimal(130); break;
            case 19: fee = new BigDecimal(138); break;
            case 20: fee = new BigDecimal(146); break;
            default: fee = new BigDecimal(146);
        }
        
        return fee;
    }
}
