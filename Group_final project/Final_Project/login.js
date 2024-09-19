console.log("Run successfully!");
let users=[];
document.addEventListener("DOMContentLoaded", () => {
    let createForm = document.getElementById("signup_button");
    let signinForm = document.getElementById("login_button");
    signinForm.addEventListener("click", (e) => {
        e.preventDefault();
        console.log("create form submitted");
        checking();
    });
    
    if (localStorage.getItem('users')) {
        let users = localStorage.getItem('users');
    }
    createForm.addEventListener("click", (e) => {
        e.preventDefault();
        let UserName=document.getElementById("signup_username").value;
        let Gmail = document.getElementById("signup_email").value;
        let Pw1 = document.getElementById("signup_passwork1").value;
        let Pw2 = document.getElementById("signup_passwork2").value;
        let username_error=false;
        users_data = JSON.parse(localStorage.getItem('users'));
        if(UserName.length == 0){
            alert('Please fill in userName');
    
        }else if(Pw1.length == 0){
            alert('Please fill in password');
    
        }else if(UserName.length == 0 && Pw1.length == 0){
            alert('Please fill in email and password');
    
        }else if(Pw1 !=Pw2 ){
            alert('Passworks does not match');
        }else if(Gmail.length==0){
            alert('Please fill in email');
        }else if(Pw1.length <3 &&Pw1.length>20&&Pw2.length <3 &&Pw2.length>20){
            alert('Password must be longer than 3 characters and not over 20 chars');
        }else if(UserName.length >0){
            for (const key in users_data) {
                if (users_data[key].username === UserName) {
                    
                    username_error=true;
                }
            }
            if(username_error==false) {
                let user = {
                    username: UserName,
                    gmail:Gmail,
                    password: Pw1,
                    login_data: ''
                  };

                document.getElementById("signup_username").value="";
                document.getElementById("signup_email").value="";
                document.getElementById("signup_passwork1").value="";
                document.getElementById("signup_passwork2").value="";
                
                if (localStorage.getItem('users')) {
                    users = localStorage.getItem('users');
                    users = JSON.parse(users);
                    users.push(user);
                    localStorage.setItem('users', JSON.stringify(users));
                }
                else {
                    users.push(user);
                    localStorage.setItem('users', JSON.stringify(users));
                }
                alert('Your account has been created'); 
                window.location.href = "login.html";
            }else{
                alert('Username already in use');
            }
        }
        
    });
    
    function checking(){
        users = JSON.parse(localStorage.getItem('users'));
        var userName = document.getElementById('login_username');
        var userPw = document.getElementById('login_passwork');
        
        let userId = null;

        for (const key in users) {
            if (users[key].username === userName.value &&users[key].password === userPw.value) {
                userId = key;
                break;  
            }
        }
        if(userId!=null){
            users[userId].login_data = 'true';
            localStorage.setItem('users', JSON.stringify(users));
            alert('You are logged in.');
            window.location.href = "index.html";
        }else{
            alert('Error on login');
            return;
        } 
    }
});