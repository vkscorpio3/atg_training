


--  @version $Id: //product/DCS/version/11.2/templates/DCS/AbandonedOrderServices/sql/abandoned_order_views.xml#1 $$Change: 946917 $
create view drpt_abandon_ord
(abandonment_date,amount,converted)
as
      select oa.abandonment_date as abandonment_date, ai.amount as amount, case when oa.abandon_state = 'CONVERTED' then 100 else 0 end as converted from dcspp_order o, dcspp_ord_abandon oa, dcspp_amount_info ai where oa.order_id=o.order_id and o.price_info=ai.amount_info_id
         
go

create view drpt_tns_abndn_ord
(abandonment_date,amount)
as
      select date_time as abandonment_date, amount as amount from drpt_session_ord where submitted=0
         
go


