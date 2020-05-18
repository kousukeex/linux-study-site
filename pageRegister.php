<?php
    $sqlKeyword = "select cid from linuxcommand where command = :keyword or cid = :cid";
    $sqlcurrentpid = "select current from linuxcommandcurrentpid";
    $sqlCIDInsert = "insert into linuxcommandpagerelation values(:current,:cid)";
    $sqlregister = "insert into linuxcommandpage values(:current,:pagename,:description,:detail)";
    $sqlfileregister = "insert into linuxfilepagerelation values(:fid,:current)";
    $sqlfilefid = "select fid from linuxfile where fid=:fid";

    $pdo = new PDO("pgsql:dbname=linuxperson host=localhost port=5432","linuxperson","kousuke");  
    $commandRegister = $pdo->prepare($sqlCIDInsert);
    $search = $pdo->prepare($sqlKeyword); 
    $filesearch = $pdo->prepare($sqlfilefid);
    $file = $pdo->prepare($sqlfileregister);

    $targetcid = null;
    $breakflag = false;
    $currentpid = $pdo->query($sqlcurrentpid)->fetch();

    $pagename = null;
    $description = null;
    $detail = null;
    $data = null;
    $isKeyword = null;
    //ファイル
    $filedata = null;
    $fileIsKeyword = null;
    if(isset($_POST["data"])){
        $data = $_POST["data"];
    }
    if(isset($_POST["isKeyword"])){
        $isKeyword = $_POST["isKeyword"];
    }
    if(isset($_POST["pagename"])){
        $pagename = $_POST["pagename"];
    }
    if(isset($_POST["description"])){
        $description = $_POST["description"];
    }
    else{
        $description = "NULL";
    }
    if(isset($_POST["detail"])){
        $detail = $_POST["detail"];
    }
    else{
        $detail = "NULL";
    }
    if(isset($_POST["filedata"])){
        $filedata = $_POST["filedata"];
    }
    if(isset($_POST["fileIsKeyword"])){
        $fileIsKeyword = $_POST["fileIsKeyword"];
    }
    if($pagename != null){
        $insertpage = $pdo->prepare($sqlregister)->execute(Array(":current"=>$currentpid[0],":pagename"=>$pagename,":description"=>$description,":detail"=>$detail));
        for($i = 0;$i < count($isKeyword) && $breakflag == false;$i++){
            if($isKeyword){
                $targetcid = $search->execute(Array(":keyword"=>$data[$i],":cid"=>null));
            }else{
                $targetcid = $search->execute(Array(":keyword"=>null,":cid"=>$data[$i]));
            }
            if($targetcid){
                $targetcid = $search->fetch();
                $commandRegister->execute(Array(":current"=>$currentpid[0],":cid"=>$targetcid[0]));
            }
        }
        if(isset($filedata)){
            for($i = 0;$i < count($filedata) && $breakflag == false;$i++){
                $filesearch -> execute(Array(":fid"=>$filedata[$i]));
                $targetfid = $filesearch -> fetch();
                var_dump($targetfid[0]);
                if($file->execute(Array(":fid"=>$targetfid[0],":current"=>$currentpid[0]))==false){
                    $pdo->query("delete from linuxfilepagerelation where pid=".$currentpid[0]);
                    $pdo->query("delete from linuxcommandpagerelation where pid=".$currentpid[0]);
                    $breakflag = true;
                }
            }
        }
        if($breakflag){
            echo "失敗している";
            ;
        }
        else{
            echo "成功している";
            $pdo->query("select nextval('linuxcommandpagen_pid_seq')");
            $pdo->query("update linuxcommandcurrentpid set current=currval(linuxcommandpagen_pid_seq)");
        }
    }
?>

<!DOCTYPE html><meta charset="UTF-8">
<html>
    <head>
        <title>Linuxコマンド集</title>
        <link href="style.css" rel="stylesheet">
        <?php
        ?>
        <script src="./component.js"></script>
    </head>
    <body>
        <a href="search.php" target="command">コマンド一覧を確認する</a><a href="files.php" target="file">ファイルを確認する</a>
        <form action="pageRegister.php" method="post">
            ページ名:<input type="text" name="pagename" required><br>
            説明文:<input type="text" name="description"><br>
            詳細:<br>
            <textarea name="detail" rows="10" cols="40"></textarea><br>
            <p>コマンド:</p>
            <table border="1" name="pagelist">
                <tr><td>キーワード</td><td>CIDである</td><td>コマンドである</td></tr>
            </table>
            <button name="addRow" type="button">+行追加</button>
            <p>ファイル:</p>
            <table border="1" name="filelist">
                <tr><td>FID</td></tr>
            </table>
            <button name="addRow" type="button">+行追加</button
            <input type="submit" value="登録"><br>
            <script>
                var table = getTableByName("pagelist");
                var filetable = getTableByName("filelist");
                var addButton = document.getElementsByName("addRow");
                var radiocount = 0;
                var deleteButton = null;
                var deleteArray = null;
                var filedeleteArray = null;
                addButton[0].addEventListener("click",function(){
                    var row = addTableRow(table);
                    var rowcount = table.rows.length;
                    var cell = addCellAndSet(row,"input","text","data[]");
                    cell.required = true;
                    cell = addCellAndSet(row,"input","radio","isKeyword["+ (rowcount-2) +"]");
                    cell.setAttribute("value","0");
                    cell = addCellAndSet(row,"input","radio","isKeyword["+ (rowcount-2) +"]");
                    cell.setAttribute("value","1");
                    cell.checked = true;
                    cell = addCellAndSet(row,"button","button","deleteRowButton");
                    cell.innerHTML="削除";
                    cell.addEventListener("click",deleteRow,false);
                    deleteButton = document.getElementsByName("deleteRowButton");
                    deleteArray = [].slice.call(deleteButton);
                },false)

                addButton[1].addEventListener("click",function(){
                    var row = addTableRow(filetable);
                    var rowcount = filetable.rows.length;
                    var cell = addCellAndSet(row,"input","text","filedata[]");
                    cell.required = true;
                    cell = addCellAndSet(row,"button","button","filedeleteRowButton");
                    cell.innerHTML="削除";
                    cell.addEventListener("click",filedeleteRow,false);
                    filedeleteButton = document.getElementsByName("filedeleteRowButton");
                    filedeleteArray = [].slice.call(filedeleteButton);
                },false)                
                
                function deleteRow(event){
                    var target = deleteArray.indexOf(event.target);
                    table.deleteRow(target+1);
                    deleteButton = document.getElementsByName("deleteRowButton");
                    deleteArray = [].slice.call(deleteButton);
                    if(table.rows.length >= 2){
                        for(var i = 1;i < table.rows.length;i++){
                            table.rows[i].cells[1].setAttribute("name","isKeyword["+ (i-1)+"]");
                            table.rows[i].cells[2].setAttribute("name","isKeyword["+ (i-1)+"]");
                        }
                    }
                }
                function filedeleteRow(event){
                    var target = filedeleteArray.indexOf(event.target);
                    //console.log(target);
                    filetable.deleteRow(target+1);
                    filedeleteButton = document.getElementsByName("filedeleteRowButton");
                    filedeleteArray = [].slice.call(filedeleteButton);
                }
            </script>
            <input type="submit" value="登録">
        </form>
    </body>
</html>
