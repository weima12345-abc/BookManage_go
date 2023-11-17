package dao

import (
	"library/model"
	"library/utils"
)

//CheckUserNameAndPassword 根据用户名和密码从数据库中查询一条记录
func CheckUserNameAndPassword(username string, password string) (*model.User_chenjunjie, error) {
	//写sql语句
	sqlStr := "select id,username,password,email from users where username = ? and password = ?"
	//执行
	row := utils.Db.QueryRow(sqlStr, username, password)
	user := &model.User_chenjunjie{}
	row.Scan(&user.ID, &user.Username, &user.Password, &user.Email)
	return user, nil
}

//CheckUserName 根据用户名和密码从数据库中查询一条记录
func CheckUserName(username string) (*model.User_chenjunjie, error) {
	//写sql语句
	sqlStr := "select id,username,password,email from users where username = ?"
	//执行
	row := utils.Db.QueryRow(sqlStr, username)
	user := &model.User_chenjunjie{}
	row.Scan(&user.ID, &user.Username, &user.Password, &user.Email)
	return user, nil
}

//SaveUser 向数据库中插入用户信息
func SaveUser(username string, password string, email string) error {
	//写sql语句
	sqlStr := "insert into users(username,password,email) values(?,?,?)"
	//执行
	_, err := utils.Db.Exec(sqlStr, username, password, email)
	if err != nil {
		return err
	}
	return nil
}

func GetUserInfo() ([]*model.User_chenjunjie, error) {
	//写sql语句
	sql := "select id,username,PASSWORD,email from users"
	//执行
	rows, err := utils.Db.Query(sql)
	if err != nil {
		return nil, err
	}
	var users []*model.User_chenjunjie
	for rows.Next() {
		user := &model.User_chenjunjie{}
		rows.Scan(&user.ID, &user.Username, &user.Password, &user.Email)
		users = append(users, user)
	}
	return users, nil
}

//DeleteBook 根据图书的id从数据库中删除一本图书
func DeleteUser(userID string) error {
	//写sql语句
	sqlStr := "delete from users where id = ?"
	//执行
	_, err := utils.Db.Exec(sqlStr, userID)
	if err != nil {
		return err
	}
	return nil
}

//GetBookByID 根据图书的id从数据库中查询出一本图书
func GetUserByID(userID string) (*model.User_chenjunjie, error) {
	//写sql语句
	sqlStr := "select * from users where id = ?"
	//执行
	row := utils.Db.QueryRow(sqlStr, userID)
	//创建Book
	user := &model.User_chenjunjie{}
	//为book中的字段赋值
	row.Scan(&user.ID, &user.Username, &user.Password, &user.Email)
	return user, nil
}

//AddBook 向数据库中添加一本图书
func AddUser(b *model.User_chenjunjie) error {
	//写sql语句
	slqStr := "insert into users(username,PASSWORD,email) values(?,?,?)"
	//执行
	_, err := utils.Db.Exec(slqStr, b.Username, b.Password, b.Email)
	if err != nil {
		return err
	}
	return nil
}

//UpdateBook 根据图书的id更新图书信息
func UpdateUser(username string, password string, email string, userID int64) error {
	//写sql语句
	sqlStr := "update users set username=?,PASSWORD=?,email=? where id=?"
	//执行
	_, err := utils.Db.Exec(sqlStr, username, password, email, userID)
	if err != nil {
		return err
	}
	return nil
}