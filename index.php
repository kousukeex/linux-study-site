<!DOCTYPE html><meta charset="UTF-8">
<html>
    <head>
        <title>LinuxDB</title>
        <link href="style.css" rel="stylesheet">
        <?php
            //ページ取得するためにDBを接続して取得する
            $pdo = new PDO("pgsql:dbname=linuxperson host=localhost port=5432","linuxperson","kousuke");
            $pageSql = "select pid,pagename from LinuxCommandPage"; //リンク用とページ名の取得
            $pageData = $pdo->query($pageSql);
        ?>

    </head>
    <body>
        <h3>Linuxデータベース</h3>
        <p>Linuxに関する情報をここに収集して掲載しております</p>
        <a href="./search.php">コマンド</a> <a href="./files.php">ファイル</a>
        <table>
        <?php

        foreach($pageData->fetchAll() as $getPage){
            echo "<a href=\"page.php?pid=".$getPage["pid"]."\">".$getPage["pagename"]."</a><br>";
        }
        ?>
        </table>
        <!---　Linuxコマンドページ項目の表示-->

        <!---　終了-->
        <a href="./pageRegister.php">ページ作成</a>
        <a href="./register.php">コマンド登録</a>
        <a href="./fileregister.php">ファイル登録</a><br>
    </body>
</html>
