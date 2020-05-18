<?php
    $fileid = $_GET["fid"];
?>
<!DOCTYPE html><meta charset="UTF-8">
<html>
    <head>
        <title>Linuxコマンド集</title>
        <link href="style.css" rel="stylesheet">
        <?php
            $pdo = new PDO("pgsql:dbname=linuxperson host=localhost port=5432","linuxperson","kousuke");
            $sql = "select filepath,description,detail from LinuxFile where fid=".$fileid;
            $sqlfileinfo = "select FO.tid,FO.title,FO.description,FTH.header
            from
            LinuxFile F,LinuxFileinfo FO,Linuxfiletableheader FTH
            where F.fid=".$fileid." and F.fid=FO.fid and FO.fid = FTH.fid and FO.tid = FTH.tid";
            $sqlTableData = "select col,row,data,issize,tid from linuxfiletabledata where issize = 'F' and fid = :fid and tid = :tid order by tid asc,col asc,row asc";
            $sqlTableSize = "select Data from LinuxfileTableData where tid = :tid and issize = 'T' and fid= :fid";
            $sqlInfoMaxCount = "select MAX(tid) from Linuxfileinfo where fid=".$fileid;
            $sqlfileinfostmt = $pdo->query($sqlfileinfo); 
            $sqlOTDstmt = $pdo->prepare($sqlTableData);
            $sqlOTSstmt = $pdo->prepare($sqlTableSize);
            $chunkCountMax = $pdo->query($sqlInfoMaxCount)->fetch();

            $stmt = $pdo->query($sql);
            $fileinfo = $stmt->fetch();
            
        ?>

    </head>
    <body>
        <form action="fileupdate2.php" method="POST">
            <?php
                printf("<input type=\"hidden\" name=\"fid\" value=\"%s\">",$fileid);
            ?>
            ファイルパス:<br><input type="text" name="filepath" value=<?php echo "\"".$fileinfo[0]."\"";?> required><br>
            説明:<br><input type="text" name="description" value=<?php echo "\"".$fileinfo[1]."\"";?>><br>
            詳細:<br><textarea name="detail" rows="20" cols="80"><?php echo $fileinfo[2]?></textarea><br>
            オプション:<br>
            <button type="button" name="addButton">+追加</button>
            <h2>その他の情報</h2>
            <div id="other">
                <?php
                    foreach($sqlfileinfostmt->fetchAll() as $sqlotherinfo){
                        printf("<div chunkNo=\"%s\">",$sqlotherinfo[0]);
                        printf("タイトル:<input type=\"text\" name=\"title[%s]\" value=\"%s\" required><br>",$sqlotherinfo[0],$sqlotherinfo[1]);
                        printf("説明文:<textarea name=\"fileDE[%s]\" rows=\"20\" cols=\"80\">%s</textarea>",$sqlotherinfo[0],$sqlotherinfo[2]);
                        echo "<br>表:<br>";
                        echo "<table border=\"1\">";
                        $headerstr = explode(",",$sqlotherinfo[3]);
                        echo "<tr>";
                        for($i = 0;$i < count($headerstr);$i++){
                            echo "<td><button type=\"button\" name=\"Button\">削除</td>";
                        }
                        echo "</tr>";
                        
                        echo "<tr>";
                        for($i = 0;$i < count($headerstr);$i++)
                            printf("<td><input type=\"text\" name=\"header[%s][]\" value=\"%s\"></td>",$sqlotherinfo[0],$headerstr[$i]);
                            
                        echo "<td><button type=\"button\" name=\"Button\">+列追加</td>";
                        echo "</tr>";
                        
                        $sqlOTSstmt -> execute(Array(":tid"=>$sqlotherinfo[0],":fid"=>$fileid));
                        $sizeStr = $sqlOTSstmt->fetch();
                        
                        $limit = explode(",",$sizeStr[0]); //[0] col [1] row
                        $colinfo = null;
                        $count = 0;

                        $sqlOTDstmt -> execute(Array(":fid"=>$fileid,":tid"=>$sqlotherinfo[0]));
                        foreach($sqlOTDstmt -> fetchAll() as $sqlOTDinfo){
                                if($sqlOTDinfo[1] == 0){
                                    echo "<tr>";
                                }
                                if($sqlOTDinfo[1] < $limit[1]){
                                printf("<td><input type=\"text\" name=\"data[%s][]\" value=\"%s\"></td>",$sqlOTDinfo[4],$sqlOTDinfo[2]);
                                }
                                if($sqlOTDinfo[1] == $limit[1]-1){
                                printf("<td><button name=\"rowdelButton\">削除</button></td>",$sqlOTDinfo[4],$sqlOTDinfo[2]);
                                echo "</tr>";
                                }
                        }
                        echo "<tr><td><button type=\"button\" name=\"Button\">+行追加</button></td></tr>";
                        echo "</table>";
                        echo "<input type=\"hidden\" name=\"chunkNo[]\" value=\"".$sqlotherinfo[0]."\">";
                        echo "<button type=\"button\" name=\"deleteoBT\">削除</button>";
                        echo "</div>";
                    }
                ?>
            </div>
            <button type="button" name="OtherAddBT">+追加</button>
            <script>
            var chunkCount = <?php if($chunkCountMax[0]==null){echo -1;}else{echo $chunkCountMax[0];}?>;
            var addButton = document.getElementsByName("addButton");
            var Button = document.getElementsByName("Button");
            var rowdelButton = document.getElementsByName("rowdelButton");
            var deleteoBT = document.getElementsByName("deleteoBT");
            var OtherAddBT = document.getElementsByName("OtherAddBT");
            var other = document.getElementById("other");
            var options = document.getElementsByName("options");
            var cell = null;
            var optionrow = null;
            var newlement = null;
            var otherElement = null;
            var tableElement = null;
            var trElement = null;
            var cellElement = null;
            var Cell= null;
            
            Button.forEach(function(BTobj){
                BTobj.addEventListener("click",CellButton,false);
            });
            rowdelButton.forEach(function(BTobj){
                BTobj.addEventListener("click",rowDelete,false);
            });
            deleteoBT.forEach(function(BTobj){
                BTobj.addEventListener("click",function(){
                    event.target.parentNode.parentNode.removeChild(event.target.parentNode);
                    chunkCount--;
                    var chunks = document.getElementById("other");
                    var chunkschildren = [].slice.call(chunks.children);
                    for(var i = 0;i < chunkschildren.length;i++){
                        console.log(chunkschildren[i].children[4]);
                        chunkschildren[i].setAttribute('chunkNo',i);
                        chunkschildren[i].children[0].setAttribute('name',"title["+i+"]");
                        chunkschildren[i].children[2].setAttribute('name',"otherDE["+i+"]");
                        chunkschildren[i].children[7].setAttribute('name',"chunkNo[" + i + "]");
                        chunkschildren[i].children[7].setAttribute('value',i);
                        chunkCount = i;   
                    }
                },false);
            });
            
            addButton[0].addEventListener("click",function(){
                cell = options[0].insertRow();
                optionrow = cell.insertCell();
                newelement = optionrow.appendChild(document.createElement("input"));
                newelement.setAttribute("type","text");
                newelement.setAttribute("name","option[]");
                optionrow = cell.insertCell();
                newelement = optionrow.appendChild(document.createElement("input"));
                newelement.setAttribute("type","text");
                newelement.setAttribute("name","optionDE[]");
                optionrow = cell.insertCell();
                newelement = optionrow.appendChild(document.createElement("button"));
                newelement.setAttribute("type","button");
                newelement.setAttribute("name","deleteButton");
                newelement.addEventListener("click",deleteRow,false)
                newelement.innerHTML = "削除";
                deleteButton = document.getElementsByName("deleteButton");
                deleteButtons = [].slice.call(deleteButton);
            },false);
            
            OtherAddBT[0].addEventListener("click",function(){
                chunkCount++;
                var chunk = other.appendChild(document.createElement('div'));
                chunk.setAttribute('chunkNo',chunkCount);
                var chunkNo = chunk.getAttribute("chunkNo")
                chunk.insertAdjacentHTML('beforeend',"タイトル:");
                otherElement = chunk.appendChild(document.createElement("input"));
                otherElement.setAttribute("type","text");
                otherElement.required = true;
                otherElement.setAttribute("name","title[" + chunkNo +"]");
                chunk.insertAdjacentHTML('beforeend',"<br>説明文:");
                otherElement = chunk.appendChild(document.createElement("textarea"));
                otherElement.setAttribute("name","fileDE[" + chunkNo + "]");
                otherElement.setAttribute("rows","20");
                otherElement.setAttribute("cols","80");
                chunk.insertAdjacentHTML('beforeend',"<br>表:<br>");
                tableElement = chunk.appendChild(document.createElement("table"));
                tableElement.setAttribute("border","1");
                trElement = tableElement.insertRow();
                cellElement = trElement.insertCell();
                Cell = cellElement.appendChild(document.createElement("button"));
                Cell.setAttribute("type","button");
                Cell.innerHTML = "削除";
                Cell.addEventListener("click",CellButton,false);
                trElement = tableElement.insertRow();
                cellElement = trElement.insertCell();
                Cell = cellElement.appendChild(document.createElement("input"));
                Cell.setAttribute("type","text");
                Cell.setAttribute("name","header["+ chunkNo +"][]");

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
                    var chunks = document.getElementById("other");
                    var chunkschildren = [].slice.call(chunks.children);
                    for(var i = 0;i < chunkschildren.length;i++){
                        chunkschildren[i].setAttribute('chunkNo',i);
                        chunkschildren[i].children[0].setAttribute('name',"title["+i+"]");
                        chunkschildren[i].children[2].setAttribute('name',"fileDE["+i+"]");
                        chunkschildren[i].children[7].setAttribute('name',"chunkNo[" + i + "]");
                        chunkschildren[i].children[7].setAttribute('value',i);

                        chunkCount = i;   
                    }
                },false);
                otherElement.innerHTML = "削除";
                otherElement = chunk.appendChild(document.createElement("input"));
                otherElement.setAttribute('type','hidden');
                otherElement.setAttribute('name','chunkNo[' + chunkCount +']');
                otherElement.setAttribute('value',chunkCount);

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
                options[0].deleteRow((deleteButtons.indexOf(event.target)));
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
        <input type="submit" value="更新">
        </form>
        <!---　Linuxコマンドページ項目の表示-->

        <!---　終了-->
    </body>
</html>
