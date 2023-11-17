package model

//Order 结构
type Order_chenjunjie struct {
	OrderID     string  //订单号
	CreateTime  string  //生成订单的时间
	TotalCount  int64   //订单中图书的总数量
	TotalAmount float64 //订单中图书的总金额
	State       int64   //订单的状态 0 未发货 1 已发货 2 交易完成
	UserID      int64   //订单所属的用户
}

//NoSend 未发货
func (order *Order_chenjunjie) NoSend() bool {
	return order.State == 0
}

//SendComplate 已发货
func (order *Order_chenjunjie) SendComplate() bool {
	return order.State == 1
}

//Complate 交易完成
func (order *Order_chenjunjie) Complate() bool {
	return order.State == 2
}
