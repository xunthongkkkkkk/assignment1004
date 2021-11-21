<html>
<head>
        <title> Control LED </title>
</head>

<body>
<center>
<h1> Control LED </h1>
<form method="GET" action="index.php">
        <button class="red" type="submit" value="ron" name="redL">Turn Red LED On</button>
        <button class="red" type="submit" value="rblink" name="redL">Blink Red LED</button>
        <button class="red" type ="submit" value="roff" name="redL">Turn Red LED Off</button>

        <br /><br />
        <br /><br />

        <button class="green" type="submit" value="gon" name="greenL">Turn Green LED On</button>
        <button class="green" type="submit" value="gblink" name="greenL">Blink Green LED</button>
        <button class="green" type="submit" value="goff" name="greenL">Turn Green LED Off</button>
        <br /><br />

</form>
</center>

<?php
    if(isset($_GET['redL'])){
        if($_GET['redL'] == 'ron'){
            $argvc = "0 1";
            exec("/../../../home/pi/pi/WiringPi/ledBlink/webcontrol $argvc 2>&1");

        }else if($_GET['redL'] == 'rblink'){
            $argvc = "0 2";
            exec("/../../../home/pi/pi/WiringPi/ledBlink/webcontrol $argvc 2>&1");

        }else if($_GET['redL'] == 'roff'){
            $argvc = "0 3";
            exec("/../../../home/pi/pi/WiringPi/ledBlink/webcontrol $argvc 2>&1");
        }
    }

    if(isset($_GET['greenL'])){
        if($_GET['greenL'] == 'gon'){
            $argvc = "0 4";
            exec("/../../../home/pi/pi/WiringPi/ledBlink/webcontrol $argvc 2>&1");
        } else if($_GET['greenL'] == 'gblink'){
            $argvc = "0 5";
            exec("/../../../home/pi/pi/WiringPi/ledBlink/webcontrol $argvc 2>&1");
        } else if($_GET['greenL'] == 'goff'){
            $argvc = "0 6";
            exec("/../../../home/pi/pi/WiringPi/ledBlink/webcontrol $argvc 2>&1");
        }
    }

?>

</body>

</html>
