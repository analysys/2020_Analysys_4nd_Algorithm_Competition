# 2020_Analysys_4nd_Algorithm_Competition

围绕“漏斗分析”、“session分析”、“PV、UV流量预测”、“性别年龄预测”等热门命题，今年已经是易观举办OLAP算法大赛的第四年。借助OLAP算法大赛，大赛荟聚了数千位算法爱好者、凝结了精彩的算法成果，在百度搜索OLAP算法，几乎被易观数科OLAP算法大赛“霸屏”。自8月中旬启动第四届比赛以来，我们累计收到了百余团队报名，得到了思否，CSDN，帆软社区，InfoQ等多家技术社区的宣传和支持。

# 一，题目

存量时代，企业更注重“精细化运营”，借助用户行为分析工具，企业可针对性地进行渠道优化、产品迭代、运营策略设计等，在使用工具过程中，“事件分析”功能的使用频次极高。事件分析模型主要用于分析用户打开 APP、注册、支付订单等在应用上的行为，通过触发用户数、触发次数等基础指标度量用户行为，也支持指标运算、构建复杂的指标衡量业务过程。本次大赛以“事件分析”为题目，下设3大场景来考察算法能力。

场景1：多指标多维度分析；
场景2：多指标多维度分析，并计算任意维度小计、合计值；
场景3：多指标多维度分析，计算任意维度小计、合计值，并支持关联用户属性数据。

说明：评委会随机设定多维度多指标需求，例如PV、UV、订单金额中位数，并要求根据指定维度+日期进行分组。参赛者根据具体需求计算结果，所有提交的方案都必须可行，并公开思路及源代码。

# 二，奖项设置

冠军：奖金6万元人民币（税前）+ 荣誉证书；
亚军：奖金3万元人民币（税前）+ 荣誉证书；
季军：奖金1万元人民币（税前）+ 荣誉证书；
特别奖：凡进入答辩环节的选手，将获得机械键盘一套，以及2020易观A10数据智能峰会开发者日门票一张。

# 三，赛程安排

——8月-9月15日，初赛报名；
——9月7日-9月25日
参赛者获得测试数据，自行调试环境与算法。组织方提供demo数据、例题和答案，用于算法校验；
——9月25日-10月15日
组织方提供数据与测试环境，参赛者获得正式数据在正式环境比赛；
——10月15日-10月20日
参赛者提交算法说明文档，参加线上答辩；
——10月24日
易观A10峰会公布获奖名单并进行颁奖。

# 四，正式比赛题目

# 数据介绍 
说明：比赛数据与测试数据格式一致，仅内容以及数据量存在差异。
比赛数据包括2部分数据 event与profile
event数据为文本文件格式，具体包含字段有： 
1、用户ID(distinct_id)，Long类型 
2、时间戳(xwhen)，毫秒级别UNIXTIME，Long类型 
3、事件CODE(xwhat)，字符串类型，包含startUp、login、searchGoods等多个事件  
4、事件ID:(xwhat_id)，与事件code一一对应，Int类型。
5、内容明细，json格式。不同事件、记录包含不同属性，包含字符串、浮点、整形3种类型的数据。总属性个数 30-50个左右
6、日期(ds)，事件发生的日期YYYYMMDD格式
内容示例：
 
Profile 数据为文本格式，具体包含字段有：
1、	用户ID(distinct_id)，Long类型 与event表的对应
2、	内容明细，json格式。
内容示例：
 

# 比赛数据体量
event表总记录数为1093972120，其中初始：1092877651;追加：1094469。
profile表总记录数为56665080,其中初始：56615080;追加50000。

# 比赛题目

1、	查询20200801-20200807的行为数据，按ds,os,city 分组统计uv(去重用户数)、pv(事件数)、price 的总和,结果需按 ds,os,city的顺序进行排序。

2、	查询20200801-20200807的以下事件:addtoshoppingcart，submitorderdetail，share，payorderdetail的行为数据，按ds，firstcommodity，os_version 分组统计 uv，pv，app_version的去重数，price的去重数,结果需要按ds，firstcommodity，os_version 进行排序


3、	查询20200801-20200807的以下事件:addtoshoppingcart，payorderdetail，按ds，firstcommodity，secondcommodity，commodityname 分组统计uv(去重用户数)、pv(事件数)、price 的总和，并同时计算 firstcommodity，secondcommodity，commodityname 的小计值、 firstcommodity的合计值 以及 firstcommodity+ds 的合计值，并统计结果需按 ds，firstcommodity，secondcommodity，commodityname的顺序进行排序
说明：返回的结果要包含4种粒度结果 
    ds+firstcommodity+secondcommodity+commodityname
    firstcommodity+secondcommodity+commodityname
    firstcommodity+ds  
    firstcommodity


4、	查询20200801-20200807的行为数据,且用户属于分群9(profile.fq9=1)，按ds加用户属性中的vip_level,total_visit_days 进行分组统计uv(去重用户数)、pv(事件数)、price 的总和,并同时计算vip_level,total_visit_days 的小计值,结果需按 ds,vip_level,total_visit_days的顺序进行排序。vip_level 存在部分null的记录，需要展示为"未知"
   说明：返回结果要包含2种粒度结果：
ds+vip_level+total_visit_days 
vip_level+total_visit_days 


5、	查询20200801-20200807的行为数据，按ds加用户属性中的vip_level,total_visit_days 进行分组统计uv(去重用户数)、pv(事件数)、price 的总和,并同时计算vip_level,total_visit_days 的小计值,并对比 人群3(fq3=1)、人群7(fq7=2)、人群8(fq8=1)、人群10(fq10=1) 的结果,结果需按 ds,vip_level,total_visit_days,fq的顺序进行排序。vip_level 存在部分null的记录，需要展示为"未知"
   说明：返回结果要分别包含4个人群的各2个粒度的结果
ds+vip_level+total_visit_days ;
vip_level+total_visit_days

# 五，比赛结果

经过一段时间的比赛，前三名已经诞生，我们将官方答案与前三名结果在此公开，供大家交流。方案PPT将在这两天更新上来。

