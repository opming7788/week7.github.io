from fastapi import FastAPI, Request ,Form ,Query
from fastapi.templating import Jinja2Templates
from fastapi.staticfiles import StaticFiles
from starlette.responses import HTMLResponse,RedirectResponse
from starlette.middleware.sessions import SessionMiddleware
from fastapi.responses import JSONResponse

from pydantic import BaseModel

import mysql.connector

# 創建 MySQL 連接
con = mysql.connector.connect(
    host="localhost",
    user="root",
    password="abc31415",
    database="website"
)

app = FastAPI()

# 定義請求體模型
class UpdateNameRequest(BaseModel):
    name: str


app.add_middleware(SessionMiddleware, secret_key="mySignIn") ##提供一個秘密鍵來簽名 cookie

# 設置 Jinja2 模板
templates = Jinja2Templates(directory="templates")

@app.get("/", response_class=HTMLResponse)
async def read_root(request: Request):
    if "username" not in request.session:
        return templates.TemplateResponse("myindex.html", {"request": request})
    else:
        return RedirectResponse(url="/member")

#Member Page:
@app.get("/member", response_class=HTMLResponse)
async def login_success(request: Request):
    if "username" in request.session:
        cursor=con.cursor()
        username=request.session["username"][1] #抓取會員帳號
        
        #獲取每條留言的使用者yourname、留言內容和使用者的username，並按照留言的時間進行排序，以便以適當的順序顯示在網頁界面上
        cursor.execute("SELECT member.yourname, message.content,member.username,message.id \
                       FROM message \
                       JOIN member ON message.member_id = member.id \
                       ORDER BY message.time DESC;")
        usersandcontents = cursor.fetchall() #usersandcontents包含所有留言者的yourname，content，username，根據時間排序
        
        yourname=request.session["username"][2]
        cursor.close()
        return templates.TemplateResponse("member.html", {"request": request,"yourname":yourname,\
                                                          "username":username,"usersandcontents":usersandcontents})
    else:
        return RedirectResponse(url="/")

@app.get("/api/member")
async def get_member(request: Request,username: str = Query(...)):
    if "username" in request.session:
        with con.cursor() as cursor:
            cursor.execute("SELECT member.id,member.yourname,member.username FROM member WHERE username = %s", (username,))
            userData = cursor.fetchone()
            if userData:
                Data={
                    "data":{
                        "id":userData[0],
                        "name":userData[1],
                        "username":userData[2]
                        }
                    }
            else:
                Data = {"data": None}
        return JSONResponse(content=Data, status_code=200)
    else:
        return RedirectResponse(url="/")


@app.patch("/api/member")
async def updatingMemberName(request: Request, updateName: UpdateNameRequest):
    if "username" in request.session:
        username = request.session["username"][1]
        print(f"Received request to update name for user: {username}")
        print(f"New name: {updateName.name}")
        with con.cursor() as cursor:
            cursor.execute("UPDATE member SET yourname = %s WHERE username = %s", (updateName.name, username))
            con.commit()
        return JSONResponse(content={"ok": True}, status_code=200)
    else:
        print("User not logged in")
        return JSONResponse(content={"error": True}, status_code=500)



#/error?msg=錯誤訊息
@app.get("/error",response_class=HTMLResponse)
async def error(request: Request,msg: str="發生錯誤"):
    if "username" in request.session:
        return RedirectResponse(url="/member")
    return templates.TemplateResponse("error.html", {"request": request,"msg":msg})
#Signup Endpoint
@app.post("/signup")
async def signup(request: Request, yourname: str = Form(None), username: str = Form(None), password: str = Form(None)):
    with con.cursor() as cursor:
        cursor.execute("SELECT * FROM member WHERE username = %s", (username,))
        user = cursor.fetchone()
        if user:
            # 如果找到使用者，返回帳號已被註冊的訊息
            return RedirectResponse(url="/error?msg=帳號已被註冊",status_code=303)
        # 如果沒有找到使用者，則新增使用者資料
        cursor.execute("INSERT INTO member (yourname, username, password) VALUES (%s, %s, %s)", (yourname, username, password))
        con.commit()
    # 新增成功後重新導向到首頁
    return RedirectResponse(url="/", status_code=303)
    
#Signin Endpoint:
@app.post("/signin")
async def signin(request: Request, username: str = Form(None), password: str = Form(None)):
    
    cursor=con.cursor()
    cursor.execute("SELECT * FROM member WHERE username = %s and password=%s", (username,password))
    user = cursor.fetchone()
    if user==None:
        return RedirectResponse("/error?msg=帳號或密碼輸入錯誤",status_code=303)
    request.session["username"] = [user[0],user[2], user[1]] #將member id和帳號(username)與大名(yourname)放入sessionMiddleware
    return RedirectResponse("/member",status_code=303)

#Signout Endpoint:    
@app.get("/signout")
async def signout(request: Request):
    
    if "username" in request.session:
        del request.session["username"]
    return RedirectResponse("/")

#CreateMessage Endpoint:
@app.post("/createMessage")
async def createMessage(request: Request, mycontent: str = Form(...)):
    if "username" not in request.session:
        return RedirectResponse("/")
    username=request.session["username"][1] #抓取sessionMiddleware中的使用者username
    user_id=request.session["username"][0]
    with con.cursor() as cursor:
        cursor.execute("INSERT INTO message (member_id, content) VALUES (%s, %s)", (user_id, mycontent))
        con.commit()
    return RedirectResponse(url="/member", status_code=303)


#DeleteMessage Endpoint:
@app.post("/DeleteMessage")
async def DeleteMessage(request: Request, myDelcontent: str = Form(...)):
    if "username" not in request.session:
        return RedirectResponse("/")
    with con.cursor() as cursor:
        cursor.execute("DELETE FROM message WHERE message.id =%s", (myDelcontent,))
    return RedirectResponse(url="/member", status_code=303)

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="127.0.0.1", port=3000)