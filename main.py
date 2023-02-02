from flask import Flask,render_template,request,redirect
from flask_sqlalchemy import SQLAlchemy
from werkzeug.utils import secure_filename
from werkzeug.datastructures import  FileStorage
# from werkzeug import secure_filename,FileStorage
from flask_mail import Mail
from flask import session
import json
import os
import math
from datetime import datetime

with open('C:\\Users\\ravi\\Desktop\\VS code\\Web developmet\\Flask\\Web Development using flask\\config.json','r') as c:
    params=json.load(c)["params"]
local_server=True

app = Flask(__name__)
app.secret_key = 'super-secret-key'
app.config['UPLOAD_FOLDER'] = params['upload_location']
app.config.update(
    MAIL_SERVER ='smtp.gmail.com',
    MAIL_PORT = '465',
    MAIL_USE_SSL ='True',
    MAIL_USERNAME= params['gmail-user'],
    MAIL_PASSWORD=params['gmail-password']




)
mail=Mail(app)
if(local_server):
    app.config['SQLALCHEMY_DATABASE_URI'] = params['local_uri']
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = params['prod_uri']




# app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://username:password@localhost/db_name'
db=SQLAlchemy(app)

class Contacts(db.Model):
    '''

    Serialno Name email PhoneNumber Message date

    '''
    Serialno = db.Column(db.Integer, primary_key=True)
    Name = db.Column(db.String(80),nullable=False)
    email = db.Column(db.String(20), nullable=False)
    PhoneNumber = db.Column(db.String(12), nullable=False)
    Message= db.Column(db.String(120), nullable=False)
    date = db.Column(db.String(12),nullable=True)



class Posts(db.Model):
    '''

    Serialno title slug content date

    '''
    Serialno = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(80),nullable=False)
    slug = db.Column(db.String(25), nullable=False)
    content = db.Column(db.String(120), nullable=False)
    tagline = db.Column(db.String(120), nullable=False)

    date = db.Column(db.String(12),nullable=True)
    img_file = db.Column(db.String(12),nullable=True)

@app.route("/")
def home():
    
    posts = Posts.query.filter_by().all()
    last=math.ceil(len(posts)/int(params['no._of_posts']))
   
    
    page=request.args.get('page')
    if (not str(page).isnumeric()):
        page=1
    page=int(page)
    posts=posts[(page-1)*int(params['no._of_posts']):(page-1)*int(params['no._of_posts']) + int(params['no._of_posts'])]
    # Pagination Logic

    if page==1:
        prev="#"
        next="/?page=" + str(page+1)

    elif (page==last):
        prev="/?page=" + str(page-1)
        next="#"
    else:
        prev="/?page=" + str(page-1)
        next="/?page=" + str(page+1)



    




    return render_template("index.html",params=params,posts=posts,prev=prev,next=next)

@app.route("/about")
def about():
    
    return render_template("about.html",params=params)


@app.route("/dashboard", methods=['GET','POST'])
def dashboard():

    if 'user' in session and session['user'] == params['admin_user']:
        posts=Posts.query.all()
        return render_template('dashboard.html',params=params,posts=posts)
    if request.method=='POST':
       username=request.form.get('uname')
       userpass=request.form.get('pass')
       if (username==params['admin_user'] and userpass==params['admin_password']):
        # Set the session variable
        session['user']=username
        return render_template('dashboard.html',params=params)
    posts=Posts.query.all()
    return render_template("login.html",params=params,posts=posts)

@app.route("/edit/<string:Serialno>",methods=['GET','POST'])
def Edit(Serialno):
    if 'user' in session and session['user'] == params['admin_user']:
        if request.method=="POST":
            box_title = request.form.get('title')
            tag_line = request.form.get('tline')
            slug = request.form.get('slug')
            contents = request.form.get('content')
            image_file = request.form.get('img_file')
            date=datetime.now()

            if Serialno=='0':
                '''
                title slug content tagline img_file
                '''
                post=Posts(title=box_title, slug=slug,content=contents,tagline=tag_line,img_file=image_file,date=date )
                db.session.add(post)
                db.session.commit()
            else:
                post=Posts.query.filter_by(Serialno=Serialno).first()
                post.title=box_title
                post.slug=slug
                post.content=contents
                post.tagline=tag_line
                post.img_file=image_file
                post.date=date
                db.session.commit()
                return redirect('/edit/' + Serialno)

        post=Posts.query.filter_by(Serialno=Serialno).first()
        return render_template('edit.html',params=params,post=post,Serialno=Serialno)



@app.route("/uploader",methods=['GET','POST'])
def uploader():
    if 'user' in session and session['user'] == params['admin_user']:

        if request.method=='POST':
            f=request.files['file1']
            f.save(os.path.join(app.config['UPLOAD_FOLDER'],secure_filename(f.filename)))
            return "Uploaded Successfully"


@app.route('/logout')
def logout():
    session.pop('user')
    return redirect('/dashboard')


@app.route("/delete/<string:Serialno>" , methods=['GET', 'POST'])
def delete(Serialno):
    if "user" in session and session['user']==params['admin_user']:
        post = Posts.query.filter_by(Serialno=Serialno).first()
        db.session.delete(post)
        db.session.commit()
    return redirect("/dashboard")

@app.route("/contact",methods=['GET','POST'])
def contact():
    if(request.method=='POST'):
        ''' Add Entry to database '''
        name=request.form.get('name')
        email=request.form.get('email')
        phone=request.form.get('phone')
        message=request.form.get('message')

        entry=Contacts(Name=name,PhoneNumber=phone,Message=message,email=email,date=datetime.now())
        db.session.add(entry)
        db.session.commit()
        mail.send_message('New Meassage from' + name,
        sender='email',
        recipients=[params['gmail-user']],
        body = message + "\n" +phone
        )
    
    return render_template("contact.html",params=params)

@app.route("/post/<string:post_slug>",methods=['GET'])
def Post_label(post_slug):
    post=Posts.query.filter_by(slug=post_slug).first()


    
    return render_template("post.html",params=params,post=post)
    #name 3 goes in template part new.html and name1 are 
    # taken from our python program 
    
app.run(debug=True)