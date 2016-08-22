------------------------------------------
--新手任务机器人
--未明谷底输入/newbietask () 启动，最后到杏子林前停止。
--男女通用，打老虎死亡等大部分意外问题都修正了。
--作者: 清风明月
--
------------------------------------------

require "wait"
function newbietask ()
    if GetOption("enable_command_stack")~=1 then
        Note("请启用游戏属性配置中的单行多命令模式\n文件->游戏属性(Alt+Enter)->Input->Commands->单行多命令。分隔符为\";\"")
        return
    end
    wait.make (function ()
        local line,gender
        Execute("sc")
        line=wait.regexp (".*你是一位.*未婚.*人类.*",10) --你是一位十四岁的未婚男性人类
        if line == nil then
            gender = 1
        elseif string.find(line,"男性人类")~=nil then
            gender = 1
        elseif string.find(line,"女性人类")~=nil then
            gender = 0
        else
            gender = 1
        end
        Execute("quest")
        line=wait.regexp (".*你来到这个陌生的地方，前途未卜，请先用hp命令检查自己的身体情况.*",10)
        Execute("hp")
        line=wait.regexp (".*你现在又渴又饿，看看在这里能否找到些吃的喝的。.*",2)
        while true do
            Execute("get ye guo") --你捡起一枚野果
            line=wait.regexp (".*你捡起一枚野果.*",5)
            if line~=nil then
                break
            end
        end
        Execute("eat ye guo")
        while true do
            line=wait.regexp ("(.*你拿起野果咬了几口.*|.*你已经吃太饱了.*)",2)
            if (line~=nil) and (string.find(line,"拿起野果")~=nil) then
                Execute("eat ye guo")
            elseif (line~=nil) and (string.find(line,"已经吃太饱")~=nil) then
                break
            end
        end
        Execute("l river")
        line=wait.regexp (".*也许你可以拿起地上的葫芦.*",2)
        while true do
            Execute("get hulu")
            line=wait.regexp (".*你捡起一个葫芦.*",5)
            if line~=nil then
                break
            end
        end
        Execute("l hulu")
        line=wait.regexp (".*看来可以用来盛溪水.*",2)
        Execute("fill hulu;drink hulu")
        while true do
            line=wait.regexp ("(.*你拿起葫芦咕噜噜地喝了几口.*|.*吃饱喝足了，你现在可以去周围探索下.*)",2)
            if (line~=nil) and (string.find(line,"拿起葫芦")~=nil) then
                Execute("drink hulu")
            elseif (line~=nil) and (string.find(line,"吃饱喝足了")~=nil) then
                Execute("e;w;s;n;w;e")
                break
            end
        end
        line=wait.regexp (".*把周围走了个遍，都没有发现有其他出口.*",3)
        wait.time(2)
        Execute("l path;climb up")
        line=wait.regexp (".*心想柳秀山庄会不会就在前面附近的地方.*",15)
        Execute("n;n;n")
        line=wait.regexp (".*你怔怔地站在那里不知所措,不如去敲敲门.*",2)
        Execute("knock gate;")
        line=wait.regexp (".*丫鬟身穿白纱挑线镶边裙走了过来门.*",1)
        Execute("ask yahuan about 葫芦")
        line=wait.regexp (".*丫鬟见你手中的葫芦，惊诧地.*",1)
        wait.time(2)
        Execute("knock gate")
        line=wait.regexp (".*丫鬟转过头来瞧着你，示意你赶紧把葫芦给这位庄主.*",25)
        Execute("give hulu to you kunyi")
        line=wait.regexp (".*游鲲翼似乎对你言而不尽.*",2)
        wait.time(5)
        Execute("ask you kunyi about here;ask you kunyi about name;ask you kunyi about 葫芦;ask you kunyi about 闯荡江湖;")
        wait.time(5)
        line=wait.regexp (".*跟着丫鬟阿姝，让她带你熟悉一下山庄吧.*",5)
        Execute("follow a shu")
        line=wait.regexp (".*请把衣服脱了,好好在这里洗个澡吧.*",60)
        wait.time(1)
        Execute("follow none;remove all;bath")
        line=wait.regexp (".*终于把澡洗完了.*",60)
        wait.time(5)
        if gender == 0 then
            Execute("wear all;s;w;ask you kunyi about 闯荡江湖;")
        else
            Execute("wear all;s;e;ask you kunyi about 闯荡江湖;")
        end
        line=wait.regexp (".*快去尚武堂找武师试试身手.*",2)
        wait.time(3)
        Execute("n;fight wushi")
        line=wait.regexp ("(.*消耗了你不少的体力，回厢房去休息.*|.*慢慢地你终于又有了知觉.*)",120)
        wait.time(5)
        if gender == 0 then
            Execute("s;e;sleep")
        else
            Execute("s;w;sleep")
        end
        line=wait.regexp (".*你气色恢复，虽然被武师打败了.*",30)
        wait.time(3)
        if gender == 0 then
            Execute("w;ask you kunyi about 闯荡江湖;")
        else
            Execute("e;ask you kunyi about 闯荡江湖;")
        end
        line=wait.regexp (".*查下柳秀票号在哪里.*",3)
        wait.time(3)
        Execute("localmaps;q")
        line=wait.regexp (".*快去柳秀票号看看游鲲翼给你存了多少钱.*",3)
        Execute("s;s;open gate;s;e;qu 100 silver")
        line=wait.regexp (".*取了钱，赶紧去药铺买药疗伤吧.*",3)
        wait.time(3)
        Execute("w;s;s;ne;buy yao;eat yao")
        line=wait.regexp (".*你的伤治好了！快回到游庄主处.*",3)
        wait.time(5)
        Execute("sw;n;n;knock gate;n;n;n;ask you kunyi about 闯荡江湖;")
        line=wait.regexp (".*快去尚武堂，找武师拜师学艺去吧.*",3)
        wait.time(3)
        Execute("n;bai wushi")
        line=wait.regexp (".*我需要一壶烧刀子和一把钢剑.*",3)
        wait.time(3)
        Execute("s")
        line=wait.regexp (".*先别走，还没给你钱.*",3)
        wait.time(5)
        Execute("s;s;s;open gate;s;s;w;buy jian")
        line=wait.regexp (".*你从老胡那里买下了一柄钢剑.*",3)
        wait.time(3)
        Execute("e;s;se;buy shaodaozi")
        line=wait.regexp (".*你从老汉那里买下了一坛烧刀子.*",3)
        wait.time(3)
        Execute("nw;n;n;knock gate;n;n;n;n;give wushi jian;")
        line=wait.regexp (".*你给武师一柄钢剑.*",3)
        wait.time(3)
        Execute("give wushi shaodaozi")
        line=wait.regexp (".*没办法，继续跑腿去买东西吧.*",3)
        wait.time(3)
        Execute("s;s;s;open gate;s;s;e;buy shi he")
        line=wait.regexp (".*你从杨永福那里买下了一个食盒.*",3)
        wait.time(3)
        Execute("w;s;se;buy jitui")
        line=wait.regexp (".*你从老汉那里买下了一根烤鸡腿.*",3)
        wait.time(3)
        Execute("put jitui in shi he")
        line=wait.regexp (".*你将一根烤鸡腿放进食盒.*",3)
        wait.time(3)
        Execute("nw;n;n;knock gate;n;n;n;n;give wushi shi he;")
        line=wait.regexp (".*再看看师傅都会些什么功夫.*",3)
        wait.time(3)
        Execute("bai wushi;cha wushi")
        line=wait.regexp (".*你问清楚了武师学了哪些技能，赶紧向他学点功夫.*",3)
        wait.time(3)
        while true do
            Execute("learn wushi for force 1;learn wushi for dodge 1;learn wushi for parry 1;learn wushi for strike 1;learn wushi for sword 1;learn wushi for taiyi-shengong 1;learn wushi for taiyi-jian 1;learn wushi for taiyi-you 1;learn wushi for taiyi-zhang 1;")
            line=wait.regexp ("(.*你今天太累了.*|.*把学到的功夫都激发起来吧.*)",2)
            wait.time(2)
            if line~=nil and  (string.find(line,"今天太累")~=nil) then
                if gender == 0 then
                    Execute("s;e;sleep")
                else
                    Execute("s;w;sleep")
                end
                line=wait.regexp ("(.*你一觉醒来，精神抖擞地活动.*|.*你刚在三分钟内睡过一觉.*)",35)
                if (line~=nil) and (string.find(line,"在三分钟内睡过")~=nil) then
                    wait.time(15)
                end
                if gender == 0 then
                    Execute("w;n")
                else
                    Execute("e;n")
                end
            elseif line~=nil and  (string.find(line,"功夫都激发")~=nil) then
                break
            end
        end
        line=wait.regexp (".*把学到的功夫都激发起来吧.*",3)
        Execute("jifa force taiyi-shengong;jifa dodge taiyi-you;jifa sword taiyi-jian;jifa parry taiyi-jian;jifa strike taiyi-zhang")
        line=wait.regexp (".*还要再准备一下主用空手招式.*",3)
        Execute("bei taiyi-zhang")
        wait.time(3)
        line=wait.regexp (".*再和武师过过招试试.*",3)
        Execute("fight wushi")
        line=wait.regexp (".*趁热打铁去练习一级太乙剑法.*",30)
        wait.time(3)
        if gender == 0 then
            Execute("s;e;wield sword;lian sword 10")
        else
            Execute("s;w;wield sword;lian sword 10")
        end
        while true do
            Execute("lian sword 10")
            line=wait.regexp ("(.*你的体力不够练太乙神剑.*|.*你握了握手中的剑，感觉自己有点功夫了.*)",5)
            if (line~=nil) and (string.find(line,"体力不够")~=nil) then
                Execute("sleep")
                line=wait.regexp ("(.*你一觉醒来，精神抖擞地活动.*|.*你刚在三分钟内睡过一觉.*)",35)
                if (line~=nil) and (string.find(line,"在三分钟内睡过")~=nil) then
                    wait.time(10)
                end
            elseif (line~=nil) and  (string.find(line,"感觉自己有点功夫")~=nil) then
                break
            end
        end
        Note("----等待回复休息----")
        wait.time(10)
        while true do
            Execute("sleep")
            line=wait.regexp ("(.*你一觉醒来，精神抖擞地活动.*|.*你刚在三分钟内睡过一觉.*)",35)
            if (line~=nil) and (string.find(line,"你一觉醒来")~=nil) then
                break
            end
            wait.time(10)
        end
        if gender == 0 then
            Execute("w;ask you kunyi about 闯荡江湖;")
        else
            Execute("e;ask you kunyi about 闯荡江湖;")
        end
        line=wait.regexp (".*去树林手刃幼虎，以示武勇.*",3)
        wait.time(3)
        Execute("s;s;open gate;s;s;s;ne;buy yao")
        wait.time(5)
        Execute("sw;s;climb down")
        line=wait.regexp (".*你费了九牛二虎之力，终于爬到了谷底.*",25)
        wait.time(5)
        Execute("w;kill lao hu")
        while true do
            Execute("perform sword.bafang")
            line=wait.regexp ("(.*手刃了恶虎，你感觉自己威风凛凛.*|.*你已经陷入半昏迷状态.*|.*你看起来已经力不从心.*|.*你的眼前一黑，接著什么也不知道了.*)",3)
            if line~=nil and (string.find(line,"手刃了恶虎")~=nil) then
                wait.time(2)
                Execute("e;climb up")
                break
            elseif (line~=nil) and ((string.find(line,"你已经陷入半昏迷")~=nil) or (string.find(line,"你看起来已经力不从心")~=nil)) then
                Execute("eat yao")
            elseif line~=nil and (string.find(line,"你的眼前一黑")~=nil) then
                line=wait.regexp (".*你慢慢睁开眼睛，清醒了过来.*",240)
                wait.time(10)
                if gender == 0 then
                    Execute("w")
                else
                    Execute("e")
                end
                Execute("s;s;open gate;s;s;s;s;climb down")
                line=wait.regexp (".*你费了九牛二虎之力，终于爬到了谷底.*",35)
                wait.time(5)
                Execute("w;kill lao hu")
            end
        end
        line=wait.regexp (".*你轻轻松松得爬了上来.*",15)
        wait.time(2)
        Execute("n;n;n;knock gate;n;n;n;ask you kunyi about 闯荡江湖;")
        line=wait.regexp (".*还是去藏书阁读一读看看.*",3)
        wait.time(2)
        Execute("n;n;get book from shujia;read book for 1")
        line=wait.regexp (".*到大厅找游鲲翼.*",3)
        wait.time(3)
        Execute("s;s;ask you kunyi about 闯荡江湖;")
        line=wait.regexp (".*既然英雄要送你，却之不恭.*",3)
        wait.time(1)
        Execute("s;s;open gate;s;s;s") --到杏子林前
    end) 
end
