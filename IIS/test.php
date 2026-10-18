
<!DOCTYPE html>
<html>
<head>
    <title>Command Interface</title>
</head>
<body>
    <h2>Command Interface</h2>

    <form method="POST">
        <input type="text" name="command"
               placeholder="Enter a command" required>
        <button type="submit">Run</button>
    </form>

    <pre><?php
    if ($_SERVER["REQUEST_METHOD"] === "POST") {
        $command = $_POST["command"] ?? "";
        echo htmlspecialchars($command, ENT_QUOTES, "UTF-8");
    }
    ?></pre>
</body>
</html>

