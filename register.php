<?php
    $command = null;
    $args = "NULL";
    $description = "NULL";
    $detail = "NULL";
    $option= null;
    $optionDE= null;
    
    //追加分
    $title = null;
    $header = null;
    $data = null;
    $otherDE = null;
    //
    
    $isSuccess = false;
    if(isset($_POST["command"])){
        $command = $_POST["command"];
    }
    if(isset($_POST["args"])){
        $args = $_POST["args"];
    }
    if(isset($_POST["description"])){
        $description = $_POST["description"];
    }
    if(isset($_POST["detail"])){
        $detail = str_replace("\r","<br>",$_POST["detail"]);
        $detail = str_replace("\n","<br>",$detail);
    }
    if(isset($_POST["option"])){
        $option = $_POST["option"];
    }
    if(isset($_POST["optionDE"])){
        $optionDE = $_POST["optionDE"];
    }
    if(isset($_POST["title"])){
        $title = $_POST["title"];
    }
    if(isset($_POST["header"])){
        $header = $_POST["header"];
    }
    if(isset($_POST["data"])){
        $data = $_POST["data"];
        for($i = 0;$i < count($data);$i++){
            for($j = 0;$j < count($data[$i]);$j++){
                $data[$i][$j] = str_replace("\\","&#92;",$data[$i][$j]);
            }
        }
    }
    if(isset($_POST["otherDE"])){
        $otherDE = $_POST["otherDE"];
        for($i = 0;$i < count($otherDE);$i++){
            $otherDE[$i] = str_replace("\r\n","<br>",$otherDE[$i]);
            $otherDE[$i] = str_replace("\r","<br>",$otherDE[$i]);
            $otherDE[$i] = str_replace("\n","<br>",$otherDE[$i]);
        }
    }
    
    $pdo = new PDO("pgsql:dbname=linuxperson host=localhost port=5432","linuxperson","kousuke");
    
    if($command != null){
        $commandsql = "insert into LinuxCommand values(:currentcid ,:command ,:args ,:description , :detail)";
        $optionsql = "insert into LinuxCommandOP values(:currentcid,:oid,:option,:optionDE)";
        $sqlcid = "select * from LinuxCommandCurrentCID;";
        $sqlother = "insert into LinuxCommandOtherChunk values(:cid,:tid,:title,:otherDE)";
        $headerCSV = "";
        $sqlheader = "insert into LinuxCommandOtherChunkTableHeader values(:cid,:tid,:headerCSV)";
        $sqlchunktable = "insert into LinuxCommandOtherChunkTableData values(:cid,:tid,:row,:col,:data,:isSize)";
        
        $cid = $pdo->query($sqlcid)->fetch();
        $otherstmt = $pdo->prepare($sqlother);
        $headerstmt = $pdo->prepare($sqlheader);
        $sqlchunktablestmt = $pdo->prepare($sqlchunktable);

        $sql = $pdo->prepare($commandsql);

        $isSuccess = $sql->execute(array(":currentcid"=>$cid[0],":command"=>$command,":args"=>$args,":description"=>$description,":detail"=>$detail));
		if(!$isSuccess){
			header("Location:./register.php");
		}
		else{
        $sql2 = $pdo->prepare($optionsql);
        
        for($count = 0;$count < count($option);$count++){
            $isSuccess = $sql2->execute(array(':currentcid'=>$cid[0],':oid'=>$count+1,':option'=>$option[$count],':optionDE'=>$optionDE[$count]));
        }

        if($title != null){
            for($i=0;$i < count($title) ; $i++){
                $otherstmt->execute(array(":cid"=>$cid[0],":tid"=>$i,":title"=>$title[$i],":otherDE"=>$otherDE[$i]));
                for($j=0;$j < count($header[$i])-1;$j++){
                    $headerCSV .= $header[$i][$j].",";
                }
                $headerCSV .= $header[$i][count($header[$i])-1];
                $headerstmt->execute(array(":cid"=>$cid[0],":tid"=>$i,":headerCSV"=>$headerCSV));
                for($j=0;$j < count($data[$i]);$j++){
                    $col = $j % count($header[$i]);
                    $row = floor($j / count($header[$i]));
                    $sqlchunktablestmt->execute(array(":cid"=>$cid[0],":tid"=>$i,":row"=>$row,":col"=>$col,":data"=>$data[$i][$j],":isSize"=>'F'));
                }
                $sqlchunktablestmt->execute(array(":cid"=>$cid[0],":tid"=>$i,":row"=>null,":col"=>null,":data"=>(count($data[$i])/count($header[$i])).",".count($header[$i]),":isSize"=>'T'));
            }
        }
        $pdo->query("select nextval('linuxcommandn_cid_seq')");
        $pdo->query("update LinuxCommandCurrentCID set current = currval('linuxcommandn_cid_seq')");
        if($isSuccess){
            echo "登録処理が完了しました<br>";
        }
        
    }
}

