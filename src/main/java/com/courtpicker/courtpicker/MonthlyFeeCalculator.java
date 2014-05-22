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
            case 2: fee = new BigDecimal(25); break;
            case 3: fee = new BigDecimal(30); break;
            case 4: fee = new BigDecimal(33); break;
            case 5: fee = new BigDecimal(37); break;
            case 6: fee = new BigDecimal(41); break;
            case 7: fee = new BigDecimal(47); break;
            case 8: fee = new BigDecimal(52); break;
            case 9: fee = new BigDecimal(56); break;
            case 10: fee = new BigDecimal(62); break;
            case 11: fee = new BigDecimal(69); break;
            case 12: fee = new BigDecimal(75); break;
            case 13: fee = new BigDecimal(81); break;
            case 14: fee = new BigDecimal(86); break;
            case 15: fee = new BigDecimal(93); break;
            case 16: fee = new BigDecimal(101); break;
            case 17: fee = new BigDecimal(110); break;
            case 18: fee = new BigDecimal(119); break;
            case 19: fee = new BigDecimal(127); break;
            case 20: fee = new BigDecimal(135); break;
            default: fee = new BigDecimal(140);
        }
        
        return fee;
    }
}
