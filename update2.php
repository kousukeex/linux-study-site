<?php
    $pdo = new PDO("pgsql:dbname=linuxperson host=localhost port=5432","linuxperson","kousuke");
    $commandid = $_POST["cid"];
    $command = $_POST["command"];
    $args = $_POST["args"];
    $description = $_POST["description"];
    $detail = str_replace("\r\n","<br>",$_POST["detail"]);
    $detail = str_replace("\n","<br>",$detail);
    $option = $_POST["option"];
    $optionDE = $_POST["optionDE"];

    if(isset($_POST["chunkNo"])){
        $chunkNo = $_POST["chunkNo"];
    }
    if(isset($_POST["title"])){
        $title = $_POST["title"];
    }
    if(isset($_POST["otherDE"])){
        $otherDE = $_POST["otherDE"];
        for($i = 0;$i < count($otherDE);$i++){
            $otherDE[$i] = str_replace("\r\n","<br>",$otherDE[$i]);
            $otherDE[$i] = str_replace("\n","<br>",$otherDE[$i]);
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
    $sql = "Update LinuxCommand set command=:command,args=:args,description = :description,detail = :detail where cid=:cid";
    $sql2 = "delete from LinuxCommandOP where cid=".$commandid;
    $sql3 = "insert into LinuxCommandOP values(:cid,:oid,:option,:optionDE)";
    $sqlother = "insert into LinuxCommandOtherChunk values(:cid,:tid,:title,:otherDE)";
    $sqlother2 = "insert into LinuxCommandOtherChunkTableHeader values(:cid,:tid,:header)";
    $sqlother3 = "insert into LinuxCommandOtherChunkTableData values(:cid,:tid,:col,:row,:data,'F')";
    $sqlother4 = "insert into LinuxCommandOtherChunkTableData values(:cid,:tid,NULL,NULL,:size,'T')";
    $sqlotherd = "delete from LinuxCommandOtherChunk where cid=".$commandid;
    $sqlotherd2 = "delete from LinuxCommandOtherChunkTableHeader where cid=".$commandid;
    $sqlotherd3 = "delete from LinuxCommandOtherChunkTableData where cid=".$commandid;

    $isSuccess = $pdo->prepare($sql)->execute(Array(":command"=>$command,":args"=>$args,":description"=>$description,":detail"=>$detail,":cid"=>$commandid));
    if(!$isSuccess){
			header("Location:./update.php?cid=".$commandid);
	}
	else{
    $pdo->query($sql2);
    $stmt = $pdo->prepare($sql3);
    $otherstmt = $pdo->prepare($sqlother);
    $otherstmt2 = $pdo->prepare($sqlother2);
    $otherstmt3 = $pdo->prepare($sqlother3);
    $otherstmt4 = $pdo->prepare($sqlother4);
    $pdo->query($sqlotherd);
    $pdo->query($sqlotherd2);
    $pdo->query($sqlotherd3);
    for($i=0;$i<count($option);$i++){
        $stmt->execute(array(":cid"=>$commandid,":oid"=>$i,":option"=>$option[$i],":optionDE"=>$optionDE[$i]));
    }

    for($i=0;$i < count($chunkNo);$i++){
            $otherstmt->execute(array(":cid"=>$commandid,":tid"=>$i,":title"=>$title[$i],":otherDE"=>$otherDE[$i]));
            $headerCSV = "";
            for($j=0;$j < count($header[$i])-1;$j++){
                $headerCSV .= $header[$i][$j].",";
            }
            $headerCSV .= $header[$i][count($header[$i])-1];
            $otherstmt2 -> execute(array(":cid"=>$commandid,":tid"=>$i,":header"=>$headerCSV));
            if(isset($data[$i]) && count($data[$i]) != 0){
                $row = count($header[$i]);
                $col = count($data[$i])/$row;
                $sizestr = $col.",".$row;
                for($j = 0;$j < count($data[$i]);$j++){
                $otherstmt3->execute(array(":cid"=>$commandid,":tid"=>$i,":col"=>floor($j/$row),":row"=>($j%$row),":data"=>$data[$i][$j]));
                }
                $otherstmt4->execute(array(":cid"=>$commandid,":tid"=>$i,":size"=>$sizestr));
            }
           

    }
    echo "<a href=\"./command.php?cid=".$commandid."\">変更が完了しました</a>";
    //header("Location:./command.php?cid=".$commandid);
}    
?> 
