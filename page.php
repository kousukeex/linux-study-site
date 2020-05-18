<?php
    $pageid = $_GET['pid'];
    $pdo = new PDO("pgsql:dbname=linuxperson host=localhost port=5432","linuxperson","kousuke");
    $sql = "select C.cid,C.command,C.args,C.description from LinuxCommandPage P,LinuxCommand C,LinuxCommandPageRelation R where P.pid = R.pid and R.pid=".$pageid;
    $sql2 = "select F.fid,F.filepath,F.description from linuxcommandpage P,linuxfile F,linuxfilepagerelation FR where F.fid = FR.fid and FR.pid = P.pid and P.pid = ".$pageid;
    $sqlDE = "select pagename,description from LinuxCommandPage where pid=".$pageid;
    $stmt = $pdo->query($sql);
    $stmt2 = $pdo->query($sql2);
    $pageinfo = $pdo->query($sqlDE)->fetch();
    
?>
<!DOCTYPE html><meta charset="UTF-8">
<html>
    <head>
        <title>Linux -<?php echo $pageinfo[0]?></title>
        <link href="style.css" rel="stylesheet">
        <?php
            //phpinfo();

        ?>

    </head>
    <body>
        <?php
        //ページ名
        echo "<h1>".$pageinfo[0]."</h1><br>";
        ?>
        目次
        <ul>
            <li><a href="#command">コマンド</a></li>
            <li><a href="#files">ファイル</a></li>
        </ul>
        <?php

        //説明文出力
        echo "<h4>説明</h4><br>";
        echo "<div>";
        echo $pageinfo[1]."<br>";
        echo "</div>";

        //コマンド出力
        echo "<a name=\"command\"><h3>コマンド</h3></a>";
        echo "<table>";
        echo "<tr><th>コマンド</th><th>引数</th><th>説明</th></tr>";
        foreach($stmt->fetchall() as $get){
            printf("<tr><td><a href=\"command.php?cid=%s\">%s</a></td><td>%s</td><td>%s</td></tr>",$get[0],$get[1],$get[2],$get[3]);
        }
        echo "</table>";

        echo "<a name=\"files\"><h3>ファイル</h3></a><br>";
        echo "<table>";
        echo "<tr><th>ファイル</th><th>説明</th></tr>";
        foreach($stmt2->fetchall() as $get){
            printf("<tr><td><a href=\"file.php?fid=%s\">%s</a></td><td>%s</td></tr>",$get[0],$get[1],$get[2]);
        }
        echo "</table>";

        ?>
        <!---　Linuxコマンドページ項目の表示-->
        

        <!---　終了-->
    </body>
</html>
