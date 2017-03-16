/*
 * File name: PopupSwitchDroplet.java
 * 
 * Purpose:
 * 
 * Functions used and called: Name Purpose ... ...
 * 
 * Additional Information:
 * 
 * Development History: Revision No. Author Date 1.0 terryli Jun 14, 2013 ...
 * ... ...
 * 
 * *************************************************
 */

package com.clothing.multisite;

import java.io.IOException;

import javax.servlet.ServletException;

import atg.repository.RepositoryItem;
import atg.servlet.DynamoHttpServletRequest;
import atg.servlet.DynamoHttpServletResponse;
import atg.servlet.DynamoServlet;



public class SitePopupSwitchDroplet extends DynamoServlet {

    private static final String SITE_CONFIGURATION = "siteConfiguration";

    private static final String OUTPUT = "output";

    private static final String TURN_ON_NEWS_LETTER_POPUP = "turnOnNewsLetterPopup";

    private static final String TURN_ON_ABANDON_SHOPPING_CART_POPUP = "turnOnAbandonShoppingCartPopup";

    private static final String TURN_ON_IPAD_USER_POPUP = "turnOnIpadUserPopup";

    private static final String SITE_ID = "siteId";

    @Override
    public void service(DynamoHttpServletRequest pReq, DynamoHttpServletResponse pRes) throws ServletException, IOException {

        Object siteIdObj = pReq.getLocalParameter(SITE_ID);
        if (siteIdObj != null) {
            RepositoryItem siteItem = getSiteItem(siteIdObj.toString());

            if (siteItem != null) {

                Object turnOnNewsLetterPopupObj = siteItem.getPropertyValue(TURN_ON_NEWS_LETTER_POPUP);
                Object turnOnAbandonShoppingCartPopupObj = siteItem.getPropertyValue(TURN_ON_ABANDON_SHOPPING_CART_POPUP);
                Object turnOnIapdUserPopupObj = siteItem.getPropertyValue(TURN_ON_IPAD_USER_POPUP);

                pReq.setParameter(TURN_ON_NEWS_LETTER_POPUP, turnOnNewsLetterPopupObj);
                pReq.setParameter(TURN_ON_ABANDON_SHOPPING_CART_POPUP, turnOnAbandonShoppingCartPopupObj);
                pReq.setParameter(TURN_ON_IPAD_USER_POPUP, turnOnIapdUserPopupObj);
                pReq.serviceLocalParameter(OUTPUT, pReq, pRes);
            }
        }
    }

    private RepositoryItem getSiteItem(final String pSiteId) {

        if (pSiteId != null) {

            RepositoryItem siteItem = null;
            return siteItem;
        }
        return null;
    }
}
