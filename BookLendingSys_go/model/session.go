package model

//Session 结构
type Session_chenjunjie struct {
	SessionID string
	UserName  string
	UserID    int
	Cart      *Cart_chenjunjie
	OrderID   string
	Orders    []*Order_chenjunjie
}
