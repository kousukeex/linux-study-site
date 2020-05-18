<?php
    $pdo = new PDO("pgsql:dbname=linuxperson host=localhost port=5432","linuxperson","kousuke");
    $fileid = $_POST["fid"];
    $filepath = $_POST["filepath"];
    $description = $_POST["description"];
    $detail = str_replace("\r\n","<br>",$_POST["detail"]);
    $detail = str_replace("\n","<br>",$detail);

    if(isset($_POST["chunkNo"])){
        $chunkNo = $_POST["chunkNo"];
    }
    if(isset($_POST["title"])){
        $title = $_POST["title"];
    }
    if(isset($_POST["fileDE"])){
        $fileDE = $_POST["fileDE"];
        for($i = 0;$i < count($fileDE);$i++){
            $fileDE[$i] = str_replace("\r\n","<br>",$fileDE[$i]);
            $fileDE[$i] = str_replace("\n","<br>",$fileDE[$i]);
            echo "<br>";
        }

    }

    if(isset($_POST["header"])){
        $header = $_POST["header"];
    }
    if(isset($_POST["data"])){
        $data = $_POST["data"];
        if(count($data) != 0){
            for($i = 0;$i < count($data);$i++){
                if(isset($data[$i])){
                    for($j = 0;$j < count($data[$i]);$j++){
                        $data[$i][$j] = str_replace("\\","&#92;",$data[$i][$j]);
                    }
                }
            }
        }
    }
    $sql = "Update Linuxfile set filepath=:filepath,description = :description,detail = :detail where fid=:fid";
    $sqlother = "insert into Linuxfileinfo values(:fid,:tid,:title,:fileDE)";
    $sqlother2 = "insert into Linuxfiletableheader values(:fid,:tid,:header)";
    $sqlother3 = "insert into Linuxfiletabledata values(:fid,:tid,:col,:row,:data,'F')";
    $sqlother4 = "insert into Linuxfiletabledata values(:fid,:tid,NULL,NULL,:size,'T')";
    $sqlotherd = "delete from Linuxfileinfo where fid=".$fileid;
    $sqlotherd2 = "delete from Linuxfiletableheader where fid=".$fileid;
    $sqlotherd3 = "delete from Linuxfiletabledata where fid=".$fileid;

    $isSuccess = $pdo->prepare($sql)->execute(Array(":fid"=>$fileid,":filepath"=>$filepath,":description"=>$description,":detail"=>$detail));
    if(!$isSuccess){
			header("Location:./fileupdate.php?cid=".$fileid);
	}
	else{
    $otherstmt = $pdo->prepare($sqlother);
    $otherstmt2 = $pdo->prepare($sqlother2);
    $otherstmt3 = $pdo->prepare($sqlother3);
    $otherstmt4 = $pdo->prepare($sqlother4);
    $pdo->query($sqlotherd);
    $pdo->query($sqlotherd2);
    $pdo->query($sqlotherd3);

    for($i=0;$i < count($chunkNo);$i++){
            $otherstmt->execute(array(":fid"=>$fileid,":tid"=>$i,":title"=>$title[$i],":fileDE"=>$fileDE[$i]));
            $headerCSV = "";
            for($j=0;$j < count($header[$i])-1;$j++){
                $headerCSV .= $header[$i][$j].",";
            }
            $headerCSV .= $header[$i][count($header[$i])-1];
            $otherstmt2 -> execute(array(":fid"=>$fileid,":tid"=>$i,":header"=>$headerCSV));
            if(isset($data[$i]) && count($data[$i]) != 0){
                $row = count($header[$i]);
                $col = count($data[$i])/$row;
                $sizestr = $col.",".$row;
                for($j = 0;$j < count($data[$i]);$j++){
                $otherstmt3->execute(array(":fid"=>$fileid,":tid"=>$i,":col"=>floor($j/$row),":row"=>($j%$row),":data"=>$data[$i][$j]));
                }
                $otherstmt4->execute(array(":fid"=>$fileid,":tid"=>$i,":size"=>$sizestr));
            }
           

    }
    echo "<a href=\"./file.php?fid=".$fileid."\">変更が完了しました</a>";
    //header("Location:./command.php?cid=".$commandid);
}    
?> 