?>
<!DOCTYPE html><meta charset="UTF-8">
<html>
    <head>
        <title>Linuxコマンド集</title>
        <link href="style.css" rel="stylesheet">
        <?php
            //phpinfo();
            //$stmt = $pdo->query($sql);
        ?>
        <script src="component.js"></script>
        <script>
        var chunkCount = 0;
        </script>
    </head>
    <body>

        <?php
        
        ?>
        <form name="cmd" action="register.php" method="POST">
            コマンド:<br><input type="text" name="command" required><br>
            引数:<br><input type="text" name="args"><br>
            説明:<br><input type="text" name="description" size="100"><br>
            詳細:<br><textarea name="detail"rows="20" cols="80"></textarea><br>
            オプション:<br>
            <table name="options">
            <tr><th>オプション</th><th>説明</th><th>削除ボタン</th></tr>
            <tr><td><input type="text" name="option[]"></td><td><textarea type="text" name="optionDE[]" rows="8" cols="20"></textarea></td>
            <td><button type="button" name="deleteButton">削除</button></td></tr>
            </table>
            <button type="button" name="addButton">+追加</button>
            <h2>その他の情報</h2>
            <div id="other"></div>
            <button type="button" name="OtherAddBT">+追加</button>
            <br><input type="submit" value="登録" >
        <script>
            //オプション表の削除ボタンのイベントを登録
            deleteButton = document.getElementsByName("deleteButton");
            deleteButtons = [].slice.call(deleteButton);
            deleteButtons[0].addEventListener("click",deleteRow,false);

            var addButton = document.getElementsByName("addButton");
            var OtherAddBT = document.getElementsByName("OtherAddBT");
            var other = document.getElementById("other");
            var optiontable = getTableByName("options");
            var cell = null;
            var optionrow = null;
            var newlement = null;
            var otherElement = null;
            var tableElement = null;
            var trElement = null;
            var cellElement = null;
            var Cell= null;
            
            
            addButton[0].addEventListener("click",function(){
                //cell = addTableRow(optiontable);
                var row = addTableRow(optiontable);
                addCellAndSet(row,"input","text","option[]");
                textarea = addCellAndSet(row,"textarea","","optionDE[]");
                textarea.setAttribute("cols","20");
                textarea.setAttribute("rows","8");
                newelement = addCellAndSet(row,"button","button","deleteButton");
                newelement.addEventListener("click",deleteRow,false)
                newelement.innerHTML = "削除";
                deleteButton = document.getElementsByName("deleteButton");
                deleteButtons = [].slice.call(deleteButton);
            },false);
            
            OtherAddBT[0].addEventListener("click",function(){
                var chunk = addElementandSetAttribute(other,"div","chunkNo",chunkCount);
                var chunkNo = chunk.getAttribute("chunkNo");
                chunk.insertAdjacentHTML('beforeend',"タイトル:");
                otherElement = chunk.appendChild(document.createElement("input"));
                otherElement.setAttribute("type","text");
                otherElement.required = true;
                otherElement.setAttribute("name","title[" + chunkNo +"]");
                chunk.insertAdjacentHTML('beforeend',"<br>説明文:");
                otherElement = chunk.appendChild(document.createElement("textarea"));
                otherElement.setAttribute("name","otherDE[" + chunkNo + "]");
                otherElement.setAttribute("rows","20");
                otherElement.setAttribute("cols","100");
                chunk.insertAdjacentHTML('beforeend',"<br>表:<br>");
                tableElement = chunk.appendChild(document.createElement("table"));
                tableElement.setAttribute("border","1");
                
                trElement = tableElement.insertRow();
                Cell = addCellAndSet(trElement,"button","button",null)
                Cell.innerHTML = "削除";
                Cell.addEventListener("click",CellButton,false);
                trElement = tableElement.insertRow();
                Cell = addCellAndSet(trElement,"input","text","header["+ chunkNo +"][]")
                cellElement = trElement.insertCell();
                Cell = cellElement.appendChild(document.createElement("button"));
                Cell.setAttribute("type","button");
                Cell.innerHTML = "+列追加";
                Cell.addEventListener("click",CellButton,false);
                trElement = tableElement.insertRow();
                cellElement = trElement.insertCell();
                Cell = cellElement.appendChild(document.createElement("input"));
                Cell.setAttribute("type","text");
                Cell.setAttribute("name","data["+chunkNo+"][]");
                cellElement = trElement.insertCell();
                Cell = cellElement.appendChild(document.createElement("button"));
                Cell.setAttribute("type","button");
                Cell.innerHTML = "削除";
                Cell.addEventListener("click",rowDelete,false);
                trElement = tableElement.insertRow();
                cellElement = trElement.insertCell();
                Cell = cellElement.appendChild(document.createElement("button"));
                Cell.setAttribute("type","button");
                Cell.innerHTML = "+行追加";
                Cell.addEventListener("click",CellButton,false);
                //otherElement.setAttribute("type","text");
                //otherElement.setAttribute("name","header[]");
                //otherElement = /other.appendChild(document.createElement("input"));
                //otherElement.setAttribute("type","text");
                //otherElement.setAttribute("name","Data[]");
                otherElement = chunk.appendChild(document.createElement("button"));
                otherElement.setAttribute('type','button');
                otherElement.addEventListener('click',function(){
                    chunk.parentNode.removeChild(chunk);
                    chunkCount--;
                },false);
                otherElement.innerHTML = "削除";
                chunkCount++;
            },false)
            
                function CellButton(event){
                    var chunkNo = event.target.parentNode.parentNode.parentNode.parentNode.parentNode.getAttribute('chunkNo');
                    var trs = event.target.parentNode.parentNode.parentNode.rows;
                    var tra = [].slice.call(trs);
                    if(tra.indexOf(event.target.parentNode.parentNode) == 0){
                        var tds = event.target.parentNode.parentNode.cells;
                        var tda = [].slice.call(tds);
                        var index = tda.indexOf(event.target.parentNode);
                        for(var i=0;i < tra.length-1;i++){
                            tra[i].deleteCell(index);
                        }
                    }
                    
                    else if(tra.indexOf(event.target.parentNode.parentNode) == 1){
                        var table = event.target.parentNode.parentNode.parentNode.parentNode;
                        var tbody =
                        event.target.parentNode.parentNode.parentNode;
                        var tr =
                        event.target.parentNode.parentNode;
                        
                        var cell = tbody.rows[0].insertCell();
                        var Cell2 = cell.appendChild(document.createElement("button"));
                        Cell2.setAttribute("type","button");
                        Cell2.innerHTML = "削除";
                        Cell2.addEventListener("click",CellButton,false);
                        
                        cell = tr.insertCell();
                        var button = event.target;
                        var text= event.target.parentNode.appendChild(document.createElement("input"));
                        var removebutton = null;
                        text.setAttribute("type","text");
                        text.setAttribute("name","header["+chunkNo+"][]");
                        event.target.parentNode.removeChild(event.target);
                        cell.appendChild(button);
                        for(var i=2;i <= trs.length-2;i++){
                            tra[i].deleteCell(tra[i].cells.length-1);
                            cell = tra[i].insertCell();
                            
                            var text= cell.appendChild(document.createElement("input"));
                            text.setAttribute("type","text");
                            text.setAttribute("name","data["+chunkNo+"][]");
                            cell = tra[i].insertCell();
                            Cell = cell.appendChild(document.createElement("button"));
                Cell.setAttribute("type","button");
                Cell.innerHTML = "削除";
                Cell.addEventListener("click",rowDelete,false);
                        }
                    }
                    else if(tra.indexOf(event.target.parentNode.parentNode) == tra.length-1){
                        var table = event.target.parentNode.parentNode.parentNode.parentNode;
                        var tr = table.insertRow(tra.length-1);
                        var tbody = event.target.parentNode.parentNode.parentNode;
                        for(i=0;i < tbody.rows[0].cells.length;i++){
                            var cell = tr.insertCell();
                            var text = cell.appendChild(document.createElement("input"));
                            text.setAttribute("type","text");
                            text.setAttribute("name","data["+chunkNo+"][]");
                        }
                        var cell = tr.insertCell();
                        var Cell = cell.appendChild(document.createElement("button"));
                            Cell.setAttribute("type","button");
                            Cell.innerHTML = "削除";
                            Cell.addEventListener("click",rowDelete,false);
                    }
                }
                            function deleteRow(event){
                optiontable.deleteRow((deleteButtons.indexOf(event.target)+1));
                deleteButton = document.getElementsByName("deleteButton");
                deleteButtons = [].slice.call(deleteButton);
            }

            function rowDelete(event){
                var table = event.target.parentNode.parentNode.parentNode.parentNode;
                var trs = table.rows;
                var tra = [].slice.call(trs);
                var index = tra.indexOf(event.target.parentNode.parentNode);
                table.deleteRow(index);
            }

        </script>
        </form>
	<a href="./index.php">戻る</a>
    </body>
</html>
