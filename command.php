<?php
    $commandid = $_GET['cid'];
    $sql = "select command,args,detail,description from LinuxCommand where cid=".$commandid;
    $sqlmore = "select O.option,O.description from LinuxCommand C,LinuxCommandOP O where O.cid=C.cid and O.cid=".$commandid;
    $sqlchunk = "select CTOC.TID,CTOC.Title,CTOC.Description,CTH.header from LinuxCommandOtherChunk CTOC,LinuxCommandOtherChunkTableHeader CTH,LinuxCommand C where C.cid = CTOC.cid and C.cid = CTH.cid and CTOC.tid = CTH.tid and C.cid=".$commandid;
    $sqlchunk2 = "select col,row,data,issize,tid from linuxcommandotherchunktabledata where issize = 'F' and cid = :cid and tid = :tid order by tid asc,col asc,row asc";
    $sqlchunk3 = "select Data from linuxCommandOtherchunkTableData where issize = 'T' and cid=:cid and tid = :tid";
    $sqlcount = "select count(tid) from LinuxCommandOtherchunk where cid =".$commandid;
    $sqlindex = "select Title from linuxcommandotherchunk where cid=".$commandid;
    $pdo = new PDO("pgsql:dbname=linuxperson host=localhost port=5432","linuxperson","kousuke");
    $commandinfo = $pdo->query($sql)->fetch();
    $stmt = $pdo->query($sqlmore);
    $stmt2 = $pdo->query($sqlchunk);
    $stmt3 = $pdo->prepare($sqlchunk2);
    $stmt4 = $pdo->prepare($sqlchunk3);
    $chunkcount = $pdo->query($sqlcount)->fetch();
    $chunkindex = $pdo->query($sqlindex)->fetchAll();
    $currentCount = 0;
?>
<!DOCTYPE html><meta charset="UTF-8">
<html>
    <head>
        <title>Linuxコマンド -<?php echo $commandinfo[0]?></title>
        <link href="style.css" rel="stylesheet">
    </head>
    <body>
        <?php
        //編集専用
        echo "<a href=\"./update.php?cid=".$commandid."\" target=\"editer\">編集</a>";

        //コマンド名表示
        echo "<h1>".$commandinfo[0]."コマンド</h1>";

        //コマンド表示
        echo "<p>".$commandinfo[0]." ".$commandinfo[1]."</p>";

        //簡単な説明
        echo "<b>".$commandinfo[3]."</b><br>";

        //詳細出力
        echo $commandinfo[2]."<br>";

        //オプション出力
        echo "<table class=\"\">";
        echo "<tr><th>オプション</th><th>説明</th></tr>";
        foreach($stmt->fetchall() as $get){
            printf("<tr><td>%s</td><td>%s</td></tr>",$get[0],$get[1]);
        }
        echo "</table>";

        echo "詳細";
        echo "<ul>";
        if($chunkcount[0] > 2){
            for($i=0;$i < $chunkcount[0];$i++){
                echo "<li><a href=\"#tid".($i+1)."\">".$chunkindex[$i][0]."</a></li>";
            }
        }        
        echo "</ul>";

        //その他を表示
        //error_reporting(E_ALL);
        foreach($stmt2->fetchAll() as $gettid){
            if($chunkcount[0] > 2){
                $currentCount++;
                echo "<h1><a name=\"tid".$currentCount."\">".$gettid[1]."</a></h1>";
            }
            else{
                echo "<h1>".$gettid[1]."</h1>";
            }

            echo "<div>".$gettid[2]."</div>";
            $stmt3 -> bindParam(':cid' ,$commandid);
            $stmt3 -> bindParam(':tid',$gettid[0]);
            $stmt3 -> execute();
            $stmt4 -> execute(Array(":cid"=>$commandid,":tid"=>$gettid[0]));
            $headers = explode(",",$gettid[3]);
            $size = $stmt4->fetch();
            $sizes = explode(",",$size[0]);

            if($headers[0] != " "){
                echo "<table>";
                echo "<tr>";
                for($i = 0;$i < count($headers);$i++){
                    printf("<th>%s</th>",$headers[$i]);
                }
                echo "</tr>";
                for($i = 0;$i < $sizes[0];$i++){
                    echo "<tr>";
                    for($j = 0;$j < $sizes[1];$j++){
                        printf("<td>%s</td>",$stmt3->fetch()[2]);
                    }
                    echo "</tr>";
                }
                echo "</table>";
            }
        }
        
        //関連ファイル(同じく存在する場合)
        
        
        ?>

    </body>
</html>
