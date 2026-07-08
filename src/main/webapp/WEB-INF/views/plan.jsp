<%-- /WEB-INF/views/plan.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AI 맞춤형 2주 학습 계획기</title>
    <!-- Google Fonts: Outfit & Noto Sans KR -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700;900&family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --bg-color: #0b0f19;
            --card-bg: rgba(22, 28, 45, 0.6);
            --card-border: rgba(255, 255, 255, 0.08);
            --primary: #6366f1;
            --primary-hover: #4f46e5;
            --secondary: #ec4899;
            --text-main: #f8fafc;
            --text-muted: #94a3b8;
            --accent: #10b981;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Outfit', 'Noto Sans KR', sans-serif;
            background-color: var(--bg-color);
            background-image: 
                radial-gradient(at 0% 0%, rgba(99, 102, 241, 0.15) 0px, transparent 50%),
                radial-gradient(at 100% 100%, rgba(236, 72, 153, 0.15) 0px, transparent 50%);
            color: var(--text-main);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            overflow-x: hidden;
        }

        .container {
            width: 100%;
            max-width: 640px;
            background: var(--card-bg);
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            border: 1px solid var(--card-border);
            border-radius: 24px;
            padding: 40px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            animation: fadeIn 0.8s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .header {
            text-align: center;
            margin-bottom: 35px;
        }

        .logo-badge {
            display: inline-block;
            padding: 6px 14px;
            border-radius: 99px;
            background: rgba(99, 102, 241, 0.1);
            border: 1px solid rgba(99, 102, 241, 0.2);
            color: #818cf8;
            font-size: 0.85rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.1em;
            margin-bottom: 15px;
        }

        h1 {
            font-size: 2.25rem;
            font-weight: 800;
            background: linear-gradient(135deg, #a5b4fc 0%, #f472b6 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 10px;
            letter-spacing: -0.02em;
        }

        .subtitle {
            color: var(--text-muted);
            font-size: 0.95rem;
            font-weight: 400;
        }

        .form-group {
            position: relative;
            margin-bottom: 25px;
        }

        input {
            width: 100%;
            padding: 16px 20px;
            border-radius: 16px;
            background: rgba(15, 23, 42, 0.6);
            border: 1.5px solid var(--card-border);
            color: var(--text-main);
            font-family: inherit;
            font-size: 1rem;
            outline: none;
            transition: all 0.25s ease;
        }

        input:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.15);
            background: rgba(15, 23, 42, 0.8);
        }

        input::placeholder {
            color: #475569;
        }

        button {
            width: 100%;
            padding: 16px;
            border-radius: 16px;
            border: none;
            background: linear-gradient(135deg, var(--primary) 0%, #4f46e5 100%);
            color: white;
            font-family: inherit;
            font-size: 1.05rem;
            font-weight: 700;
            cursor: pointer;
            box-shadow: 0 10px 20px rgba(99, 102, 241, 0.2);
            transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px;
        }

        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 24px rgba(99, 102, 241, 0.35);
        }

        button:active {
            transform: translateY(0);
        }

        /* Loading Spinner */
        .spinner {
            display: none;
            width: 22px;
            height: 22px;
            border: 3px solid rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            border-top-color: white;
            animation: spin 1s ease-in-out infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        /* Result Section */
        .result-container {
            margin-top: 35px;
            background: rgba(15, 23, 42, 0.4);
            border: 1px solid var(--card-border);
            border-radius: 20px;
            padding: 30px;
            animation: slideUp 0.6s cubic-bezier(0.16, 1, 0.3, 1) both;
        }

        @keyframes slideUp {
            from { opacity: 0; transform: translateY(15px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .result-header {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 1.1rem;
            font-weight: 700;
            color: #a5b4fc;
            margin-bottom: 20px;
            padding-bottom: 12px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
        }

        .result-header svg {
            color: var(--secondary);
            fill: none;
            stroke: currentColor;
            stroke-width: 2;
        }

        .result-body {
            font-size: 0.98rem;
            line-height: 1.7;
            color: #cbd5e1;
            white-space: pre-wrap;
        }

        .result-body p {
            margin-bottom: 12px;
        }

        .result-body strong {
            color: #f1f5f9;
            font-weight: 700;
        }

        .result-body ul {
            list-style-type: none;
            margin-top: 8px;
            margin-bottom: 16px;
        }

        .result-body li {
            position: relative;
            padding-left: 20px;
            margin-bottom: 8px;
        }

        .result-body li::before {
            content: "•";
            position: absolute;
            left: 5px;
            color: var(--primary);
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <span class="logo-badge">NVIDIA NIM • DEEPSEEK</span>
            <h1>AI 2주 학습 계획기</h1>
            <p class="subtitle">배우고 싶은 과목을 입력하면 맞춤형 계획을 설계해 드립니다.</p>
        </div>

        <form id="planForm" method="post">
            <div class="form-group">
                <input id="subjectInput" name="subject" placeholder="예: Spring Boot, Rust, 머신러닝" required autocomplete="off">
            </div>
            <button type="submit" id="submitBtn">
                <span class="spinner" id="btnSpinner"></span>
                <span id="btnText">계획 짜기</span>
            </button>
        </form>

        <c:if test="${not empty plan}">
            <div class="result-container" id="resultContainer">
                <div class="result-header">
                    <svg width="20" height="20" viewBox="0 0 24 24">
                        <path d="M12 2L2 7l10 5 10-5-10-5zM2 17l10 5 10-5M2 12l10 5 10-5"/>
                    </svg>
                    <span>추천 2주 학습 계획</span>
                </div>
                <div class="result-body" id="resultBody"><c:out value="${plan}"/></div>
            </div>
        </c:if>
    </div>

    <script>
        document.getElementById('planForm').addEventListener('submit', function(e) {
            const btn = document.getElementById('submitBtn');
            const spinner = document.getElementById('btnSpinner');
            const text = document.getElementById('btnText');
            const input = document.getElementById('subjectInput');

            if (input.value.trim() !== '') {
                btn.style.pointerEvents = 'none';
                btn.style.opacity = '0.8';
                spinner.style.display = 'inline-block';
                text.textContent = 'AI 분석 및 설계 중...';
            }
        });

        // Simple Markdown parsing for visual polish
        window.addEventListener('DOMContentLoaded', () => {
            const bodyEl = document.getElementById('resultBody');
            if (bodyEl) {
                let text = bodyEl.innerHTML;
                
                // Replace double asterisks with bold tag
                text = text.replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>');
                
                // Replace bullet points (e.g. • or - or *) at the beginning of a line
                text = text.replace(/(?:^|\n)(?:•|-|\*)\s*(.*?)(?=\n|$)/g, '<li>$1</li>');
                
                // Wrap list items in ul
                text = text.replaceAll('<li>', '<ul><li>').replaceAll('</li>', '</li></ul>');
                // Clean up nested/sequential list elements
                text = text.replaceAll('</ul><ul>', '');
                
                bodyEl.innerHTML = text;
            }
        });
    </script>
</body>
</html>
