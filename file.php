<?php
    $fid = $_GET['fid'];
    $sql = "select filepath,description,detail from Linuxfile where fid=".$fid;
    $sqlinfo = "select LFI.tid,LFI.title,LFI.description from linuxfileinfo LFI,linuxfile LF where LF.fid = LFI.fid and LFI.fid=:fid and LFI.tid=:tid";
    $sqltidmax = "select MAX(tid) from linuxfileinfo where fid=:fid";
    $sqlheader = "select tid,header from linuxfiletableheader where fid=:fid and tid=:tid";
    $sqldata = "select tid,row,col,data,issize from linuxfiletabledata where fid=:fid and tid=:tid and issize='F'";
    $sqlsizedata = "select data from linuxfiletabledata where fid=:fid and tid=:tid and issize='T'";
    $pdo = new PDO("pgsql:dbname=linuxperson host=localhost port=5432","linuxperson","kousuke");
    $stmt = $pdo->prepare($sql);
    $stmt2 = $pdo->prepare($sqlinfo);
    $stmt3 = $pdo->prepare($sqlheader);
    $stmt4 = $pdo->prepare($sqldata);
    $stmt5 = $pdo->prepare($sqltidmax);
    $sizestmt = $pdo->prepare($sqlsizedata);

    $fileinfo = $pdo->query($sql)->fetch();
    $moreinfo = $pdo->prepare($sqlinfo);
    $headerinfo = $pdo->prepare($sqlheader);
    $datainfo = $pdo->prepare($sqldata);
?>
<!DOCTYPE html><meta charset="UTF-8">
<html>
    <head>
        <title>Linuxファイル -<?php echo $fileinfo[0]?></title>
        <link href="style.css" rel="stylesheet">
    </head>
    <body>
        <?php
        //編集専用
        echo "<a href=\"./fileupdate.php?fid=".$fid."\" target\"editer\">編集</a>";
        
        //コマンド名表示
        echo "<h1>".$fileinfo[0]."</h1>";
        
        echo "<b>".$fileinfo[1]."</b><br>";

        //詳細出力
        echo $fileinfo[2]."<br>";

        //ファイルに関する情報を表示
        $stmt5->execute(Array(":fid"=>$fid));
        $max = $stmt5->fetch();
        for($i = 0;$i <= $max[0];$i++){
            $moreinfo -> execute(Array(":fid"=>$fid));
            $stmt2 -> execute(Array(":fid"=>$fid,":tid"=>$i));
            foreach($stmt2 -> fetchAll() as $get){
                printf("<div chunkNo=%s>",$get[0]);
                printf("<h3>%s</h3>",$get[1]);
                printf("<div>%s</div>",$get[2]);
                $stmt3 -> execute(Array(":fid"=>$fid,":tid"=>$i));
                if($stmt3->rowCount() >= 1){
                    echo "<table></tr>";
                    $header = $stmt3 -> fetch();
                    for($j = 0,$headarray = explode(",",$header[1]);$j < count($headarray);$j++){
                        printf("<th><b>%s</b></th>",$headarray[$j]);
                    }
                    $stmt4 -> execute(Array(":fid"=>$fid,":tid"=>$i));
                    $sizestmt -> execute(Array(":fid"=>$fid,":tid"=>$i));
                    $size = $sizestmt->fetch();
                    $sizes = explode(",",$size[0]);
                    for($col=0;$col < $sizes[0];$col++){
                        echo "<tr>";
                        for($row=0;$row < $sizes[1];$row++){
                            $datas = $stmt4->fetch();
                            printf("<td>%s</td>",$datas[3]);
                        }
                        echo "</tr>";
                    }
                }
                    echo "</tr>";
                }
                echo "</div>";
            }

        ?>

    </body>
</html>
 
