<%@page import="util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%

	String player ="";

	String totalNum = (String)session.getAttribute("totalNum");  // 残数用の変数。仮で25をセットしている。必要に応じて変更
	if(Utility.isNullOrEmpty(totalNum)){
		totalNum = "25";
	}
	int totalNumInt = Integer.parseInt(totalNum);
	
	String def = request.getParameter("num");
	if(Utility.isNullOrEmpty(def)){
	}else{
		//1～3で決定を押したときの処理
		int defInt = Integer.parseInt(def);
		totalNumInt -= defInt;
		totalNum = String.valueOf(totalNumInt);
		session.setAttribute("totalNum",totalNum);	
	}
	
	String stoneDisplay = Utility.getStoneDisplayHtml(totalNumInt);
	
	if(totalNumInt <= 0){
		response.sendRedirect("finish.jsp");
	}

	if(!Utility.isNullOrEmpty(def)){
		player = (String)session.getAttribute("player");
		if("A".equals(player)){
			session.setAttribute("player","B");
		}else{
			session.setAttribute("player","A");
		}
	}

	if(Utility.isNullOrEmpty(player)){
		player = "A";
		if("A".equals(player)){
			session.setAttribute("player","B");
		}else{
			session.setAttribute("player","A");
		}
	}

	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Java基礎課題</title>
<link href="css/styles.css" rel="stylesheet">
</head>
<body>
  <h1>石取りゲーム</h1>

  <div class="info">
    <h2>
      残り：<%= totalNumInt %>個
    </h2>
    <p class="stone">
      <%= stoneDisplay %>
    </p>
  </div>
  <div class="info">
    <h2>
      プレイヤー<%= player %>の番
    </h2>

    <form action="play.jsp">
      <p>
        石を
        <input type="number" name="num" min="1" max="3">
        個取る<br> ※1度に3個取れます。
      </p>
      <button class="btn" type="submit">決定</button>
    </form>
  </div>
</body>
</html>