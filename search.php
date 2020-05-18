<?php
    $keyword = ""; //検索キーワード
    $isNeedSearch = false; //検索を必要とするフラグ　キーワードがある場合のみtrue

    if(isset($_GET["keyword"])){ //検索キーワードが存在するなら代入を行う
        $keyword = $_GET["keyword"];
        $isNeedSearch = true;
    }
?>
<!DOCTYPE html>
<html>
    <head>
        <title>Linuxコマンド集</title>
        <meta http-equiv="content-type" charset="Shift_JIS">
        <link href="style.css" rel="stylesheet">
        <?php
            $pdo = new PDO("pgsql:dbname=linuxperson host=localhost; port=5432","linuxperson","kousuke");
            $commandSql = "select cid,command,description from LinuxCommand order by cid asc";
            $searchSql = "select cid,command,description from LinuxCommand where command like '%".$keyword."%' order by cid asc";
            $commandData = $pdo->query($commandSql);   
            $searchStmt = $pdo->prepare($searchSql);
        ?>

    </head>
    <body>
        <h3><a href="search.php">Linuxコマンドページ</a></h3>
        <p>検索する際は、検索欄にキーワードを入力してください</p>
        <p>コマンドが無い場合<a href="register.php">ここ</a></p>
        <form action="search.php" method="get">
            <input type="text" name="keyword" >
            <input type="submit" value="検索">
        </form>
        <?php if(isset($isNeedSearch)){echo "<p>検索キーワード:<b>".$keyword."</b></p>";}?>
        <table>
            <tr><th>CID</th><th>コマンド名</th><th>説明</th></tr>
        <?php
            if($isNeedSearch){
                $searchStmt->execute();
                foreach($searchStmt->fetchAll() as $get){
                    printf("<tr><td>%s</td><td><a href=\"./command.php?cid=%s\" target=\"commandpage\">%s</a></td><td>%s</td></tr>",$get[0],$get[0],$get[1],$get[2]);
                }
            }
            else{
                foreach($commandData->fetchAll() as $get){
                    printf("<tr><td>%s</td><td><a href=\"./command.php?cid=%s\" target=\"commandpage\">%s</a></td><td>%s</td></tr>",$get[0],$get[0],$get[1],$get[2]);
                }
            }
        ?>
        </table>

    </body>
</html>
