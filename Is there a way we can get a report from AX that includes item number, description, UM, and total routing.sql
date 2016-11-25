
--Is there a way we can get a report from AX that includes item number, description, UM, and total routing?

-- Header  
SELECT 
	IT.ITEMID, 
	IT.NAMEALIAS											NAME,
	UNITID													InvUOM,
	ROUTEID ,  
	SUM(ISNULL(SETUPTIME,0))								SETUPTIME,   
	SUM(ISNULL(PROCESSTIME,0))								PROCESSTIME, 
	SUM(ISNULL(SETUPTIME,0)) + SUM(ISNULL(PROCESSTIME,0))	TOTALTIME 
FROM		RouteVersion		RV 
INNER JOIN  InventTable			IT	ON RV.ITEMID		= IT.ITEMID
INNER JOIN  RouteOpr			RO	ON RO.ROUTERELATION = ROUTEID
LEFT JOIN	InventTableModule	ITM	ON ITM.itemid		= it.ITEMID and moduletype = 0
WHERE ACTIVE = 1 and APPROVED = 1 
--and it.ITEMID = '0076'
GROUP BY IT.ITEMID, ROUTEID , NAMEALIAS,UNITID


--Detail

SELECT 
	IT.ITEMID, 
	IT.NAMEALIAS											NAME,
	UNITID													InvUOM,
	ROUTEID ,  
	OPRID,
	ISNULL(SETUPTIME,0)								SETUPTIME,   
	ISNULL(PROCESSTIME,0)							PROCESSTIME, 
	ISNULL(SETUPTIME,0) + ISNULL(PROCESSTIME,0)		TOTALTIME 
FROM		RouteVersion		RV 
INNER JOIN  InventTable			IT	ON RV.ITEMID		= IT.ITEMID
INNER JOIN  RouteOpr			RO	ON RO.ROUTERELATION = ROUTEID
LEFT JOIN	InventTableModule	ITM	ON ITM.itemid		= it.ITEMID and moduletype = 0
WHERE ACTIVE = 1 and APPROVED = 1 
--and it.ITEMID = '0076'
