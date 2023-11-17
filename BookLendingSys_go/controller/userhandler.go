package controller

import (
	"library/dao"
	"library/model"
	"library/utils"
	"html/template"
	"net/http"
	"strconv"
)

//Logout //处理用户注销的函数
func Logout(w http.ResponseWriter, r *http.Request) {
	//获取Cookie
	cookie, _ := r.Cookie("user")
	if cookie != nil {
		//获取cookie的value值
		cookieValue := cookie.Value
		//删除数据库中与之对应的Session
		dao.DeleteSession(cookieValue)
		//设置cookie失效
		cookie.MaxAge = -1
		//将修改之后的cookie发送给浏览器
		http.SetCookie(w, cookie)
	}
	//去首页
	GetPageBooksByPrice(w, r)
}

//Login 处理用户登录的函数
func Login(w http.ResponseWriter, r *http.Request) {
	//判断是否已经登录
	flag, _ := dao.IsLogin(r)
	if flag {
		//已经登录
		//去首页
		GetPageBooksByPrice(w, r)
	} else {
		//获取用户名和密码
		username := r.PostFormValue("username")
		password := r.PostFormValue("password")
		//调用userdao中验证用户名和密码的方法
		user, _ := dao.CheckUserNameAndPassword(username, password)
		if user.ID > 0 {
			//用户名和密码正确
			//生成UUID作为Session的id
			uuid := utils.CreateUUID()
			//创建一个Session
			sess := &model.Session_chenjunjie{
				SessionID: uuid,
				UserName:  user.Username,
				UserID:    user.ID,
			}
			//将Session保存到数据库中
			dao.AddSession(sess)
			//创建一个Cookie，让它与Session相关联
			cookie := http.Cookie{
				Name:     "user",
				Value:    uuid,
				HttpOnly: true,
			}
			//将cookie发送给浏览器
			http.SetCookie(w, &cookie)
			t := template.Must(template.ParseFiles("views/pages/user/login_success.html"))
			t.Execute(w, user)
		} else {
			//用户名或密码不正确
			t := template.Must(template.ParseFiles("views/pages/user/login.html"))
			t.Execute(w, "用户名或密码不正确！")
		}
	}
}

//Regist 处理用户的函注册数
func Regist(w http.ResponseWriter, r *http.Request) {
	//获取用户名和密码
	username := r.PostFormValue("username")
	password := r.PostFormValue("password")
	email := r.PostFormValue("email")
	//调用userdao中验证用户名和密码的方法
	user, _ := dao.CheckUserName(username)
	if user.ID > 0 {
		//用户名已存在
		t := template.Must(template.ParseFiles("views/pages/user/regist.html"))
		t.Execute(w, "用户名已存在！")
	} else {
		//用户名可用，将用户信息保存到数据库中
		dao.SaveUser(username, password, email)
		//用户名和密码正确
		t := template.Must(template.ParseFiles("views/pages/user/regist_success.html"))
		t.Execute(w, "")
	}
}

//CheckUserName 通过发送Ajax验证用户名是否可用
func CheckUserName(w http.ResponseWriter, r *http.Request) {
	//获取用户输入的用户名
	username := r.PostFormValue("username")
	//调用userdao中验证用户名和密码的方法
	user, _ := dao.CheckUserName(username)
	if user.ID > 0 {
		//用户名已存在
		w.Write([]byte("用户名已存在！"))
	} else {
		//用户名可用
		w.Write([]byte("<font style='color:green'>用户名可用！</font>"))
	}
}

func GetUserInfo(w http.ResponseWriter, r *http.Request) {
	//调用dao中获取所有订单的函数
	usersinfo, _ := dao.GetUserInfo()
	//解析模板
	t := template.Must(template.ParseFiles("views/pages/user/user_manager.html"))
	//执行
	t.Execute(w, usersinfo)
}

func DeleteUser(w http.ResponseWriter, r *http.Request) {
	//获取要删除的图书的id
	userID := r.FormValue("userId")
	//调用bookdao中删除图书的函数
	dao.DeleteUser(userID)
	//调用GetBooks处理器函数再次查询一次数据库
	GetUserInfo(w, r)
}

func ToUpdateUser(w http.ResponseWriter, r *http.Request) {
	//获取要更新的图书的id
	userID := r.FormValue("userId")
	//调用bookdao中获取图书的函数
	user, _ := dao.GetUserByID(userID)
	if user.ID > 0 {
		//在更新图书
		//解析模板
		t := template.Must(template.ParseFiles("views/pages/manager/user_edit.html"))
		//执行
		t.Execute(w, user)
	} else {
		//在添加图书
		//解析模板
		t := template.Must(template.ParseFiles("views/pages/manager/user_edit.html"))
		//执行
		t.Execute(w, "")
	}
}

//UpdateOrAddBook 更新或添加图书
func UpdateOrAddUser(w http.ResponseWriter, r *http.Request) {
	ID := r.FormValue("userId")
	user, _ := dao.GetUserByID(ID)
	username := r.PostFormValue("username")
	password := r.PostFormValue("passwd")
	email := r.PostFormValue("email")
	userID, _ := strconv.ParseInt(ID, 10, 0)
	if user.ID > 0 {
		dao.UpdateUser(username, password, email, userID)
	} else {
		dao.SaveUser(username, password, email)
	}
	GetUserInfo(w, r)
}
