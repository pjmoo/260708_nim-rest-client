<%-- /WEB-INF/views/plan.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>학습 계획을 짜드립니다</title>
</head>
<body>
<h1>학습 계획 짜드림</h1>
<form method="post">
    <input name="subject" placeholder="과목을 입력하세요"><br>
    <button>계획 짜기</button>
</form>
<section>
    <c:out value="${plan}"/>
</section>
</body>
</html>
