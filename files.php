<?php
    $keyword = null;
    $isNeedSearch = false;
    if(isset($_GET["keyword"])){
        $keyword = $_GET["keyword"];
        $isNeedSearch = true;
    }
?>
<link href="style.css" rel="stylesheet">
<title>ファイル一覧</title>
<h3><a href="files.php">Linuxファイルページ</a></h3>
        <p>検索する際は、検索欄にキーワードを入力してください</p>
        <p>ファイルが無い場合<a href="fileregister.php">ここ</a></p>
    <form action="files.php" method="get">
    <input type="text" name="keyword" >
    <input type="submit" value="検索">
    </form>
    <?php if(isset($isNeedSearch)){echo "<p>検索キーワード:<b>".$keyword."</b></p>";}?>
<table>
<?php
    $pdo = new PDO("pgsql:dbname=linuxperson host=localhost port=5432","linuxperson","kousuke");
    $sql = "select * from linuxfile order by fid";
    $sql2 = "select * from linuxfile where filepath like '%".$keyword."%' order by fid";
    $stmt = $pdo->query($sql);
    $searchStmt = $pdo->prepare($sql2);
    echo "<tr><th>FID</th><th>ファイル</th><th>説明</th></tr>"; 
        if($isNeedSearch){
            $searchStmt->execute();
            foreach($searchStmt->fetchAll() as $get){
                printf("<tr><td>%s</td><td><a href=\"./file.php?fid=%s\" target=\"filepage\">%s</a></td><td>%s</td></tr>",$get[0],$get[0],$get[1],$get[2]);
            }
        }
        else{
            foreach($stmt->fetchAll() as $get){
                printf("<tr><td>%s</td><td><a href=\"./file.php?fid=%s\" target=\"filepage\">%s</a></td><td>%s</td></tr>",$get[0],$get[0],$get[1],$get[2]);
            }
        }
    
?> 
</table>
