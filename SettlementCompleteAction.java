package com.internousdev.arizona.action;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.internousdev.arizona.dao.CartInfoDAO;
import com.internousdev.arizona.dao.PurchaseHistoryInfoDAO;
import com.internousdev.arizona.dto.CartInfoDTO;
import com.opensymphony.xwork2.ActionSupport;

public class SettlementCompleteAction extends ActionSupport implements SessionAware {

	private String id;
	private Map<String, Object> session;

	public String execute()  {
		if (!session.containsKey("tempUserId") && !session.containsKey("userId")) {
			return "sessionTimeout";
		}

		int logined = Integer.parseInt(String.valueOf(session.get("logined")));
		if (logined != 1) {
			return "sessionTimeout";
		}

		String result = ERROR;
		try{

		String userId = session.get("userId").toString();

		CartInfoDAO cartInfoDAO = new CartInfoDAO();
		List<CartInfoDTO> cartInfoDTOList = new ArrayList<CartInfoDTO>();
			cartInfoDTOList = cartInfoDAO.getCartInfoDTOlist(userId);

		PurchaseHistoryInfoDAO purchaseHistoryDAO = new PurchaseHistoryInfoDAO();
		int count = 0;
		for (CartInfoDTO dto : cartInfoDTOList) {
			count += purchaseHistoryDAO.registPurchaseHistoryInfo(userId, dto.getProductId(), dto.getProductCount(),
					dto.getPrice(),Integer.parseInt(id));
		}

		if (count > 0) {
				count = cartInfoDAO.deleteAll(String.valueOf(session.get("userId")));
			if (count > 0) {
				result = SUCCESS;
			}
		}

		return result;
		}catch(Exception e){
			e.printStackTrace();
		}
		return result;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Map<String, Object> getSession() {
		return session;
	}

	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

}
